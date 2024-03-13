#!/bin/bash

rm -rf Figures/*

cp ../Figures/* Figures/

pandoc ../README.md -o output.tex

python width_filter.py
