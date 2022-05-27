#!/bin/bash
artist=$(echo $1 | sed -r 's/ /%20/g')
rm final
touch final
NC='\033[0m' # No Color
BPurple='\033[1;35m'
echo -e "${BPurple}
  _____  ______       _____ _           _       
 |  __ \|  ____|     / ____| |         (_)      
 | |__) | |__ ______| |    | |__   __ _ _ _ __  
 |  ___/|  __|______| |    | '_ \ / _\` | | \'_ \ 
 | |    | |         | |____| | | | (_| | | | | |
 |_|    |_|          \_____|_| |_|\__,_|_|_| |_|
                                                 ${NC}"



wget \
\
\
\
\
\
-q -O $artist.html https://pitchfork.com/search/?query=$artist

grep -oP '\/search\/more\/\?query='$artist'&amp;filter=albumreviews' $artist.html | sed 's/amp;//'> showall
if [ -s showall ]; then
showall=$(cat showall)
wget \
\
\
\
\
\
-q -O $artist.html https://pitchfork.com$showall

fi


grep -oP '\/reviews\/albums\/[^(\">)]*' $artist.html > links.html
while read -r line; do
    if [ ${#line} -gt 16 ]
      then
        echo $line
      fi
done < links.html > albums.html

echo -e "Please wait..\nPF-Chain uses politeness intervals to respect Pitchfork's servers"

declare -i num=1
while read -r line; do
  wget -q -O review$num.html pitchfork.com/$line;
  num=$((num + 1))
  sleep 0.5
done < albums.html

grep -oP "[^\"]* \| " review*.html > data
grep -oP "score\">[0-9].?[0-9]" review*.html >> data
grep -oP 'release_year\":[0-9]*' review*.html >> data
declare -i dup=0;
for (( i=1; i<$num; i++ ))
  do
    while read -r line; do
      if [[ "$line" == "review$i."* || $num -eq 2 ]]; then
        if [[ $dup -eq 0 ]]; then
          printf "E\n" >> final
          dup=1
        else
          echo $line | cut -f2- -d: | cut -f2- -d: >> final
        fi
      fi
    done < data
  dup=0
done

rm *.html
rm data
rm showall
printf "\n$1:\n======================================\n"
#cat final
python3 graph.py
