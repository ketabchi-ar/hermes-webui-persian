# 🇮🇷 Hermes WebUI Persian & RTL Support (فارسی‌ساز و راست‌چین هرمس وب یوآی)

افزونه رسمی و خودکار برای افزودن فونت **وزیرمتن (Vazirmatn)** و **راست‌چین هوشمند (RTL)** به [Hermes WebUI](https://github.com/nousresearch/hermes-webui).

---

## ✨ ویژگی‌ها (Features)

- 🔤 **فونت وزیرمتن (Vazirmatn Font):** بارگذاری آفلاین و محلی بدون نیاز به اینترنت و بدون فیلتر با ۴ وزن (Regular, Medium, SemiBold, Bold).
- 🔄 **راست‌چین هوشمند (Smart RTL):** تشخیص خودکار متون فارسی و راست‌چین کردن پیام‌ها و کامپوزر ورودی.
- 🛡️ **حفظ و ایزوله‌سازی کدها (Code Isolation):** بلوک‌های کد (`pre`, `code`)، شبیه‌ساز ترمینال، فرمول‌های ریاضی KaTeX و متون انگلیسی کاملاً چپ‌چین (`LTR`) با فونت مونواسپیس باقی می‌مانند.
- 🔒 **پایداری دائمی در برابر آپدیت‌ها (Update-Proof):** با `git pull`، به‌روزرسانی نسخه هرمس یا ریستارت سرور از بین نمی‌رود، زیرا در دایرکتوری پایدار کاربری (`~/.hermes/webui/extensions`) نصب می‌شود.

---

## 🚀 روش‌های نصب (Installation)

### روش ۱: نصب تک‌خطی با دستور ترمینال (پیشنهادی)

کافیست دستور زیر را در ترمینال سیستم خود اجرا کنید:

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/install.sh | bash
```

سپس صفحه مرورگر Hermes WebUI را رفرش کنید!

---

### روش ۲: نصب از طریق خود هرمس (Hermes Agent / WebUI)

لینک این مخزن را به هرمس بدهید و بگویید:
> «این پروژه را برای هرمس وب‌یوای من نصب کن: https://github.com/m4tinbeigi-official/hermes-webui-persian»

هرمس به صورت خودکار پروژه را کلون کرده و `install.sh` یا `install.py` را اجرا می‌کند.

---

### روش ۳: نصب دستی (Manual Installation)

```bash
git clone https://github.com/m4tinbeigi-official/hermes-webui-persian.git
cd hermes-webui-persian
chmod +x install.sh
./install.sh
```

یا در پایتون (سازگار با ویندوز، مک و لینوکس):

```bash
python3 install.py
```

---

## 🗑️ حذف افزونه (Uninstall)

اگر زمانی مایل به غیرفعال‌سازی یا حذف بودید:

```bash
curl -fsSL https://raw.githubusercontent.com/m4tinbeigi-official/hermes-webui-persian/main/uninstall.sh | bash
```

---

## 📄 مجوز (License)
MIT License - توسعه داده شده برای جامعه کاربری فارسی‌زبان هوش مصنوعی.
