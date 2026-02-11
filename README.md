# Intune-Chrome-Compliance-Automation
Automated Google Chrome compliance enforcement using Microsoft Intune Proactive Remediations and PowerShell.
🚀 Intune Chrome Compliance Automation

Automated Google Chrome version compliance enforcement using Microsoft Intune Proactive Remediations and PowerShell.

This solution dynamically detects outdated Chrome installations and performs automated remediation using the official Chrome Enterprise MSI (Extended Stable) installer.

📌 Project Objective

Outdated browsers are one of the most common attack vectors in enterprise environments. This project provides a zero-touch, scalable, and production-ready solution to:

Detect outdated Google Chrome installations

Enforce enterprise-approved Chrome versions

Automate silent remediation

Improve endpoint security posture

              ┌────────────────────────────┐
              │   Microsoft Intune         │
              │   Proactive Remediations   │
              └──────────────┬─────────────┘
                             │
                ┌────────────▼────────────┐
                │     Detection Script     │
                └────────────┬────────────┘
                             │
           ┌─────────────────▼─────────────────┐
           │ Compare Installed vs Latest       │
           │ Chrome Version (Google API)       │
           └─────────────────┬─────────────────┘
                             │
                    Non-Compliant Device
                             │
                ┌────────────▼────────────┐
                │    Remediation Script    │
                └────────────┬────────────┘
                             │
      User Notification → Close Chrome → Silent Install → Cleanup

