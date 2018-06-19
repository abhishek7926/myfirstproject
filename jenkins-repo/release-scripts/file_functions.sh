function deleteOlderFiles() {
    PARENT_DIR=$1
    DIRS_COUNT_TO_BE_SKIPPED=$2

    cd ${PARENT_DIR}
    DIR_COUNT=`ls -lrt | wc -l`
    if [ $DIR_COUNT -le $DIRS_COUNT_TO_BE_SKIPPED ]; then
       exit;
    else
       DIR_COUNT_TO_DELETE=$((${DIR_COUNT}-${DIRS_COUNT_TO_BE_SKIPPED}))
       echo "Removing $DIR_COUNT_TO_DELETE directories under ${PARENT_DIR}"
       ls -lrt | head -$DIR_COUNT_TO_DELETE | awk '{print $9}'
       rm -rvf `ls -lrt | head -$DIR_COUNT_TO_DELETE | awk '{print $9}'`
    fi
}

