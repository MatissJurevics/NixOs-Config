{ config, lib, pkgs, ... }:

{
  # TLP Configuration
  services.tlp = {
    enable = true;
    settings = {
      # CPU Scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;  # Limits max CPU performance on battery

      # Platform Power Profile
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery Protection
      START_CHARGE_THRESH_BAT0 = 75;    # Start charging at 75%
      STOP_CHARGE_THRESH_BAT0 = 80;     # Stop charging at 80%
      RESTORE_THRESHOLDS_ON_BAT = 1;

      # PCIe Active State Power Management
      PCIE_ASPM_ON_BAT = "powersupersave";

      # Runtime Power Management
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ALL = 1;

      # Disk Management
      DISK_DEVICES = "nvme0n1 sda";
      DISK_APM_LEVEL_ON_BAT = "254";
      MAX_LOST_WORK_SECS_ON_BAT = 15;

      # USB Autosuspend
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1;
      };
  };

  # Complementary power settings
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false;
}

