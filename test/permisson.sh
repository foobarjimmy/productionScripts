#! /bin/bash
# written by jim.li@20170425
read -p "Specify your full directory path : " dir
if [ "${dir}" == "" -o ! -d "${dir}" ];then
  echo "Argument must be an actual directory name!"
else
  filelist=$(ls "${dir}")
  for file in ${filelist}
  do
  echo " Filename: ${file} Permission: 
    $(test -w "${dir}/${file}"&& echo -e "\033[1;31mwritable\033[0m")
    $(test -r "${dir}/${file}"&& echo -e "\033[1;31mreadable\033[0m")
    $(test -x "${dir}/${file}"&& echo -e "\033[1;31mexecutable\033[0m")"
  done
fi	
