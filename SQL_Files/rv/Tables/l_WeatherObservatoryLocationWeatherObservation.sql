CREATE TABLE rv.l_WeatherObservatoryLocationWeatherObservation (
    WeatherObservatoryLocationWeatherObservationHashKey CHAR(32) NOT NULL
  , WeatherObservationHashKey CHAR(32) NOT NULL
  , WeatherObservatoryLocationHashKey CHAR(32) NOT NULL
  , LoadDate DATETIME2 NOT NULL
  , RecordSource VARCHAR(500) NOT NULL

  , CONSTRAINT [PK_l_WeatherObservatoryLocationWeatherObservation] PRIMARY KEY NONCLUSTERED
  (
    WeatherObservatoryLocationWeatherObservationHashKey ASC
  )
  , CONSTRAINT [UK_l_WeatherObservatoryLocationWeatherObservation] UNIQUE NONCLUSTERED
  (
      WeatherObservationHashKey
    , WeatherObservatoryLocationHashKey
  )
);