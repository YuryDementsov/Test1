
#SHELL := #!/bin/sh

CC = gcc
AR = ar

LIBS = libhello.a libgoodbye.a

TARGET = hellobye

SRC = hello.c

DL_PATH = /opt/lib

%.o : %.c
	$(CC) -Wall -c $< -o $@

%.a : %.o
	$(AR) -cvq $@ $<

OUTPUT = $(LIBS) $(TARGET)

$(TARGET) :
	$(CC) -o $(TARGET) $(SRC) $(LIBS)


libs : $(LIBS)

clean :
	@echo "Cleaning..."
	$(RM) $(OUTPUT) 

all : clean libs $(TARGET)