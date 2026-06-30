#!/usr/bin/env bash
set -e

MANIFEST=android/app/src/main/AndroidManifest.xml
STYLES=android/app/src/main/res/values/styles.xml
MAIN=$(find android/app/src/main/java -name MainActivity.java | head -n1)

if ! grep -q 'screenOrientation' "$MANIFEST"; then
  sed -i '/android:name=".MainActivity"/a\            android:screenOrientation="landscape"' "$MANIFEST"
fi

if ! grep -q 'windowFullscreen' "$STYLES"; then
  sed -i 's#<style name="AppTheme" parent="\([^"]*\)">#<style name="AppTheme" parent="\1">\n        <item name="android:windowFullscreen">true</item>\n        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>#' "$STYLES"
fi

PKG=$(grep -m1 '^package' "$MAIN" | sed 's/package //; s/;//')
cat > "$MAIN" <<EOF
package \$PKG;

import android.os.Bundle;
import android.view.View;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        hideSystemUi();
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) hideSystemUi();
    }

    private void hideSystemUi() {
        getWindow().getDecorView().setSystemUiVisibility(
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
            | View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
            | View.SYSTEM_UI_FLAG_FULLSCREEN);
    }
}
EOF

echo "Parche aplicado (package \$PKG)"
