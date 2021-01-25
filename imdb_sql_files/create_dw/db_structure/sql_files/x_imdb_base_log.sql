DROP TABLE IF EXISTS X_IMDB_BASE_LOG;

CREATE TABLE X_IMDB_BASE_LOG(
LOAD_TIMESTAMP TIMESTAMPTZ
,LOAD_SEQ_NUM INTEGER
,SRC_NAME TEXT
,OBJECT_NAME TEXT
,LOAD_DATE DATE
,ROW_COUNT INTEGER
,DISTINCT_PK_COUNT INTEGER
,CREATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
--,UPDATED_AT TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

--CREATE TRIGGER X_IMDB_BASE_LOG_UPDT
--BEFORE UPDATE ON X_IMDB_BASE_LOG
--FOR EACH ROW
--EXECUTE PROCEDURE TRIGGER_SET_TIMESTAMP();
