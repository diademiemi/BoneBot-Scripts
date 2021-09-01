#!/bin/bash
# Admin commands for BoneBot-Scripts

IFS=' ' read -ra INPUT_ARRAY <<< "${BB_INPUT^^}"

case ${INPUT_ARRAY[0]} in

  ADDPERM)

    if BoneBot-Scripts/hasperm.sh ADMIN; then

      if [ ! -z ${INPUT_ARRAY[1]} ]; then

        # Make sure the file exists
        if [ ! -f "./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}" ]; then

          touch ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}

        fi
        
        # Check if user was given
        if echo ${INPUT_ARRAY[2]} | grep -P '(?<!\d)\d{18}(?!\d)'; then

          # Check if user already has perm
          if ! grep ${INPUT_ARRAY[2]} ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}; then

            # Get ID and add to file
            echo ${INPUT_ARRAY[2]} | grep -oP '(?<!\d)\d{18}(?!\d)' >> ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}
            echo ":white_check_mark: Permission added!"

          else 
            
            echo "User already has this permission!"

          fi

        else

          echo "Please attach a user ID or ping"

        fi

      else
        
        echo "Please specify a role name"

      fi

    fi

    ;;

  RMPERM)

    if BoneBot-Scripts/hasperm.sh ADMIN; then

      if [ ! -z ${INPUT_ARRAY[1]} ]; then

        # Make sure the file exists
        if [ ! -f "./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}" ]; then

          touch ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}

        fi
        
        # Check if the user was given
        if echo ${INPUT_ARRAY[2]} | grep -qP '(?<!\d)\d{18}(?!\d)'; then

          # Check if user has this permission
          if grep -q $(echo ${INPUT_ARRAY[2]} | grep -oP '(?<!\d)\d{18}(?!\d)' ) ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}; then

            sed -i "/$(echo ${INPUT_ARRAY[2]} | grep -oP '(?<!\d)\d{18}(?!\d)' )/d" ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]}
            echo ":white_check_mark: Permission removed from user! "

          else 
            
            echo "User does not have this permission"

          fi

        else

          # Delete permission if no user given
          # Deleting does not actually delete, it moves the file so it can be recovered
          # Deny removing admin perm
          if [ ! ${INPUT_ARRAY[1]} == ADMIN ]; then

            mv ./BoneBot-Scripts/perms/${INPUT_ARRAY[1]} ./BoneBot-Scripts/perms/.deleted-${INPUT_ARRAY[1]}
            echo ":white_check_mark: Permission deleted!"

          else

            echo "Please don't delete the ADMIN permission!"

          fi

        fi

      else
        
        echo "Please specify a role permission"

      fi

    fi

    ;;

  PERMS)

    if BoneBot-Scripts/hasperm.sh ADMIN; then

      # Check if user was given
      if [ ! -z ${INPUT_ARRAY[1]} ]; then

        echo 'This user has the following permissions: ```'

        # Get every permission
        for f in ./BoneBot-Scripts/perms/*; do

          # Check if user has it
          if grep -q "$(echo ${INPUT_ARRAY[2]} | grep -qP '(?<!\d)\d{18}(?!\d)' )" $f; then

            echo $(basename $f)

          fi
          
        done

        echo '```'

      else

        echo 'The following permissions exist: ```'

        # Get every permission
        for f in ./BoneBot-Scripts/perms/*; do

          echo $(basename $f)

        done

        echo '```'

      fi

    fi

    ;;


  ENV)

    if BoneBot-Scripts/hasperm.sh TRUSTED; then

      # Check if variable was specified and if it starts with BB_
      if [ ! -z ${INPUT_ARRAY[1]} ] && [[ ${INPUT_ARRAY[1]} = BB_* ]]; then

        # Return variable
        echo '```'
        echo ${INPUT_ARRAY[1]}
        echo ${!INPUT_ARRAY[1]}
        echo '```'

      else
         
        # Return a list of all variables if no variable was specified
        echo '```'

        echo BB_INPUT
        echo $BB_INPUT
        echo BB_USER
        echo $BB_USER
        echo BB_ID
        echo $BB_ID
        echo BB_AVATAR
        echo $BB_AVATAR
        echo BB_FILE
        echo $BB_FILE
        echo BB_EMBED
        echo $BB_EMBED

        echo BB_MENTION_USER
        echo $BB_MENTION_USER
        echo BB_MENTION_ID
        echo $BB_MENTION_ID
        echo BB_MENTION_AVATAR
        echo $BB_MENTION_AVATAR

        echo BB_REPLY_INPUT
        echo $BB_REPLY_INPUT
        echo BB_REPLY_USER
        echo $BB_REPLY_USER
        echo BB_REPLY_ID
        echo $BB_REPLY_ID
        echo BB_REPLY_AVATAR
        echo $BB_REPLY_AVATAR
        echo BB_REPLY_FILE
        echo $BB_REPLY_FILE
        echo BB_REPLY_EMBED
        echo $BB_REPLY_EMBED

        echo BB_REPLY_MENTION_USER
        echo $BB_REPLY_MENTION_USER
        echo BB_REPLY_MENTION_ID
        echo $BB_REPLY_MENTION_ID
        echo BB_REPLY_MENTION_AVATAR
        echo $BB_REPLY_MENTION_AVATAR

        echo '```'

      fi

    fi
    ;;

  *)
    echo "Invalid option!"
    ;;

esac
