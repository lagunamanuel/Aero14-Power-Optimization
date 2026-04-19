# Aero14-Power-Optimization

A low-level system utility to fix battery drain issues on the Gigabyte Aero 14 (Intel 12th Gen) by managing ACPI wakeup events.

## 📝 Description

This project addresses a common issue in modern laptops where specific PCIe and USB controllers prevent the CPU from entering deep sleep states (C-states) during suspension. By toggling these "rebel" devices in the ACPI wakeup table, we significantly reduce power consumption while the lid is closed.

The solution consists of a **Bash script** that handles the hardware logic and a **Systemd service** that ensures the configuration is applied automatically at system boot.

## ✨ Features

- **Automated ACPI Management**: Targets specific nodes (`XHCI`, `RP05`, `RP06`, etc.) known for causing battery drain.
- **Persistence**: Integrates with `systemd` to keep settings across reboots.
- **Detailed Logging**: Every action is recorded in `/var/log/acpi_wakeup_manager.log` for easy auditing.
- **Non-Intrusive**: Only toggles devices that are currently enabled, following Linux kernel best practices.

## 🚀 Installation

Follow these steps to deploy the optimization on your system:

### 1. Script Setup
Move the script to a system-wide binary path and grant execution permissions:

```bash
sudo cp src/acpi-wakeup-fix.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/acpi-wakeup-fix.sh
```

### 2. Systemd Integration
Install and enable the service to automate the process on every boot:

```bash
sudo cp systemd/acpi-wakeup-fix.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now acpi-wakeup-fix.service
```

## 🔍 Verification & Logs

You can verify that the service is running correctly by checking the system status:

```bash
systemctl status acpi-wakeup-fix.service
```

To audit which devices were disabled and check the execution history:

```bash
cat /var/log/acpi_wakeup_manager.log
```

## ⚖️ License

This project is licensed under the **MIT License**. See the `LICENSE` file for the full text.

---
**Developed by Manuel Laguna Martinez**
