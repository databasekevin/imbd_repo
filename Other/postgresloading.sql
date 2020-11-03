CREATE TABLE titleBasics (
    tconST         varchar(10) PRIMARY KEY,
    titleType      varchar(20),
    primaryTitle   varchar(400),
    originalTitle  varchar(400),
    isAdult        int,
    STartYear      int,
    endYear        int,
    runtimeMinutes int,
    genres         varchar(100)
);

\COPY titleBasics FROM '/Users/mikejcarey/IMDBData/title.basics.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE titleRatings (
    tconST         varchar(10) PRIMARY KEY,
    averageRating  float,
    numVotes       int
);

\COPY titleRatings FROM '/Users/mikejcarey/IMDBData/title.ratings.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE titleCrew (
    tconST         varchar(10) PRIMARY KEY,
    directors      varchar(5000),
    writers        varchar(7000)
);

\COPY titleCrew FROM '/Users/mikejcarey/IMDBData/title.crew.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE titleEpisode (
    tconST         varchar(10) PRIMARY KEY,
    parentTconST   varchar(10),
    seasonNumber   int,
    episodeNumber  int
);

\COPY titleEpisode FROM '/Users/mikejcarey/IMDBData/title.episode.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE titlePrincipals (
    tconST         varchar(10) PRIMARY KEY,
    principalCaST  varchar(200)
);

\COPY titlePrincipals FROM '/Users/mikejcarey/IMDBData/title.principals.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE titleAkas (
    titleId varchar(10),
    ordering int,
    title varchar(1000),
    region varchar(100),
    language varchar(100),
    types varchar(100),
    attributes varchar(100),
    isOriginalTitle int
);

\COPY titleAkas FROM '/Users/mikejcarey/IMDBData/title.akas.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;

CREATE TABLE nameBasics (
    nconST varchar(10),
    primaryName varchar(400),
    birthYear int,
    deathYear int,
    primaryProfession varchar(100),
    knownForTitles varchar(100)
);

\COPY nameBasics FROM '/Users/mikejcarey/IMDBData/name.basics.tsv' QUOTE '|' DELIMITER E'\t' NULL '\N' CSV HEADER;
