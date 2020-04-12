# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 2;

  networking.wireless = {
    # Enables wireless support via wpa_supplicant.
    enable = true;
    networks = {
      AirLink2277b0 = {
        psk = "riNMmF3W";
      };
      Headquarters-5G = {
        psk = "allyourbaseare";
      };
      Strandhyddan = {
	psk = "8972524000";
      };
      OnePlus3 = {
        psk = "pappapappa";
      };
      "free.wifi" = {};
    };
  };

  hardware.bumblebee.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    alacritty
    dmenu
    git
  ];

  # Fix cursor size
  environment.variables.XCURSOR_SIZE = "64";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Workaround for buggy shutdown
  systemd.extraConfig = ''
    DefaultTimeoutStopSec = 5s
  '';

  # List services that you want to enable:
  services = {
    upower.enable = true;
    emacs = {
      enable = true;
      #package = (import ./emacs/emacs.nix {pkgs = pkgs;});
    };
    rabbitmq.enable = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.pathsToLink = [ "/libexec" ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "dvorak";
    xkbVariant = "pc105";
    xkbOptions = "caps:swapescape";
    dpi = 180;

    # Enable touchpad support.
    libinput.enable = true;

    desktopManager.xterm.enable = false;

    displayManager.defaultSession = "none+xmonad";

    windowManager.xmonad.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      ttf_bitstream_vera
      emojione
      noto-fonts
      noto-fonts-emoji
      roboto
      font-awesome-ttf
    ];
    fontconfig = {
      defaultFonts = {
        serif =     [ "Bitstream Vera Sans"      "EmojiOne Color"  "Font Awesome 5 Free"];
        sansSerif = [ "Bitstream Vera Serif"     "EmojiOne Color"  "Font Awesome 5 Free"];
        monospace = [ "Bitstream Vera Sans Mono" "EmojiOne Color"  "Font Awesome 5 Free"];
      };
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

#  # https://nixos.wiki/wiki/Nvidia
#  #
#  # disable card with bbswitch by default since we turn it on only on demand!
#  hardware.nvidiaOptimus.disable = true;
#  # install nvidia drivers in addition to intel one
#  hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
#  hardware.opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.starlord = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
