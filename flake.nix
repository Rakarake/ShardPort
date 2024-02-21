{
  description = "Shard, restructured";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nuget-packageslock2nix = {
      url = "github:mdarocha/nuget-packageslock2nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, flake-utils, nuget-packageslock2nix, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { inherit system; };
        dotnetSdk = pkgs.dotnet-sdk_8;
        dotnetRuntime = pkgs.dotnet-runtime_8;
        deps = with pkgs; [
          SDL2
          SDL2_gfx
          SDL2_image
          SDL2_mixer
          SDL2_ttf

          gcc
          pkg-config
        ];
      in
      rec {
        defaultPackage = pkgs.stdenv.mkDerivation {                                                                     
          name = "Shard";                                                                          
          src = ./.;
          installPhase = ''
            # Copy the necessary text files to build directory
            mkdir -p $out/bin                                                                             
            cp $src/envar.cfg $src/config.cfg $out/bin
            # Copy the asset files
            cp -r $src/Assets $out/bin
            # Add the actual game to the ouptut path
            cp ${shardDotnetPackage}/bin/Shard $out/bin
          '';
        };

        # The package without the cfg files
        shardDotnetPackage = pkgs.buildDotnetModule rec {
          pname = "ShardDotnetBin";
          version = "0.0.1";
          src = ./.;
          dotnet-sdk = dotnetSdk;
          dotnet-runtime = dotnetRuntime;
          runtimeDeps = deps;
          nugetDeps = nuget-packageslock2nix.lib {
            system = system;
            name = pname;
            lockfiles = [
              ./packages.lock.json
            ];
          };
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath deps;
        };
        devShell = pkgs.mkShell {
          packages = deps ++ [ dotnetSdk ];
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath deps;
        };
      }
    );
}
