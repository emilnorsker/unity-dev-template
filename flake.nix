{
  description = "Unity minimal project with testing capabilities";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { config.allowUnfree = true; inherit system; };
        
        unity_editor = pkgs.buildFHSEnv {
          name = "unity_editor";

          # these deps were taken from the fhsenv used by the unityhub package in nixpkgs
          targetPkgs =
            pkgs:
            with pkgs;
            [
              # Unity Hub binary dependencies
              xorg.libXrandr
              xdg-utils
      
              # GTK filepicker
              gsettings-desktop-schemas
              hicolor-icon-theme
      
              # Bug Reporter dependencies
              fontconfig
              freetype
              lsb-release
            ]
            ++ extraPkgs pkgs;

          multiPkgs =
            pkgs:
            with pkgs;
            [
              # Unity Hub ldd dependencies
              cups
              gtk3
              expat
              libxkbcommon
              lttng-ust_2_12
              krb5
              alsa-lib
              nss
              libdrm
              libgbm
              nspr
              atk
              dbus
              at-spi2-core
              pango
              xorg.libXcomposite
              xorg.libXext
              xorg.libXdamage
              xorg.libXfixes
              xorg.libxcb
              xorg.libxshmfence
              xorg.libXScrnSaver
              xorg.libXtst
      
              # Unity Hub additional dependencies
              libva
              openssl
              cairo
              libnotify
              libuuid
              libsecret
              udev
              libappindicator
              wayland
              cpio
              icu
              libpulseaudio
      
              # Unity Editor dependencies
              libglvnd # provides ligbl
              xorg.libX11
              xorg.libXcursor
              glib
              gdk-pixbuf
              libxml2
              zlib
              clang
              git # for git-based packages in unity package manager
      
              # Unity Editor 2019 specific dependencies
              xorg.libXi
              xorg.libXrender
              gnome2.GConf
              libcap
      
              # Unity Editor 6000 specific dependencies
              harfbuzz
            ];
          runScript = "~/Unity/Hub/Editor/6000.0.34f1/Editor/Unity";
        };

        unity_install = pkgs.writeScriptBin "unity_install" ''s
          #!${pkgs.bash}/bin/bash
          
          
          UNITY_VERSION="6000.0.34f1"
          
          echo "Ensuring Unity $UNITY_VERSION is installed..."
          
          # Install Unity through Unity Hub
          unityhub -- --headless install \
            --version $UNITY_VERSION \
            --module linux-il2cpp
            
          echo "Unity installation completed or already exists"
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            unity_editor
            unity_install
            unityhub
            libxml2
            just
          ];

          shellHook = ''                                    
            unity_install
            echo "🎮 Unity Development Environment"
            echo "Unity version: 6000.0.34f1 (Unity 6)"
            echo ""
            echo "Available commands:"
            echo "just unity - Launch Unity Editor directly"
            echo "just test - Run tests in unity project"
            echo "just install - Install Unity Editor"
            echo "  unity           - Launch Unity Editor directly"
          '';
        };
      }
    );
}
