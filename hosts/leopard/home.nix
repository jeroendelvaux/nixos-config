{ config, lib, pkgs, secrets, ... }:

{
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.username = secrets.hosts.leopard.owner.username;
  home.homeDirectory = "/home/${secrets.hosts.leopard.owner.username}";

  imports = lib.filesystem.listFilesRecursive ../../modules/home;

  # Terminal:
  foot.enable = true;
  fish.enable = true;
  starship.enable = true;

  # Fonts:
  fonts.enable = true;

  # Code editor:
  nvim.enable = true;

  # Version control:
  git.enable = false;

  sops.enable = false;

  bat.enable = true;
  eza.enable = true;
  wget.enable = true;
  btop.enable = true;

  # Archives:
  "7zip".enable = true;

  # PDFs:
  okular.enable = false;
  latex.enable = true;

  # Markdown files:
  ghostwriter.enable = false;

  # Penetration testing:
  android-tools.enable = true;
  ascii.enable = true;
  binwalk.enable = true;
  burpsuite.enable = false;
  checksec.enable = true;
  file.enable = true;
  gdb.enable = true;
  ghidra.enable = false;
  hexedit.enable = false;
  jadx.enable = true;
  nmap.enable = true;
  rizin.enable = false;
  tcpdump.enable = false;
  unblob.enable = false;
  wireshark.enable = false;

  gtk3.enable = false;

  home.stateVersion = "26.05"; # Do not change even when updating the version in flake.nix
}
