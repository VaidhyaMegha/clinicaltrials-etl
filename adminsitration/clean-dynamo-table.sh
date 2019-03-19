#!/bin/bash
set -ex

# https://gist.githubusercontent.com/toshke/d972b56c6273639ace5f62361e1ffac1/raw/80bb503618c8938179bac7a78f8ed93221d59927/clean-dynamo-table
####
#### Delete (remove) all items from Aws Dynamo DB table, by specifing table name and primary key
####
#### Forked from https://gist.github.com/k3karthic/4bc929885eef40dbe010
####
#### Usage: 
#### clean-dynamo-table TABLE_NAME PRIMARY_KEY
####

set -e

TABLE_NAME=$1
KEY_NAME=$2

# Get id list
aws dynamodb scan --table-name $TABLE_NAME --output json | jq ".Items[].$KEY_NAME.S" > "/tmp/dynamo_${TABLE_NAME}_keys.txt"

# Delete from id list
cat /tmp/dynamo_${TABLE_NAME}_keys.txt | while read f
do
  echo "Deleting $key from $TABLE_NAME..."
  aws dynamodb delete-item --table-name $TABLE_NAME --key "{ \"$KEY_NAME\": { \"S\": "${f/"//}" }}"
done

# Remove id list
rm "/tmp/dynamo_${TABLE_NAME}_keys.txt"
