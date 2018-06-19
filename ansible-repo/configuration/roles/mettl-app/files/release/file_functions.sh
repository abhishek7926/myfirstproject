function createEmptyFile() {
	>| "$1"	
}

# To search *log* FILE_REGEX=.*\(log\)*
# To search *.log FILE_REGEX=.*.log 
function findFilesOfDirectoryRecursively() {
	local DIRECTORY_PATH_TO_SEARCH="$1"
	local FILE_REGEX="$2"
	local OUTPUT_FILE_NAME="$3"
	find "$DIRECTORY_PATH_TO_SEARCH" -regex "$FILE_REGEX" -type f -follow > "$OUTPUT_FILE_NAME"
}

#Returns top N lines after sorting the content of file in Descending order
function findNSortedLines() {
	local INPUT_FILE="$1"
	local OUTPUT_FILE="$2"
	local NUMBER_OF_FILES="$3"
	cat "$INPUT_FILE" | sort -gr | head -"$NUMBER_OF_FILES" > "$OUTPUT_FILE" 
}

function getSizeOfFile() {
	local INPUT_FILE="$1"
	du -sb  ${INPUT_FILE} | awk '{print $1}'
}

#Returns 2 dimensional data first column is the size of file and second column is name of file
function getSizeOfFiles() {
	local INPUT_FILE="$1"
	local OUTPUT_FILE="$2"
	createEmptyFile ${OUTPUT_FILE}	
	echo "Calculating of size of files in ${INPUT_FILE} to ${OUTPUT_FILE}"
	while read fileName
	do
		du -sb "$fileName" >> "$OUTPUT_FILE"
	done < "$INPUT_FILE"
}

#Returns 2 dimension data first column is the size of file and second column is name of file, with the filter of minimum size
function findFilesAboveThresholdSize() {
	local INPUT_FILE="$1"
        local OUTPUT_FILE="$2"
        local THRESHOLD_FILE_SIZE="$3"

	getSizeOfFiles ${INPUT_FILE} ${INPUT_FILE}.tmp
	createEmptyFile ${OUTPUT_FILE}
	while read fileNameWithSize
	do
		echo "Processing file ${fileNameWithSize}"
		sizeOfFile=`echo "$fileNameWithSize" | awk '{print $1}'`
		if [ "${sizeOfFile}" -ge "${THRESHOLD_FILE_SIZE}" ]
		then
			echo "$fileNameWithSize" >> "$OUTPUT_FILE"
		#else
		#	exit 0
		fi
	done < "${INPUT_FILE}.tmp"
}

function getLineNoMatchingRegex() {
	local FILE_NAME="$1"
	local PATTERN="$2"

	echo `grep -i -n -w "$PATTERN" "$FILE_NAME" | awk '{print $1}' | cut -d':' -f1`
}

function deleteLineFromFile() {
	local LINE_NO="$1"
	local FILE_NAME="$2"

	sed -i ''$LINE_NO'd' "$FILE_NAME"
}

function numberOfLinesInFile() {
	local FILE_NAME="$1"
	echo `wc -l "$FILE_NAME" | awk '{print $1}'`
}

function addLineIfNotPresent() {
	local FILE_NAME="$1"
	local LINE="$2"
	local lineCount=`getLineNoOfMatchingRegex $LINE $FILE_NAME`
	if [ "" = "$lineCount" ]; then
		echo "Adding $LINE at the end of $FILE_NAME"
		echo $LINE >> $FILE_NAME
	fi
}

function addLineBelow() {
	local LINE_NO="$1"
	local LINE="$2"
	local FILE_NAME="$3"

	sed -i ''$LINE_NO' a\'"$LINE"'' "$FILE_NAME"
}

function addLineAbove() {
	local LINE_NO="$1"
	local LINE="$2"
	local FILE_NAME="$3"

	sed -i ''$LINE_NO' i\'"$LINE"'' "$FILE_NAME"
}

function appendLine() {
	local FILE_NAME="$1"
	local LINE="$2"
	
	echo $LINE >> $FILE_NAME
}

function getStringAtLineNo(){
    START_LINE_NO=$1
    LOG_FILE=$2
    LINE_STRING=$( ( sed -n "$START_LINE_NO"p "$LOG_FILE" ) )
    echo "$LINE_STRING"
}

function getWordAtPosition() {
	local LINE="$1"
	local POSITION="$2"
	local SEPARATOR=$3
	WORD=$( echo "${LINE}" | cut -f${POSITION} -d${SEPARATOR} )
	echo "${WORD}"
}

function syncFolders() {
	SOURCE=$1
	TARGET=$2
	
        cp -r ${SOURCE}/*  ${TARGET}/
}

function copyFile() {
	from="$1"
	to="$2"
	cp -v "$from" "$to"
}

function moveFile() {
	from="$1"
	to="$2"
	mv -v "$from" "$to"
}

function createDirectory() {
	directoryName="$1"
	mkdir -p "$directoryName"
}

function removeFile() {
	filePath="$1"
	rm -vf "$filePath"
}

function removeDirectory() {
	directoryPath="$1"
	rm -rf "$directoryPath"
}	

function fileExists() {
	local FOLDER_PATH="$1"
	local FILE_NAME="$2"
	if [ -f ${FOLDER_PATH}/${FILE_NAME} ]; then
		echo "1"
	else
		echo "0"
	fi
}

function exitIfFileNotExists () {
	FILE=$1
	if [ ! -f ${FILE} ]; then
        	echo "${FILE} doesn't exists..! Please check"
	        exit 1;
	fi
}

function exitWhenDirectoryExists() {
	DIRECTORY=$1
	if [ -d $DIRECTORY ]; then
        	echo "${DIRECTORY} doesn't exists..! Please check"
	        exit 1;
	fi
}

# I'll process a OUT_TEMPLATE_FILE and replace all the SEARCH values with REPLACE values 
function processTemplateFile() {
	OUT_TEMPLATE_FILE=$1
	SEARCH=$2
	REPLACE=$3
	echo "Performing replace operation using s/${SEARCH}/${REPLACE}/g"
	sed -i  s/${SEARCH}/${REPLACE}/g $OUT_TEMPLATE_FILE
}

# I'll find files older then n number of days
function findOlderFiles() {
	FILESEARCH_REGEX=$1
	OLD_FILE_DAYS=$2
	#echo "Finding files older then ${OLD_FILE_DAYS}"
	find  ${FILESEARCH_REGEX} -type f -mtime +${OLD_FILE_DAYS}
}

function findRecentlyModifiedFiles() {
	FILESEARCH_REGEX=$1
	OLD_FILE_MINS=$2
	#echo "Finding files older then ${OLD_FILE_DAYS}"
	find  ${FILESEARCH_REGEX} -type f -mmin -${OLD_FILE_MINS}
}

function exitIfFileContainsData() {
	FILE=$1
	MSG=$2
	if [ -s $FILE ]; then
		echo "$MSG"
		exit 1
	fi
}

function initializFile(){
    FILE_NAME=$1
    :>$FILE_NAME
}

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

function moveFolderToS3() {
	CURRENT_TIME=`date +%Y/%m/%d`
	FOLDER_PATH=$1
	S3_FOLDER=$2

	S3_BACKUP_FOLDER=s3://${S3_FOLDER}/${CURRENT_TIME}/

#        echo "Moving content  in ${FOLDER_PATH} logs to ${BACKUP_LOG_DIR}"
#	aws s3 mv --recursive ${FOLDER_PATH} ${S3_BACKUP_FOLDER}

	date
        echo "Compressing ${FOLDER_PATH}"
	tar -czf backup.tar.gz ${FOLDER_PATH}
	echo "Moving content  in ${FOLDER_PATH} to ${S3_BACKUP_FOLDER}"
	aws s3 mv backup.tar.gz ${S3_BACKUP_FOLDER}

	date
	echo "Copying done ${FOLDER_PATH} to ${S3_BACKUP_FOLDER}"	
	rm -rf ${FOLDER_PATH}/*

}

