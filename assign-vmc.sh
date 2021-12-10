#!/usr/bin/env bash
while read ISOFILE; do
    GAMEID=$(isoinfo -l -i "${ISOFILE}" | grep -Eo '[A-Z]{4}_[0-9]{3}.[0-9]{2}')
    test -a "/media/USB/OPL/CFG/${GAMEID}.cfg" || {
        NEWGAME="1"
        echo "${GAMEID} - VMC assigned"
        echo -e '$VMC_0=generic_0\n$VMC_1=generic_1' > "/media/USB/OPL/CFG/${GAMEID}.cfg"
    }
done <<<$(find "/media/USB/OPL/DVD/" -iname '*.iso')

# Erase local OPL game database
test -n "${NEWGAME}" && {
    test -f "/media/USB/OPL/DVD/games.bin" && {
        rm -rfv "/media/USB/OPL/DVD/games.bin"
    }
} || {
    exit 0
}
