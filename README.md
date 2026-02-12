# Data Analysis with Python: Cleaning, Analysis, and Visualization

## Project Overview
This project focuses on cleaning, analyzing, and visualizing messy real-world datasets using Python. The goal is to preprocess raw data, handle inconsistencies, and perform exploratory data analysis (EDA) to uncover meaningful patterns, trends, and insights.

The datasets used across this repository vary by folder and may include transactional, customer, operational, or categorical data such as dates, categories, numeric values, text fields, and percentages.

---

## Objectives
- Load and clean datasets containing missing or inconsistent data.
- Standardize column names, text entries, and date formats.
- Handle missing numeric values and inconsistent numeric representations.
- Perform exploratory analysis to understand distributions, trends, and group behavior.
- Visualize insights using matplotlib and seaborn.

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
df = pd.read_csv("dataset.csv")
df.head()
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
- Fill missing numeric values with the column mean (or other appropriate method):
```python
df["Units Sold"].fillna(df["Units Sold"].mean(), inplace=True)
df["Total Sales"].fillna(df["Total Sales"].median(), inplace=True)
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
- Standardize text columns for consistency:
```python
for col in ["Region", "Product", "Category"]:
    df[col] = df[col].str.strip().str.title()
- 
```
- Optionally map inconsistent category labels:
```python
category_map = {"Elec": "Electronics", "Gadget": "Gadgets"}
df["category"] = df["category"].replace(category_map)
```

### 7. Clean Numeric and Currency Columns
- Convert numeric columns stored as text:
```python
df["Units Sold"] = pd.to_numeric(df["Units Sold"], errors="coerce")
```
- Clean currency or symbol-based columns:
```python
for col in ["Unit Price", "Total Sales"]:
    df[col] = df[col].astype(str).str.replace("[$, USD]", "", regex=True).str.strip()
    df[col] = pd.to_numeric(df[col], errors="coerce")
```

### 8. Fix Percentage Columns
- Standardize percentage values:
```python
df["percentage"] = (
    df["percentage"]
    .astype(str)
    .str.replace("%", "", regex=True)
    .astype(float)
)

df["percentage"] = np.where(
    df["percentage"] < 1,
    df["percentage"] * 100,
    df["percentage"]
)
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
### 1. Aggregated Values by Category
```python
plt.figure(figsize=(7,5))
sns.barplot(data=df_cleaned, x="Region", y="Total Sales", estimator=sum, palette="cool")
plt.title("Total Sales by Region")
plt.xticks(rotation=20)
plt.show()
```
<img width="641" height="477" alt="image" src="https://github.com/user-attachments/assets/2c802c84-c7ee-43ba-9004-f3aa953e0923" />

### 2. Trend Over Time
```python
plt.figure(figsize=(7,5))
df_cleaned.groupby("Date")["Total Sales"].sum().plot(kind="line", color="teal")
plt.title("Sales Trend Over Time")
plt.ylabel("Total Sales ($)")
plt.show()
```
<img width="630" height="459" alt="image" src="https://github.com/user-attachments/assets/63c374d1-c9d4-4a60-aad3-5e34eb2f7709" />


### 3. Category Distribution
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
- Certain categories or groups contribute more significantly than others
- Trends over time reveal patterns such as growth, decline, or seasonality
- Data inconsistencies and missing values were successfully cleaned and standardized
- Visualizations help clearly communicate key insights

## Conclusion
This Python-based project demonstrates:
- Efficient data cleaning and preprocessing using pandas and NumPy.
- Handling messy numeric, text, date, and percentage data.
- Exploratory data analysis across different types of datasets.
- Clear and effective visualization using matplotlib and seaborn.

This project showcases practical skills in data analysis, business intelligence, and Python programming. 



