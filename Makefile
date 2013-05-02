#
# Makefile for eCos applications
#

# Platform specific setups needed variables
# You can run bellow command (ecos/scripts/envsetup.sh) to select .ecc file
# $ lunch
# Or just manually set it
#ECOS_ECC_FILE = ecos.ecc
# Or use the 1st .ecc file without redboot
ECOS_ECC_FILE ?= $(shell grep "template    redboot" *.ecc -L | grep ecc -m1)

# Platform specific setups
include $(PROJ_ROOT)/ecos/scripts/Make.params


# Generic Makefile for C/C++ Program needed variables

# The executable file name.
# If not specified, current directory name or `demo.out' will be used.
#PROGRAM = httpd

# The pre-processor and compiler options.
#MY_CFLAGS = `pkg-config --cflags opencv boost` -I$(SRCROOT)
MY_CFLAGS = -L.

# Keep `make` still means `make all` by default, e.g. when there is `${MY_LIBS_TO_GEN}:`
my_all: all

# The linker options.
#MY_LIBS   = `pkg-config --libs opencv boost`
#MY_LIBS   = -ljpeg
#MY_LIBS_TO_GEN = libjpeg.a
ifneq ($(MY_LIBS_TO_GEN),)
${MY_LIBS_TO_GEN}:
	CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" ./gen-libs.sh
endif

# Generic Makefile for C/C++ Program from
# github.com/flyskywhy/makefile.git
# forked and modified from
# github.com/librakyle/makefile.git
include $(PROJ_ROOT)/tools/makefile/Makefile

