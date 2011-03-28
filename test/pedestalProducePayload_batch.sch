#!/bin/csh

set tag = "HcalPedestals_ADC_v9.12_offline"
set run = 155555
set threshold  = 0.2

cmsrel CMSSW_3_11_0
cd CMSSW_3_11_0/src/
cmsenv
cvs co CalibCalorimetry/HcalStandardModules
scram b
cd CalibCalorimetry/HcalStandardModules/test

set localDir = ${1}
# copy the file from you local directory (need to be specified in ${1} - first parameter for this script)
cp ${localDir}/pedstxt.zip .

    sed -i "s:<send_tag>:${tag}:g" pedestalProducePayload.csh
    sed -i "s:<send_run>:${run}:g" pedestalProducePayload.csh
    sed -i "s:<send_thresh>:${threshold}:g" pedestalProducePayload.csh

./pedestalProducePayload.csh > logfile_pedestalProducePayload.txt

cp test.db $localDir
cp logfile_pedestalProducePayload.txt $localDir


