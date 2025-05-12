#!/bin/sh

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh

sh ~/miniconda.sh -b -f -p  $HOME/.miniconda
rm ~/miniconda.sh

source $HOME/.miniconda/etc/profile.d/conda.sh
$HOME/.miniconda/bin/conda init bash

conda config --set auto_activate_base false
