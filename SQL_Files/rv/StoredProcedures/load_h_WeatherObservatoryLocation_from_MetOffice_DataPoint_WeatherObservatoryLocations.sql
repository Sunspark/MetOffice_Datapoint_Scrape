CREATE PROCEDURE load_h_WeatherObservatoryLocation_from_MetOffice_DataPoint_WeatherObservatoryLocations
  @LoadDate DATETIME2 = NULL -- Needs to be not null in order to collect the correct data from STG. Script fails on NULL.
AS
BEGIN
  DECLARE
    @RecordSource VARCHAR(500) = 'MetOffice.DataPoint.WeatherObservatoryLocations'
  ;

  IF @LoadDate IS NULL
  BEGIN;
    THROW 50001, N'Load Date was null. Provide a Load Date to ensure correct data is collected from staging.', 1;
    RETURN 1;
  END

  BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO [rv].[h_WeatherObservatoryLocation]
    (
        WeatherObservatoryLocationHashKey
      , LoadDate
      , RecordSource
      , LocationID
    )
    SELECT DISTINCT
        WeatherObservatoryLocationHashKey
      , LoadDate
      , @RecordSource
      , i
    FROM
      [stg_MetOffice].[DataPoint_WeatherObservatoryLocations]
    WHERE
      WeatherObservatoryLocationHashKey NOT IN (SELECT WeatherObservatoryLocationHashKey FROM [rv].[h_WeatherObservatoryLocation])
      AND LoadDate = @LoadDate
    ;

    COMMIT TRANSACTION;    
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH


END