# Check update and install the software compilation
sudo apt-get update
# Next, install a few prerequisite packages which let apt use packages over HTTPS:
if ! [ -x "$(command -v add-apt-repository)" ]; then
  # Install add-apt-repository
  sudo apt-get -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates gnupg
  sudo apt-get update
fi
if ! [ -x "$(command -v build-essential)" ]; then
  # Install build-essential
  sudo apt-get -y install build-essential
fi
if ! [ -x "$(command -v cmake)" ]; then
  # Install cmake
  sudo apt-get -y install cmake
fi
if ! [ -x "$(command -v python3-dev)" ]; then
  # Install python3-dev
  sudo apt-get -y install python3-dev
fi
if ! [ -x "$(command -v curl)" ]; then
  # Install curl
  sudo apt-get -y install curl
fi
if ! [ -x "$(command -v unzip)" ]; then
  # Install unzip
  sudo apt-get -y install unzip
fi
if ! [ -x "$(command -v wget)" ]; then
  # Install wget
  sudo apt-get -y install wget
fi

# Enable the universe repository
sudo add-apt-repository universe
# Install Gnome Tweak Tool
sudo apt-get install -y gnome-tweak-tool
# Install Gnome Extensions
sudo apt-get install -y chrome-gnome-shell
sudo apt-get install -y gnome-shell-extension-pixelsaver
gnome-extensions enable pixel-saver@deadalnix.me

mkdir -p ~/.local/share/gnome-shell/extensions
# CoverflowAltTab
git clone https://github.com/dmo60/CoverflowAltTab.git
# Copy to extensions directory
cp -r CoverflowAltTab/CoverflowAltTab@dmo60.de -t ~/.local/share/gnome-shell/extensions
gnome-extensions enable CoverflowAltTab@palatis.blogspot.com
rm -rf CoverflowAltTab

# Dash to dock
wget https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v71.shell-extension.zip
# Unzip to extensions directory
unzip dash-to-dockmicxgx.gmail.com.v71.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/
gnome-extensions enable dash-to-dock@micxgx.gmail.com
rm -rf dash-to-dockmicxgx.gmail.com.v71.shell-extension.zip

# Unite
git clone https://github.com/hardpixel/unite-shell.git
# Copy to extensions directory
cp -r unite-shell/unite@hardpixel.eu -t ~/.local/share/gnome-shell/extensions
gnome-extensions enable unite@hardpixel.eu
rm -rf unite-shell

# Install flameshot
sudo snap install flameshot

# Install albert
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"
sudo apt-get update
sudo apt-get install -y albert

# Install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb
