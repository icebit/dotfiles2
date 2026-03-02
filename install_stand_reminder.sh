#!/bin/bash

# Registers stand_reminder.sh as a launchd agent so it starts on login.

SCRIPT_PATH="./stand_reminder.sh"
PLIST_LABEL="com.user.standreminder"
PLIST_PATH="$HOME/Library/LaunchAgents/${PLIST_LABEL}.plist"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: $SCRIPT_PATH not found."
    exit 1
fi

cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${PLIST_LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>${SCRIPT_PATH}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/stand_reminder.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/stand_reminder.log</string>
</dict>
</plist>
EOF

UID_NUM=$(id -u)
launchctl bootout "gui/${UID_NUM}/${PLIST_LABEL}" 2>/dev/null || true
launchctl bootstrap "gui/${UID_NUM}" "$PLIST_PATH"
echo "Installed and started."
echo ""
echo "To stop now:   launchctl bootout gui/${UID_NUM}/${PLIST_LABEL}"
echo "To uninstall:  launchctl bootout gui/${UID_NUM}/${PLIST_LABEL} && rm \"$PLIST_PATH\""
