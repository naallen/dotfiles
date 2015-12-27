export HOME=/home/nick
duplicity --ssh-options="-oIdentityFile=/home/nick/.ssh/id_rsa" --asynchronous-upload --encrypt-key EC106B21 /home/nick --exclude /home/nick/VMs --exclude /home/nick/Downloads --exclude /home/nick/Dropbox --exclude /home/nick/.wine --exclude /home/nick/.photoshop --exclude /home/nick/.wine32 --exclude /home/nick/Public scp://user@192.168.221.125//media/shareddrive/backup/x201/home
duplicity --ssh-options="-oIdentityFile=/home/nick/.ssh/id_rsa" --asynchronous-upload --encrypt-key EC106B21 /etc/ scp://user@192.168.221.125//media/shareddrive/backup/x201/etc
