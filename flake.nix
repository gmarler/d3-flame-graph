{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        buildInputs = with pkgs; [
        ];
        nativeBuildInputs = with pkgs; [
        ];
      in
      with pkgs;
      {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = mkShell {
          nativeBuildInputs = nativeBuildInputs;
          buildInputs = buildInputs ++ [
            nodejs
            yarn-berry
            swc
            jq
          ];
          # Instead of putting the equivalents in .yarnrc.yml
          YARN_HTTPS_PROXY = "http://10.211.55.2:8888/";
          YARN_HTTP_PROXY = "http://10.211.55.2:8888/";
        };
      }
    );
}
