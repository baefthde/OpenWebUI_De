#!/bin/bash
echo "   Deutsche KI Webinterface mit Sprachausgabe"
echo " "
echo "  installieren von:"
echo "  1. - llama3.1 auf ollama"
echo "  2. - openwebui als Weboberfläche auf Port 8080"
echo "  3. - watchtower zum dauerhaften aktualisieren von open-webui"
echo "  4. - Deutscher Sprachausgabe über openedai-speech API Schnistelle mit der Stimme von thorsten"
echo " "
echo "  ins Userverzeichnis gehen"
cd ~
echo "  1. ollama installieren:"
curl -fsSL https://ollama.com/install.sh | sh

echo "  1.1 ollama mit llama3.1 starten"
echo "      muss manuell beendet werden mit /bye"
ollama run llama3.1

echo "  2. openwebui über Docker starten"
echo "  Vorkonfiguriert für ollama API mit 127.0.0.1:11434"
#sudo docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
echo "  Vorkonfiguriert für externe Datenbank: webui.db"
sudo docker run -d --network=host -v open-webui:/app/backend/data -v /home/bastian/open-webui/webui.db:/app/backend/data/webui.db -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

echo "  3. watchtower über Docker starten, damit sich der Docker Container openwebui immer alle 24 Stunden aktualisiert"
sudo docker run -d --name watchtower --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower open-webui

echo "  4. openedai-speech installieren:"

echo "  4.1 openedai-speech per git holen:"
git clone https://github.com/matatonic/openedai-speech.git

echo "  4.2 Standard Konfiguration erstellen"
cd openedai-speech
cp sample.env speech.env

echo "  4.3 openedai-speech über Docker starten"
sudo docker compose -f docker-compose.min.yml up -d

echo "  4.4 Deutsche Sprache Donloaden"
cd voices
wget https://huggingface.co/rhasspy/piper-voices/resolve/main/de/de_DE/thorsten/high/de_DE-thorsten-high.onnx
wget https://huggingface.co/rhasspy/piper-voices/raw/main/de/de_DE/thorsten/high/de_DE-thorsten-high.onnx.json
cd ..
echo "  openedai-speech Koniguration wiederherstellen"

cp ~/OpenWebUI_De/voice_to_speaker.yaml ~/openedai-speech/config/voice_to_speaker.yaml
echo "  Installation Abgeschlossen"
echo " "
echo "  OpenWebUI aufrufen"
echo "  am Web UI anmelden http://IP:8080"
echo "  Erste Registrierung bekommt Adminrechte zum konfigurieren"
echo "  Registrieren, Name, Email, Password"
echo " "
echo "  - Einstellungen:"
echo "    - auf Deutsch einstellen"
echo "  - Einstellungen -> Audio -> TTS-Einstellungen"
echo "    - Antwort automatisch abspielen auf Ein"
echo "  - Admin Panel -> Einstellungen -> Verbindungen"
echo "	  - OpenAI-API sollte deaktiviert werden"
echo "    - Ollama-API ist auf http://localhost:11434 über Docker start eingestellt"
echo "  - Admin Panel -> Einstellungen -> Audio"
echo "    - TTS-Einstellungen:" 
echo "      - Text-zu-Sprache-Engine: http://IP:8000/v1 OpenAI: sk-111111111"
echo "      - TTS-Stimme: thorsten TTS-Modell: tts-1"
echo "  KI Chat uns Sprachausgabe testen"
