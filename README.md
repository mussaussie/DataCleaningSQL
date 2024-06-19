# Cleaning Data in SQL Projects

This project focuses on cleaning and transforming the data in the `NationalHousing` table from the `Housing Project` database using SQL. The steps include converting date formats, handling missing values, breaking down addresses into multiple columns, and standardizing certain field values.

## Steps

### Step 1: Initial Data Glance
Get an overview of the dataset by selecting all records from the `NationalHousing` table.

### Step 2: Convert Date Format
Change the date format of the `SaleDate` column from string to `Date`.

#### Add and Populate New Date Column
1. Add a new column `SaleDateConverted` to store the converted date values.
2. Update the `SaleDateConverted` column with the converted date values from the `SaleDate` column.

### Step 3: Handle Missing Property Addresses
Identify and fill missing values in the `PropertyAddress` column.

#### Fill Missing Property Addresses
1. Use the `ISNULL` function to fill missing property addresses by joining records with the same `ParcelID` but different `UniqueID`.
2. Update the `PropertyAddress` column with the filled values.

### Step 4: Break Down Addresses into Multiple Columns
Split the `PropertyAddress` and `OwnerAddress` columns into multiple parts.

#### Split Property Address
1. Add new columns `Propertyspilitaddress` and `PropertyspilitCity`.
2. Update the new columns with the respective parts of the `PropertyAddress`.

#### Split Owner Address
1. Add new columns `Ownerspilitaddress`, `Ownerspilitcity`, and `Ownerspilitstate`.
2. Update the new columns with the respective parts of the `OwnerAddress`.

### Step 5: Standardize SoldAsVacant Values
Change the values in the `SoldAsVacant` column from 'Y' and 'N' to 'Yes' and 'No'.

#### Update SoldAsVacant Column
1. Use a `CASE` statement to update the values in the `SoldAsVacant` column.

### Step 6: Remove Duplicates
Remove duplicate records using a common table expression (CTE) and the `ROW_NUMBER` function.

#### Identify and Remove Duplicates
1. Create a CTE `ROWNUMcte` to assign row numbers to duplicate records.
2. Select records with row numbers greater than 1 for removal.

### Step 7: Clean Up Columns
Drop unnecessary columns from the `NationalHousing` table.

## Conclusion
This project demonstrates the steps to clean and transform a dataset using SQL. By converting date formats, handling missing values, breaking down addresses, standardizing field values, and removing duplicates, we can ensure the data is clean and ready for analysis.

## Repository Link
[GitHub Repository](https://github.com/mussaussie/sql-data-cleaning)

## Contact
For any questions or further information, please contact me at mussaussie@gmail.com.

---
Abdul Mussavir
