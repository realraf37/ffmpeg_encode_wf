#set -e

export botmsg="curl -s -X POST "https://api.telegram.org/bot${BOTAPI}/sendMessage" -d chat_id="${CHATID}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text"

sudo apt install ffmpeg -y

echo -e "\nPlease set input and input! (only 720p encodes supported as of now)\n"
echo ${i}
echo ${o}
#read -e -p "Input: " i
#read -e -p "Output: " o

if [ -z "$i" -o -z "$o" ]; then
       echo -e "\nNo input or output found\n"
       exit 1
fi

$botmsg="${o} encode started"

echo -e "\n"

low() {
	rm ${o}*.txt
	time ffmpeg -i  "${i}" -s 1280x720 -c copy -map 0 -c:v libx265 -x265-params crf=28 -pix_fmt yuv420p -preset slow  "${o}" 2>&1 | tee ${o}-$(date +'%Y%m%d-%H%M').txt
}

up() {
[ -f "github-release-2.0.0.2-ubuntu" ] && echo "gh rel already exists" || ( echo "gh rel not found" && wget https://github.com/tfausak/github-release/releases/download/2.0.0.2/github-release-2.0.0.2-ubuntu && chmod +x github-release-2.0.0.2-ubuntu )

./gi* upload --token $GHSECRET --owner 'zmzu' --repo 'dump' --tag '1.0' --file ${o} --name ${o}
}

low

[ -f ${o} ] && up && echo "${o} encode / upload success" && $botmsg="${o} encode / upload success" || ( echo "${o} encode / upload failed" && $botmsg="${o} encode / upload failed" )
