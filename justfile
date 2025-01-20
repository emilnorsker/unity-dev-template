# Unity Development Tasks
set shell := ["bash", "-c"]
set dotenv-load := true

default:
    @just --list

# Launch Unity
unity *args: ensure-license
    unity_editor \
        -username "$UNITY_USERNAME" \
        -password "$UNITY_PASSWORD" \
        -projectPath "$(pwd)/UnityProject" \
        {{args}}

# Ensure Unity license is set up
ensure-license:
    #!/usr/bin/env bash
    LICENSE_PATH=~/.local/share/unity3d/Unity/Unity_lic.ulf
    
    if [ ! -f "$LICENSE_PATH" ]; then
        echo "🔑 No Unity license found at $LICENSE_PATH"
        echo ""
        echo "Please follow these steps:"
        echo "1. Run: unityhub"
        echo "2. Log in with your Unity account"
        echo "3. Go to Preferences > Licenses"
        echo "4. Click Add > Get a free personal license"
        echo ""
        echo "The license file will be created automatically at:"
        echo "$LICENSE_PATH"
        echo ""
        echo "Then run 'just' again to launch Unity"
        exit 1
    fi

# Hidden helper command for license activation
_activate file:
    #!/usr/bin/env bash
    echo "🔑 Activating Unity license..."
    unity_editor -batchmode -manualLicenseFile "{{file}}" -logFile -
    echo "✅ License activated! Run 'just' to start Unity" 