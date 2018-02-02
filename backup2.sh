read -p "Folder need to be compressed : " folder
read -p "Folder you want to put backup file to : " store_folder
read -p "Folder need to be excluded : " excludes
read -n1 -p "Compression level : (n,m,h)" level

if [ ! -z ${folder} -a ! -z ${store_folder} ];then
    foldername=$(basename ${folder})
    opt_n="-cvf \"${store_folder}/${foldername}.tar\" \"${folder}\"" 
    opt_gz="-cvzf \"${store_folder}/${foldername}.tar.gz\" \"${folder}\""
    opt_bz2="-cvjf \"${store_folder}/${foldername}.tar.bz2\" \"${folder}\"" 
    if [ ! -z $excludes -a -e "\"$folder\"/\"$excludes\"" ];then
        if [ $level = "n" ];then 
            opt="$opt_n"
        elif [ $level = "m" ];then
            opt="$opt_gz"
        elif [ $level = "h" ];then
            opt="$opt_bz2"
        else
            echo "level only accept one parameter(n/m/h)"
            echo
        eval "tar $opt --exclude=${excludes}"
        fi
    elif [ ! -e "\"$folder\"/\"$excludes\"" ];then
        if [ $level = "n" ];then
            opt="$opt_n"
        elif [ $level = "m" ];then
            opt="$opt_gz"
        elif [ $level = "h" ];then
            opt="$opt_bz2"
        else
            echo "level only accept one parameter(n/m/h)"
            echo
        fi
        eval "tar $opt"
        echo "yes"
    else
        echo "handle this"
    fi 
else 
    echo "Missing target folder or storing folder!"
fi         
