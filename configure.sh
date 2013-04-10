#!/bin/bash

# If the frost fw folder hasn't been symlinked into
# the src folder, do so. Love ignores symlinks, but ldoc
# will follow them
if [ ! -d "src/fw" ]; then
    ln -s $(pwd)/external/frost/src/fw $(pwd)/src/fw
fi

if [ ! -f "docmon.sh" ]; then
    sed -e "s/external/external\/frost\/external/" external/frost/docmon.sh > docmon.sh
    chmod +x docmon.sh
fi

# Generate first batch of documentation
lua external/frost/external/ldoc/ldoc.lua src
