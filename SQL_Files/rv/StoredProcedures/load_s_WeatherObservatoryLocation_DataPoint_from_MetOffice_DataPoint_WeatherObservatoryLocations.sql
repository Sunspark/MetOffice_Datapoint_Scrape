CREATE PROCEDURE load_s_WeatherObservatoryLocation_DataPoint_from_MetOffice_DataPoint_WeatherObservatoryLocations
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

    INSERT INTO [rv].[s_WeatherObservatoryLocation_DataPoint]
    (
        WeatherObservatoryLocationHashKey
      , LoadDate
      , RecordSource
      , HashDiff
      , [lat]
      , [lon]
      , [name]
      , [country]
      , [continent]
      , [elevation]
    )
    SELECT DISTINCT
        stg.WeatherObservatoryLocationHashKey
      , stg.LoadDate
      , @RecordSource
      , stg.HashDiff
      , stg.[lat]
      , stg.[lon]
      , stg.[name]
      , stg.[country]
      , stg.[continent]
      , stg.[elevation]    
    FROM
      [stg_MetOffice].[DataPoint_WeatherObservatoryLocations] stg
      LEFT OUTER JOIN [rv].[s_WeatherObservatoryLocation_DataPoint] sat ON (
        stg.WeatherObservatoryLocationHashKey = sat.WeatherObservatoryLocationHashKey
        AND sat.LoadDate = (
          SELECT MAX(z.LoadDate)
          FROM [rv].[s_WeatherObservatoryLocation_DataPoint] z
          WHERE z.WeatherObservatoryLocationHashKey = sat.WeatherObservatoryLocationHashKey
        )
      )
    WHERE
      (
        sat.HashDiff != stg.HashDiff
        OR sat.HashDiff IS NULL
      )
      AND stg.LoadDate = @LoadDate
    ;

    COMMIT TRANSACTION;    
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH


END