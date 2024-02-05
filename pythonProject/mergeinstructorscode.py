import pandas as pd

# Load the UGA_Salaries and syllabus-data CSV files
uga_salaries = pd.read_csv(r'C:\Users\areeb\PycharmProjects\pythonProject3\UGA_Salaries_2022.csv', encoding='latin-1')
syllabus_data = pd.read_csv(r'C:\Syllabus review project 2-5-2024\syllabus-review-project\syllabus-data.csv', encoding='latin-1')

# Merge the two DataFrames based on 'Last Name' and 'Year' columns
merged_data = pd.merge(uga_salaries, syllabus_data, on=['Last Name', 'Year'], how='inner')

# Create a new DataFrame with only 'Last Name' and 'Year' columns
result_df = merged_data[['Last Name', 'Year']]

# Export the result DataFrame to a new CSV file
result_df.to_csv('updatematched_instructors.csv', index=False, encoding='latin-1')

print("Merged data saved to 'updatematched_instructors.csv'")




