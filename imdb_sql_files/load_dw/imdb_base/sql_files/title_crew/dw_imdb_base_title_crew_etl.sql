TRUNCATE TABLE X_IMDB_BASE_TITLE_CREW_CHG;

/* DETECT CHANGES */
INSERT INTO X_IMDB_BASE_TITLE_CREW_CHG (
	P_TCONST_ID
	,TCONST_NK
	,DIRECTORS
	,WRITERS
	,SRC_NAME
	,LOAD_DATE
	,NOTE
	,CHG_FLG
	)
SELECT DW.P_TCONST_ID
	,ST.TCONST_NK
	,ST.DIRECTORS
	,ST.WRITERS
	,ST.SRC_NAME
	,ST.LOAD_DATE
	,ST.NOTE
	,CASE
		WHEN DW.P_TCONST_ID IS NULL
			THEN 'I'
		ELSE 'X'
		END
FROM ST_IMDB_BASE_TITLE_CREW ST
LEFT OUTER JOIN DW_IMDB_BASE_TITLE_CREW DW
	ON DW.TCONST_NK = ST.TCONST_NK
WHERE DW.P_TCONST_ID IS NULL
	OR DW.DIRECTORS <> ST.DIRECTORS
	OR DW.WRITERS <> ST.WRITERS
	OR DW.SRC_NAME <> ST.SRC_NAME
	OR DW.NOTE <> ST.NOTE;

ANALYZE X_IMDB_BASE_TITLE_CREW_CHG;

/* SAVE CURRENT X_CHG LOAD LOG */
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
	,20
	,X.SRC_NAME
	,'X_IMDB_BASE_TITLE_CREW_CHG'
	,MAX(X.LOAD_DATE)
	,SUM(ROW_COUNT)
	,SUM(DISTINCT_PK_COUNT)
FROM (
	SELECT TCONST_NK
		,SRC_NAME
		,MAX(LOAD_DATE) AS LOAD_DATE
		,COUNT(*) AS ROW_COUNT
		,1 AS DISTINCT_PK_COUNT
	FROM X_IMDB_BASE_TITLE_CREW_CHG
	GROUP BY TCONST_NK
		,SRC_NAME
	) AS X
GROUP BY X.SRC_NAME;

/* SAVE X_CHG ETL LOG HISTORY */
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
	,'NO RECORDS TO UPSERT. (TABLE X_IMDB_BASE_TITLE_CREW_CHG).'
	,CASE
		WHEN SUM(ROW_COUNT) = SUM(DISTINCT_PK_COUNT)
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE FAILED PRIMARY KEY TEST. (TABLE X_IMDB_BASE_TITLE_CREW_CHG).'
FROM X_IMDB_BASE_LOG
WHERE LOAD_SEQ_NUM = 20
GROUP BY LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_NAME
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT;

/* INSERT CHANGES */
INSERT INTO DW_IMDB_BASE_TITLE_CREW (
	P_TCONST_ID
	,TCONST_NK
	,DIRECTORS
	,WRITERS
	,SRC_NAME
	,LOAD_DATE
	,LAST_UPDATE
	,NOTE
	)
SELECT M.MAX_ID + ROW_NUMBER() OVER (
		ORDER BY ST.TCONST_NK
		)
	,ST.TCONST_NK
	,ST.DIRECTORS
	,ST.WRITERS
	,ST.SRC_NAME
	,ST.LOAD_DATE
	,ST.LOAD_DATE
	,ST.NOTE
FROM X_IMDB_BASE_TITLE_CREW_CHG ST
	,(
		SELECT MAX(P_TCONST_ID) MAX_ID
		FROM DW_IMDB_BASE_TITLE_CREW
		) M
WHERE ST.CHG_FLG = 'I';

/* UPDATE CHANGES */
UPDATE DW_IMDB_BASE_TITLE_CREW
SET TCONST_NK = X.TCONST_NK
	,DIRECTORS = X.DIRECTORS
	,WRITERS = X.WRITERS
	,SRC_NAME = X.SRC_NAME
	,LAST_UPDATE = X.LOAD_DATE
	,NOTE = X.NOTE
FROM X_IMDB_BASE_TITLE_CREW_CHG X
WHERE X.TCONST_NK = DW_IMDB_BASE_TITLE_CREW.TCONST_NK
	AND X.CHG_FLG = 'X';

ANALYZE DW_IMDB_BASE_TITLE_CREW;

/* SAVE CURRENT DW LOAD LOG */
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
	,30
	,DW.SRC_NAME
	,'DW_IMDB_BASE_TITLE_CREW'
	,MAX(DW.LAST_UPDATE)
	,SUM(ROW_COUNT)
	,SUM(DISTINCT_PK_COUNT)
FROM (
	SELECT DW.TCONST_NK
		,DW.SRC_NAME
		,MAX(DW.LAST_UPDATE) AS LAST_UPDATE
		,COUNT(*) AS ROW_COUNT
		,1 AS DISTINCT_PK_COUNT
	FROM DW_IMDB_BASE_TITLE_CREW DW
	JOIN X_IMDB_BASE_TITLE_CREW_CHG X
		ON DW.TCONST_NK = X.TCONST_NK
	WHERE DW.LAST_UPDATE = (
			SELECT MAX(LOAD_DATE)
			FROM X_IMDB_BASE_TITLE_CREW_CHG
			)
	GROUP BY DW.TCONST_NK
		,DW.SRC_NAME
	) AS DW
GROUP BY DW.SRC_NAME;

/* SAVE ETL LOG HISTORY */
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
	,FAIL_CHECK_BOOL_3
	,ERROR_MESSAGE_3
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
	,'NO RECORDS UPSERTED. (TABLE DW_IMDB_BASE_TITLE_CREW).'
	,CASE
		WHEN SUM(ROW_COUNT) = SUM(DISTINCT_PK_COUNT)
			THEN 0
		ELSE 1
		END
	,'DATA SOURCE FAILED PRIMARY KEY TEST. (TABLE DW_IMDB_BASE_TITLE_CREW).'
	,CASE
		WHEN (SELECT ROW_COUNT FROM X_IMDB_BASE_LOG	WHERE LOAD_SEQ_NUM = 20) = ROW_COUNT
			THEN 0
		ELSE 1
		END
	,CONCAT ('CHANGED RECORD COUNT INCORRECT. TABLE X_IMDB_BASE_TITLE_CREW_CHG = '
		,(SELECT ROW_COUNT FROM X_IMDB_BASE_LOG	WHERE LOAD_SEQ_NUM = 20)
		,', TABLE DW_IMDB_BASE_TITLE_CREW ='
		,ROW_COUNT)
FROM X_IMDB_BASE_LOG
WHERE LOAD_SEQ_NUM = 30
GROUP BY LOAD_TIMESTAMP
	,LOAD_SEQ_NUM
	,SRC_NAME
	,OBJECT_NAME
	,LOAD_DATE
	,ROW_COUNT
	,DISTINCT_PK_COUNT;

COMMIT;
