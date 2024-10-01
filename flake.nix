{
  nixConfig = {
    # HACK https://github.com/NixOS/nix/issues/6771
    # TODO Leave only own cache settings when fixed
    extra-trusted-public-keys = [
      "copier.cachix.org-1:sVkdQyyNXrgc53qXPCH9zuS91zpt5eBYcg7JQSmTBG4="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "moduon.cachix.org-1:sXMrTN5LuhZyh6CnzYXM4pZkah/Yy//eGKt1oOZc0zw="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
    extra-substituters = [
      "https://copier.cachix.org"
      "https://devenv.cachix.org"
      "https://moduon.cachix.org"
      "https://numtide.cachix.org"
    ];
  };

  inputs = {
    flake-compat.url = "github:edolstra/flake-compat/refs/pull/63/head"; # HACK
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "nixpkgs";
  };

  outputs = inputs: let
    precommix = import ./precommix.nix;
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [precommix.flakeModules.devshell];
      perSystem = {pkgs, ...}: {
        devshells.default.commands = [
          {package = pkgs.go;}
          {package = pkgs.hugo;}
        ];
      };
    };
}
