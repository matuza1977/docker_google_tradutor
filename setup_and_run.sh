#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${2}${1}${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_message "This script is only for macOS" "$RED"
    exit 1
fi

# Check for Homebrew
if ! command_exists brew; then
    print_message "Installing Homebrew..." "$YELLOW"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    print_message "Homebrew is already installed" "$GREEN"
fi

# Check for Docker
if ! command_exists docker; then
    print_message "Docker is not installed. Please install Docker Desktop for Mac from https://www.docker.com/products/docker-desktop" "$RED"
    print_message "After installation, run this script again" "$YELLOW"
    exit 1
else
    print_message "Docker is installed" "$GREEN"
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    print_message "Docker is not running. Please start Docker Desktop" "$RED"
    exit 1
else
    print_message "Docker is running" "$GREEN"
fi

# Check for Python
if ! command_exists python3; then
    print_message "Installing Python..." "$YELLOW"
    brew install python
else
    print_message "Python is installed" "$GREEN"
fi

# Check for pip
if ! command_exists pip3; then
    print_message "Installing pip..." "$YELLOW"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
else
    print_message "pip is installed" "$GREEN"
fi

# Install Python dependencies
print_message "Installing Python dependencies..." "$YELLOW"
pip3 install -r requirements.txt

# Check if .env file exists
if [ ! -f .env ]; then
    print_message "Creating .env file..." "$YELLOW"
    touch .env
    echo "GOOGLE_API_KEY=your_api_key_here" > .env
    print_message "Please add your Google API key to the .env file" "$YELLOW"
    exit 1
fi

# Build and run Docker containers
print_message "Building and starting Docker containers..." "$YELLOW"
docker-compose up --build -d

# Wait for the application to start
print_message "Waiting for the application to start..." "$YELLOW"
sleep 5

# Check if the application is running
if curl -s http://localhost:5000 > /dev/null; then
    print_message "Application is running at http://localhost:5000" "$GREEN"
else
    print_message "Application failed to start. Check the logs with: docker-compose logs" "$RED"
    exit 1
fi

# Function to handle script termination
cleanup() {
    print_message "\nStopping Docker containers..." "$YELLOW"
    docker-compose down
    print_message "Script terminated" "$GREEN"
    exit 0
}

# Set up trap to catch script termination
trap cleanup SIGINT SIGTERM

print_message "Press Ctrl+C to stop the application" "$YELLOW"

# Keep the script running
while true; do
    sleep 1
done 