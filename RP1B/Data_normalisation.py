import pandas as pd
import numpy as np
import glob
import os
from sklearn.preprocessing import StandardScaler  # Import StandardScaler

# Folder where raw datasets are stored
folder_path = "/Volumes/SM/datasets"
processed_folder = "/Volumes/SM/processed_datasets"  # Folder to save processed files

#Find all CSV files in the folder
file_paths = glob.glob(f"{folder_path}/*.csv")

#Load datasets into DataFrames
datasets = [pd.read_csv(file) for file in file_paths]

if not datasets:
    print("Error: No CSV files found in the specified folder.")
    exit()

print(f" Loaded {len(datasets)} datasets.")

# Function to clean data: Remove rows with missing values
def clean_data(df):
    df_cleaned = df.replace(0, np.nan).dropna()  # Replace 0s with NaN, then drop NaNs
    return df_cleaned if not df_cleaned.empty else None  # Avoid empty DataFrames

# Clean all datasets
datasets_cleaned = [clean_data(df) for df in datasets if clean_data(df) is not None]

if not datasets_cleaned:
    print("Error: All datasets were cleaned out (empty).")
    exit()

# Save cleaned datasets
os.makedirs(processed_folder, exist_ok=True)  # Create folder if it doesn't exist
for idx, (cleaned_df, file_path) in enumerate(zip(datasets_cleaned, file_paths)):
    original_filename = os.path.basename(file_path).replace(".csv", "")
    cleaned_file_path = os.path.join(processed_folder, f"{original_filename}_cleaned.csv")
    cleaned_df.to_csv(cleaned_file_path, index=False)
    print(f"Saved cleaned dataset: {cleaned_file_path}")

# Load cleaned datasets
cleaned_file_paths = glob.glob(f"{processed_folder}/*_cleaned.csv")
datasets = [pd.read_csv(file) for file in cleaned_file_paths]

# Sample type labels (Ensure these match the datasets correctly!)
sample_types = ["cardiac", "M0", "M1", "M2", "SIS", "UBM"]

# Add 'sample_type' column
merged_datasets = []
for cleaned_df, sample_type in zip(datasets, sample_types):
    cleaned_df["sample_type"] = sample_type
    merged_datasets.append(cleaned_df)

# Merge all datasets into one
merged_df = pd.concat(merged_datasets, ignore_index=True)

# Strip extra spaces from column names
merged_df.columns = merged_df.columns.str.strip()

# Save merged dataset
merged_file_path = os.path.join(processed_folder, "merged_dataset.csv")
merged_df.to_csv(merged_file_path, index=False)
print(f"\n✅ Merged dataset saved to: {merged_file_path}")

# Normalization (Z-score) Process
print("\n🔍 Starting Normalization Process...")

# Define columns **NOT** to normalize
exclude_columns = ["Experiment", "Well ID", "Unique ID", "Row", "Column", "Field", "Object Number (per well)", "sample_type"]

# Identify actual existing columns to exclude (in case some are missing)
existing_exclude_columns = [col for col in exclude_columns if col in merged_df.columns]

# Select only numeric columns (excluding categorical ones)
numeric_columns = merged_df.select_dtypes(include=['number']).columns
columns_to_normalize = [col for col in numeric_columns if col not in existing_exclude_columns]

# Debugging: Show column selection
print(f"\n All Numeric Columns: {list(numeric_columns)}")
print(f"\n Excluded from Normalization: {existing_exclude_columns}")
print(f"\n Columns Being Normalized: {columns_to_normalize}")

# Apply Z-score normalization
scaler = StandardScaler()
merged_df_normalized = merged_df.copy()
merged_df_normalized[columns_to_normalize] = scaler.fit_transform(merged_df[columns_to_normalize])

# Save normalized dataset
normalized_file_path = os.path.join(processed_folder, "merged_dataset_zscore.csv")
merged_df_normalized.to_csv(normalized_file_path, index=False)
print(f"\n Normalized dataset saved to: {normalized_file_path}")

