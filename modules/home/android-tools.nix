{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.android-tools;
in
{
  options.modules.android-tools.enable = lib.mkEnableOption "Enable android-tools";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.android-tools
      pkgs.apksigner
      pkgs.apktool
      pkgs.scrcpy
      (pkgs.writeShellApplication {
        name = "mobsf";
        runtimeInputs = [ pkgs.docker ];
        text = ''
          echo "Launching Mobile Security Framework (MobSF) on port 8000..."
          exec docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest
        '';
      })
    ];
  };
}
