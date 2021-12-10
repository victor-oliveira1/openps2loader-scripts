#!/usr/bin/env bash
while read ISOFILE; do
    echo "${ISOFILE}"
    isoinfo -l -i "${ISOFILE}" | grep -Eo '[A-Z]{4}_[0-9]{3}.[0-9]{2}'
done <<<$(find -iname '*.iso'|sort)
