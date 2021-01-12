/* INSERT INTO STAGING TABLE */
TRUNCATE TABLE ST_IMDB_BASE_TITLE_EPISODE;

INSERT INTO ST_IMDB_BASE_TITLE_EPISODE (
	TCONST_NK
	,PARENTTCONST
	,SEASONNUMBER
	,EPISODENUMBER
	,SRC_ID
	,LOAD_DATE
	,NOTE
	)
SELECT TCONST_NK AS TCONST_NK
	,PARENTTCONST AS PARENTTCONST
	,SEASONNUMBER AS SEASONNUMBER
	,EPISODENUMBER AS EPISODENUMBER
	,SRC_ID AS SRC_ID
	,LOAD_DATE AS LOAD_DATE
	,NOTE AS NOTE
FROM SV_IMDB_BASE_TITLE_EPISODE S
ORDER BY TCONST_NK;

ANALYZE ST_IMDB_BASE_TITLE_EPISODE;

/* LOG CURRENT LOAD INFO */
TRUNCATE TABLE X_IMDB_BASE_LOG;

INSERT INTO X_IMDB_BASE_LOG (
	LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_ID
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT
	)
SELECT NOW()
	,10
	,S.SRC_ID
	,'ST_IMDB_BASE_TITLE_EPISODE'
	,MAX(S.LOAD_DATE)
	,SUM(ROW_COUNT)
	,SUM(DISTINCT_PK_COUNT)
FROM (
	SELECT TCONST_NK
		,SRC_ID
		,MAX(LOAD_DATE) AS LOAD_DATE
		,COUNT(*) AS ROW_COUNT
		,1 AS DISTINCT_PK_COUNT
	FROM ST_IMDB_BASE_TITLE_EPISODE
	GROUP BY TCONST_NK
		,SRC_ID
	) AS S
GROUP BY S.SRC_ID;

/* CHECK LOAD AND SAVE ETL HISTORY */
INSERT INTO ETL_LOG (
	SUBJECT_AREA
	,LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_ID
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT
	,FAIL_CHECK_BOOL_1
	,ERROR_MESSAGE_1
	,FAIL_CHECK_BOOL_2
	,ERROR_MESSAGE_2
	)
SELECT 'IMDB_BASE'
	,LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_ID
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT
	,CASE
		WHEN COUNT(*) > 0
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE IS EMPTY. (TABLE ST_IMDB_BASE_TITLE_EPISODE).'
	,CASE
		WHEN SUM(ROW_COUNT) = SUM(DISTINCT_PK_COUNT)
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE FAILED PRIMARY KEY TEST. (TABLE ST_IMDB_BASE_TITLE_EPISODE).'
FROM X_IMDB_BASE_LOG
WHERE LOAD_SEQ_NUM = 10
GROUP BY LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_ID
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT;

COMMIT;
