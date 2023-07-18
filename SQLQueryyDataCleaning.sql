--Cleaning Data in Sql Projects

Select * 
From [Housing Project]..NationalHousing

-- change the date format , use update function to change the data tyoe of column in table or you can us Alter

Select Saledate, CONVERT(Date, SaleDate) 
From [Housing Project]..NationalHousing

update	NationalHousing	
set SaleDate = CONVERT(Date, SaleDate) 

Select SaleDateConverted
from [Housing Project]..NationalHousing

--1) you have to use ALter function to add new column, then equals the new coulmn to desire column using convert function after use update 

Alter Table NationalHousing
Add SaleDateConverted Date;

Update NationalHousing
Set SaleDateConverted = CONVERT(Date, SaleDate) 

--populate property address

Select PropertyAddress
from [Housing Project]..NationalHousing
where PropertyAddress is null

Select a.ParcelID, b.ParcelID , a.PropertyAddress, B.PropertyAddress
from [Housing Project]..NationalHousing as A
join [Housing Project]..NationalHousing as B
On A.ParcelID = B.ParcelID
And A.[UniqueID ] <> B.[UniqueID ]
--Where A.PropertyAddress is null

-- we will use isnull functoin to fill nul values (Basically what it does it took the value fron 1 column and put this to desire column i.e null

Select a.ParcelID, b.ParcelID , a.PropertyAddress, B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
from [Housing Project]..NationalHousing as A
join [Housing Project]..NationalHousing as B
On A.ParcelID = B.ParcelID
And A.[UniqueID ] <> B.[UniqueID ]
Where A.PropertyAddress is null


Update	a
Set PropertyAddress = ISNULL(A.PropertyAddress,B.PropertyAddress)
from [Housing Project]..NationalHousing as A
join [Housing Project]..NationalHousing as B
On A.ParcelID = B.ParcelID
And A.[UniqueID ] <> B.[UniqueID ]
Where A.PropertyAddress is null

--Breaking down address into many columns(The SUBSTRING function extracts a part of the PropertyAddress column.
--It takes three arguments: the input string (PropertyAddress), the starting position (1), and the length of the desired substring.
--In this case, the starting position is 1, and the length is calculated by subtracting 1 from the position of the comma (,) found using the CHARINDEX function.
--This part extracts the substring from the beginning of PropertyAddress until just before the comma, representing the first part of the address.
--SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS AddressPart2:
--Similar to the previous part, this SUBSTRING function also extracts a part of the PropertyAddress column.
--The starting position is calculated by adding 1 to the position of the comma (,) found using the CHARINDEX function.
--The length is specified as LEN(PropertyAddress), which means the substring will include all characters from the starting position until the end of the PropertyAddress string.
--This part extracts the substring from just after the comma until the end of the PropertyAddress, representing the second part of the address.)
---

Select SUBSTRING(PropertyAddress, 1,CHARINDEX(',' , PropertyAddress) - 1) As Address,
SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) As Address
From [Housing Project]..NationalHousing

-- we did break the column now we have to update this into the table 

Alter Table NationalHousing
Add Propertyspilitaddress nvarchar(255);

Update NationalHousing
Set Propertyspilitaddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',' , PropertyAddress) - 1) 

Alter Table NationalHousing
Add PropertyspilitCity nvarchar(255);

Update NationalHousing
Set PropertyspilitCity = SUBSTRING(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

Select *
From [Housing Project]..NationalHousing

Select 
Parsename(Replace(OwnerAddress, ',', '.'), 3),
Parsename(Replace(OwnerAddress, ',', '.'), 2),
Parsename(Replace(OwnerAddress, ',', '.'), 1)
From [Housing Project]..NationalHousing

Alter Table NationalHousing
Add Ownerspilitaddress nvarchar(255);

Update NationalHousing
Set Ownerspilitaddress = Parsename(Replace(OwnerAddress, ',', '.'), 3) 

Alter Table NationalHousing
Add Ownerspilitcity nvarchar(255);

Update NationalHousing
Set Ownerspilitcity = Parsename(Replace(OwnerAddress, ',', '.'), 2) 

Alter Table NationalHousing
Add Ownerspilitstate nvarchar(255);

Update NationalHousing
Set Ownerspilitstate = Parsename(Replace(OwnerAddress, ',', '.'), 1)

Select * 
From NationalHousing

-- Change Y and N to yes and no in sold Vacant field first look at it

Select Distinct (SoldAsVacant), Count(SoldAsVacant)
From NationalHousing
group by SoldAsVacant
Order by 2

Select SoldAsVacant,
 Case When SoldAsVacant = 'Y' then 'Yes'
       When SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant 
	   ENd
	   
From NationalHousing

Update NationalHousing
 Set SoldAsVacant = Case When SoldAsVacant = 'Y' then 'Yes'
       When SoldAsVacant = 'N' then 'No'
	   Else SoldAsVacant 
	   ENd
From NationalHousing




--Remove Duplicates not from original data but we will make cte or temp table and put data into temp table then remove from temp table
--ROW_NUMBER() that assigns a unique number to each row within a specific partition. The partitioning is done based on the specified columns (parcelId, PropertyAddress, Saleprice, Saledate, and LegalReference), and the ordering is determined by the UniqueId column. The assigned row number is then given the alias row_num.

WITH ROWNUMcte AS (
Select *,
  Row_number() Over (
  partition by parcelId,
               PropertyAddress,
			   Saleprice,
			   Saledate,
			   LegalReference
			   Order by UniqueId 
			   ) row_num
From Nationalhousing
)

--Order by ParcelID
--where row_num > 1
-- we use delete funtion befpre to del duplicate

Select *
From ROWNUMcte
where row_num > 1
--Order by PropertyAddress

Select *
From NationalHousing

Alter Table Nationalhousing
Drop column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table Nationalhousing
Drop column Saleprice