#!/bin/sh
ip route | awk 'NR==1{print $3}' | xclip
