# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 2;
  boot.loader.grub.efiInstallAsRemovable = true;


  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dropbox-cli
    git
    vim
    wget
  ];

  networking.firewall = {
    allowedTCPPorts = [
      17500 # dropbox
    ];
    allowedUDPPorts = [
      17500 # dropbox
    ];
  };

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
    };

    desktopManager = {
      xterm.enable = false;
    };

    windowManager = {
      i3.enable = true;
    };
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

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group";
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
