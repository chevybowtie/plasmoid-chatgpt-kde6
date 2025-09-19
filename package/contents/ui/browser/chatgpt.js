/**
 * Returns the prompt input textarea element for ChatGPT.
 * @returns {HTMLTextAreaElement|null}
 */
const getPromptInput = () => document.querySelector('#prompt-textarea');

/**
 * Focuses the prompt input textarea if it exists.
 */
const tryToFocusPromptInput = () => {
	const promptInput = getPromptInput();
	if (!promptInput) {
		return;
	}

	promptInput.focus();
}

/**
 * Calls the callback whenever the page URL changes (SPA navigation).
 * @param {function({url: string}):void} callback
 */
const onUrlChanged = (callback) => {
	let previousUrl = '';
	const observer = new MutationObserver(() => {
		if (location.href !== previousUrl) {
			previousUrl = location.href;

			callback({ url: location.href });
		}
	});

	observer.observe(document, {
		childList: true,
		subtree: true,
	})
}

/**
 * Handles keydown events on the prompt input. Sends message on Ctrl+Enter.
 * @param {KeyboardEvent} event
 */
const onPromptInputKeydown = (event) => {
	const promptInput = event.target;

	if (promptInput.value.trim().length < 0) {
		return
	}

	if (event.ctrlKey && event.key === 'Enter') {
		const sendButton = document.querySelector('[data-testid="send-button"]');
		if (!sendButton) {
			return;
		}

		sendButton.click();
	}
}

/**
 * Determines if a URL is external (not openai.com or chatgpt.com).
 * @param {string} url
 * @returns {boolean}
 */
const isExternalLink = (url) => {
	return !url.includes('openai.com') && !url.includes('chatgpt.com');
}

/**
 * Checks if the document is in dark mode.
 * @returns {boolean}
 */
const isDarkMode = () => document.documentElement.classList.contains('dark');

/**
 * Fixes the placeholder color in the prompt input for dark mode.
 */
const removeBlackPlaceholderInPromptInput = () => {
	const promptInput = getPromptInput();

	const placeholderGray = 'placeholder-gray-500'
	const placeholderBlack = 'placeholder-black/50'

	if (!promptInput?.classList.contains(placeholderGray)) {
		promptInput.classList.add(placeholderGray);
		promptInput.classList.remove(placeholderBlack);
	}
}

// `WebEngineView` show the placeholder text in black color when dark mode is enabled.
// This is a workaround to fix this issue. We can remove this once the issue is fixed.

/**
 * Workaround for black placeholder text in dark mode (WebEngineView bug).
 * Observes class changes and reapplies fix as needed.
 */
const fixDarkModeStyles = () => {
	if (!isDarkMode() || !getPromptInput()) {
		return;
	}

	removeBlackPlaceholderInPromptInput();

	const observer = new MutationObserver((changes) => {
		for (const change of changes) {
			// If the class attribute is changed, we need to fix the dark mode styles again.
			if (change.type === 'attributes' && change.attributeName === 'class') {
				removeBlackPlaceholderInPromptInput();

				observer.disconnect();
			}
		}
	});

	observer.observe(getPromptInput(), {
		attributes: true,
		attributeFilter: ['class'],
	})
}

/**
 * Main entry point: sets up URL change and input listeners, fixes dark mode, and handles external links.
 */
const main = () => {
	// Initialize the script
	main();
	onUrlChanged(() => {
		const promptInput = getPromptInput();
		if (!promptInput) {
			return;
		}

		fixDarkModeStyles()

		promptInput.removeEventListener('keydown', onPromptInputKeydown);

		promptInput.addEventListener('keydown', onPromptInputKeydown);
	});

	document.addEventListener('click', (event) => {
		if (event.target.nodeName === 'A') {
			if (isExternalLink(event.target.href)) {
				event.preventDefault();
				window.location.href = event.target.href;
			}
		}
	});
}

main();
