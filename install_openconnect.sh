#!/bin/bash
# create the virtual environment in your home directory
# found the answer here: https://bbs.archlinux.org/viewtopic.php?id=277082
python -m venv =$HOME/$USR/openconnect-sso

# activate the environment
. $HOME/$USR/openconnect-sso/bin/activate

# install the necessary packages
pip install openconnect-sso
pip install pyqt5
pip install PyQtWebEngine

# use the zhaw_vpn script
