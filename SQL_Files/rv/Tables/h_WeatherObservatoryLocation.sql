CREATE TABLE h_WeatherObservatoryLocation (
    WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
  , LocationID INT NOT NULL
);