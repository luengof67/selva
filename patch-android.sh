#!/usr/bin/env bash
set -e

MANIFEST=android/app/src/main/AndroidManifest.xml
STYLES=android/app/src/main/res/values/styles.xml

if ! grep -q 'screenOrientation' "$MANIFEST"; then
  sed -i '/android:name=".MainActivity"/a\            android:screenOrientation="landscape"' "$MANIFEST"
fi

if ! grep -q 'windowFullscreen' "$STYLES"; then
  sed -i 's#<style name="AppTheme" parent="\([^"]*\)">#<style name="AppTheme" parent="\1">\n        <item name="android:windowFullscreen">true</item>#' "$STYLES"
fi

echo "Parche aplicado: landscape + status bar oculta"
