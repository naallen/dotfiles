sleep 0.5
DOCKED=$(cat /sys/devices/platform/dock.2/docked)
case "$DOCKED" in
	"0")
        rm /home/nick/.docked
	;;
	"1")
        touch /home/nick/.docked
	;;
esac
exit 0
