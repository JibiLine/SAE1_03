#! /bin/bash
clear

sudo apt update
sudo apt install code
sudo apt install firefox-esr
sudo apt install libreoffice

clear
if [ -e "$1" ]
then

    if [ -f "$1" ]
    then

    sudo mkdir -p "/home/partageChefs"
    while IFS=";" read -r name firstname password department
    do

        if [ "$name" != "Nom" ]
        then

            user="${firstname:0:1}${name:0:7}"

            echo -e "
            $user
            $name
            $firstname
            $password
            $department
            "


            if ! grep "^$department:" /etc/group
            then
                sudo groupadd "$department"

                sudo mkdir -p "/home/partage$department"
                sudo mkdir -p "/home/$department"

                sudo useradd -d "/home/$department/$user" -c "$firstname $name" "$user"
                echo -e "$password\n$password" | sudo passwd "$user"

                sudo adduser "$user" "$department"
                sudo adduser "$user" "admin"

                sudo chown ":$department" "/home/$department"
                sudo chown ":$department" "/home/partage$department"
                sudo ln -sf "/home/partage$department" "/home/$department/$user"
                sudo ln -sf "/home/partageChefs" "/home/$department/$user"
            fi

            if ! grep "^$user:" /etc/passwd
            then
                sudo useradd -d "/home/$department/$user" -c "$firstname $name" "$user"
                echo -e "$password\n$password" | sudo passwd "$user"
                sudo adduser "$user" "$department"
                sudo ln -sf "/home/partage$department" "/home/$department/$user"
            fi
            
        fi

    done < "$1"

    else
        echo "Le parametre n'est pas un fichier valable"
    fi
        
else
    echo "Le parametre n'existe pas"
    exit 0
fi