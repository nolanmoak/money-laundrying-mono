#!/bin/bash

# Set paths
PROJECT_DIR=$(pwd)
FLUTTER_DIR="$PROJECT_DIR/frontend"   # Path to your Flutter project
BACKEND_DIR="$PROJECT_DIR/backend"    # Path to your .NET backend
WWWROOT_DIR="$BACKEND_DIR/wwwroot"  # wwwroot folder in the backend

# Step 1: Build the Flutter frontend
echo "Building Flutter frontend (web)..."
cd $FLUTTER_DIR
flutter build web
if [ $? -ne 0 ]; then
    echo "Flutter build failed!"
    exit 1
fi

# Step 2: Copy the Flutter build output to wwwroot in the backend
echo "Copying Flutter build to backend..."
cd $PROJECT_DIR
rm -rf $WWWROOT_DIR/*  # Clean the wwwroot folder before copying
cp -r $FLUTTER_DIR/build/web/* $WWWROOT_DIR/

# Step 3: Build the .NET backend
echo "Building .NET backend..."
cd $BACKEND_DIR
dotnet build -c Release
if [ $? -ne 0 ]; then
    echo ".NET build failed!"
    exit 1
fi
