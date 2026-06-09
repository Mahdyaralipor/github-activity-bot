# GitHub Activity Bot 🤖

<div dir="rtl">

## فارسی

### چیه این پروژه؟

یه اسکریپت ساده Bash که هر چند ساعت یه‌بار به‌صورت خودکار یه خط متن رندوم به یه فایل اضافه می‌کنه و اون رو commit و push می‌کنه به GitHub.
نتیجه؟ گراف فعالیت GitHub شما همیشه سبز می‌مونه 🟩

---

### ساختار پروژه

```
github-activity-bot/
├── auto_commit.sh   ← اسکریپت اصلی
├── setup.sh         ← نصب خودکار
├── activity.txt     ← فایل متنی (خودکار ساخته می‌شه)
└── .gitignore
```

---

### پیش‌نیازها

- سیستم‌عامل Linux یا macOS
- git نصب باشه
- احراز هویت GitHub (SSH یا Personal Access Token)

---

### نصب

**۱. کلون کن:**
```bash
git clone git@github.com:USERNAME/github-activity-bot.git
cd github-activity-bot
```

**۲. اسکریپت setup رو اجرا کن:**
```bash
bash setup.sh
```

setup.sh به‌صورت تعاملی ازت می‌پرسه:
- روش احراز هویت (SSH یا Token)
- هر چند ساعت یه‌بار commit بزنه

همه چیز خودکار تنظیم می‌شه ✅

---

### احراز هویت

#### روش ۱: SSH (توصیه‌شده)

```bash
# ساخت SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# نمایش public key
cat ~/.ssh/id_ed25519.pub
```

بعد برو GitHub ← Settings ← SSH and GPG keys ← New SSH key و paste کن.

سپس remote رو به SSH تغییر بده:
```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

#### روش ۲: Personal Access Token

برو GitHub ← Settings ← Developer settings ← Personal access tokens ← Generate new token

فقط scope مربوط به `repo` رو تیک بزن، بعد:
```bash
git remote set-url origin https://USERNAME:TOKEN@github.com/USERNAME/REPO.git
```

---

### تست دستی

```bash
bash auto_commit.sh
```

---

### مشاهده لاگ‌ها

```bash
tail -f /tmp/github_activity_bot.log
```

---

### مدیریت Cron Job

مشاهده:
```bash
crontab -l
```

ویرایش یا حذف:
```bash
crontab -e
```

---

### عیب‌یابی

| مشکل | راه‌حل |
|------|--------|
| `Permission denied` | `chmod +x auto_commit.sh` |
| `Username/password` می‌خواد | Remote رو به SSH تغییر بده |
| Push نمی‌کنه | `git remote -v` رو چک کن |
| Cron اجرا نمی‌شه | مطمئن شو مسیر فایل در crontab کامل و درسته |

</div>

---

## English

### What is this?

A simple Bash script that automatically appends a random line to a text file and commits + pushes it to GitHub on a schedule using cron.
Result? Your GitHub activity graph stays green 🟩

---

### Project Structure

```
github-activity-bot/
├── auto_commit.sh   ← main script
├── setup.sh         ← automated installer
├── activity.txt     ← text file (auto-created)
└── .gitignore
```

---

### Requirements

- Linux or macOS
- git installed
- GitHub authentication (SSH or Personal Access Token)

---

### Installation

**1. Clone the repo:**
```bash
git clone git@github.com:USERNAME/github-activity-bot.git
cd github-activity-bot
```

**2. Run the setup script:**
```bash
bash setup.sh
```

The setup script will interactively ask you:
- Authentication method (SSH or Token)
- How often to commit (every 1h, 2h, 6h, or custom)

Everything is configured automatically ✅

---

### Authentication

#### Option 1: SSH (Recommended)

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Copy public key
cat ~/.ssh/id_ed25519.pub
```

Go to GitHub → Settings → SSH and GPG keys → New SSH key and paste it.

Then update your remote:
```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

#### Option 2: Personal Access Token

Go to GitHub → Settings → Developer settings → Personal access tokens → Generate new token

Check only the `repo` scope, then:
```bash
git remote set-url origin https://USERNAME:TOKEN@github.com/USERNAME/REPO.git
```

---

### Manual Test

```bash
bash auto_commit.sh
```

---

### View Logs

```bash
tail -f /tmp/github_activity_bot.log
```

---

### Manage Cron Job

View:
```bash
crontab -l
```

Edit or remove:
```bash
crontab -e
```

---

### Troubleshooting

| Issue | Fix |
|-------|-----|
| `Permission denied` | Run `chmod +x auto_commit.sh` |
| Asks for username/password | Switch remote to SSH |
| Push fails | Check `git remote -v` |
| Cron doesn't run | Make sure the full path is used in crontab |

---

### License

MIT
