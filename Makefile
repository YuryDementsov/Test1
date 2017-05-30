
#SHELL := #!/bin/sh

CC = gcc
AR = ar

D_OBJ = libhello.o
S_OBJ = libgoodbye.o

DLIB = libhello.so
SLIB = libgoodbye.a

TARGET = hellobye

SRC = hello.c
DLIB_SRC = libhello.c 
SLIB_SRC = libgoodbye.c

DL_PATH = /opt/lib

#%.o : %.c
#	$(CC) -Wall -c $< -o $@

$(S_OBJ) : $(SLIB_SRC)
	$(CC) -Wall -c $< -o $@

$(D_OBJ) : $(DLIB_SRC)
	$(CC) -Wall -fPIC -c $< -o $@


$(SLIB) : $(S_OBJ)
	$(AR) -cvq $@ $<


$(DLIB) : $(D_OBJ)
	$(CC) -shared -Wl,-soname,$@.1 -o $@.1.0  $< 
#	$(CC) -shared -o $@ $<

dlin : $(DLIB)
	@echo "Dyn lib linkage"
	mv $<.1.0 $(DL_PATH)
	ln -sf $(DL_PATH)/$<.1.0 $(DL_PATH)/$<.1
	ln -sf $(DL_PATH)/$<.1.0 $(DL_PATH)/$<
	export LD_LIBRARY_PATH=$(DL_PATH):$LD_LIBRARY_PATH
#	export LD_LIBRARY_PATH=/opt/lib:$LD_LIBRARY_PATH


$(TARGET) :
	$(CC) -rdynamic $(SRC) $(SLIB) -ldl -o $@
#	$(CC) -Wall -L$(DL_PATH) $(SRC) $(SLIB) -lhello -o $@
#	$(CC) -Wall -L$(DL_PATH) $(SRC) $(LIBS) -o $@
#	$(CC) -o $(TARGET) $(SRC) $(LIBS)

OBJ = $(S_OBJ) $(D_OBJ)

LIBS = $(SLIB) $(DLIB)

OUTPUT = $(OBJ) $(LIBS) $(TARGET)

libs : $(OBJ) $(LIBS) dlin

build : libs $(TARGET)

clean :
	@echo "Clear..."
	$(RM) $(OUTPUT) 
	$(RM) $(DLIB).1.0


all : clean build