-- This table is the type-ascribed outcome of the CSV
-- If type checking and error reporting/ isolation is required,
-- follow that pattern.
CREATE TABLE lnd_MetOffice.DataPoint_WeatherObservatoryLocations (
    [i] INT
  , [lat] NUMERIC(10,5)
  , [lon] NUMERIC(10,5)
  , [name] NVARCHAR(300)
  , [country] NVARCHAR(300)
  , [continent] NVARCHAR(300)
  , [elevation] NUMERIC(10,5)
);