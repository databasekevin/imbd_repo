/* COPY EXTERNAL DATA INTO EXT TABLE */
TRUNCATE TABLE EXT_IMDB_BASE_TITLE_PRINCIPALS;

/* CHARACTER CASE OF THE FOLLOWING LOAD SEQUENCE MUST REMAIN */
COPY EXT_IMDB_BASE_TITLE_PRINCIPALS FROM PROGRAM 'curl "https://datasets.imdbws.com/title.principals.tsv.gz" | gunzip' QUOTE '`' DELIMITER E'\t' NULL '\N' CSV HEADER;

ANALYZE EXT_IMDB_BASE_TITLE_PRINCIPALS;

COMMIT;
