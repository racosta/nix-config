let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    biber
    cargo
    cowsay
    dua
    eza
    gcc14
    git
    go
    just
    lazygit
    lolcat
    python3
    rust-analyzer
    rustc
    rustfmt
    starship
    workshop-runner
    (texliveTeTeX.withPackages (ps: [
        ps.biblatex
        ps.enumitem
        ps.fontawesome
        ps.fontawesome5
        ps.roboto
        ps.sourcesanspro
        ps.tcolorbox
        ps.xstring
    ]))
    tmux
    tmuxp
    vim
  ];

  GREETING = "Hello, Nix!";

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

  shellHook = ''
    echo $GREETING | cowsay | lolcat

    alias ls='eza --icons'

    eval "$(starship init bash)"
  '';
}
