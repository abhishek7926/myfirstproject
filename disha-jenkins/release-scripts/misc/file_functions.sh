function deleteOlderDirectories() {
	PARENT_DIR=$1
	DIRS_COUNT_TO_BE_SKIPPED=$2

	echo "Removing directories under ${PARENT_DIR}"
	cd ${PARENT_DIR}
	DIR_COUNT=`ls -lrtd */ | wc -l`
	ls -lrtd */ | head -$((${DIR_COUNT}-${DIRS_COUNT_TO_BE_SKIPPED})) | awk '{print $9}'
	rm -rvf `ls -lrtd */ | head -$((${DIR_COUNT}-${DIRS_COUNT_TO_BE_SKIPPED})) | awk '{print $9}'`
}

function deleteOlderFiles() {
        PARENT_DIR=$1
        DIRS_COUNT_TO_BE_SKIPPED=$2

        echo "Removing directories under ${PARENT_DIR}"
        cd ${PARENT_DIR}
        DIR_COUNT=`ls -lrt | wc -l`
        ls -lrt | head -$((${DIR_COUNT}-${DIRS_COUNT_TO_BE_SKIPPED})) | awk '{print $9}'
        rm -rvf `ls -lrt | head -$((${DIR_COUNT}-${DIRS_COUNT_TO_BE_SKIPPED})) | awk '{print $9}'`
}

