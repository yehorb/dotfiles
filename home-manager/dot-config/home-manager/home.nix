{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yborkov";
  home.homeDirectory = "/home/yborkov";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # cli
    pkgs.bat
    pkgs.direnv
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.jq
    pkgs.lazygit
    pkgs.pass
    pkgs.ripgrep
    pkgs.starship
    pkgs.stow
    pkgs.unzip
    pkgs.zoxide

    # tmux
    pkgs.tmux

    # nvim
    pkgs.neovim-unwrapped
    pkgs.tree-sitter

    # nix
    pkgs.nixd
    pkgs.nixfmt

    # python
    pkgs.uv

    (
      let
        nixgl = inputs.nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLIntel;
        ghosttyNixgl = pkgs.writeShellScriptBin "ghosttyNixgl" /* bash */ ''
          exec ${pkgs.lib.getExe' nixgl "nixGLIntel"} ${pkgs.lib.getExe pkgs.ghostty} "$@"
        '';
      in
      pkgs.symlinkJoin {
        name = "ghosttyNixgl";
        meta.mainPrograms = "ghosttyNixgl";
        paths = [
          pkgs.ghostty
          ghosttyNixgl
        ];
        postBuild = /* bash */ ''
          ghostty="$out/share/applications/com.mitchellh.ghostty.desktop"
          ghosttyNixgl="$out/share/applications/com.mitchellh.ghosttyNixgl.desktop"
          substitute $ghostty $ghosttyNixgl \
            --replace-fail ${pkgs.lib.getExe pkgs.ghostty} ${pkgs.lib.getExe ghosttyNixgl} \
            --replace-fail "Name=Ghostty" "Name=Ghostty (nixGL)" \
            --replace-fail "DBusActivatable=true" "DBusActivatable=false"
          rm $ghostty
        '';
      }
    )
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yborkov/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
