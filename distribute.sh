# Clean up from previous releases
if [ -d dist ]; then
    rm -rf dist
fi

# Put the game in release mode
sed "s/t.console = true/t.console = false/;s/t.release = false/t.console = true/" -i src/conf.lua

# Get the short hash of the current git version
HASH=$(git rev-parse --short HEAD)
echo $HASH

# File names
LOVEFILE=dist/lord-evil-rev-$HASH.love
BUNDLEFILE=dist/lord-evil-bundle-rev-$HASH.zip

# Create a .love file of the source folder
mkdir dist
cd src
zip -r ../$LOVEFILE .
cd ..

# Create a distribution bundle zip
zip $BUNDLEFILE $LOVEFILE README.md LICENSE screenshot1.png screenshot2.png screenshot3.png

# Reset configuration file to dev mode
git checkout src/conf.lua
