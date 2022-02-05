#!/bin/env bash

readonly BACKUP_FOLDER=pad_backups

main(){
    mkdir -p ${BACKUP_FOLDER}
    backup_master_pad
    backup_calls_notes_okfn_de
    # backup_calls_notes_okfn_org
}

backup_master_pad(){
    curl https://pad.okfn.de/p/openscience-ag-master-pad/export/txt \
	 > ${BACKUP_FOLDER}/openscience-ag-master-pad.txt
    sleep 10
    curl https://pad.okfn.de/p/openscience-ag-master-pad/export/html \
	 > ${BACKUP_FOLDER}/openscience-ag-master-pad.html
    sleep 10
}

backup_calls_notes_okfn_de(){
    for MEETING_NUMBER in $(seq 70 80)
    do
	NUMBER_STRING=$(printf "%03d" "${MEETING_NUMBER}")
	curl https://pad.okfn.de/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/txt \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".txt
	sleep 10
	curl https://pad.okfn.de/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/html \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".html
	sleep 10
    done
}


# Used for the earlier calls:
backup_calls_notes_okfn_org(){
    for MEETING_NUMBER in $(seq 02 22)
    do
	NUMBER_STRING=$(printf "%03d" "${MEETING_NUMBER}")
	lynx -dump -nolist -width=1024 https://pad.okfn.org/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}" \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".txt
	curl https://pad.okfn.org/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}" \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".html	
    done
}

main

## Alternative routine with automatic parsing of pad URLs from masterpad
#
# curl https://pad.okfn.de/p/openscience-ag-master-pad/export/txt | \
# grep -P ".*(https?:\/\/(pad.okfn.de|pad.okfn.org|etherpad.wikimedia.org)\/p\/[-_[:alnum:]]+).*" | \
# sed -E "s/.*(https?:\/\/(pad.okfn.de|pad.okfn.org|etherpad.wikimedia.org)\/p\/[-_[:alnum:]]+).*/\1/" | \
# while read URL;
# do
#     OUTFILE=`echo "$URL" | sed "s/.*\///"`
#     HOST=`echo "$URL" | sed -E "s/https?:\/\/(pad|etherpad).(okfn.de|okfn.org|wikimedia.org).*/\2/"`
#     case $HOST in
#         okfn.de|wikimedia.org)
#             curl --output ${BACKUP_FOLDER}/${OUTFILE}.txt "${URL}/export/txt"
#             curl --output ${BACKUP_FOLDER}/${OUTFILE}.html "${URL}/export/html"
#             ;;
#         okfn.org)
#             lynx -dump -nolist -width=1024 ${URL} > ${BACKUP_FOLDER}/${OUTFILE}.txt
#             curl --output ${BACKUP_FOLDER}/${OUTFILE}.html "${URL}"
#             ;;
#     esac
# done;

