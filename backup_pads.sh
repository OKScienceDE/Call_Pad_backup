#!/bin/env bash

readonly BACKUP_FOLDER=pad_backups

main(){
    mkdir -p ${BACKUP_FOLDER}
    backup_master_pad
    backup_calls_notes_okfn_de

    # To check:
    # backup_calls_notes_okfn_org
}

backup_master_pad(){
    curl https://pad.okfn.de/p/openscience-ag-master-pad/export/txt \
	 > ${BACKUP_FOLDER}/openscience-ag-master-pad.txt
    curl https://pad.okfn.de/p/openscience-ag-master-pad/export/html \
	 > ${BACKUP_FOLDER}/openscience-ag-master-pad.html
}

backup_calls_notes_okfn_de(){
    for MEETING_NUMBER in $(seq 23 60)
    do
	NUMBER_STRING=$(printf "%03d" "${MEETING_NUMBER}")
	curl https://pad.okfn.de/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/txt \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".txt
	curl https://pad.okfn.de/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/html \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".html
    done
}


# Used for the earlier calls:
backup_calls_notes_okfn_org(){
    for MEETING_NUMBER in $(seq 02 22)
    do
	NUMBER_STRING=$(printf "%03d" "${MEETING_NUMBER}")
	curl https://pad.okfn.org/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/txt \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".txt
	curl https://pad.okfn.org/p/Open_Science_AG_Public_Call_"${NUMBER_STRING}"/export/html \
	     > ${BACKUP_FOLDER}/Open_Science_AG_Public_Call_"${NUMBER_STRING}".html	
    done
}

main
