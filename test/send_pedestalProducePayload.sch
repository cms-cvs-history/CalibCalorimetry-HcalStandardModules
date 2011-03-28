#!/bin/csh

set currentDir = `pwd`
echo "current dir is "  $currentDir 

set tag = "HcalPedestals_ADC_v9.12_offline"
set run = 155555
set threshold  = 0.2

cmsrel CMSSW_3_11_0
cd CMSSW_3_11_0/src/
cmsenv
cvs co CalibCalorimetry/HcalStandardModules
scram b
cd CalibCalorimetry/HcalStandardModules/test

cp <pedFileDir>/pedstxt.zip .

    sed -i "s:<send_tag>:${tag}:g" pedestalProducePayload.csh
    sed -i "s:<send_run>:${run}:g" pedestalProducePayload.csh
    sed -i "s:<send_thresh>:${threshold}:g" pedestalProducePayload.csh

./pedestalProducePayload.csh > logfile_pedestalProducePayload.txt

cp test.db $currentDir
cp logfile_pedestalProducePayload.txt $currentDir


