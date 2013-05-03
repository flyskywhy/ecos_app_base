
# GCC ARM ELF target
ARCH = microblaze-uclinux-

# Build tag
BUILD_TAG = echo `date`

# Compiler release
COMPILER_RELEASE = echo `$(ARCH)gcc --version | head -1`

# Whoami
UNAME = `whoami | cut -c 1-2`

# Base target image name

#$(ECOS_TARGET_DIR)/install
ECOS_INCLUDE_DIR = $(ECOS_INSTALL_DIR)/include
ECOS_LIB_DIR = $(ECOS_INSTALL_DIR)/lib


# bintuils
CC = $(ARCH)gcc
CXX = $(ARCH)g++
AR = $(ARCH)ar
ARFLAGS = crv
LD = $(ARCH)ld


# Optimization flags
OPT_FLAGS = -O2 -mcpu=v4.00.a -DSHELL_DEBUG

# Debug flags
#DEBUG_FLAGS = -mcpu=arm920t -ggdb2 -DSHELL_DEBUG -Wa,-gstabs

# Generic CFLAGS & LDFLAGS
CFLAGS += -Wall -Wno-unused $(DEBUG_FLAGS) $(OPT_FLAGS) -I. -ffunction-sections -fdata-sections
LDFLAGS = $(DEBUG_FLAGS) $(THUMB_FLAGS) -L$(ECOS_LIB_DIR) -Wl,--gc-sections -Ttarget.ld -nostdlib

# Flags for Speex
#CFLAGS_NT = -Wall $(DEBUG_FLAGS) $(OPT_FLAGS) -I. -ffunction-sections -fdata-sections -mthumb-interwork

# TCP/IP support
USE_TCPIP = 0

#CFLAGS += -I$(ECOS_INCLUDE_DIR) -I/home/projects/ecos/sw/projects/ecos-shell/bsp/microblaze_0/include
CFLAGS += -I$(ECOS_INCLUDE_DIR) -Ibsp/microblaze_0/include
#CFLAGS_NT += -I$(ECOS_INCLUDE_DIR)
LDFLAGS += -L$(ECOS_LIB_DIR)

# Phony targets
.PHONY = clean

STATIC_LIB = lib$(NAME).a

.SUFFIXES: .o .c .cpp .cxx .s .S

CFLAGS +=	-DBUILD_TAG=\""$(shell $(BUILD_TAG))"\" -DCOMPILER_RELEASE=\""$(shell $(COMPILER_RELEASE))"\" \
		-DBUILD_FLAGS="\"$(DEBUG_FLAGS) $(OPT_FLAGS)"\"

NAME = ../shelltask

OBJS = buildtag.o \
	builtin_commands.o \
	init.o \
	shell_err.o \
	shell_thread.o \
	shelltask.o \
	thread_cleanup.o \
	thread_info.o

all: $(NAME)

.c.o:
#	echo $(ECOS_TARGET_DIR)
	$(CC) $(CFLAGS) -o $@ -c $<

.cpp.o:
	$(CXX) $(CFLAGS) -o $@ -c $<

$(NAME): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	rm -f buildtag.o
#neni potreba
#	$(ARCH)objcopy -O binary $(NAME) $(NAME).bin

.PHONY:	clean

clean:
ifeq ($(TARGET), library)
	rm -f $(OBJS) $(STATIC_LIB) *.o *~ 
else
	rm -f $(NAME) $(OBJS) $(STATIC_LIB) *.o *~ 
endif

# Dependencies
#
# Rebuild if Makefiles change

$(NAME):	Makefile
$(STATIC_LIB): Makefile

#eCos install folder
