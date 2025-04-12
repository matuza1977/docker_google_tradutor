import os
from dotenv import load_dotenv
import requests

# Load environment variables
load_dotenv()

# Available languages dictionary
LANGUAGES = {
    '1': {'code': 'en', 'name': 'English'},
    '2': {'code': 'es', 'name': 'Spanish'},
    '3': {'code': 'fr', 'name': 'French'},
    '4': {'code': 'de', 'name': 'German'},
    '5': {'code': 'pt', 'name': 'Portuguese'}
}

def test_api_key():
    """Test if the API key is working correctly."""
    try:
        api_key = os.getenv('GOOGLE_API_KEY')
        if not api_key:
            return False, "API key not found in .env file"
            
        # Test API with a simple translation
        url = f"https://translation.googleapis.com/language/translate/v2?key={api_key}"
        data = {
            'q': 'Hello',
            'target': 'es'
        }
        
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return True, "API key is working correctly!"
        else:
            return False, f"API test failed with status code: {response.status_code}"
            
    except Exception as e:
        return False, f"Error testing API key: {str(e)}"

def translate_text(text, target_language):
    """Translate text to the target language."""
    try:
        api_key = os.getenv('GOOGLE_API_KEY')
        if not api_key:
            return "Error: GOOGLE_API_KEY not found in .env file"
            
        url = f"https://translation.googleapis.com/language/translate/v2?key={api_key}"
        data = {
            'q': text,
            'target': target_language
        }
        
        response = requests.post(url, json=data)
        if response.status_code == 200:
            result = response.json()
            return result['data']['translations'][0]['translatedText']
        else:
            return f"Translation failed with status code: {response.status_code}"
            
    except Exception as e:
        return f"Error during translation: {str(e)}"

def show_language_menu():
    """Display the language selection menu."""
    print("\nAvailable languages:")
    for key, lang in LANGUAGES.items():
        print(f"{key}. {lang['name']} ({lang['code']})")
    
    while True:
        choice = input("\nSelect target language (1-5): ")
        if choice in LANGUAGES:
            return LANGUAGES[choice]['code']
        print("Invalid choice. Please select a number between 1 and 5.")

def main():
    print("Welcome to the Language Translator!")
    
    # Test API key first
    print("\nTesting API key...")
    success, message = test_api_key()
    print(message)
    
    if not success:
        print("Please check your API key and try again.")
        return
    
    while True:
        print("\nOptions:")
        print("1. Translate text")
        print("2. Exit")
        
        choice = input("\nEnter your choice (1 or 2): ")
        
        if choice == "1":
            text = input("\nEnter the text to translate: ")
            target_language = show_language_menu()
            
            translated_text = translate_text(text, target_language)
            print(f"\nTranslated text: {translated_text}")
        
        elif choice == "2":
            print("Goodbye!")
            break
        
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main() 