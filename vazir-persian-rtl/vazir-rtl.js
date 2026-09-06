/**
 * Hermes WebUI - Persian RTL & Vazirmatn Font Automation
 * Automatically detects Persian/Arabic text and handles RTL layout dynamically.
 */
(function () {
  const RTL_CHAR_REGEX = /[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]/;

  function isRtlText(text) {
    if (!text || typeof text !== 'string') return false;
    const clean = text.replace(/`{3}[\s\S]*?`{3}|`[^`]*`|https?:\/\/\S+/g, '').trim();
    // Check first 150 non-whitespace characters for Persian/Arabic
    const sample = clean.slice(0, 150);
    return RTL_CHAR_REGEX.test(sample);
  }

  function processElementDirection(el) {
    if (!el || el.nodeType !== 1) return;
    // Skip code, terminal, math blocks
    if (el.matches('pre, code, .xterm, .terminal-container, .katex, .katex-display, .font-mono')) {
      return;
    }

    if (el.classList.contains('msg-body') || el.classList.contains('msg-row') || el.classList.contains('message-bubble')) {
      const text = el.textContent || '';
      if (isRtlText(text)) {
        el.setAttribute('dir', 'rtl');
        el.classList.add('msg-rtl');
      } else {
        el.setAttribute('dir', 'ltr');
        el.classList.remove('msg-rtl');
      }
    }
  }

  function enhanceComposer() {
    const textareas = document.querySelectorAll('textarea#msg, .composer-box textarea, input[type="text"]');
    textareas.forEach(input => {
      if (!input.dataset.rtlEnhanced) {
        input.dataset.rtlEnhanced = '1';
        input.setAttribute('dir', 'auto');
        
        input.addEventListener('input', function () {
          if (isRtlText(this.value)) {
            this.setAttribute('dir', 'rtl');
            this.style.textAlign = 'right';
          } else {
            this.setAttribute('dir', 'ltr');
            this.style.textAlign = 'left';
          }
        });
      }
    });
  }

  function scanAllMessages() {
    enhanceComposer();
    const messageBodies = document.querySelectorAll('.msg-body, .message-bubble, .session-title');
    messageBodies.forEach(processElementDirection);
  }

  // Setup DOM MutationObserver to catch streamed messages and new turns
  function setupObserver() {
    const target = document.querySelector('#chat') || document.querySelector('.chat-container') || document.body;
    if (!target) return;

    const observer = new MutationObserver(mutations => {
      for (const m of mutations) {
        if (m.type === 'childList') {
          m.addedNodes.forEach(node => {
            if (node.nodeType === 1) {
              if (node.classList && (node.classList.contains('msg-body') || node.classList.contains('msg-row'))) {
                processElementDirection(node);
              } else {
                const inner = node.querySelectorAll && node.querySelectorAll('.msg-body, .msg-row');
                if (inner && inner.length) {
                  inner.forEach(processElementDirection);
                }
              }
              enhanceComposer();
            }
          });
        } else if (m.type === 'characterData' || m.type === 'subtree') {
          const parent = m.target.parentElement;
          if (parent) {
            const body = parent.closest('.msg-body');
            if (body) processElementDirection(body);
          }
        }
      }
    });

    observer.observe(target, {
      childList: true,
      subtree: true,
      characterData: true
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      scanAllMessages();
      setupObserver();
    });
  } else {
    scanAllMessages();
    setupObserver();
  }

  // Polling fallback to guarantee composer and elements are decorated
  setInterval(() => {
    enhanceComposer();
  }, 2000);
})();
