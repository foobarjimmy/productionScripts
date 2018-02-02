#! /bin/bash

echo "User input file_type and dir_name, then move file_type to dir_name"
echo
read -p "filetype that you want move :" filetype
read -p "dirname that you want to put in :" dirname
echo

test -d "$HOME/$dirname" || mkdir -m 755 "$HOME/$dirname"
# test the existence of dir "dirname"
find / -path "$HOME" -prune -o -exec -name "*.$filetype" -exec cp -p {} "$HOME/$dirname" \;
exit 0
