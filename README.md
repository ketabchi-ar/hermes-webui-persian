# 🇮🇷 Hermes WebUI Persian & RTL Support (فارسی‌ساز و راست‌چین هرمس وب یوآی)

افزونه رسمی و فوق‌سریع برای افزودن فونت **وزیرمتن (Vazirmatn)** و **راست‌چین هوشمند (RTL)** به [Hermes WebUI](https://github.com/nousresearch/hermes-webui).

---

## ✨ ویژگی‌ها (Features)

- ⚡ **نصب آنی و زیر ۱ ثانیه (Instant Install):** بدون نیاز به clone کردن گیت، تنها با دانلود بسته‌ی سبک فشرده در چند میلی‌ثانیه.
- 🔤 **فونت وزیرمتن (Vazirmatn Font):** بارگذاری آفلاین و محلی بدون نیاز به اینترنت و بدون فیلتر با ۴ وزن (Regular, Medium, SemiBold, Bold).
- 🔄 **راست‌چین هوشمند (Smart RTL):** تشخیص خودکار متون فارسی و راست‌چین کردن پیام‌ها و کامپوزر ورودی.
- 🛡️ **حفظ و ایزوله‌سازی کدها (Code Isolation):** بلوک‌های کد (`pre`, `code`)، شبیه‌ساز ترمینال، فرمول‌های ریاضی KaTeX و متون انگلیسی کاملاً چپ‌چین (`LTR`) با فونت مونواسپیس باقی می‌مانند.
- 🎛️ **دکمه سوئیچ سریع (Live Toggle):** دارای دکمه شناور در گوشه صفحه برای فعال/غیرفعال‌سازی سریع فونت وزیرمتن و بازگشت به فونت اصلی در صورت نیاز.
- 🔒 **پایداری دائمی در برابر آپدیت‌ها (Update-Proof):** با `git pull`، به‌روزرسانی نسخه هرمس یا ریستارت سرور از بین نمی‌رود، زیرا در دایرکتوری پایدار کاربری (`~/.hermes/webui/extensions`) نصب می‌شود.
- 💻 **سازگار با تمام سیستم‌عامل‌ها:** macOS, Linux, WSL و Windows.

---

## 🚀 روش‌های نصب (Installation)

### ۱. مک و لینوکس (macOS / Linux / WSL) — نصب تک‌خطی

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/install.sh | bash
```

سپس صفحه مرورگر Hermes WebUI را رفرش کنید (`Cmd+R` یا `Ctrl+R`).

---

### ۲. ویندوز (Windows PowerShell) — نصب تک‌خطی

در PowerShell ویندوز:

```powershell
iwr -useb https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/install.ps1 | iex
```

---

### ۳. درخواست مستقیم از هرمس ایجنت (Hermes Agent Autonomous Install)

لینک این مخزن را به هرمس بدهید و بگویید:
> «این پروژه را برای هرمس وب‌یوای من نصب کن: https://github.com/m4tinbeigi-official/hermes-webui-persian»

هرمس به صورت خودکار پروژه را شناسایی و در کمتر از یک ثانیه نصب می‌کند.

---

### ۴. نصب دستی (Manual Installation)

```bash
git clone https://github.com/m4tinbeigi-official/hermes-webui-persian.git
cd hermes-webui-persian
./install.sh
```

---

## 🗑️ حذف افزونه (Uninstall)

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/uninstall.sh | bash
```

---

## 📄 مجوز (License)
MIT License - توسعه داده شده برای جامعه کاربری فارسی‌زبان هوش مصنوعی.
