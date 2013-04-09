Lord Evil's Daring Escape
=========================

This game was originally conceived as an entry to Ludum Dare 25. It is
a retro platformer, featuring an evil mastermind in his quest to avoid
intergalactic justice.

Dependencies
------------

 * [LÖVE 0.8](http://www.love2d.org)
 * [Frost framework](https://github.com/cryovat/frost)

For development aid:

 * [LDoc](https://github.com/stevedonovan/LDoc) by (stevedonovan)[https://github.com/stevedonovan]
 * bash, iwatch, lua 5.1, sed and zip

Building/distribution
---------------------

The following shell commands should configure a proper development
environment:

    git clone https://github.com/cryovat/lord-evil-game
    cd lord-evil-game
    ./configure.sh

To monitor source directory and regenerate documentation upon source
file changes (requires iwatch and lua 5.1):

    ./docmon.sh

To create a zip distribution of the game:

    ./distribute.sh (generates .love and bundle .zip in dist folder)

Past versions
-------------

 * [Ludum Dare 25 version](https://github.com/cryovat/lord-evil-game/tree/ludum-dare-25)