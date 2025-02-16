# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	./nordvpn.nix
	./hardware/power-managment.nix
    ];

  # Bootloader.
  boot.loader = {
  grub = {
    enable = true;                # Enable GRUB bootloader
    efiSupport = true;            # Enable UEFI support
    device = "nodev";             # Use "nodev" for UEFI systems
    useOSProber = true;           # Detect other operating systems (optional)
    copyKernels = true;           # Copy kernels to the ESP (optional, but useful for UEFI)
  };
  efi.canTouchEfiVariables = true; # Allow modifying EFI variables
};

  networking.hostName = "nixos"; # Define your hostname.


  myypo.services.custom.nordvpn.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ko_KR.UTF-8";
    LC_IDENTIFICATION = "ko_KR.UTF-8";
    LC_MEASUREMENT = "ko_KR.UTF-8";
    LC_MONETARY = "ko_KR.UTF-8";
    LC_NAME = "ko_KR.UTF-8";
    LC_NUMERIC = "ko_KR.UTF-8";
    LC_PAPER = "ko_KR.UTF-8";
    LC_TELEPHONE = "ko_KR.UTF-8";
    LC_TIME = "ko_KR.UTF-8";
  };



  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  pname = "distro-grub-themes";
  version = "3.1";
  src = pkgs.fetchFromGitHub {
    owner = "AdisonCavani";
    repo = "distro-grub-themes";
    rev = "v3.1";
    hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  };
  installPhase = "cp -r customize/nixos $out";
};

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.flatpak.enable = true; 
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  services.fprintd = {
	enable = true;
	package = pkgs.fprintd-tod;
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
# Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matissj = {
    isNormalUser = true;
    description = "Matiss Jurevics";
    extraGroups = [ "networkmanager" "wheel" "nordvpn"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  users.groups.nordvpn = {}; 
  systemd.services.nordvpn.serviceConfig = {
    RuntimeDirectory = "nordvpn";
    RuntimeDirectoryMode = "0750"; # Ensure group access
    Group = "nordvpn";
  };
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  	wget
	neovim
	neofetch
	vscode
	wget
	htop
	element-desktop
	bitwarden-desktop
	bun
        discord
        spotify
        fish
	appimage-run
	ani-cli
	fprintd
	tmux
	usbutils
	zip
	unzip
	quickemu
	ollama
	alacritty
	python312Full
        tlp
        qbittorrent
	gfn-electron
	prismlauncher
	figma-linux
        code-cursor
        ];

	

  # Set fish as the default shell system-wide
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
