#!/bin/bash

# curUsr=$(whoami)

update () {
    yay -Sy 
    yay -Su 
    yay -Qdt
}

i_yay () {
    sudo pacman -S git base-devel
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R saracen:users ./yay
    cd yay
    makepkg -si
    cd
    sudo rm -fr yay
    source ~/.bashrc

}

clean_gnome () {
    yay -R totem
}

u_python () {
    yay -S python3 
    yay -S python-pip 
}

i_albert () {
    yay -S albert-bin
}

i_brave () {
    git clone https://aur.archlinux.org/brave-bin.git
    cd brave-bin
    makepkg -si
    sudo rm -fr brave-bin
}
i_celluloid () { yay -S celluloid ; }
i_discord () { yay -S discord ; }
i_firefox () { yay -S firefox ; }
i_gnome_boxes () { yay -S gnome-boxes ; }
i_gparted () { yay -S gparted ; }
i_grub-customizer () { yay -S grub-customizer ; }
i_kazam () { yay -S kazam ; }
i_micro () { 
    yay -R nano
    yay -S micro
}
i_neofetch () {
    yay -S neofetch 
    echo "neofetch" >> ~/.bashrc
    source ~/.bashrc
}

i_nextcloud () { yay -S nextcloud-client ; }
i_tor () { yay -S tor-browser ; }
i_terminator () { yay -S terminator ; }
i_thunderbird () { yay -S thunderbird ; }
i_timeshift () { yay -S timeshift ; }
i_tree () { yay -S tree ; }
i_celluloid () { yay -S celluloid ; }
i_vs-code () { yay -S visual-studio-code-bin ; }


i_node () {
    yay -S nodejs 
    yay -S npm 
}

cust_grub () {
    git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
    cd Top-5-Bootloader-Themes
    sudo ./install.sh
    cd
    sudo rm -fr Top-5-Bootloader-Themes
}

i_py3 () {
    yay -S python3 
    yay -S python-pip 
    echo "alias python=python3" >> ~/.bashrc
    source ~/.bashrc
}

aliases () {
    echo "alias i='yay -S'" >> ~/.bashrc
    echo "alias r='yay -R'" >> ~/.bashrc
    echo "alias s='yay -Ss'" >> ~/.bashrc
    echo "alias tool='sudo bash debTool.sh'" >> ~/.bashrc
    echo "done..."
    source ~/.bashrc
}

theme_tweaks() {
    yay -S chrome-gnome-shell
    yay -S curl
    yay -S wget
    cd Pictures
    wget http://wallpoper.com/images/00/39/10/60/linux-arch_00391060.png
    wget https://wallpapercave.com/wp/NyaITD5.png
    wget https://wallpapercave.com/wp/PKt7K9T.jpg
    wget https://wallpaperset.com/w/full/2/a/0/418263.jpg
    cd
    gsettings set org.gnome.mutter center-new-windows 'true'
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
    gsettings set org.gnome.desktop.background picture-uri 'file:///home/saracen/Pictures/PKt7K9T.jpg'
    mv ~/themes/.themes ~/
    mv ~/themes/.icons ~/.icons
    gsettings set org.gnome.desktop.interface gtk-theme "Orchris-green-dark"
    gsettings set org.gnome.desktop.wm.preferences theme "Orchris-green-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Kora"
    gsettings set org.gnome.desktop.interface cursor-theme 'macOSBigSur'
    sudo rm -fr themes

}

quit () {
    yay -Qdt 
    exit
}

while :
do
    clear
    cat<<EOF
    Please enter your choice:

     (1) setup
     (2) inst nvidia drivers
     (3) inst cust grub
     (0) quit
    ------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
        "1") i_yay
             update
             clean_gnome
             i_celluloid
             i_discord
             i_firefox
             i_gnome_boxes
             i_gparted
             i_grub-customizer
             i_micro
             i_neofetch
             i_nextcloud
             i_terminator
             i_tor
             i_timeshift
             i_thunderbird
             i_tree
             i_vs-code
             i_node
             i_py3
             aliases 
             ;;
        "2") i_nvidia ;;
        "3") cust_grub ;;
        "0") quit && break ;;
     * )  echo "invalid option" ;;
    esac
    sleep 1
done