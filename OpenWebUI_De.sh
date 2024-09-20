#!/bin/bash

reset='\x1B[0m'
blue='\033[47m\033[34m'

echo -e "${blue}   Deutsche KI Webinterface mit Sprachausgabe ${reset}"
echo " "
echo -e "${blue}  installieren von:  ${reset}"
echo -e "${blue}  1. - llama3.1 auf ollama  ${reset}"
echo -e "${blue}  2. - openwebui als Weboberfläche auf Port 8080  ${reset}"
echo -e "${blue}  3. - watchtower zum dauerhaften aktualisieren von open-webui  ${reset}"
echo -e "${blue}  4. - Deutscher Sprachausgabe über openedai-speech API Schnistelle mit der Stimme von thorsten  ${reset}"
echo " "

echo -e "${blue}  Abhänigkeit installieren: Docker über snap  ${reset}"
sudo snap install docker

echo -e "${blue}  ins Userverzeichnis gehen  ${reset}"
cd ~
echo -e "${blue}  1. ollama installieren:  ${reset}"
curl -fsSL https://ollama.com/install.sh | sh

echo -e "${blue}  1.1 ollama mit llama3.1 starten  ${reset}"
ollama pull llama3.1

echo -e "${blue}  2. openwebui über Docker starten  ${reset}"
echo -e "${blue}  Vorkonfiguriert für ollama API mit 127.0.0.1:11434  ${reset}"
#sudo docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

echo -e "${blue}  Lerre OpenWebUI Datenbank erstellen  ${reset}"
mkdir open-webui
touch ~/open-webui/webui.db

echo -e "${blue}  Vorkonfiguriert für externe Datenbank: webui.db  ${reset}"
sudo docker run -d --network=host -v open-webui:/app/backend/data -v ~/open-webui/webui.db:/app/backend/data/webui.db -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

echo -e "${blue}  3. watchtower über Docker starten, damit sich der Docker Container openwebui jede Stunde aktualisiert  ${reset}"
sudo docker run -d --name watchtower --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower open-webui -i 3600

echo -e "${blue}  4. openedai-speech installieren:  ${reset}"

echo -e "${blue}  4.1 openedai-speech per git holen:  ${reset}"
git clone https://github.com/matatonic/openedai-speech.git

echo -e "${blue}  4.2 Standard Konfiguration erstellen  ${reset}"
cd openedai-speech
cp sample.env speech.env

echo -e "${blue}  4.3 openedai-speech über Docker starten  ${reset}"
sudo docker compose -f docker-compose.min.yml up -d

echo -e "${blue}  4.4 Deutsche Sprache Donloaden  ${reset}"
cd voices
wget https://huggingface.co/rhasspy/piper-voices/resolve/main/de/de_DE/thorsten/high/de_DE-thorsten-high.onnx
wget https://huggingface.co/rhasspy/piper-voices/raw/main/de/de_DE/thorsten/high/de_DE-thorsten-high.onnx.json
cd ..
echo -e "${blue}  openedai-speech Koniguration wiederherstellen  ${reset}"

cp ~/OpenWebUI_De/voice_to_speaker.yaml ~/openedai-speech/config/voice_to_speaker.yaml
echo -e "${blue}  Installation Abgeschlossen  ${reset}"
echo " "
echo -e "${blue}  OpenWebUI aufrufen  ${reset}"
echo -e "${blue}  am Web UI anmelden http://IP:8080  ${reset}"
echo -e "${blue}  Erste Registrierung bekommt Adminrechte zum konfigurieren  ${reset}"
echo -e "${blue}  Registrieren, Name, Email, Password  ${reset}"
echo " "
echo -e "${blue}  - Einstellungen:  ${reset}"
echo -e "${blue}    - auf Deutsch einstellen  ${reset}"
echo -e "${blue}  - Einstellungen -> Audio -> TTS-Einstellungen  ${reset}"
echo -e "${blue}    - Antwort automatisch abspielen auf Ein  ${reset}"
echo -e "${blue}  - Admin Panel -> Einstellungen -> Verbindungen  ${reset}"
echo -e "${blue}	  - OpenAI-API sollte deaktiviert werden  ${reset}"
echo -e "${blue}    - Ollama-API ist auf http://localhost:11434 über Docker start eingestellt  ${reset}"
echo -e "${blue}  - Admin Panel -> Einstellungen -> Audio  ${reset}"
echo -e "${blue}    - TTS-Einstellungen:  ${reset}"
echo -e "${blue}      - Text-zu-Sprache-Engine: http://IP:8000/v1 OpenAI: sk-111111111  ${reset}"
echo -e "${blue}      - TTS-Stimme: thorsten TTS-Modell: tts-1  ${reset}"
echo -e "${blue}  KI Chat uns Sprachausgabe testen  ${reset}"
echo " "
echo -e "${blue}  Quelle: https://github.com/baefthde/OpenWebUI_De  ${reset}"
