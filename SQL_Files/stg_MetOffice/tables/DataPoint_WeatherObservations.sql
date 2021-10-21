CREATE TABLE stg_MetOffice.DataPoint_WeatherObservations (
    [LoadDate] DATETIME2(7) NOT NULL
  , [WeatherObservationHashKey] CHAR(32) NOT NULL
  , [WeatherObservatoryLocationHashKey] CHAR(32) NOT NULL
  , [G] NUMERIC(10,2)
  , [T] NUMERIC(10,2)
  , [V] NUMERIC(10,2)
  , [D] NVARCHAR(4)
  , [S] NUMERIC(10,2)
  , [W] NUMERIC(10,2)
  , [P] NUMERIC(10,2)
  , [Pt] NVARCHAR(4)
  , [Dp] NUMERIC(10,2)
  , [H] NUMERIC(10,2)
  , [LocationID] INT -- PK component
  , [ObservationDate] DATE
  , [$] INT
  , [DateKey] INT -- PK component, FK to ref.Date
  , [TimeKey] INT -- PK component, FK to ref.Time
  , [HashDiff] CHAR(32) NOT NULL
);