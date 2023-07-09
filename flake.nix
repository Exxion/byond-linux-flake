{
  description = "Linux tools for the BYOND game engine.";

  inputs.byond-linux = {
    type = "tarball";
    url = "https://www.byond.com/download/build/515/515.1608_byond_linux.zip";
    flake = false;
  };

  outputs = { self, nixpkgs, byond-linux, ... }: let byond_ver = "515"; byond_build = "1608"; in rec {
    packages.i686-linux.byond-linux = with import nixpkgs { config.allowUnfree = true; system = "i686-linux"; };
      stdenv.mkDerivation rec {
        pname = "byond-linux";
        version = "${byond_ver}.${byond_build}";
        src = "${byond-linux}";

        nativeBuildInputs = [ autoPatchelfHook ];

        buildInputs = [ gcc-unwrapped glibc ];

        buildPhase = " ";

        installPhase = ''
          mkdir -p $out
          cp -a * $out
          cd $out/bin
        '';

        meta = with lib; { #Is this even useful in a flake?
          description = "Linux tools for the BYOND game engine.";
          homepage = "https://www.byond.com/";
          license = licenses.unfree;
          platforms = [ "i686-linux" ];
        };
      };

    defaultPackage.x86_64-linux = packages.i686-linux.byond-linux;
  };
}
