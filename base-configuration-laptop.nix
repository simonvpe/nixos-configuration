{ config, lib, pkgs, ... }:

let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  exec -a "$0" "$@"
  '';
in {
  environment = {
    systemPackages = [ nvidia-offload ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    nvidia = {
      modesetting.enable = false;
      prime = {
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
        offload = {
          enable = true;
        };
        sync = {
          enable = false;
        };
      };
    };

    pulseaudio = {
      enable = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
    };

    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    bluetooth.enable = true;
  };

  services = {
    xserver = {
      dpi = 180;
      libinput.enable = true;
      videoDrivers = [ "intel" ];
    };
    upower.enable = true;
  };

  networking = {
    wireless = {
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
  };

  sound = {
    enable = true;
  };


}
