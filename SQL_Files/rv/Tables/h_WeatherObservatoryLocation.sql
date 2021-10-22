CREATE TABLE rv.h_WeatherObservatoryLocation (
    WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
  , LocationID INT NOT NULL

  , CONSTRAINT [PK_h_WeatherObservatoryLocation] PRIMARY KEY NONCLUSTERED
  (
    WeatherObservatoryLocationHashKey ASC
  )
  , CONSTRAINT [UK_h_WeatherObservatoryLocation] UNIQUE NONCLUSTERED
  (
    LocationID
  )
);