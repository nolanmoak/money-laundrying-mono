# Set paths
#!/bin/bash

PROJECT_DIR=$(pwd)
FLUTTER_DIR="$PROJECT_DIR/frontend"   # Path to your Flutter project

# Build flutter front end
echo "Building Flutter frontend (apk)..."
cd $FLUTTER_DIR
flutter build apk
if [ $? -ne 0 ]; then
    echo "Flutter build failed!"
    exit 1
fi
echo "Building Flutter frontend (appbundle)..."
flutter build appbundle
if [ $? -ne 0 ]; then
    echo "Flutter build failed!"
    exit 1
fi
