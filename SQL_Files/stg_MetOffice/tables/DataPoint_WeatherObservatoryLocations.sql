CREATE TABLE stg_MetOffice.DataPoint_WeatherObservatoryLocations (
    [LoadDate] DATETIME2(7) NOT NULL
  , [WeatherObservatoryLocationHashKey] CHAR(32) NOT NULL
  , [i] INT -- PK component
  , [lat] NUMERIC(10,5)
  , [lon] NUMERIC(10,5)
  , [name] NVARCHAR(300)
  , [country] NVARCHAR(300)
  , [continent] NVARCHAR(300)
  , [elevation] NUMERIC(10,5)
  , [HashDiff] CHAR(32) NOT NULL
);