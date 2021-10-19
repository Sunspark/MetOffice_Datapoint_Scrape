-- This table is the type-ascribed outcome of the CSV
-- If type checking and error reporting/ isolation is required,
-- follow that pattern.
CREATE TABLE lnd_MetOffice.DataPoint_WeatherObservations (
    [G] NUMERIC(10,2)
  , [T] NUMERIC(10,2)
  , [V] NUMERIC(10,2)
  , [D] NVARCHAR(4)
  , [S] NUMERIC(10,2)
  , [W] NUMERIC(10,2)
  , [P] NUMERIC(10,2)
  , [Pt] NVARCHAR(4)
  , [Dp] NUMERIC(10,2)
  , [H] NUMERIC(10,2)
  , [LocationID] INT
  , [ObservationDate] DATE
  , [$] INT
);