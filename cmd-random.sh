#!/bin/bash
# Script to get a random file from a folder, or specified subfolder

DIR=BoneBot-Scripts/images

# Get any input
IFS=' ' read -ra INPUT_ARRAY <<< "${BB_INPUT}"

if [ ! -z ${INPUT_ARRAY[0]} ]; then
  
  # Check if attempting to traverse to parent directories
  if ! echo ${INPUT_ARRAY[0]} | grep -q ".."; then
    
    echo ${INPUT_ARRAY[0]}
    DIR=${DIR}/${INPUT_ARRAY[0]}

  elif BoneBot-Scripts/hasperm.sh TRUSTED; then

    DIR=${DIR}/${INPUT_ARRAY[0]}

  else
    
    echo "You are not allowed to traverse to parent directories"

  fi

fi

# Find files in this directory, exclude hidden files. Get a random file and get it's full path
readlink -f $( find ${DIR} -not -path '*/[@.]*' -type f | shuf -n1)
