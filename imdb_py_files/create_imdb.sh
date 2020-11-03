#!/bin/bash

## This script download the data and clone imdb-to-sql repo on github

## Requirements:
### - Python 2.6+
### - psycopg2 python lib
### - git client
### - wget


#### config STuff
## old code IMDB_SOURCE="ftp://ftp.fu-berlin.de/pub/misc/movies/database"
IMDB_SOURCE="https://datasets.imdbws.com"
## old code FILE_LIST=(aka-names aka-titles movies genres actors keywords actresses)
FILE_LIST=(name.basics title.akas title.basics title.crew title.episode title.principals title.ratings)

TARGET_DB="imdb"
TARGET_USER=$(whoami)
## STOP editing #######


PROGRAM_NAME=$(basename ${0} | awk -F . '{print $1}')


##### TESTS
rm -rf "${PROGRAM_NAME}"

mkdir -p "${PROGRAM_NAME}"
cd "${PROGRAM_NAME}"



function run_psql() {
	psql -c "${1}"
}

run_psql 'DROP DATABASE IF EXISTS imdb;'
run_psql 'CREATE DATABASE imdb;'

export PGDATABASE="${TARGET_DB}"

git clone https://github.com/ameerkat/imdb-to-sql.git
cd imdb-to-sql

## cp -rv ~/tmp/db_dump .

gsed -i -E 's|type[[:blank:]]{1,}\=[[:blank:]]{1,}DatabaseTypes.*|type \= DatabaseTypes\.POSTGRES|' $(pwd)/settings.py
gsed -i -E 's|database[[:blank:]]{1,}\=.*|database \= "'${TARGET_DB}'"|' $(pwd)/settings.py
gsed -i -E 's|clear_old_db[[:blank:]]{1,}\=.*|clear_old_db \= True|' $(pwd)/settings.py
gsed -i -E 's|user[[:blank:]]{1,}\=.*|user \= "'${TARGET_USER}'"|' $(pwd)/settings.py

mkdir -p db_dump && cd db_dump
for item in ${FILE_LIST[@]}; do
##	old code file_name="${item}.liST.gz"
	file_name="${item}.tsv.gz"
	file_url="${IMDB_SOURCE}/${file_name}"
	echo processing ${file_name}...

	wget -q -c "${file_url}"
	gunzip "${file_name}"
done

cd ..
python tosql.py
