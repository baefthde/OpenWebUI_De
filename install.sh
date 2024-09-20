#!/bin/bash
cd ~
echo " "
echo "  Installation von OpenWebUI_De"
echo "  von https://github.com/baefthde/OpenWebUI_De/"
echo " "
echo "  System aktualisieren"
sudo apt-get update
sudo apt-get upgrade
echo "  Abhänigkeiten installieren"
sudo apt-get install git
echo "  Paket per Git laden"
git clone https://github.com/baefthde/OpenWebUI_De
echo "  Paket starten"
cd OpenWebUI_De
chmod +x OpenWebUI_De.sh
./OpenWebUI_De.sh
