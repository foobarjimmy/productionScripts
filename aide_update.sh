#! /bin/bash
DATE=$(date +%F_%H:%M:%S)
AIDE_LOG_DIR="/var/log/aide"
AIDE_DB_DIR="/var/lib/aide"
AIDE_DB_FILE="${AIDE_DB_DIR}/aide.db.gz"
AIDE=$(which aide)

# function declaration
function mv_db_file () {
    mv "${AIDE_DB_DIR}/aide.db.new.gz" "${AIDE_DB_DIR}/aide.db.gz"
}

# make sure only rotate one copy of aide database
if [ -f "$AIDE_DB_FILE" ]
then
    if [ -e "$AIDE_DB_DIR/aide.db.gz.1" ]
        then
        rm -e "$AIDE_DB_DIR/aide.db.gz.1"
    fi
    mv "${AIDE_DB_FILE}" $AIDE_DB_DIR/aide.db.gz.1
fi

# recreate aide database and reuse as main database
if [ ! -e "$AIDE_DB_DIR/aide.db.new.gz" ]
then
    ${AIDE} --init
    mv_db_file
else
    mv_db_file
fi
