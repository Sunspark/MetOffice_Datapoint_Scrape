CREATE TABLE rv.s_WeatherObservation_DataPoint (
    WeatherObservationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
  , HashDiff CHAR(32) NOT NULL
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
  , [ObservationDate] DATE
  , [$] INT

  , CONSTRAINT [PK_s_WeatherObservation_DataPoint] PRIMARY KEY NONCLUSTERED
  (
    WeatherObservationHashKey ASC
    , LoadDate ASC
  )  
);