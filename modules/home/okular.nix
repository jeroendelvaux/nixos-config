{ config, lib, pkgs, secrets, ... }:

{
  options.okular.enable = lib.mkEnableOption "Enable okular";

  config = lib.mkIf config.okular.enable {
    home.packages = with pkgs; [
      kdePackages.okular 
    ];
  };
}
