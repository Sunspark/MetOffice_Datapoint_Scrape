CREATE TABLE h_WeatherObservation (
  WeatherObservationHashKey CHAR(32) NOT NULL
  , WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
  , LocationID INT NOT NULL
  , DateKey INT NOT NULL
  , TimeKey INT NOT NULL
);