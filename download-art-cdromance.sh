#!/usr/bin/env bash
while read ISOFILE; do
    GAMEID=$(isoinfo -l -i "${ISOFILE}" | grep -Eo '[A-Z]{4}_[0-9]{3}.[0-9]{2}')
    test -a "/media/USB/OPL/ART/${GAMEID}_COV.jpg" || {
        COVERURL=$(wget -U 'USERAGENT' -nv -O - "https://cdromance.com/?s=${GAMEID/./}"|grep -E 'game-thumb.*\-150x150'|grep -Eo 'src=".*'|cut -d\" -f2|sed '1!d')
        wget -U 'USERAGENT' -nv -O "/media/USB/OPL/ART/${GAMEID}_COV.jpg" "${COVERURL/-150x150/}" && {
            mogrify -resize 256 "/media/USB/OPL/ART/${GAMEID}_COV.jpg"
        } || {
            rm -rfv "/media/USB/OPL/ART/${GAMEID}_COV.jpg"
        }
    }
done <<<$(find "/media/USB/OPL/DVD/" -iname '*.iso')
