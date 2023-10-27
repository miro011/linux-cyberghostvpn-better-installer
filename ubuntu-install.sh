#!/bin/bash

# if user is not running the command as root
if [ "$UID" -ne 0 ]; then
	echo "Please run the installer with SUDO!"
	exit
fi

echo "*******************************************************"
echo "INSTALLING DEPENDENCIES"
echo "If anything fails, stop the installer when prompted"
echo "*******************************************************"
echo ""

# requiredPackages=(curl openvpn resolvconf wireguard)
echo -e ">>>>>>>> CURL <<<<<<<<"
apt  -y install curl
echo -e "\n\n>>>>>>>> OPENVPN <<<<<<<<\n\n"
apt  -y install openvpn
echo -e "\n\n>>>>>>>> RESELVCONF <<<<<<<<\n\n"
apt -y install resolvconf
echo -e "\n\n>>>>>>>> WIREGUARD <<<<<<<<\n\n"
apt -y install wireguard

while [ 1 -eq 1 ]; do
	read -p "Everything went well Y/n? " uin
	uin=$(echo "$uin" | xargs) # trim
	uin=$(echo "$uin" | tr '[:upper:]' '[:lower:]') # lower-case
	if [[ "$uin" == "" || "$uin" == "y" ]]; then
		break
	elif [[ "$uin" == "n" ]]; then
		echo "EXITING SETUP"
		exit
	else
		echo "Invalid input, try again"
	fi
done

echo ""
echo "*******************************************************"
echo "COPYING CYBERGHOST FILES"
echo "*******************************************************"
echo ""

# rm prev directory if exists
if [ -d /usr/local/cyberghost ]; then
	rm -rf /usr/local/cyberghost
fi

mkdir /usr/local/cyberghost
cp -r cyberghost/* /usr/local/cyberghost
# change directory permissions
chmod -R 755 /usr/local/cyberghost

echo ""
echo "*******************************************************"
echo "CREATING LINKS"
echo "*******************************************************"
echo ""

# rm old symlink if exists
if [ -L /usr/bin/cyberghostvpn ]; then
	rm /usr/bin/cyberghostvpn
fi

ln -sf /usr/local/cyberghost/cyberghostvpn /usr/bin/cyberghostvpn

echo ""
echo "*******************************************************"
echo "SETUP APPLICATION"
echo "*******************************************************"
echo ""

cyberghostvpn --setup
