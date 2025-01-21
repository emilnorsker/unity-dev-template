{
  description = "Unity minimal project with testing capabilities";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        unity_editor = pkgs.buildFHSEnv {
          name = "unity_editor";
          targetPkgs = pkgs: with pkgs; [
            # Basic system libraries
            libxml2
            libGL
            libGLU
            icu
            
            # X11 and display related
            xorg.libX11
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXinerama
            xorg.libXi
            xorg.libXext
            xorg.libXfixes
            xorg.libXrender
            xorg.libXcomposite
            xorg.libXdamage
            
            # System and UI libraries
            systemd
            gtk3
            gdk-pixbuf
            glib
            zlib
            
            # Audio libraries
            alsa-lib
            pulseaudio
            
            # Additional dependencies
            udev
            libpulseaudio
            libdrm
            mesa
            vulkan-loader
            bzip2
            cups
            dbus
            fontconfig
            freetype
            openssl
            gcc
            gdb
            
            cairo
            pango
            atk
            freetype
            fontconfig
            dbus
            xorg.libXcomposite
            xorg.libXdamage
            xorg.libXext
            xorg.libXfixes
            xorg.libXi
            xorg.libXrender
            xorg.libXtst
            xorg.libxcb
            libdrm
            mesa
            pulseaudio
            libcap
            libunwind
            libuuid
            nspr
            nss
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
            # Add Unity to PATH
            export PATH=${pkgs.unityhub}/bin:$PATH
            
          '';
        };
      }
    );
}