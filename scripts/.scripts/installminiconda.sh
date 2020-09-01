#!/bin/sh

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh

sh ~/miniconda.sh
rm ~/miniconda.sh

#source $HOME/miniconda3/etc/profile.d/conda.sh

conda config --set auto_activate_base false
