CREATE TABLE l_WeatherObservatoryLocationWeatherObservation (
    WeatherObservatoryLocationWeatherObservationHashKey CHAR(32) NOT NULL
  , WeatherObservationHashKey CHAR(32) NOT NULL
  , WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL
);