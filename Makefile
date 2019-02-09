# Builds setdate command

# Requirements:
# 1. Gmake must be used.

ifeq ($(OS),Windows_NT)
    COPY=copy
    APPLEWIN="c:\opt\AppleWin1.26.2.3\applewin.exe"
else
    COPY=cp
    APPLEWIN=applewin
endif

PGM=setdate
DISK_VOL=$(PGM)
DISK=$(PGM).dsk
AC=java -jar AppleCommander-ac-1.4.0.jar
U2A=java -cp . Unix2Apple2
VIRTBAS=python $(HOME)/hg/virtualbasic/virtualbasic.py
PGMS=setdate.bas dateentryform.bas setdate.orig.bas setdatevalues.bas
SRCS=setdate.baz dateentryform.baz setdatevalues.baz

# Extra stuff
BASIC_AUX_TYPE=0x0801
READ_TIME_LOAD_ADDR=0x0260
SYS_LOAD_ADDR=0x2000
BIN_LOAD_ADDR=0x0803

########################################

all: $(DISK)

$(DISK): $(PGMS) Unix2Apple2.class
	$(RM) $(DISK)
	$(AC) -pro140 $(DISK) $(DISK_VOL)
	$(U2A) setdate.bas | $(AC) -p $(DISK) setdate.t TXT
	$(U2A) dateentryform.bas | $(AC) -p $(DISK) dateentryform.t TXT
	$(U2A) setdate.orig.bas | $(AC) -p $(DISK) setdate.orig.t TXT
	$(U2A) setdatevalues.bas | $(AC) -p $(DISK) setdatevalues.t TXT

Unix2Apple2.class: Unix2Apple2.java
	javac Unix2Apple2.java

setdate.bas: setdate.baz
	$(VIRTBAS) setdate.baz remgo

dateentryform.bas: dateentryform.baz
	$(VIRTBAS) dateentryform.baz remgo

setdatevalues.bas: setdatevalues.baz
	$(VIRTBAS) setdatevalues.baz remgo

test: $(DISK)
	$(APPLEWIN) -d1 $(DISK)
	#$(APPLEWIN) -s7 empty -d1 $(DISK)

clean:
	$(RM) *.o setdate.bas dateentryform.bas setdatevalues.bas $(DISK)

