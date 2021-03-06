#!/usr/bin/env sh

BASE_LANG="en"

LANGUAGES=(de es-419 es fr it ja ko nl pt-PT pt ru tr zh-Hans zh-Hant)

#TRANSLATE_LANG="de" # $1
TYPE=$1
ENGLISH_STRING=$2
#TYPE="[a-zA-Z]\+"

translate() {
  LANG=$1
  TYPE=$2
  ENGLISH_STRING=$3

  INPUT_DIR="ios/TunnelBear/Resources/Views/Onboarding/$LANG.lproj/"
  OUTPUT_FILE="ios/TunnelBear/Support/$LANG.lproj/Localizable.strings"

  TRANSLATION=""
  PREV_TRANSLATION=""
  PREV_LINE=""

  MATCHES=$(cat $INPUT_DIR/*  | grep "/\*.*; $TYPE = \"$ENGLISH_STRING\";.*\*/")
  #echo $(cat $INPUT_DIR/*  )
  #echo "matches: $MATCHES"

  #cat $INPUT_DIR/* | grep "/\* Class = \".*\"; $TYPE = \"$ENGLISH_STRING\";.*\*/" | while read -r line; do 
  while IFS= read -r line; do
    #echo "$LANG: match: $line" 1>&2
    if [ -z "$line" ] 
    then
        echo "$LANG: Error: no match..." 1>&2
        return
    fi

    OBJECT_ID=$(echo "$line" | sed -e "s/\/\*.*; ObjectID = \"//g" | sed -e "s/\"; \*\///g")

    #echo "$LANG: finding object id: $OBJECT_ID" 1>&2

    INPUT_TEXT=$(cat $INPUT_DIR/* | grep "$OBJECT_ID\.$TYPE")
    TRANSLATION=$(echo $INPUT_TEXT | sed -e 's/^\".*\" = \"//g' | sed -e 's/";$//g')

    #echo "$LANG: found translation: $TRANSLATION" 1>&2

    # if multiple matches, make sure translations match....
    if ! [ -z "$PREV_TRANSLATION" ] && ! [ "$PREV_TRANSLATION" == "$TRANSLATION" ] 
    then
      # multiple matches DONT match
      echo "$LANG: Error: translation mismatch" 1>&2
      echo "$LANG: $PREV_TRANSLATION -- $PREV_LINE" 1>&2
      echo "$LANG: $TRANSLATION -- $line" 1>&2
      return
    fi

    PREV_TRANSLATION=$TRANSLATION
    PREV_LINE=$line
  #done
  done <<< "$MATCHES"



  #OBJECT_ID=""
  #INPUT_TEXT=$(cat $INPUT_DIR/* | grep "$OBJECT_ID\.$TYPE")
  #TRANSLATION=$(echo $INPUT_TEXT | sed -e 's/^\".*\" = \"//g' | sed -e 's/";$//g')
  #
  #echo "\"$ENGLISH_STRING\" = \"$TRANSLATION\";"


  if [ -z "$TRANSLATION" ] 
  then
      echo "$LANG: Error: no translation" 1>&2
      return
  fi

  echo "$LANG: \"$ENGLISH_STRING\" = \"$TRANSLATION\";"
  echo "\"$ENGLISH_STRING\" = \"$TRANSLATION\";" >> $OUTPUT_FILE
}

for lang in "${LANGUAGES[@]}"
do
  translate $lang $TYPE "$ENGLISH_STRING"
done

