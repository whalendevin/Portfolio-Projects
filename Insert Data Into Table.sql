BULK INSERT dbo.OriginationData
FROM 'C:\Users\whale\OneDrive\Documents\Portfolio Projects\Housing\historical_data_2008Q1.txt'
WITH 
  (
    FIELDTERMINATOR = '|', 
    ROWTERMINATOR = '0x0A'
  )

bulk insert dbo.MonthlyPerformance
from 'C:\Users\whale\OneDrive\Documents\Portfolio Projects\Housing\historical_data_time_2008Q1.txt'
with
(fieldterminator = '|',
rowterminator = '0x0A')