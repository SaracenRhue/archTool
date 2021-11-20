#!/bin/bash

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

bash_aliases () {
    echo "neofetch" >> ~/.bashrc
    echo "alias i='yay -S --noconfirm'" >> ~/.bashrc
    echo "alias r='yay -R --noconfirm'" >> ~/.bashrc
    echo "alias s='yay -Ss'" >> ~/.bashrc
    echo "done..."
    source ~/.bashrc
}

zsh_aliases () {
    echo "neofetch" >> ~/.zshrc
    echo "alias i='yay -S --noconfirm'" >> ~/.zshrc
    echo "alias r='yay -R --noconfirm'" >> ~/.zshrc
    echo "alias s='yay -Ss'" >> ~/.zshrc
    echo "done..."
    source ~/.zshrc
}

cust_grub () {
    git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
    cd Top-5-Bootloader-Themes
    sudo ./install.sh
    cd
    sudo rm -fr Top-5-Bootloader-Themes
}

quit () {
    yay -Qdt 
    exit
}


r_gnome_packages(){
    PKGS=(
    'yelp'
    'python'
    'chromium'
    'totem'
    'nano'
    )

    for PKG in "${PKGS[@]}"; do
        yay -R --noconfirm $PKG
    done

}

basic_packages() {
    yay -R --noconfirm python
    yay -S --noconfirm - < packages.txt
}

setup_zsh() {
    yay -S --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting
    chsh -s $(which zsh)
}

i_graphicsdriver() {
     # Graphics Drivers find and install
    if lspci | grep -E "NVIDIA|GeForce"; then
        yay -S --noconfirm nvidia
    	nvidia-xconfig
    elif lspci | grep -E "Radeon"; then
        yay -S --noconfirm xf86-video-amdgpu
    elif lspci | grep -E "Integrated Graphics Controller"; then
        yay -S --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils
    fi
}

setup_virt_manager() {
    yay -S --noconfirm virt-manager qemu vde2 iptables-nft dnsmasq bridge-utils openbsd-netcat edk2-ovmf swtpmr
    sudo systemctl enable libvirtd.service
    sudo systemctl start libvirtd.service
    sudo usermod -a -G libvirt $USER
}

while :
do
    clear
    cat<<EOF
    Please enter your choice:

     (1) basic packages
     (2) setup zsh
     (3) zsh aliases
     (4) bash aliases
     (8) cust grub
     (9) setup virt-manager
     (10) quit
     (0) quit
    ------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
        "1") i_yay
             basic_packages
             i_graphicsdriver
             ;;
        "2") setup_zsh ;;
        "3") zsh_aliases ;;
        "4") bash_aliases ;;
        "8") cust_grub ;;
        "9") setup_virt_manager ;;
        "0") quit && break ;;
     * )  echo "invalid option" ;;
    esac
    sleep 1
done






# gonome_setup() {
#     yay -S --noconfirm gnome-tweaks chrome-gnome-shell gnome-shell-extension-dash-to-dock
#     cd Pictures
#     wget http://wallpoper.com/images/00/39/10/60/linux-arch_00391060.png
#     wget https://wallpapercave.com/wp/NyaITD5.png
#     wget https://wallpapercave.com/wp/PKt7K9T.jpg
#     wget https://wallpaperset.com/w/full/2/a/0/418263.jpg
#     cd
#     gsettings set org.gnome.mutter center-new-windows 'true'
#     gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
#     gsettings set org.gnome.desktop.background picture-uri 'file:///home/saracen/Pictures/PKt7K9T.jpg'
#     mv ~/themes/.themes ~/
#     mv ~/themes/.icons ~/
#     gsettings set org.gnome.desktop.interface gtk-theme "Orchris-green-dark"
#     gsettings set org.gnome.desktop.wm.preferences theme "Orchris-green-dark"
#     gsettings set org.gnome.desktop.interface icon-theme "Kora"
#     gsettings set org.gnome.desktop.interface cursor-theme 'macOSBigSur'
#     sudo rm -fr themes
#}