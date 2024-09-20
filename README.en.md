
# Projekt [OpenWebUI_De](https://github.com/baefthde/OpenWebUI_De/)

[![de](https://img.shields.io/badge/lang-de-green.svg)](https://github.com/baefthde/OpenWebUI_De/blob/master/README.md)

The goal is a simple installation and starting the OpenWebUi in German.

A script for the installation and subsequent registration and settings for German speech output

## Documentation

The documentation is still in progress.
[(Documentation)](https://github.com/baefthde/OpenWebUI_De/doc/)

## Dependencies

Linux (tested with Ubuntu 24 LTS Server)

RAM should be at least 16 GB RAM for the standard installation of llama3.1 (use via CPU, adaptation for AMD or NVIDIA also possible, see Ollama)

at least 40 GB storage space hard drive/SSD

root rights

## Installation

### Install everything with one command :-)

The password for the root is only required once

```bash
  wget https://raw.githubusercontent.com/baefthde/OpenWebUI_De/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
Execute download and set rights and execute install.sh

The install.sh:
 - installed git
 - get the current OpenWebUI_De directory via git
 - sets the rights and runs OpenWebUI_De.sh

### Manually via git

```bash
  git clone https://github.com/baefthde/OpenWebUI_De
  cd /OpenWebUI_De
  chmod +x OpenWebUI_De.sh
  ./OpenWebUI_De.sh
```

### OpenWebUI_De.sh
  
installed:
 - Docker via Snap
 - ollama as API interface (only internally on 127.0.0.1:11434)
   - llama3.1 as LLM (Large Language Model) language model from Meta AI
 - OpenWebUI in Docker (accessible externally via port: 8080)
   - OpenWenUI database at ~/open-webui/webui.db accessible for backup and restore outside of Docker
 - watchtower in Docker so that OpenWebUI updates itself automatically every hour
 - openedai-speech API interface (externally accessible port: 8000)
   - with German voice output via the voice of Thorsten-Voice

## Settings after installation

Open OpenWebUI at [http://IP:8080](http://IP:8080)

First registration gets admin rights for configuration (name, email, password), no email will be sent!


- Settings -> General:
  -  Set Language to "German Deutsch".
- Settings -> Audio -> TTS Settings
  - Autoplay reply on
- Admin Panel -> Settings -> Connections
	 - OpenAI API should be disabled
  - Ollama API is set to http://localhost:11434 via Docker start
- Admin Panel -> Settings -> Audio
  - TTS settings:
    - Text-to-speech-engine: http://IP:8000/v1 OpenAI: sk-111111111
    - TTS voice: thorsten TTS-model: tts-1

The AI ​​chat with voice output can then be tested.


## A notice

### Other LLMs

Additional LLMs can also be installed both directly via ollama and via the OpenWebUI web interface:

The selection of available LLM models can be found here: [https://ollama.com/library](https://ollama.com/library)

e.g. ollama pull mistral

## Other languages ​​or voices

1. The voice files must be of the type language.onnx and language.onnx.json and must be placed in the folder ~/openedai-speech/voices.
2. The configuration file ~/openedai-speech/config/voice_to_speaker.yaml needs to be adjusted, more detailed information can be found at: [https://github.com/matatonic/openedai-speech](https://github.com/matatonic/openedai -speech)
  
## Overview of the projects used
  
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

#### Testing the voices

[https://rhasspy.github.io/piper-samples/](https://rhasspy.github.io/piper-samples/)

## Authors

- [@baefthde](https://www.github.com/baefthde)
