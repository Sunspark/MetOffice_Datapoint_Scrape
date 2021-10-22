CREATE PROCEDURE load_h_WeatherObservation_from_MetOffice_DataPoint_WeatherObservations
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

    INSERT INTO [rv].[h_WeatherObservation]
    (
        WeatherObservationHashKey
      , WeatherObservatoryLocationHashKey
      , LoadDate
      , RecordSource
      , LocationID
      , DateKey
      , TimeKey
    )
    SELECT DISTINCT
        WeatherObservationHashKey
      , WeatherObservatoryLocationHashKey
      , LoadDate
      , @RecordSource
      , LocationID
      , DateKey
      , TimeKey
    FROM
      [stg_MetOffice].[DataPoint_WeatherObservations]
    WHERE
      WeatherObservationHashKey NOT IN (SELECT WeatherObservationHashKey FROM [rv].[h_WeatherObservation])
      AND LoadDate = @LoadDate
    ;

    COMMIT TRANSACTION;    
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH


END