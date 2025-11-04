set -e

export TZ='Asia/Kolkata'

export botmsg="curl -s -X POST "https://api.telegram.org/bot${BOTAPI}/sendMessage" -d chat_id="${CHATID}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text"

export TG=$HOME/telegram.sh/telegram

[ -f export.sh ] && . ./export.sh || ( echo "export.sh not found" && exit 1 )

sudo apt update
sudo apt install ffmpeg -y

fmpgscrpt() {

[ -d "$HOME/telegram.sh" ] || time git clone https://github.com/RahifM/telegram.sh $HOME/telegram.sh

if [ -d "$HOME/.telegram.sh" ]; then
echo ".Tgsh already exists"
else
cat <<'EOF' >> $HOME/.telegram.sh
TELEGRAM_TOKEN="demo1"
TELEGRAM_CHAT="demo2"
EOF
sed -i s/demo1/${BOTAPI}/g $HOME/.telegram.sh
sed -i s/demo2/${CHATID}/g $HOME/.telegram.sh
fi


tmsa() {

tms() {
        ( sudo apt install transmission-cli transmission-daemon -y && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd) ) 2>&1 | tee tm.txt
}
        tms

        [ "$(grep success tm.txt)" == "" ] && tms && rm tm.txt

	[ -d Bl* ] && rm -rf Bl*
	transmission-remote --start-paused -a "${tl}" &&
	transmission-remote -t 1 -G all &&
	echo "transmission-remote -t 1 -g${t}" &&
	transmission-remote -t 1 -g${t} &&
	transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s
	transmission-remote -t 1 -f | grep Yes > check.txt
}

fmpg() {
echo -e "\nPlease set input and output! (only 720p encodes supported as of now)\n"
echo ${i}
echo ${o}

[ -z "$i" -o -z "$o" ] && echo -e "\nNo input or output found\n" && exit 1

$botmsg="${o} encode started"

echo -e "\n"

low() {
        [ -f ${o}*.txt ] && rm ${o}*.txt
        time ffmpeg -i  "${i}" -s 1280x720 -c copy -map 0 -c:v libx265 -x265-params crf=28 -pix_fmt yuv420p -preset slow  "${o}" 2>&1 | tee ${o}-$(date +'%Y%m%d-%H%M').txt
}

up() {
echo
[ -f "github-release-2.0.0.2-ubuntu-bkup" ] && echo "gh rel already exists" || ( echo "gh rel not found" && time wget https://github.com/RahifM/releases/releases/download/1.0/github-release-2.0.0.2-ubuntu-bkup && chmod +x github-release-2.0.0.2-ubuntu-bkup )

./gi* upload --token $GHSECRET --owner 'zmzu' --repo 'be_dump' --tag '1.0' --file ${o} --name ${o}
}

low

[ -f ${o} ] && up && echo && echo "${o} encode / upload success" && $botmsg="${o} encode / upload success" || ( echo && echo "${o} encode / upload failed" && $botmsg="${o} encode / upload failed" )
}

tmc() {
echo
echo "Downloading..."
echo
while true ; do
	if [ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 100%" ] ; then
		echo $(transmission-remote -t 1 -i | grep State)
		echo $(transmission-remote -t 1 -i | grep Percent)
		echo
		echo "Downloaded, starting encode"
		echo
		transmission-remote -t 1 -S
		break
	fi
	[ "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" = "5%" ] && echo "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" "$(transmission-remote -t 1 -i | grep ETA)"
	[ "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" = "25%" ] && echo "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" "$(transmission-remote -t 1 -i | grep ETA)"
	[ "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" = "50%" ] && echo "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" "$(transmission-remote -t 1 -i | grep ETA)"
	[ "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" = "75%" ] && echo "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" "$(transmission-remote -t 1 -i | grep ETA)"
	[ "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" = "95%" ] && echo "$(transmission-remote -t 1 -f | grep Yes | awk '{ print $2 }')" "$(transmission-remote -t 1 -i | grep ETA)"
  sleep 1
done
}

time tmsa
time tmc

echo && pwd && du -hs *
cd $(cat check.txt | awk '{ print $7 }' | cut -d "/" -f -2) && echo && pwd && du -hs *
[ -f ${o} ] && rm ${o}
fmpg
echo && echo && pwd && du -hs *
}

[ -f log*.txt ] && rm log*.txt
time fmpgscrpt 2>&1 | tee log-${o}-$(date +'%Y%m%d-%H%M').txt
$TG -f log*.txt
