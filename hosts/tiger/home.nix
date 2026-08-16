{ config, lib, pkgs, secrets, ... }:

{
  programs.home-manager.enable = true;

  home.username = secrets.hosts.tiger.owner.username;
  home.homeDirectory = "/home/${secrets.hosts.tiger.owner.username}";

  imports = lib.filesystem.listFilesRecursive ../../modules/home;

  # Window manager:
  hyprland.enable = true;
  hypridle.enable = true;
  hyprpaper.enable = true;
  waybar.enable = true;

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

  sops.enable = true;

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
  "7zip".enable = true;

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

  /*services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };*/
  # enables SSH agent, allowing for password-less logins

  # Utilities:
  home.packages = with pkgs; [
    wl-clipboard
    usbutils # lsusb, ...
    parted # formatting and partitioning
    bashmount # menu-driven mounting; wrapper of udisks2
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

  home.stateVersion = "25.05"; # Do not change, even if the version in flake.nix is updated.
}
