# Colors for output
$Red = [System.ConsoleColor]::Red
$Green = [System.ConsoleColor]::Green
$Yellow = [System.ConsoleColor]::Yellow

# Function to print colored messages
function Write-ColorMessage {
    param (
        [string]$Message,
        [System.ConsoleColor]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}

# Function to check if a command exists
function Test-Command {
    param (
        [string]$Command
    )
    return [bool](Get-Command -Name $Command -ErrorAction SilentlyContinue)
}

# Check if running on Windows
if ($env:OS -ne "Windows_NT") {
    Write-ColorMessage "This script is only for Windows" $Red
    exit 1
}

# Check for Python
if (-not (Test-Command "python")) {
    Write-ColorMessage "Python is not installed. Please install Python from https://www.python.org/downloads/" $Red
    Write-ColorMessage "After installation, run this script again" $Yellow
    exit 1
} else {
    Write-ColorMessage "Python is installed" $Green
}

# Check for pip
if (-not (Test-Command "pip")) {
    Write-ColorMessage "Installing pip..." $Yellow
    python -m ensurepip --default-pip
} else {
    Write-ColorMessage "pip is installed" $Green
}

# Install Python dependencies
Write-ColorMessage "Installing Python dependencies..." $Yellow
pip install -r requirements.txt

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-ColorMessage "Creating .env file..." $Yellow
    @"
GOOGLE_API_KEY=your_api_key_here
"@ | Out-File -FilePath ".env" -Encoding UTF8
    Write-ColorMessage "Please add your Google API key to the .env file" $Yellow
}

# Create virtual environment
Write-ColorMessage "Creating virtual environment..." $Yellow
python -m venv venv

# Activate virtual environment
Write-ColorMessage "Activating virtual environment..." $Yellow
.\venv\Scripts\Activate.ps1

# Install dependencies in virtual environment
Write-ColorMessage "Installing dependencies in virtual environment..." $Yellow
pip install -r requirements.txt

# Create startup script
Write-ColorMessage "Creating startup script..." $Yellow
@"
@echo off
call .\venv\Scripts\activate.bat
python app.py
"@ | Out-File -FilePath "start.bat" -Encoding ASCII

# Make startup script executable
Write-ColorMessage "Making startup script executable..." $Yellow
icacls "start.bat" /grant "Everyone:(RX)"

Write-ColorMessage "Setup completed successfully!" $Green
Write-ColorMessage "To start the application, run: .\start.bat" $Yellow
Write-ColorMessage "Don't forget to add your Google API key to the .env file" $Yellow 