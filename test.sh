[ -f export.sh ] && . ./export.sh || ( echo "export.sh not found" && exit 1 )

sudo apt install transmission-cli transmission-daemon -y

sudo /etc/init.d/transmission-daemon stop
sudo sed -i 's|"rpc-authentication-required": true,|"rpc-authentication-required": false,|g' /etc/transmission-daemon/settings.json 
sudo cat /etc/transmission-daemon/settings.json
sudo /etc/init.d/transmission-daemon restart/start

transmission-daemon
transmission-remote -l
transmission-remote -w $(pwd)
echo "transmission setup done"
transmission-remote --start-paused -a "${tl}"
transmission-remote -t 1 -G all &&
echo "transmission-remote -t 1 -g${t}" &&
transmission-remote -t 1 -g${t} &&
transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s
transmission-remote -t 1 -f | grep Yes > check.txt
