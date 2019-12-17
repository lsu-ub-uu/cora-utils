#! /bin/bash
NUMBER_OF_PARAM=$#
WORKSPACE_PATH=/mnt/depot/cora/eclipse201909forcora5/workspace
CURRENT_PATH=''
#CURRENT_PATH=/mnt/depot/cora/eclipse201909forcora5/workspace/timestampChanger/cora/

if [ $NUMBER_OF_PARAM -eq "0" ]
then
    CURRENT_PATH=$WORKSPACE_PATH
    echo "No parameters found, using the following path "$CURRENT_PATH
elif [ $NUMBER_OF_PARAM -eq "1" ] 
then
    CURRENT_PATH=$WORKSPACE_PATH$1
    echo "Parameter found, using the following path "$CURRENT_PATH
else 
    echo "More than one parameter found"
    exit 1
fi

echo $CURRENT_PATH

echo "Decompress files"
find $CURRENT_PATH -name '*.gz' -exec gzip -d {} \;

echo "Update files"
find $CURRENT_PATH -name '*.json'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3})"/"\1T\2000Z"/g' {} \;
find $CURRENT_PATH -name '*.json'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{2})"/"\1T\20000Z"/g' {} \;
find $CURRENT_PATH -name '*.json'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{1})"/"\1T\200000Z"/g' {} \;
find $CURRENT_PATH -name '*.wiki'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3})"/"\1T\2000Z"/g' {} \;
find $CURRENT_PATH -name '*.wiki'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{2})"/"\1T\20000Z"/g' {} \;
find $CURRENT_PATH -name '*.wiki'  -exec sed -i -E 's/"([0-9]{4}-[0-9]{2}-[0-9]{2})[ ]([0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{1})"/"\1T\200000Z"/g' {} \;

echo "Compress files"
find $CURRENT_PATH -name '*.json' -exec gzip {} \;
