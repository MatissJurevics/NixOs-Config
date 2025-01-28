{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... } @inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = {
        nvf = nvf.lib.${system}.makeNixvim {
          modules = [ ./nvf-configuration.nix ];
        };
        default = self.packages.${system}.nvf;
      };
    };
}

