# Virtual Assistant - Proof of Concept (POC)

## Officer

Mike Niner Bravog

## Bootcamp

BairesDev - Machine Learning Practitioner - February 2025

## Description

This project is a virtual assistant built using **Natural Language Processing (NLP)**. The system captures audio input from the user, transcribes it to text (*Speech-to-Text*), identifies the intent, and performs searches on Google Maps based on the spoken command.

### Features

* Audio capture via microphone and conversion to text
* Command interpretation and Google Maps search
* Voice response confirming the query before opening the browser
* Continuous loop until the user ends the session

## Requirements

The system was developed and tested with **Python 3.11**. To ensure correct execution, install the dependencies below.

### Dependencies

Install all required packages with:

```bash
pip install -r requirements.txt
```

If you haven't created the `requirements.txt` file yet, run:

```bash
pip freeze > requirements.txt
```

### Specific Package Installation

If you face issues with **PyAudio** on Linux, install **PortAudio** first:

```bash
sudo apt update
sudo apt install portaudio19-dev
pip install pyaudio
```

On Windows, you may need to install it using **pipwin**:

```bash
pip install pipwin
pipwin install pyaudio
```

Additionally, **pygobject** was required for system compatibility:

```bash
pip install pygobject
```

## Usage

To start the virtual assistant, run:

```bash
python do1.py
```

The assistant will begin by asking **"What would you like to search for on Google Maps?"**
Simply say a location or service. The system will continue listening for commands until you say **"end"**, **"quit"**, or **"exit"**.

### Example Commands

* "Japanese restaurant in Leblon"
* "Plasterer near me"
* "24-hour pharmacy in Copacabana"

## Code Structure

### 1. Text-to-Speech (TTS)

Uses `gTTS` to convert text into speech, allowing the assistant to confirm the query audibly.

### 2. Speech-to-Text (STT)

Uses `speech_recognition` to capture speech and convert it to text. Configurations were tuned to prevent audio clipping.

### 3. Google Maps Search

Dynamically generates the search URL and opens it in the default web browser.

### 4. Main Loop

Keeps the system running, continuously listening for new commands until the user decides to stop.

## Conclusion

This project showcases how **Machine Learning and NLP** can be applied to build a functional voice assistant. The code has been optimized to minimize speech recognition interruptions and improve search accuracy. This assistant can be easily extended to other use cases like conversational bots, task automation, or integration with external APIs.
