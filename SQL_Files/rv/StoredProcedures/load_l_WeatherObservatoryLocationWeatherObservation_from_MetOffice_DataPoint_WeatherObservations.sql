CREATE PROCEDURE load_l_WeatherObservatoryLocationWeatherObservation_from_MetOffice_DataPoint_WeatherObservations
  @LoadDate DATETIME2 = NULL -- Needs to be not null in order to collect the correct data from STG. Script fails on NULL.
AS
BEGIN
  DECLARE
    @RecordSource VARCHAR(500) = 'MetOffice.DataPoint.WeatherObservations'
  ;

  IF @LoadDate IS NULL
  BEGIN;
    THROW 50001, N'Load Date was null. Provide a Load Date to ensure correct data is collected from staging.', 1;
    RETURN 1;
  END

  BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO [rv].[l_WeatherObservatoryLocationWeatherObservation]
    (
        WeatherObservatoryLocationWeatherObservationHashKey
      , WeatherObservationHashKey
      , WeatherObservatoryLocationHashKey
      , LoadDate
      , RecordSource
    )
    SELECT DISTINCT
        WeatherObservatoryLocationWeatherObservationHashKey
      , WeatherObservationHashKey
      , WeatherObservatoryLocationHashKey
      , LoadDate
      , @RecordSource
    FROM
      [stg_MetOffice].[DataPoint_WeatherObservations]
    WHERE
      WeatherObservatoryLocationHashKey IS NOT NULL
      AND WeatherObservatoryLocationWeatherObservationHashKey NOT IN (SELECT WeatherObservatoryLocationWeatherObservationHashKey FROM [rv].[l_WeatherObservatoryLocationWeatherObservation])
      AND LoadDate = @LoadDate
    ;

    COMMIT TRANSACTION;    
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH


END