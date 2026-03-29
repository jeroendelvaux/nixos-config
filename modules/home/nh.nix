{ config, pkgs, secrets, ... }:

{
  programs.nh = {
    enable = true;
    # Automatic garbage collection policy:
    # - Keep all generations from the past week.
    # - Additionally, keep 3 generations older than one week.
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };
}
