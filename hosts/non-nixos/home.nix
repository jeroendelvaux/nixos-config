{ config, lib, pkgs, secrets, ... }:

{
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.username = secrets.user.name;
  home.homeDirectory = "/home/${secrets.user.name}";

  imports = lib.filesystem.listFilesRecursive ../../modules/home;

  # Terminal:
  kitty.enable = true;
  fish.enable = true;
  starship.enable = true;

  # Fonts:
  fonts.enable = true;

  # Code editor:
  nvim.enable = true;

  # Version control:
  git.enable = false;

  sops.enable = true;

  bat.enable = true;
  eza.enable = true;
  wget.enable = true;
  btop.enable = true;

  # Archives:
  "7zip".enable = true;

  # PDFs:
  okular.enable = true;
  latex.enable = false;

  # Markdown files:
  ghostwriter.enable = true;

  # Penetration testing:
  # android-tools.enable = true;
  ascii.enable = true;
  binwalk.enable = true;
  burpsuite.enable = true;
  checksec.enable = true;
  file.enable = true;
  gdb.enable = true;
  ghidra.enable = false;
  hexedit.enable = true;
  jadx.enable = true;
  nmap.enable = true;
  rizin.enable = true;
  tcpdump.enable = true;
  unblob.enable = true;
  wireshark.enable = false;

  gtk3.enable = true;

  home.stateVersion = "25.05"; # Do not change even when updating the version in flake.nix
}
