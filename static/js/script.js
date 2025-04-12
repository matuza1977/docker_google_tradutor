document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('translationForm');
    const sourceText = document.getElementById('sourceText');
    const targetLanguage = document.getElementById('targetLanguage');
    const translatedText = document.getElementById('translatedText');
    const loading = document.querySelector('.loading');
    const sourceTextError = document.getElementById('sourceTextError');
    const translationError = document.getElementById('translationError');
    const translationSuccess = document.getElementById('translationSuccess');
    const charCount = document.querySelector('.char-count');

    // Character count and validation
    sourceText.addEventListener('input', function() {
        const count = this.value.length;
        charCount.textContent = `${count}/5000 characters`;
        
        if (count > 5000) {
            sourceTextError.textContent = 'Text exceeds maximum length of 5000 characters';
            sourceTextError.style.display = 'block';
        } else {
            sourceTextError.style.display = 'none';
        }
    });

    // Form submission
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        if (!sourceText.value.trim()) {
            sourceTextError.textContent = 'Please enter text to translate';
            sourceTextError.style.display = 'block';
            return;
        }

        if (sourceText.value.length > 5000) {
            return;
        }

        try {
            loading.style.display = 'block';
            translatedText.value = '';
            translationError.style.display = 'none';
            translationSuccess.style.display = 'none';
            
            const response = await fetch('/translate', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    text: sourceText.value,
                    target_language: targetLanguage.value
                })
            });
            
            const data = await response.json();
            
            if (response.ok) {
                translatedText.value = data.translated_text;
                translationSuccess.textContent = 'Translation successful!';
                translationSuccess.style.display = 'block';
            } else {
                throw new Error(data.error || 'Translation failed');
            }
        } catch (error) {
            translationError.textContent = `Error: ${error.message}`;
            translationError.style.display = 'block';
        } finally {
            loading.style.display = 'none';
        }
    });

    // Accessibility improvements
    sourceText.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }
    });
}); 