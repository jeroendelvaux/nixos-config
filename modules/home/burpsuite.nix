{ config, lib, pkgs, secrets, ... }:

{
  options.burpsuite.enable = lib.mkEnableOption "Enable Burp Suite";

  config = lib.mkIf config.burpsuite.enable {
    java.enable = true;
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
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "burpsuite"
    ];
  };
}
