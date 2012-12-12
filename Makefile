#
# Makefile for eCos applications
#

# Platform specific setups needed variables
# default is 1st .ecc file without redboot
#ECOS_ECC_FILE = ecos.ecc
ECOS_ECC_FILE = $(shell grep "template    redboot" *.ecc -L | grep ecc -m1)

# Platform specific setups
include Make.params

# Generic Makefile for C/C++ Program needed variables
# If not specified, default is current directory name
#PROGRAM = httpd

# Generic Makefile for C/C++ Program from
# github.com/flyskywhy/makefile.git
# forked and modified from
# github.com/librakyle/makefile.git
include ../../tools/makefile/Makefile

