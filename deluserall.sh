sudo rm -f -r "/homùe/partageChefs"
while IFS=";" read -r name firstname password department
do
    user="${firstname:0:1}${name:0:7}"
    sudo groupdel "$department"
    sudo deluser "$user"
    sudo groupdel "$user"
    sudo rm -r -f "/home/$user"
    sudo rm -r -f "/home/$department"
    sudo rm -r -f "/home/partage$department"
done < $1
clear

echo -e "\n\nGroupes \n"
cat /etc/group

echo -e "\n\nUtilisateurs \n"
cat /etc/passwd
