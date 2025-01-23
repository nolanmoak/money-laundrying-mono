# Set paths
#!/bin/bash

PROJECT_DIR=$(pwd)
FLUTTER_DIR="$PROJECT_DIR/frontend"   # Path to your Flutter project

# Build flutter front end
echo "Building Flutter frontend (linux)..."
cd $FLUTTER_DIR
flutter build linux
if [ $? -ne 0 ]; then
    echo "Flutter build failed!"
    exit 1
fi
