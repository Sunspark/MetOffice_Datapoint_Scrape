CREATE TABLE s_WeatherObservatoryLocation_DataPoint (
    WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
  , HashDiff CHAR(32) NOT NULL
  , [lat] NUMERIC(10,5)
  , [lon] NUMERIC(10,5)
  , [name] NVARCHAR(300)
  , [country] NVARCHAR(300)
  , [continent] NVARCHAR(300)
  , [elevation] NUMERIC(10,5)
);