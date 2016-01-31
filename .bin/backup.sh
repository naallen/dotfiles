borg create ssh://nick@192.168.221.125//media/shareddrive/backup/x201::"$(date +\"%m-%d-%y-%H:%M\")" /home/nick /etc --exclude-if-present .borgexclude --compression=zlib
