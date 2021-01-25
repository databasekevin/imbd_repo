/* INSERT INTO STAGING TABLE */
TRUNCATE TABLE ST_IMDB_BASE_TITLE_PRINCIPALS;

INSERT INTO ST_IMDB_BASE_TITLE_PRINCIPALS (
	TCONST_NK
	,ORDERING
	,NCONST
	,CATEGORY
	,JOB
	,CHARACTERS
	,SRC_NAME
	,LOAD_DATE
	,NOTE
	)
SELECT TCONST_NK AS TCONST_NK
	,ORDERING AS ORDERING
	,NCONST AS NCONST
	,CATEGORY AS CATEGORY
	,JOB AS JOB
	,CHARACTERS AS CHARACTERS
	,SRC_NAME AS SRC_NAME
	,LOAD_DATE AS LOAD_DATE
	,NOTE AS NOTE
FROM SV_IMDB_BASE_TITLE_PRINCIPALS
ORDER BY TCONST_NK;

ANALYZE ST_IMDB_BASE_TITLE_PRINCIPALS;

/* LOG CURRENT LOAD INFO */
TRUNCATE TABLE X_IMDB_BASE_LOG;

INSERT INTO X_IMDB_BASE_LOG (
	LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_NAME
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT
	)
SELECT NOW()
	,10
	,S.SRC_NAME
	,'ST_IMDB_BASE_TITLE_PRINCIPALS'
	,MAX(S.LOAD_DATE)
	,SUM(ROW_COUNT)
	,SUM(DISTINCT_PK_COUNT)
FROM (
	SELECT TCONST_NK
		,SRC_NAME
		,MAX(LOAD_DATE) AS LOAD_DATE
		,COUNT(*) AS ROW_COUNT
		,1 AS DISTINCT_PK_COUNT
	FROM ST_IMDB_BASE_TITLE_PRINCIPALS
	GROUP BY TCONST_NK
		,SRC_NAME
	) AS S
GROUP BY S.SRC_NAME;

/* CHECK LOAD AND SAVE ETL HISTORY */
INSERT INTO ETL_LOG (
	SUBJECT_AREA
	,LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_NAME
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
	,SRC_NAME
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT
	,CASE
		WHEN COUNT(*) > 0
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE IS EMPTY. (TABLE ST_IMDB_BASE_TITLE_PRINCIPALS).'
	,CASE
		WHEN SUM(ROW_COUNT) = SUM(DISTINCT_PK_COUNT)
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE FAILED PRIMARY KEY TEST. (TABLE ST_IMDB_BASE_TITLE_PRINCIPALS).'
FROM X_IMDB_BASE_LOG
WHERE LOAD_SEQ_NUM = 10
GROUP BY LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_NAME
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT;

COMMIT;
