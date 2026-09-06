/**
 * Hermes WebUI - Persian RTL & Vazirmatn Engine
 * Ultra-fast native DOM observer and direction controller.
 */
(function () {
  const RTL_CHAR_REGEX = /[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]/;

  function isRtlText(text) {
    if (!text || typeof text !== 'string') return false;
    const clean = text.replace(/`{3}[\s\S]*?`{3}|`[^`]*`|https?:\/\/\S+/g, '').trim();
    const sample = clean.slice(0, 150);
    return RTL_CHAR_REGEX.test(sample);
  }

  function processElementDirection(el) {
    if (!el || el.nodeType !== 1) return;
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
              } else if (node.querySelectorAll) {
                const inner = node.querySelectorAll('.msg-body, .msg-row');
                inner.forEach(processElementDirection);
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

  function createQuickToggle() {
    if (document.getElementById('hermes-rtl-toggle')) return;
    const btn = document.createElement('div');
    btn.id = 'hermes-rtl-toggle';
    btn.title = 'تغییر وضعیت فونت وزیرمتن و راست‌چین';
    btn.innerHTML = '🇮🇷 وزیرمتن فعال';
    
    let isVazirActive = true;
    btn.addEventListener('click', () => {
      isVazirActive = !isVazirActive;
      if (isVazirActive) {
        document.documentElement.style.removeProperty('--font-ui');
        document.documentElement.style.removeProperty('--font-conversation');
        btn.innerHTML = '🇮🇷 وزیرمتن فعال';
        btn.style.opacity = '0.7';
      } else {
        document.documentElement.style.setProperty('--font-ui', 'inherit', 'important');
        document.documentElement.style.setProperty('--font-conversation', 'inherit', 'important');
        btn.innerHTML = '🌐 فونت پیش‌فرض';
        btn.style.opacity = '0.4';
      }
    });
    document.body.appendChild(btn);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      scanAllMessages();
      setupObserver();
      createQuickToggle();
    });
  } else {
    scanAllMessages();
    setupObserver();
    createQuickToggle();
  }

  setInterval(enhanceComposer, 2000);
})();
