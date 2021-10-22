CREATE VIEW [dm_Common].[WeatherObservations]
AS
SELECT
  wo.DateKey
  , wo.LocationID
  , wo.TimeKey
  
  , DATEADD(MINUTE, wos.[$], CONVERT(DATETIME2(0), wos.ObservationDate)) AS [Observation Time]
  , wos.[$] AS [Minutes Past Midnight]

  , wos.G AS [Wind Gust]
  , wos.T AS [Temperature]
  , wos.V AS [Visibility]
  , wos.D AS [Wind Direction]
  , wos.S AS [Wind Speed]
  , wos.W AS [Weather Type]
  , wos.P AS [Pressure]
  , CASE
    WHEN wos.Pt = 'F' THEN 'Falling'
    WHEN wos.Pt = 'R' THEN 'Rising'
  END AS [Pressure Tendency]
  , wos.Dp AS [Dew Point]
  , wos.H AS [Screen Relative Humidity]

  , wols.lat AS [Latitude]
  , wols.lon AS [Longitude]


FROM
  rv.h_WeatherObservation wo
  INNER JOIN rv.s_WeatherObservation_DataPoint wos ON (
    wo.WeatherObservationHashKey = wos.WeatherObservationHashKey
    AND wos.LoadDate = (
      SELECT MAX(s.LoadDate)
      FROM rv.s_WeatherObservation_DataPoint s
      WHERE s.WeatherObservationHashKey = wo.WeatherObservationHashKey
    )
  )
  INNER JOIN rv.l_WeatherObservatoryLocationWeatherObservation wolwo ON (wo.WeatherObservationHashKey = wolwo.WeatherObservationHashKey)
  INNER JOIN rv.h_WeatherObservatoryLocation wol ON (wolwo.WeatherObservatoryLocationHashKey = wol.WeatherObservatoryLocationHashKey)
  INNER JOIN rv.s_WeatherObservatoryLocation_DataPoint wols ON (
    wol.WeatherObservatoryLocationHashKey = wols.WeatherObservatoryLocationHashKey
    AND wols.LoadDate = (
      SELECT MAX(s.LoadDate)
      FROM rv.s_WeatherObservatoryLocation_DataPoint s
      WHERE s.WeatherObservatoryLocationHashKey = wol.WeatherObservatoryLocationHashKey
    )
  )
;