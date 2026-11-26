[ -f export.sh ] && . ./export.sh || ( echo "export.sh not found" && exit 1 )
sudo apt install transmission-cli transmission-daemon -y && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd)
echo "transmission setup done"
transmission-remote --start-paused -a "${tl}" &&
