#! /bin/bash
# Welcome to the preparation sh file of all my scrpits
# Author: Jim.li
# Data: 20180101
# Propose: Prepare introduction of each sh file and write to it
# Version: 1.0
# Git tag: not yet available

if [ "$#" != "5" ];then    
    echo "Usage: ${0} [Author_name] [Date(exp. 20180101)] [Propose] [Version] [Script_name]"
    echo "Now exiting!"
    exit 1
fi

echo "Are you sure to proseed with all $* arguments?"
read iscontinue
iscontinue=$(echo "$iscontinue" | tr A-Z a-z )
if [ "$iscontinue" == "yes" ];then
    echo "Preparing your sh file introduction now!"
    echo -e "#! /bin/bash\n# Author: ${1}\n# Date: ${2}\n# Propose: ${3}\n# Version: ${4}\n" > ./"${5}.sh"
else
    echo "Aborting!"
fi
