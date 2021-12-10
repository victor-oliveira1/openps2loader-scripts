#!/usr/bin/env bash

coolromDownload() {
	local ID="${1}"
	local URLDOWNLOAD="$(curl -s "https://coolrom.com.au/dlpop.php?id=${ID}"|sed 's/>/\n/g'| grep -Eo 'action=".*"'|cut -d\" -f2)"

	curl -sJO "${URLDOWNLOAD}" & disown
}

listPlatform() {
	curl -s 'https://coolrom.com.au/js/dropmenu.min.js'|grep -Eo '/roms/\w+'|cut -d/ -f3
	read -ep 'Digite uma plataforma: ' PLATFORM
}

selectGame() {
	read -ep 'Digite uma letra (0 para números): ' LETTER
	curl -s "https://coolrom.com.au/roms/${PLATFORM}/${LETTER}/"|grep 'value="Show/Hide All"'|sed -e 's/<a href=/\n/g' -e 's/<\/a>/\n/g'|grep '^"'|sed 's:>:/:g'|cut -d/ -f4,6|sed 's:/: - :g'|less
	echo
	read -ep 'Digite o ID do jogo que deseja baixar: ' GAMEID
}

listPlatform
while :; do
	selectGame
	if [ -n "${GAMEID}" ]; then
		coolromDownload "${GAMEID}"
	fi
done