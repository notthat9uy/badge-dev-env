#!/bin/bash

# ANSI Escape Codes
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check for command
if [[ -z $(command -v pip3) ]]
then
    printf "${RED}pip3 not found. Install python3 using brew (brew install python3)${NC}\n"
    DEPENDENCY_MISSING=""
else
    echo "pip3 found: " "$(which pip3)"
fi
if [[ -z $(command -v brew) ]]
then
    printf "${RED}brew not found. Install with `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`${NC}\n"
    DEPENDENCY_MISSING=""
else
    echo "brew found: " "$(which brew)"
fi
if [[ -z $(command -v git) ]]
then
    printf "${RED}git not found. Install with using XCode Command Line Tools (https://www.freecodecamp.org/news/install-xcode-command-line-tools/)${NC}\n"
    DEPENDENCY_MISSING=""
else
    echo "git found: " "$(which git)"
fi

# Catch all to exit if dependencies are missing
if [[ ! -z ${DEPENDENCY_MISSING+x} ]]
then
    exit
fi

echo "Downloading submodules"
git submodule init
git submodule update

echo "Installing prerequisites"
brew install cmake ninja dfu-util

echo "Running esp32 install script"
esp-idf/install.sh
if [ $? -eq 0 ]; then
    printf "${BLUE}Install succeeded\n${NC}"
    printf "${BLUE}Add this alias for easy esp-idf loading\n${NC}"
    printf "${BLUE}alias get_idf='. $PWD/esp-idf/export.sh'\n${NC}"
else
    echo "Failed to download cross-compile toolchain"
fi
