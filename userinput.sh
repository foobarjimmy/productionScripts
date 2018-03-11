#! /bin/bash

echo "your are using is $(basename $0)"
test -z "$1" || echo "Hello $1"
exit 0
