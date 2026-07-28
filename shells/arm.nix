{ pkgs }:

let
  stlink-170 = pkgs.stlink.overrideAttrs (oldAttrs: rec {
    version = "1.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "stlink-org";
      repo = "stlink";
      rev = "v${version}";
      hash = "sha256-9Pm3zaecl7xKQLMlfcFd9eT5djK49vVZrpHcdZ27vg8=";
    };
    patches = [];
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    ];
  });
in
pkgs.mkShell {
  name = "arm-embedded-env";

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.gcc-arm-embedded
    pkgs.gnumake
    pkgs.ninja
    pkgs.openocd
    stlink-170
  ];

  shellHook = ''
    echo "ARM Embedded Environment Active"
  '';
}