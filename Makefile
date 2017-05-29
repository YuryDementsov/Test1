
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

#%.o : %.c
#	$(CC) -Wall -c $< -o $@

$(S_OBJ) : $(SLIB_SRC)
	$(CC) -Wall -c $< -o $@

$(D_OBJ) : $(DLIB_SRC)
	$(CC) -Wall -fPIC -c $< -o $@


$(SLIB) : $(S_OBJ)
	$(AR) -cvq $@ $<


$(DLIB) : $(D_OBJ)
	$(CC) -shared -o $@ $<


$(TARGET) :
	$(CC) -o $(TARGET) $(SRC) $(LIBS)

OBJ = $(S_OBJ) $(D_OBJ)

LIBS = $(SLIB) $(DLIB)

OUTPUT = $(OBJ) $(LIBS) $(TARGET)

libs : $(OBJ) $(LIBS)

build : libs $(TARGET)

clean :
	@echo "Clear..."
	rm --version
	$(RM) $(OUTPUT)
#	$(RM) $(OBJ) $(LIBS)

#$(RM) $(OBJ)
#$(OUTPUT)

all : clean build


txt :
	@echo OBJ   : $(OBJ)
	@echo OUTPUT: $(OUTPUT)

obj: $(OBJ)
