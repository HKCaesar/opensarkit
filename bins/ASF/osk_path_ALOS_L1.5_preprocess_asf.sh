#!/bin/bash


#-------------------------------------------------------------------------------------------
#	ALOS Level 1.5 FBD DualPol Bulk Preprocessing
#
#	Dependencies:
#
#		- SAGA GIS 
#		- Sentinel 1 Toolbox
#		- ASF Mapready
#		- gdal
#
#-------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------
#	0 Set up Script variables
#-------------------------------------------------------------------------------------------

# TMP sourcing for Sepal env.
source /data/home/Andreas.Vollrath/github/OpenSARKit_source.bash >/dev/null 2>&1
source /home/avollrath/github/OpenSARKit/OpenSARKit_source.bash >/dev/null 2>&1

#-------------------------------------------------------------------------------------------	
# 	0.1 Check for right usage & set up basic Script Variables
if [ "$#" != "2" ]; then
  echo -e "Usage: osk_ALOS_L1_1_preprocess /path/to/paths /path/to/dem"
  echo -e "The path will be your Project folder!"
  exit 1
else
  echo "----------------------"
  echo "Welcome to OpenSARKit!"
  echo "----------------------"
# set up input data
  cd $1
  PROC_DIR=`pwd`
  DEM_FILE=$2
  echo "Processing folder: ${PROC_DIR}"

fi


cd ${PROC_DIR}

for DATE in `ls -1 -d [0-9]*`;do

	echo "------------------------------------------------"
	echo " Bulk Processing ALOS Scenes from ${DATE} (YYYYMMDD)"
	echo "------------------------------------------------"

	cd ${DATE}

	for FILE in `ls -1 *.zip`;do
		bash ${ASF_BIN}/osk_single_ALOS_L1.5_preprocess_asf.sh ${FILE} $2 ${PROC_DIR}/${DATE}  
	done

	# possible Path mosaicing --> use extra script, that could be used also later on
	#list=`ls -d */Gamma0* | tr '\ ' ';'`

	cd ${PROC_DIR}
done

