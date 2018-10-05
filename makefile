#  Makefile for Sparse1.3
#
#  Ken Kundert
#  UC Berkeley
#
CFLAGS = -O
LINTFLAGS = -lc -lm
SHELL = /bin/sh
CC = cc

HFILES = spConfig.h spDefs.h spMatrix.h
CFILES = spAllocate.c spBuild.c spFactor.c spOutput.c spSolve.c spUtils.c \
	 spFortran.c
OFILES = spAllocate.o spBuild.o spFactor.o spOutput.o spSolve.o spUtils.o \
	 spFortran.o
LIBRARY = sparse.a
DESTINATION = sparse
TESTC = spTest.c
TESTO = spTest.o

SOURCE = $(HFILES) $(CFILES)

$(DESTINATION)	: $(LIBRARY) $(TESTO)
	$(CC) $(CFLAGS) -o $(DESTINATION) $(TESTO) $(LIBRARY) -lm

$(LIBRARY)	: $(OFILES)
	ar r   $(LIBRARY) $?
	ranlib $(LIBRARY)

lint		:
	@lint $(LINTFLAGS) $(CFILES) $(TESTC) | grep -v "but never used"

clean		:
	rm -f $(OFILES) $(LIBRARY) $(TESTO) $(DESTINATION) core

touch		:
	touch -c  $(OFILES) $(LIBRARY)
	ranlib $(LIBRARY)

tags		: $(SOURCE) $(TESTC)
	ctags -t -w $(SOURCE) $(TESTC)

$(OFILES)	: $(HFILES)
$(TESTO)	: $(HFILES)
