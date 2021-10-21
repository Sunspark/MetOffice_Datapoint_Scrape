CREATE PROCEDURE [stg_MetOffice].[stage_DataPoint_WeatherObservations]
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

    TRUNCATE TABLE [stg_MetOffice].[DataPoint_WeatherObservations];

    INSERT INTO [stg_MetOffice].[DataPoint_WeatherObservations]
    (
        [LoadDate]
      , [WeatherObservationHashKey]
      , [WeatherObservatoryLocationHashKey]
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
      , [LocationID]
      , [ObservationDate]
      , [$]
      , [DateKey]
      , [TimeKey]
      , [HashDiff]
    )
    SELECT
        @LoadDate AS [LoadDate]
      , TRY_CONVERT(
        CHAR(32)
        , HASHBYTES(
          'MD5'
          , CONCAT(
            ISNULL(TRY_CONVERT(NVARCHAR(255), [LocationID]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), keys.DateKey), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), keys.TimeKey), 'XX'), '^|^'
          )
        )
        , 2
      ) AS [WeatherObservationHashKey]
      , TRY_CONVERT(
        CHAR(32)
        , HASHBYTES(
          'MD5'
          , CONCAT(
            ISNULL(TRY_CONVERT(NVARCHAR(255), [LocationID]), 'XX'), '^|^'
          )
        )
        , 2
      ) AS [WeatherObservatoryLocationHashKey]
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
      , [LocationID]
      , [ObservationDate]
      , [$]
      , keys.DateKey AS [DateKey]
      , keys.TimeKey AS [TimeKey]
      , TRY_CONVERT(
        CHAR(32)
        , HASHBYTES(
          'MD5'
          , CONCAT(
              ISNULL(TRY_CONVERT(NVARCHAR(255), [G]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [T]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [V]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [D]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [S]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [W]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [P]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [Pt]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [Dp]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [H]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [ObservationDate]), 'XX'), '^|^'
            , ISNULL(TRY_CONVERT(NVARCHAR(255), [$]), 'XX'), '^|^'
          )
        )
        , 2
      ) AS [HashDiff]
    FROM
      [lnd_MetOffice].[DataPoint_WeatherObservations]
      CROSS APPLY (
        SELECT
          DATEADD(
            MINUTE
            , [$]
            , TRY_CONVERT(DATETIME2(0), [ObservationDate])
          ) AS ObservationDateTime
      ) ca
      CROSS APPLY (
        SELECT
            CONVERT(INT, CONVERT(VARCHAR(8), ca.ObservationDateTime, 112)) AS [DateKey]
          , CONVERT(INT, FORMAT(ca.ObservationDateTime, 'HHmmss')) AS [TimeKey]
      ) keys
    ;

    COMMIT TRANSACTION;

  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH
END