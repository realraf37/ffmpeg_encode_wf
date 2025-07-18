mkdir tm && cd tm &&
	wget https://raw.githubusercontent.com/RahifM/scripts/refs/heads/newffmpeg/tm2.sh && chmod +x tm2.sh && time ./tm2.sh &&
	transmission-remote --start-paused -a "https://github.com/zmzu/dump/releases/download/1.0/Bleach.Box.1-6.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.torrent" &&
	transmission-remote -t 1 -G all && transmission-remote -t 1 -g6 && transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s

export i=Bleach.E007.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.mkv
export o=Bleach.E007.mkv

fmpg() {
	cd Bl* && cd Bl* && pwd && du -hs * && wget https://raw.githubusercontent.com/realraf37/ffmpeg_encode_wf/refs/heads/exp/f2.sh && chmod +x f2.sh && ./f2.sh
}

while true ; do
	if [ "$(transmission-remote -t 1 -i | grep State)" = "  State: Idle" ] ; then
		echo "Idling, starting encode"
		transmission-remote -t 1 -S
		ls && pwd
		fmpg
		pwd && du -hs *
		break
	fi
	echo $(transmission-remote -t 1 -i | grep State)
	echo $(transmission-remote -t 1 -i | grep Percent)
	echo "check back after 15s"
  sleep 15
done
