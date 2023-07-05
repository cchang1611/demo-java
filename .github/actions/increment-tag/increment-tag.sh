#!/bin/bash

TAG=$1

TAG_PREFIX=${TAG%-snapshot}  # Elimina la palabra "snapshot" al final del tag
TAG_SUFFIX=${TAG#"$TAG_PREFIX"}  # Obtiene la parte del tag después del prefijo

INCREMENTED_TAG=""
IFS='.' read -ra TAG_PARTS <<< "$TAG_PREFIX"
for ((i=${#TAG_PARTS[@]}-1; i>=0; i--)); do
  PART=${TAG_PARTS[i]}
  if ((PART < 9)); then
    PART=$((PART + 1))
    PART=$(printf "%02d" $PART)
    TAG_PARTS[i]=$PART
    break
  else
    TAG_PARTS[i]=0
  fi
done

INCREMENTED_TAG="${TAG_PARTS[*]}$TAG_SUFFIX"
echo $INCREMENTED_TAG
