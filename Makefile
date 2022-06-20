# Makefile for snr, a program to report statistics on
# signal-to-noise ratio on packets received by rtl_433
# and logged in JSON format.
#
#2022.05.16	Inital version
#Author: HDTodd@gmail.com, Williston VT
#

CC = gcc
PROJ = snr

BIN = ~/bin/
#CFLAGS += -D DEBUG_ENABLE
LDFLAGS = -lm
OBJS   = snr.o snr-cli.o stats.o tree.o mjson.o


all:	${PROJ}

.SUFFIXES: .c

.c.o:	
	$(CC) $(CFLAGS) -c $<

${PROJ}: ${OBJS}
	$(CC) -o $@ ${OBJS} $(LDFLAGS) 

clean:
	/bin/rm -f *~ *.o ${PROJ}

install:
	mkdir -p ${BIN}
	mv snr ${BIN}
	cp SNR.py ${BIN}
	cp class_stats.py ${BIN}

uninstall:
	rm ${BIN}snr
	rm ${BIN}SNR.py
	rm ${BIN}class_stats.py


