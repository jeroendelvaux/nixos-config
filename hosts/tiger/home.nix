{ config, lib, pkgs, secrets, ... }:

{
  programs.home-manager.enable = true;

  home.username = secrets.hosts.tiger.owner.username;
  home.homeDirectory = "/home/${secrets.hosts.tiger.owner.username}";

  #imports = lib.filesystem.listFilesRecursive ../../modules/home;
  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) 
    (lib.filesystem.listFilesRecursive ../../modules/home);

  modules = {
    # Window manager:
    niri.enable = true;
    hyprland.enable = false;
    hypridle.enable = true;
    waybar.enable = false;
    quickshell.enable = true;
    wofi.enable = true;

    # Terminal:
    foot.enable = true;
    fish.enable = true;
    starship.enable = true;

    # Fonts:
    fonts.enable = true;

    # Browser:
    firefox.enable = true;

    # Code editor:
    nvim.enable = true;

    # Version control:
    git.enable = true;

    # Cloud storage:
    rclone.enable = true;

    # Navigation:
    bat.enable = true;
    eza.enable = true;

    # Web utilities:
    wget.enable = true;
    traceroute.enable = true;

    # Processes:
    btop.enable = true;

    # Passwords:
    bitwarden.enable = true;

    # Archives:
    "7zip" = {
      enable = true;
    };

    # Office:
    libreoffice.enable = true;

    # PDFs:
    okular.enable = true;
    latex.enable = true;

    # Markdown files:
    ghostwriter.enable = true;

    # Images:
    imv.enable = true;
    imagemagick.enable = true;
    gimp.enable = true;

    # Media files:
    mpv.enable = true;

    # 3D Creation:
    blender.enable = true;

    # Penetration testing:
    android-tools.enable = true;
    ascii.enable = true;
    binwalk.enable = true;
    burpsuite.enable = true;
    checksec.enable = true;
    file.enable = true;
    gdb.enable = true;
    ghidra.enable = true;
    hexedit.enable = true;
    jadx.enable = true;
    nmap.enable = true;
    rizin.enable = true;
    semgrep.enable = true;
    tcpdump.enable = true;
    unblob.enable = true;
    wireshark.enable = true;

    gtk3.enable = true;

    # Programming:
    python.enable = true;

    # Utilities:
    ventoy.enable = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    usbutils
    parted
    bashmount
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {};
      "puma" = {
        hostname = secrets.hosts.puma.ip;
        user = secrets.hosts.puma.owner.username;
        forwardAgent = true;
      };
    };
  };

  home.stateVersion = "26.05";
}
