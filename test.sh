[ -f export.sh ] && . ./export.sh || ( echo "export.sh not found" && exit 1 )

sudo apt install transmission-cli transmission-daemon -y

/etc/init.d/transmission-daemon restart/start
sudo sed -i 's|"rpc-authentication-required": true,|"rpc-authentication-required": false,|g' /etc/transmission-daemon/settings.json 
sudo cat /etc/transmission-daemon/settings.json

transmission-daemon
transmission-remote -l
transmission-remote -w $(pwd)
echo "transmission setup done"
transmission-remote --start-paused -a "${tl}"

