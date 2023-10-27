- Put the script where the regular install.sh scirpt typically is and run it using:
  - sudo bash dnf-install.sh
  - or
  - sudo bash apt-install.sh
- If you want to remove the need for running the cyberghostvpn command with sudo, after the install is complete run:
  - sudo visudo
  - Append to the end of the file:
    - %wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/cyberghostvpn
  - This will give all members of the wheel group sudo-less access
- You could make your life even easier by creating some aliases. Here are some of the ones I have in my ~/.bashrc file:
  - alias cgh="printf '\nSEARCH COUNTRY CODE:\ncgcc countryName\n\nESTABLISH CONNECTION:\ncgc countryCode\n\nSHOW CONNECTION STATUS:\ncgs\n\nDISCONNECT:\ncgq\n\n'"
  - alias cgcc="sudo cyberghostvpn --country-code | grep -i --"
  - alias cgc="sudo cyberghostvpn --openvpn --server-type traffic --connect --country-code"
  - alias cgs="cyberghostvpn --status"
  - alias cgq="sudo cyberghostvpn --stop"
