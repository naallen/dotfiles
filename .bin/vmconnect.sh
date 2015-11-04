virsh start windows7
xfreerdp /u:Administrator /p:" " /v:192.168.122.222 /shell:"%ProgramFiles%\\Microsoft Office 15\\root\\office15\\ONENOTE.EXE" +clipboard +home-drive +fonts
virsh managedsave windows7 | zenity --progress --no-cancel --pulsate --auto-close --text="Saving VM State" 
