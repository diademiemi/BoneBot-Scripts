#!/bin/bash
# Script to deepfry an image

# Get image from image resolving script
IMAGE=$(BoneBot-Scripts/getimg.sh)

# Delete old image(s) if they exist
rm ./BoneBot-Scripts/temp/fryout*.png

# Create a function to deepfry given image
function fry {
   convert ${IMAGE} \
  -sharpen 0x5.0 \
  -modulate 100,150 \
  -resize 50% \
  -resize 200% \
  -contrast \
  +noise poisson \
  -equalize \
  -sharpen 0x4.0 \
  -fill red -tint 90 \
  -fill yellow -tint 100 \
  -gamma 0.5 \
  ./BoneBot-Scripts/temp/fryout.png &>/dev/null
}

# If the command errors
if ! fry; then
  echo ":octagonal_sign: No file found\!";
fi

# Get input
IFS=' ' read -ra INPUT_ARRAY <<< "${BB_INPUT^^}"

# If number is greater than 0 and lesser than or equal to 10
if [ ${INPUT_ARRAY[0]} -le 10 ] && [ ${INPUT_ARRAY[0]} -gt 0 ]; then
  
  # If user has the EXTRA permission
  if BoneBot-Scripts/hasperm.sh EXTRA; then

    # Start at 2, this means it counts the 1 already ran
    i=2

    # Redefine image input to the output path
    IMAGE=./BoneBot-Scripts/temp/fryout.png
    
    # While loop to deepfry
    while [ $i -le ${INPUT_ARRAY[0]} ]; do

      fry
      ((i++))

    done

  else

    echo "Because of resource usage, you need permission to loop deepfry"

  fi

fi
