PACKAGE = package
DOCCMD = lua external/frost/external/ldoc/ldoc.lua src

# From http://scribu.net/blog/git-alias-for-updating-submodules.html
GIT_FETCHALL = git submodule foreach git fetch origin --tags && git pull && git submodule update --init --recursive

LUA_DISABLE_CONSOLE  = s/t.console = true/t.console = false/;
LUA_ENABLE_RELEASE   = s/t.release = false/t.release = true/
LUA_CONF_CHANGES     = $(LUA_DISABLE_CONSOLE)$(LUA_ENABLE_RELEASE)

# target: all - Default target. Calls init, clean and dist
all:	init clean dist

# target: help - Shows available targets
help:
	egrep "^# target:" [Mm]akefile

# target: init - Initializes the development environment
init:
	$(GIT_FETCHALL);						\
									\
	pwd;								\
	if [ ! -d "src/fw" ]; then					\
		ln -s $$(pwd)/external/frost/src/fw $$(pwd)/src/fw;	\
	fi

# target: run - Runs game in debug mode (updates submodules if needed)
run:	init
	love src

# target: fastrun - Runs game in debug mode without updating submodules
fastrun:
	love src

# target: clean - Removes dist files and docs
clean:
	rm -rf docs
	rm -rf dist

# target: dist - Creates distribution .love and .zip
dist:	init clean
	sed "$(LUA_CONF_CHANGES)" -i src/conf.lua;			\
	export GITREV=$$(git rev-parse --short HEAD);			\
	export LOVEFILE=dist/lord-evil-rev-$$GITREV.love;		\
	export BUNDLEFILE=dist/lord-evil-bundle-rev-$$GITREV.zip;	\
									\
	mkdir dist;							\
	cd src;								\
	zip -r ../$$LOVEFILE .;						\
	cd ..;								\
									\
	zip -j $$BUNDLEFILE $$LOVEFILE README.md LICENSE;		\
									\
	git checkout src/conf.lua;

# target: rundist - Creates distribution and runs the generated file
rundist: dist
	love $$(ls dist/*love)

#target: docs - Rebuilds documentation
docs:	init
	$(DOCCMD)	

#target: watch - Watches src folder and rebuilds documentation on change
watch:	init
	iwatch -e close_write -c "$(DOCCMD)" -X "[~#]." -r src

.PHONY: all help init run clean docs watch
