#!/bin/bash
DOCFILE="script_listing"

echo "#!/bin/more" > "$DOCFILE"

ls *.sh > tmplisting.txt

while IFS= read -r FILENAME; do
    if [ -f "$FILENAME" ]; then
        echo "==================" >>"$DOCFILE"
        echo "SCRIPT NAME: $FILENAME " >> "$DOCFILE"
        echo ""
        echo "'cat $FILENAME'" >> "$DOCFILE"
    fi
done < tmplisting.txt

chmod 755 "$DOCFILE"
# arrayex.sh

serverlist = ("web01" "web02" "web03")
count=0
for INDEX in ${serverlist[@]}; do
    echo "Processing server: ${SERVERLIST[COUNT]}"
    COUNT="'expr $COUNT +1'"
done
