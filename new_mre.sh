#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  echo "Usage: $0 <new_app_name>"
  echo "  Creates a new MRE app from _template_app."
  echo "  Example: $0 my_bug_name"
  exit 1
}

[[ $# -ne 1 ]] && usage

NEW_NAME="$1"
SRC="$SCRIPT_DIR/_template_app"
DST="$SCRIPT_DIR/$NEW_NAME"

if [[ ! -d "$SRC" ]]; then
  echo "Error: template not found at $SRC"
  exit 1
fi

if [[ -d "$DST" ]]; then
  echo "Error: '$DST' already exists"
  exit 1
fi

echo "Copying template to $DST..."
cp -r "$SRC" "$DST"

# Remove any stale build artifacts carried over from the template
rm -rf "$DST/build"

# Rename files that contain _template_app in their name
mv "$DST/_template_app.iml" "$DST/${NEW_NAME}.iml"
mv "$DST/android/_template_app_android.iml" "$DST/android/${NEW_NAME}_android.iml"

# Rename the Android Kotlin package directory (u_template_app -> new name)
KOTLIN_OLD="$DST/android/app/src/main/kotlin/com/example/u_template_app"
KOTLIN_NEW="$DST/android/app/src/main/kotlin/com/example/${NEW_NAME}"
if [[ -d "$KOTLIN_OLD" ]]; then
  mv "$KOTLIN_OLD" "$KOTLIN_NEW"
fi

# Replace all _template_app / u_template_app references in file contents
find "$DST" -type f \( \
  -name "*.dart" -o -name "*.yaml" -o -name "*.json" -o -name "*.html" \
  -o -name "*.md"  -o -name "*.txt"  -o -name "*.cmake" \
  -o -name "*.cc"  -o -name "*.h"    -o -name "*.cpp"   \
  -o -name "*.xcconfig" -o -name "*.pbxproj" -o -name "*.plist" \
  -o -name "*.xml" -o -name "*.gradle.kts"   -o -name "*.iml" \
  -o -name "*.properties" -o -name "*.kt" \
\) | xargs sed -i \
  "s/u_template_app/${NEW_NAME}/g; s/_template_app/${NEW_NAME}/g"

echo "Done. New MRE created at: $DST"
echo "Next steps:"
echo "  1. Update the description in $DST/pubspec.yaml"
echo "  2. Edit $DST/lib/main.dart to reproduce the bug"
