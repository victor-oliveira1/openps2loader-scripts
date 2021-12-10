#!/usr/bin/env bash
while read ISOFILE; do
    GAMEID=$(isoinfo -l -i "${ISOFILE}" | grep -Eo '[A-Z]{4}_[0-9]{3}.[0-9]{2}')
    test -a "/media/USB/OPL/ART/${GAMEID}_COV.jpg" || {
        GAMEPATH=$(wget -U 'USERAGENT' -nv -O - "https://wiki.pcsx2.net/index.php?search=$(echo ${GAMEID}|sed -e 's/\.//g' -e 's/_/-/g')"|grep 'data-serp-pos="0"'|grep -o 'href=.*'|cut -d\" -f2)
        IMAGEPATH="$(wget -U 'USERAGENT' -nv -O - "https://wiki.pcsx2.net${GAMEPATH}"|grep 'td colspan="2"'|grep -o 'href=".*'|cut -d\" -f2)"
        COVERURL="https://wiki.pcsx2.net$(wget -U 'USERAGENT' -nv -O - "https://wiki.pcsx2.net${IMAGEPATH}"|grep 'Original file'|grep -o 'href=".*'|cut -d\" -f2)"
        wget -U 'USERAGENT' -nv -O "/media/USB/OPL/ART/${GAMEID}_COV.jpg" "${COVERURL}" && {
            mogrify -resize 256 "/media/USB/OPL/ART/${GAMEID}_COV.jpg"
        } || {
            rm -rfv "/media/USB/OPL/ART/${GAMEID}_COV.jpg"
        }
    }
done <<<$(find "/media/USB/OPL/DVD/" -iname '*.iso')
