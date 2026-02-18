# 💰 Cost-Efficient Email & Calendar Scripts

**Zero API costs!** Run these directly instead of asking Garion for routine tasks.

## 📧 Email Scripts

### `check-email.sh`
Quick email check - recent messages and unread count
```bash
~/clawd/scripts/check-email.sh
```

### `send-email.sh`
Send emails directly
```bash
~/clawd/scripts/send-email.sh "recipient@example.com" "Subject" "Message body"
```

## 📅 Calendar Scripts

### `check-calendar.sh`
Today's events and 3-day preview
```bash
~/clawd/scripts/check-calendar.sh
```

## 📊 Combined Scripts

### `daily-summary.sh`
Complete email + calendar summary (recommended daily check!)
```bash
~/clawd/scripts/daily-summary.sh
```

## 💡 Usage Tips

**Daily routine:**
1. Run `daily-summary.sh` each morning
2. Use `send-email.sh` for quick messages
3. Check `check-calendar.sh` before meetings

**When to use Garion:**
- Complex email searches
- Calendar event creation
- Multi-step workflows  
- Analysis and summaries
- When you need help with commands

**Cost savings:**
- These scripts: $0.00
- Asking Garion to do the same: ~$0.05-0.20 each time

## 🚀 Aliases (Optional)

Add to your `~/.zshrc` for even faster access:
```bash
alias email="~/clawd/scripts/check-email.sh"
alias cal="~/clawd/scripts/check-calendar.sh"  
alias daily="~/clawd/scripts/daily-summary.sh"
```

Then just type `daily` for your morning summary!