
# Projekt [OpenWebUI_De](https://github.com/baefthde/OpenWebUI_De/)

Deutsch (English)

Ziel ist eine einfache Installation und starten der OpenWebUi auf Deutsch mit Deutscher Sprachausgabe

(The goal is a simple installation and starting the OpenWebUi in German)

Ein Script für die Installation und anschließende Registrierung und Einstellungen für Deutsche Sprachausgabe

## Dokumentation (Documentation)

Die Dokumentation  ist noch in Arbeit.
[Dokumentation](https://github.com/baefthde/OpenWebUI_De/doc/) [(Documentation)](https://github.com/baefthde/OpenWebUI_De/doc/)

## Abhängigkeiten

Linux (getestet mit Ubuntu 24 LTS Server)

Arbeitsspeicher sollte mindestens 16 GB Ram sein für die Standart Installation von llama3.1 (nutzung über CPU, Anpassung für AMD oder NVIDIA auch möglich, siehe Ollama)


mindestens 40 GB Speicherplatz Festplatte/SSD

root Rechte

## Installation

### Alles über einen Befehl installieren :-)

lediglich einmal das Password für die Root wird benötigt

```bash
  wget https://raw.githubusercontent.com/baefthde/OpenWebUI_De/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
Ausführen Download sowie Rechte setzen und Ausführen install.sh

Die install.sh:
 - installiert git
 - holt das aktuelle OpenWebUI_De Verzeichnis über git
 - setzt die Rechte und führt OpenWebUI_De.sh aus

### Manuell über git

```bash
  git clone https://github.com/baefthde/OpenWebUI_De
  cd /OpenWebUI_De
  chmod +x OpenWebUI_De.sh
  ./OpenWebUI_De.sh
```

### OpenWebUI_De.sh

installiert:
 - Docker über Snap
 - ollama als API Schnittstelle (nur intern auf 127.0.0.1:11434)
   - llama3.1 als LLM (Large Language Model) Sprachmodell von Meta AI
 - OpenWebUI in Docker (extern erreichbar über Port: 8080)
   - OpenWenUI Datenbank unter ~/open-webui/webui.db für Sicherungs- und Wiederherstellung außerhalb von Docker erreichbar
 - watchtower in Docker, damit OpenWebUI jede Stunde sich automatisch aktualisiert
 - openedai-speech API Schnittstelle (extern erreichbar Port: 8000)
   - mit Deutscher Sprachausgabe über die Stimme von thorsten-voice

## Einstellungen nach der Installation

OpenWebUI aufrufen unter http://IP:8080

Erste Registrierung bekommt Adminrechte zum Konfigurieren (Name, E-Mail, Password), es wird keine E-Mail versandt!

- (Settings) Einstellungen -> (General) Allgemein:
  - (Language) Sprache auf "German Deutsch" einstellen
- Einstellungen -> Audio -> TTS-Einstellungen
  - Antwort automatisch abspielen auf Ein
- Admin Panel -> Einstellungen -> Verbindungen
	 - OpenAI-API sollte deaktiviert werden
  - Ollama-API ist auf http://localhost:11434 über Docker start eingestellt
- Admin Panel -> Einstellungen -> Audio
  - TTS-Einstellungen:
    - Text-zu-Sprache-Engine: http://IP:8000/v1 OpenAI: sk-111111111
    - TTS-Stimme: thorsten TTS-Modell: tts-1

Anschließend kann der KI Chat mit Sprachausgabe getestet werden.

## Hinweis

### Andere LLM

sowohl direkt über ollama als auch über die Weboberfläche von OpenWebUI können auch weitere LLM installiert werden:

Die Auswahl der verfügbaren LLM Modele sind hier zu finden: [https://ollama.com/library](https://ollama.com/library)

z.B. ollama pull mistral

## Andere Sprachen bzw. Stimmen

1. Die Sprach-Dateien müssen vom Typ Sprache.onnx und Sprache.onnx.json sein und müssen in den Ordner ~/openedai-speech/voices abgelegt werden.
2. Die Konfigurationsdatei ~/openedai-speech/config/voice_to_speaker.yaml muss angepasst werden, genauere Informationen unter: [https://github.com/matatonic/openedai-speech](https://github.com/matatonic/openedai-speech)
  
## Übersicht der genutzten Projekte

### Ollama

[https://ollama.com/](https://ollama.com/)

[https://github.com/ollama/ollama](https://github.com/ollama/ollama)

### Open Web UI

[openwebui.com](https://openwebui.com)

[https://github.com/open-webui/open-webui](https://github.com/open-webui/open-webui)

### openedai-speech-integration

[openedai-speech-integration](https://docs.openwebui.com/tutorial/openedai-speech-integration/)

[https://github.com/matatonic/openedai-speech](https://github.com/matatonic/openedai-speech)

### thorsten-voice

[https://www.thorsten-voice.de/](https://www.thorsten-voice.de/)

[https://huggingface.co/rhasspy/piper-voices/tree/main/de/de_DE/thorsten/high](https://huggingface.co/rhasspy/piper-voices/tree/main/de/de_DE/thorsten/high)

####Testen der Stimmen:

[https://rhasspy.github.io/piper-samples/](https://rhasspy.github.io/piper-samples/)

## Autor (Authors)

- [@baefthde](https://www.github.com/baefthde)
