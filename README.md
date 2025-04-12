# Language Translator Web App

A modern web application for translating text and documents between multiple languages using the Google Cloud Translate API.

## Features

- Text translation between multiple languages
- PDF and DOCX file translation
- Drag and drop file upload
- Clean and intuitive interface
- Support for multiple target languages:
  - English
  - Spanish
  - French
  - German
  - Portuguese

## Prerequisites

- Python 3.9 or higher
- Google Cloud API Key
- Windows operating system (for the provided setup script)

## Installation

### Windows Setup

1. Download or clone this repository
2. Open PowerShell as Administrator
3. Navigate to the project directory
4. Run the setup script:
   ```powershell
   .\setup.ps1
   ```
5. The script will:
   - Install Python dependencies
   - Create a virtual environment
   - Set up the configuration files
   - Create a startup script

6. Edit the `.env` file and add your Google API key:
   ```
   GOOGLE_API_KEY=your_api_key_here
   ```

## Running the Application

### Windows
Simply run the created `start.bat` script:
```powershell
.\start.bat
```

The application will be available at:
- http://localhost:5000

## Usage

### Text Translation
1. Enter the text you want to translate in the text area
2. Select the target language
3. Click "Translate Text"
4. The translated text will appear in the result area

### File Translation
1. Click "Choose File" or drag and drop a PDF or DOCX file
2. Select the target language
3. Click "Translate File"
4. The translated file will be downloaded automatically

## Supported File Formats
- PDF (.pdf)
- Microsoft Word (.docx)

## Notes
- The maximum file size is limited by Flask's default configuration (16MB)
- The translated file will be saved as a DOCX file
- Basic text formatting is preserved in the translation

## Troubleshooting

If you encounter any issues:

1. Make sure Python is installed and in your system PATH
2. Verify your Google API key is correct in the `.env` file
3. Check that all dependencies are installed correctly
4. Ensure you have sufficient permissions to run the scripts

## License
This project is licensed under the MIT License - see the LICENSE file for details. 