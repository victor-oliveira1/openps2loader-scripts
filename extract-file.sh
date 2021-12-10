#!/usr/bin/env bash
find -type f -iname '*.7z' | while read FILE; do
    7z x -y "${FILE}" && {
        rm -rfv "${FILE}"
    }
done
