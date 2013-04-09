#!/bin/bash

# If the frost repo hasn't been cloned yet
if [ ! -d "external/ldoc" ]; then
    # Clone frost to get the framework bits and pieces
    git clone https://github.com/cryovat/frost.git external/frost

    # Make sure the frost repo pulls down externals and such
    sh external/frost/configure.sh
fi

# If the frost fw folder hasn't been symlinked into
# the src folder, do so. Love ignores symlinks, but ldoc
# will follow them
if [ ! -d "src/fw" ]; then
    ln -s $(pwd)/external/frost/src/fw $(pwd)/src/fw
fi

# Steal the docmon.sh script from frost but change the ldoc path
if [ ! -f "docmon.sh" ]; then
    sed -e "s/external/external\/frost\/external/" external/frost/docmon.sh > docmon.sh
    chmod +x docmon.sh
fi

# Generate first batch of documentation
lua external/frost/external/ldoc/ldoc.lua src
