CREATE PROCEDURE [stg_MetOffice].[stage_DataPoint_WeatherObservatoryLocations]
  @LoadDate DATETIME2 = NULL -- Passed in from orchestrator, or set below
AS
BEGIN
  -- Set LoadDate to UTC now if null
  IF @LoadDate IS NULL
  BEGIN
    SET @LoadDate = GETUTCDATE();
  END

  BEGIN TRY
    BEGIN TRANSACTION;

    TRUNCATE TABLE [stg_MetOffice].[DataPoint_WeatherObservatoryLocations];

    INSERT INTO [stg_MetOffice].[DataPoint_WeatherObservatoryLocations]
    (
        [LoadDate]
      , [WeatherObservatoryLocationHashKey]
      , [i]
      , [lat]
      , [lon]
      , [name]
      , [country]
      , [continent]
      , [elevation]
      , [HashDiff]
    )
    SELECT
        @LoadDate AS [LoadDate]
      , TRY_CONVERT(
        CHAR(32)
        , HASHBYTES(
          'MD5'
          , CONCAT(
            ISNULL(TRY_CONVERT(NVARCHAR(255), [i]), 'XX'), '^|^'
          )
        )
        , 2
      ) AS [WeatherObservatoryLocationHashKey]
      , [i]
      , [lat]
      , [lon]
      , [name]
      , [country]
      , [continent]
      , [elevation]
      , TRY_CONVERT(
        CHAR(32)
        , HASHBYTES(
          'MD5'
          , CONCAT(
              ISNULL(TRY_CONVERT(NVARCHAR(255), [lat]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [lon]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [name]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [country]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [continent]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [elevation]), 'XX'), '^|^'
          )
        )
        , 2
      ) AS [HashDiff]
    FROM
      [lnd_MetOffice].[DataPoint_WeatherObservatoryLocations]
    ;

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH
END