# 🩺 Linux Health Check Script

A lightweight, Bash-based system health check script to monitor critical system metrics such as CPU load, memory usage, disk space, network connectivity, and service availability.

---

## 📋 Features

- ✅ Check 1-minute **CPU load**
- ✅ Monitor **memory usage**
- ✅ Inspect **disk usage** of root filesystem (`/`)
- ✅ Perform a **network connectivity** test via ping
- ✅ Ensure critical **services** (like `sshd`) are running
- ✅ Color-coded `[OK]` / `[FAIL]` status messages for clarity
- ✅ Ideal for **cron jobs**, **DevOps pipelines**, and **on-demand diagnostics**

---

## 📂 Files Included

- `health_check.sh` – The main script file
- `README.md` – Documentation

---

## 💻 Usage

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/linux-health-check.git
   cd linux-health-check

2. **Make the script executable**:

   ```bash
   chmod +x health_check.sh
   
4. **Run the script**:

   ```bash
   ./health_check.sh

## 📖 Detailed Blog Post

Want a full **line-by-line breakdown** of this script?

👉 Read the blog post here: [Linux Health Check Script - Explained Step by Step](https://shell-scripting-to-monitor-system-health.hashnode.dev/lightweight-linux-system-health-check-script)

It covers:
- Purpose of each check
- How the logic works
- Key uses of the script

## 🧪Sample Output
   
```bash
[OK] CPU Load: 0.45
[OK] Memory usage: 61% used
[OK] Disk usage on /: 47% used
[OK] Network: Ping to 8.8.8.8
[OK] Service 'sshd' is running
```
Or in case of issues:
```bash
[FAIL] Memory usage: 91% used
[FAIL] Disk usage on /: 92% used
[FAIL] Service 'sshd' is NOT running
```

## ⚙️Configuration

- Thresholds:
  Modify cpu_threshold, memory or disk usage limits directly in the script.

- Service Check:
  Replace sshd with any other critical service (e.g., nginx, docker, mysql).

- Colors:
  You can define or disable color output for better compatibility with non-TTY environments.

## 🧩Function Breakdown

- print_status(): Prints [OK] or [FAIL] with color

- CPU, Memory, Disk, Network, and Service checks: Implemented with standard Linux tools (uptime, free, df, ping, systemctl)

## 🛠️Recommended Enhancements

- Log output to a file
- Email or Slack alerts on failure
- Add checks for other services (e.g., docker, nginx, postgresql)
- Integrate with CI/CD pipeline or cron jobs

## 🙌 Contributions

  Feel free to fork the repo, suggest improvements, or submit pull requests!

