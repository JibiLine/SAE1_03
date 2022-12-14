while IFS=";" read -r name firstname password department
do
    user="${firstname:0:1}${name:0:7}"
    sudo groupdel "$department"
    sudo deluser "$user"
    sudo groupdel "$user"
done < $1
clear

echo -e "\n\nGroupes \n"
cat /etc/group

echo -e "\n\nUtilisateurs \n"
cat /etc/passwd