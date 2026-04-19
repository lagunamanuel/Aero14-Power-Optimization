#!/bin/bash

# =================================================================
# Script: acpi-wakeup-fix.sh
# Description: Disables specific ACPI wakeup events to prevent 
#              unintended battery drain during sleep states.
# Target Hardware: Gigabyte Aero 14 (and similar Intel-based laptops)
# Author: Manuel Laguna Martinez
# =================================================================

# Path for the log file and list of problematic devices
LOG_FILE="/var/log/acpi_wakeup_manager.log"
DEVICES=("XHCI" "TXHC" "AWAC" "RP05" "RP06" "TRP0" "TRP1")

# Create log file if it doesn't exist and ensure it's writable
touch "$LOG_FILE" 2>/dev/null

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting ACPI wakeup configuration..." >> "$LOG_FILE"

# Iterate through each device to check its current status
for dev in "${DEVICES[@]}"; do
    # Check if the device is currently 'enabled' for wakeup in the ACPI table
    if grep -q "$dev.*enabled" /proc/acpi/wakeup; then
        # Writing the device name to /proc/acpi/wakeup toggles its state
        echo "$dev" > /proc/acpi/wakeup
        
        # Verify the change and log the outcome
        if grep -q "$dev.*disabled" /proc/acpi/wakeup; then
            echo "[INFO] Device $dev successfully disabled." >> "$LOG_FILE"
        else
            echo "[ERROR] Failed to disable device: $dev." >> "$LOG_FILE"
        fi
    fi
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] ACPI power optimization completed." >> "$LOG_FILE"