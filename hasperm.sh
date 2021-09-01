#!/bin/bash
# Check if user has the permission 

# Read and check permissions file for this user ID
if grep -q "${BB_ID}" "BoneBot-Scripts/perms/${1}"; then
  exit 0
else
  echo ":octagonal_sign: You are not permitted to execute this!"
  exit 1
fi

