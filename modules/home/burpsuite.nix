{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.burpsuite;
in
{
  options.modules.burpsuite.enable = lib.mkEnableOption "Enable Burp Suite";

  config = lib.mkIf cfg.enable {
    modules.java.enable = true;
    home.packages = [
      (pkgs.symlinkJoin {
        name = "burpsuite-wrapped";
        paths = [ pkgs.burpsuite ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
        wrapProgram $out/bin/burpsuite --add-flags \
          "--user-config-file=${config.xdg.configHome}/burp/user-config.json"
        '';
      })
    ];
    xdg = {
      configFile."burp/user-config.json".text = builtins.toJSON {
        user_options = {
          display = {
            user_interface = {
              font_size = 16;
              look_and_feel = "Dark";
            };
          };
        };
      };
    };
  };
}
