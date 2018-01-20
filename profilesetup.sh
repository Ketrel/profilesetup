#!/bin/sh
switchCheck=0
fullArg="${@}"
checkForSwitch(){
    switchCheck=0
    if [ ! -z "${1}" ] && [ -z "${1%%*${2}*}" ]; then
        switchCheck=1
    else
        switchCheck=0
    fi
}
textReset(){
    printf "\033[0m"
}
textBold(){
    printf "\033[0;1m"
}
textColor(){
    printf "\033[${1:-0}m"
}
textBackground(){
    printf "\033[$((${1:-0} + 10 ))m"
}
checkForSwitch "${fullArg}" "--skip-profile-check"
if ([ -f "$HOME/.profile" ] && [ -f "$HOME/.profile.bak" ] && [ ${switchCheck} -eq 0 ]); then
    textBold;textColor 38;textBackground 31
  printf "%s\033[0m\n" \
         "----------------------------------------------"
    textReset
  printf " Error: a '"
    textReset;textBold;textColor 33
  printf            ".profile.bak"
    textReset;
  echo                          "' file exists.         "
    echo "   This script will automatically move an     "
  printf "   existing '"
    textReset;textBold;textColor 33;
  printf              ".profile"
    textReset;
    echo                      "' file to this location. "
    echo "   To avoid losing your backup, please rename "
    echo "   this file before running this script.      "
    textBold;textColor 38;textBackground 31
    printf "%s\033[0m\n" \
         "----------------------------------------------"
    textReset
    exit
fi

textBold;textColor 34
echo "Setting Up .profile"
textColor 33

if [ -f "$HOME/.profile" ]; then
#    mv "$HOME/.profile" "$HOME/.profile.bak"
    printf "%s\n" "  '.profile' exists, moving to '.profile.bak'"
fi
dot_profile='--
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Add user bin directory to PATH if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add user scripts directory to PATH if it exists
if [ -d "$HOME/scripts" ] ; then
    PATH="$HOME/scripts:$PATH"
fi

# Add user Scripts directory to PATH if it exists
if [ -d "$HOME/Scripts" ] ; then
    PATH="$HOME/Scripts:$PATH"
fi'

dot_profile=$(echo "${dot_profile}" | sed '/^--$/d')
#echo "${dot_profile}" > "$HOME/.profile"
echo "  ..Done"


textBold;textColor 34
echo "Setting Up .nanorc"
dot_nanorc='--
set const
set tabstospaces
set tabsize 4'
dot_nanorc=$(echo "${dot_nanorc}" | sed '/^--$/d')

if [ -f "$HOME/.nanorc" ]; then
#    echo "${dot_nanorc}" > "$HOME/.nanorc_alt"
    textColor 33
    echo "  '.nanorc' exists."
    echo "  Output to '$HOME/.nanorc_alt' instead."
    echo "  ..Done"
else
#    echo "${dot_nanorc}" > "$HOME/.nanorc"
    textColor 33
    echo "  ..Done"
fi


textReset



exit
textBold;textColor 34
echo "Setting Up ???"
textColor 33
echo "  ..Done"
textReset
