{
  description = "Home Manager configuration of yborkov";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    try = {
      url = "github:tobi/try";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate = pkgs._cuda.lib.allowUnfreeCudaPredicate;
          cudaCapabilities = [ "12.0" ];
          cudaForwardCompat = true;
          cudaSupport = true;
        };
      };
    in
    {
      homeConfigurations."yborkov" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          { nix.package = null; }
          ./home.nix
          {
            home.packages = [
              inputs.try.packages.${pkgs.stdenv.hostPlatform.system}.default
              pkgs.ruby
            ];
          }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
