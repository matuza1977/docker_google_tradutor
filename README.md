# Language Translator

A simple command-line application for translating text between different languages using the Google Cloud Translate API.

## Setup

1. Make sure you have Python installed on your system
2. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```
3. The application uses the Google Cloud API key from the `.env` file

## Usage

Run the application using:
```
python translator.py
```

The application will present you with a menu where you can:
1. Translate text to any supported language
2. Exit the application

When translating, you'll need to provide:
- The text you want to translate
- The target language code (e.g., 'es' for Spanish, 'fr' for French, 'pt' for Portuguese)

## Supported Languages

The application supports all languages available in the Google Translate API. Some common language codes:
- English: 'en'
- Spanish: 'es'
- French: 'fr'
- German: 'de'
- Portuguese: 'pt'
- Italian: 'it'
- Russian: 'ru'
- Chinese (Simplified): 'zh'
- Japanese: 'ja'
- Korean: 'ko' 