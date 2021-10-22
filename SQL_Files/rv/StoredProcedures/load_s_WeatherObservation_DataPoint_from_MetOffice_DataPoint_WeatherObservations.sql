CREATE PROCEDURE load_s_WeatherObservation_DataPoint_from_MetOffice_DataPoint_WeatherObservations
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

    INSERT INTO [rv].[s_WeatherObservation_DataPoint]
    (
        WeatherObservationHashKey
      , LoadDate
      , RecordSource
      , HashDiff
      , [G]
      , [T]
      , [V]
      , [D]
      , [S]
      , [W]
      , [P]
      , [Pt]
      , [Dp]
      , [H]
      , [ObservationDate]
      , [$]
    )
    SELECT DISTINCT
        stg.WeatherObservationHashKey
      , stg.LoadDate
      , @RecordSource
      , stg.HashDiff
      , stg.[G]
      , stg.[T]
      , stg.[V]
      , stg.[D]
      , stg.[S]
      , stg.[W]
      , stg.[P]
      , stg.[Pt]
      , stg.[Dp]
      , stg.[H]
      , stg.[ObservationDate]
      , stg.[$]      
    FROM
      [stg_MetOffice].[DataPoint_WeatherObservations] stg
      LEFT OUTER JOIN [rv].[s_WeatherObservation_DataPoint] sat ON (
        stg.WeatherObservationHashKey = sat.WeatherObservationHashKey
        AND sat.LoadDate = (
          SELECT MAX(z.LoadDate)
          FROM [rv].[s_WeatherObservation_DataPoint] z
          WHERE z.WeatherObservationHashKey = sat.WeatherObservationHashKey
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