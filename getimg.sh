#!/bin/bash
# Script to resolve image attachments and return result
# PRIORITY: Mentioned user avatar > Attached file in referenced message > Embedded file in referenced message > Attached file > Embedded file 

# Check if image ends in these file extensions
# Not a foolproof way to prevent crashes, but better than not having anything
# Ignores ?size and other URL variables
CHECK='.*\.(jpg|jpeg|png|bmp|ico|pdf|tiff|webp)($|\?)'

if echo ${BB_MENTION_AVATAR} | grep -qE "${CHECK}"; then
  echo "${BB_MENTION_AVATAR}"
elif echo ${BB_REPLY_FILE} | grep -qE "${CHECK}"; then
  echo "${BB_REPLY_FILE}"
elif echo ${BB_REPLY_EMBED} | grep -qE "${CHECK}"; then
  echo "${BB_REPLY_EMBED}"
elif echo ${BB_FILE} | grep -qE "${CHECK}"; then
  echo "${BB_FILE}"
elif echo ${BB_EMBED} | grep -qE "${CHECK}"; then
  echo "${BB_EMBED}"
fi
