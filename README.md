# Python for Sales Data: Cleaning, Analysis, and Visualization 

## Project Overview
This project focuses on cleaning and analyzing messy retail sales data using Python. The goal is to preprocess, clean, and visualize sales data to uncover insights such as sales trends, category performance, and regional revenue distribution.

The dataset contains transaction-level information including date, region, product, category, units sold, unit price, total sales, and profit margin.

---

## Objectives
- Load and clean a messy sales dataset with missing or inconsistent data.  
- Standardize column names, text entries, and date formats.  
- Handle missing numeric values and inconsistent currency/percentage formats.  
- Explore key statistics such as total sales, sales by region, and category performance.  
- Visualize insights using **matplotlib** and **seaborn**.  

---

## Project Structure

### 1. Import Libraries
- The project uses Python libraries for data manipulation and visualization:
```python
import warnings
warnings.filterwarnings("ignore")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```

### 2. Load the Dataset
```python
df = pd.read_csv("messy_sales.csv")
df.head(20)
```

### 3. Check for Missing Values and Data Info
- Inspect the dataset for null values and verify data types:
```python
df.info()
df.isnull().sum()
```

### 4. Handle Missing Values
- Ensure numeric columns are numeric before filling NaN:
```python
df["Units Sold"] = pd.to_numeric(df["Units Sold"], errors="coerce")
df["Total Sales"] = pd.to_numeric(df["Total Sales"], errors="coerce")
```
- Fill missing numeric values with the column mean:
```python
df["Units Sold"].fillna(df["Units Sold"].mean(), inplace=True)
df["Total Sales"].fillna(df["Total Sales"].mean(), inplace=True)
```

### 5. Clean Column Names
- Remove leading/trailing spaces from column names:
```python
df.columns = df.columns.str.strip()
```

### 6. Standardize Data
- Fix date formats:
```python
df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
```
- Standardize text columns and category names:
```python
for col in ["Region", "Product", "Category"]:
    df[col] = df[col].str.strip().str.title()

category_map = {"Elec": "Electronics", "Gadget": "Gadgets"}
df["Category"] = df["Category"].replace(category_map)
```

### 7. Clean Numeric and Currency Columns
- Convert Units Sold to numeric:   
```python
df["Units Sold"] = pd.to_numeric(df["Units Sold"], errors="coerce")
```
- Clean currency columns (Unit Price, Total Sales) by removing symbols and converting to numeric:
```python
for col in ["Unit Price", "Total Sales"]:
    df[col] = df[col].astype(str).str.replace("[$, USD]", "", regex=True).str.strip()
    df[col] = pd.to_numeric(df[col], errors="coerce")
```

### 8. Fix Profit Margin (%)
```python
df["Profit Margin (%)"] = df["Profit Margin (%)"].astype(str).str.replace("%", "", regex=True).str.replace("percent", "", regex=True).astype(float)
df["Profit Margin (%)"] = np.where(df["Profit Margin (%)"] < 1, df["Profit Margin (%)"] * 100, df["Profit Margin (%)"])
```


### 9. Drop Rows with Missing Key Data
```python
df_cleaned = df.dropna(subset=["Date", "Region", "Total Sales"])
```

### 10. Check Cleaned Data
```python
df_cleaned.head()
```

## Data Analysis and Visualization
### 1. Total Sales by Region
```python
plt.figure(figsize=(7,5))
sns.barplot(data=df_cleaned, x="Region", y="Total Sales", estimator=sum, palette="cool")
plt.title("Total Sales by Region")
plt.xticks(rotation=20)
plt.show()
```
<img width="641" height="477" alt="image" src="https://github.com/user-attachments/assets/2c802c84-c7ee-43ba-9004-f3aa953e0923" />

### 2. Sales Trend Over Time
```python
plt.figure(figsize=(7,5))
df_cleaned.groupby("Date")["Total Sales"].sum().plot(kind="line", color="teal")
plt.title("Sales Trend Over Time")
plt.ylabel("Total Sales ($)")
plt.show()
```
<img width="630" height="459" alt="image" src="https://github.com/user-attachments/assets/63c374d1-c9d4-4a60-aad3-5e34eb2f7709" />


### 3. Category Share Pie Chart
```python
plt.figure(figsize=(6,6))
category_sales = df_cleaned.groupby("Category")["Total Sales"].sum()
category_sales.plot(kind="pie", autopct="%1.1f%%", startangle=90, colors=sns.color_palette("pastel"))
plt.title("Sales Share by Category")
plt.ylabel("")
plt.show()
```
<img width="532" height="497" alt="image" src="https://github.com/user-attachments/assets/6a2b9443-a1dd-44bf-b308-1c40da606a1d" />


## Findings
- Some regions outperform others in total sales.
- Certain product categories contribute the majority of revenue.
- Sales trend shows fluctuations over time, indicating seasonality or market patterns.
- Profit margins and currency inconsistencies were successfully standardized.

## Conclusion
This Python-based project demonstrates:
- Efficient data cleaning and preprocessing using pandas.
- Handling messy numeric, text, date, and currency data.
- Effective visualization of key business insights using matplotlib and seaborn.
- A practical approach to turning messy raw sales data into actionable insights.

This project showcases practical skills in data analysis, business intelligence, and Python programming. 



