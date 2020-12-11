DROP TABLE IF EXISTS ETL_LOG;

CREATE TABLE ETL_LOG (
	SUBJECT_AREA TEXT
	,LOAD_TIMESTAMP TIMESTAMPTZ
	,LOAD_SEQ_NUM TEXT
	,SRC_ID TEXT
	,OBJECT_NAME TEXT
	,LOAD_DATE DATE
	,ROW_COUNT INT
	,DISTINCT_PK_COUNT INT
	,FAIL_CHECK_BOOL_1 INT DEFAULT 0
	,ERROR_MESSAGE_1 TEXT DEFAULT 'N/A'
	,FAIL_CHECK_BOOL_2 INT DEFAULT 0
	,ERROR_MESSAGE_2 TEXT DEFAULT 'N/A'
	,FAIL_CHECK_BOOL_3 INT DEFAULT 0
	,ERROR_MESSAGE_3 TEXT DEFAULT 'N/A'
	,FAIL_CHECK_BOOL_4 INT DEFAULT 0
	,ERROR_MESSAGE_4 TEXT DEFAULT 'N/A'
	,FAIL_CHECK_BOOL_5 INT DEFAULT 0
	,ERROR_MESSAGE_5 TEXT DEFAULT 'N/A'
	,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
	,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
	);

	CREATE TRIGGER ETL_LOG_UPDT
	BEFORE UPDATE ON ETL_LOG
	FOR EACH ROW
	EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();
