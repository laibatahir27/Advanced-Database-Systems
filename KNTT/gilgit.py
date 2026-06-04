import pandas as pd
import numpy as np

# Loading the excel sheet
excel_file = 'Gilgit.xls'
climate_df = pd.read_excel(excel_file) # read function to read from excel file
original_data = climate_df.copy() 

# KNTT function
def kntt(df, day, month, year, omega=3, k=5):
    
    # setting omega/threshold=3 means 3 days before and 3 days after the missing value
    start_day = max(1, day - omega)
    end_day = min(31, day + omega)

    curr_trend = df[(df['YYYY'] == year) & 
                       (df['MM'] == month) & 
                       (df['DD'].between(start_day, end_day))]
      
    curr_trend = curr_trend[curr_trend['TMAX'] != -99.9]
    
    if len(curr_trend) == 0:
        old_mean = df[(df['MM'] == month) & (df['DD'] == day) & (df['TMAX'] != -99.9)]['TMAX'].mean()
        return round(old_mean, 2) if not np.isnan(old_mean) else 0.0

    curr_val = curr_trend['TMAX'].values
    days_to_match = curr_trend['DD'].values
    sim_matches = []

    # Checking every other year in the dataset
    for y in df['YYYY'].unique():
        if y == year: 
            continue

        # Looking at the same dates in past years
        past_data = df[(df['YYYY'] == y) & (df['MM'] == month) & (df['DD'].between(start_day, end_day))]
        target_day_row = past_data[past_data['DD'] == day]
        
        # If the historical day itself is missing, we skip that year
        if target_day_row.empty or (target_day_row['TMAX'] == -99.9).any():
            continue
      
        past_pattern = []
        for d in days_to_match:
            temp_val = past_data[past_data['DD'] == d]['TMAX']
            if not temp_val.empty and temp_val.values[0] != -99.9:
                past_pattern.append(temp_val.values[0])
               
        # Comparing the two trends
        if len(past_pattern) == len(curr_val):
            past_pattern = np.array(past_pattern)
            gap = np.sqrt(np.sum((curr_val - past_pattern) ** 2))          
            sim_matches.append((gap, target_day_row['TMAX'].values[0]))

    if not sim_matches:
        return round(np.mean(curr_val), 2)

    # K most similar years
    sim_matches.sort(key=lambda x: x[0]) 
    top_k_values = [v for g, v in sim_matches[:k]]
    
    return round(np.mean(top_k_values), 2)

# Finding missing value
miss_points = climate_df[climate_df['TMAX'] == -99.9].index

print(f"\nIMPUTED THE MISSING VALUES:")

# Filling the missing values one by one
for i in miss_points:
    d = int(climate_df.loc[i, 'DD'])
    m = int(climate_df.loc[i, 'MM'])
    y = int(climate_df.loc[i, 'YYYY'])
    
    # Calling the KNTT function
    pred_temp = kntt(climate_df, d, m, y)
    
    climate_df.at[i, 'TMAX'] = pred_temp
    
    if len(miss_points) > 10:
        print(f"Filled: {y}-{m:02d}-{d:02d} -> {pred_temp} °C")

# --- VALIDATION TEST WITH RMSE ---
print("\n--- VALIDATION ---")
test_dates = [(10, 1, 2010), (20, 4, 2007), (29, 10, 2003), (24, 9, 2005), (24, 6, 1995)]

sq_errors = [] # List to store (actual - predicted)^2 for RMSE

for td, tm, ty in test_dates:
    actual = original_data[(original_data['YYYY']==ty) & (original_data['MM']==tm) & (original_data['DD']==td)]['TMAX'].values[0]
    predicted = kntt(original_data, td, tm, ty)
    
    error = actual - predicted
    sq_errors.append(error ** 2) # Square of the error
    
    print(f"Date: {ty}-{tm:02d}-{td:02d} | Actual: {actual:5.2f}°C | Predicted: {predicted:5.2f}°C | Error: {abs(error):5.2f}°C")


rmse = np.sqrt(np.mean(sq_errors))
print(f"\nFINAL RMSE: {rmse:.4f}")