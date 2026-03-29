{ config, lib, pkgs, secrets, ... }:

{
  options.eza.enable = lib.mkEnableOption "Enable eza";

  config = lib.mkIf config.eza.enable {
    home.packages = with pkgs; [
      eza
    ];
    programs.fish.shellAbbrs = lib.mkIf (config.fish.enable or false) {
      "ls" = "eza";
    };
  };
}
