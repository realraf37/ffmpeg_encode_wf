mkdir tm && cd tm && wget https://raw.githubusercontent.com/RahifM/scripts/refs/heads/newffmpeg/tm2.sh && chmod +x tm2.sh && ./tm2.sh && transmission-remote --start-paused -a "https://github.com/zmzu/dump/releases/download/1.0/Bleach.Box.1-6.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.torrent" && transmission-remote -t 1 -G all && transmission-remote -t 1 -g2 && transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s

fmpg() {
	cd Bl* && cd Bl* && wget https://raw.githubusercontent.com/RahifM/scripts/refs/heads/newffmpeg/f.sh && chmod +x f.sh && ./f.sh
}

while true ; do
	if [ "$(transmission-remote -t 1 -i | grep State)" = "  State: Idle" ] ; then
		echo "Idling, starting encode"
		transmission-remote -t 1 -S
		ls && pwd
		fmpg
		break
	fi
	echo $(transmission-remote -t 1 -i | grep State)
	echo $(transmission-remote -t 1 -i | grep Percent)
	echo "check back after 15s"
  sleep 15
done
