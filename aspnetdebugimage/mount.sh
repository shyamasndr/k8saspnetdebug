#!/bin/bash
SHAREPATH=""
LOCALPATH=""        
USERNAME=""  
PASSWORD=""
DOMAIN=""
                                       
usage() {                                      # Function: Print a help message.
  echo "Usage: $0  -s SHAREPATH  -l LOCALPATH   -u USERNAME   -p PASSWORD   -d DOMAIN" 1>&2 
# /bin/bash /app/mount.sh -s "//inblrw325416.vcn.ds.volvo.net/sql2019" -l "/app/appsource" -u [USERNAME] -p [PASSWORD] -d [DOMAIN]
}

exit_abnormal() {                              # Function: Exit with error.
  usage
  exit 1
}
while getopts ":s:l:u:p:d:" options; do              
                                               
                                               
  case "${options}" in                         
    s)                                         
      SHAREPATH=${OPTARG}                      
      ;;
    l)                                         
      LOCALPATH=${OPTARG}                      
      ;;
    u)                                         
      USERNAME=${OPTARG}                      
      ;;
    p)                                         
      PASSWORD=${OPTARG}                      
      ;; 
    d)                                         
      DOMAIN=${OPTARG}                      
      ;;
    :)                                         
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                            
      ;;
    *)                                         
      exit_abnormal                            
      ;;
  esac
done
echo using shared path $SHAREPATH creating mount at $LOCALPATH
[ ! -d "$LOCALPATH" ] && mkdir -p "$LOCALPATH"
df $LOCALPATH | grep -q $LOCALPATH && echo "$LOCALPATH already mounted" || mount -t cifs $SHAREPATH $LOCALPATH -o username=$USERNAME,password=$PASSWORD,domain=$DOMAIN
echo mount job compleated!
exit 0                                         # Exit normally.