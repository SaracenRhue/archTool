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

clean_gnome () {
    yay -R --noconfirm totem
    yay -R --noconfirm nano
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

theme_tweaks() {
    yay -S --noconfirm gnome-tweaks
    yay -S --noconfirm chrome-gnome-shell
    yay -S --noconfirm gnome-shell-extension-dash-to-dock
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
    mv ~/themes/.icons ~/
    gsettings set org.gnome.desktop.interface gtk-theme "Orchris-green-dark"
    gsettings set org.gnome.desktop.wm.preferences theme "Orchris-green-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Kora"
    gsettings set org.gnome.desktop.interface cursor-theme 'macOSBigSur'
    sudo rm -fr themes

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

PKGS=(
'arc'
'albert'
'grub'
'grub-btrfs'
'bash-completion'
'python3'
'python-pip'
'celluloid'
'discord'
'firefox'
'gnome-boxes'
'gparted'
'htop'
'grub-customizer'
'neofetch'
'nodejs'
'npm'
'kazam'
'micro'
'visual-studio-code-bin'
'thunderbird'
'nextcloud-client'
'timeshift'
'tree'
'tor-browser'
'zoom'
'github-desktop-bin'
'curl'
'wget'
'zsh'
'zsh-autosuggestions'
'zsh-syntax-highlighting'
)
i_packages() {
    for PKG in "${PKGS[@]}"; do
        yay -S --noconfirm $PKG
    done
}

default_zsh() {
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



while :
do
    clear
    cat<<EOF
    Please enter your choice:

     (1) setup
     (2) theme tweaks
     (3) inst cust grub
     (0) quit
    ------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
        "1") i_yay
             update
             i_graphicsdriver
             i_packages
             clean_gnome
             ;;
             zsh_aliases
        "2") theme_tweaks ;;
        "3") cust_grub ;;
        "0") quit && break ;;
     * )  echo "invalid option" ;;
    esac
    sleep 1
done