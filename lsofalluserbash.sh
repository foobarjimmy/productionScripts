#! /bin/sh
for user in $(who | cut -d" " -f1);do
    lsof -u "$user" -a -c bash | grep cwd
done
