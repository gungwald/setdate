10 REM SETDATE.BAS - 17/02/2019 - 06h53
20 REM ********************************************************
30 REM PROGRAM: SETDATE
40 REM SYSTEM:  PRODOS
50 REM AUTHOR:  BILL CHATFIELD
60 REM LICENSE: GPL3
70 REM SOURCE:  HTTPS://GITHUB.COM/GUNGWALD/SETDATE/SETDATE.BAZ
80 REM ********************************************************
90 LET D$=CHR$(4)
100 LET LT$=CHR$(8)
110 LET DOWN$=CHR$(10)
120 LET UP$=CHR$(11)
130 LET RET$=CHR$(13)
140 LET D1$=CHR$(17) 
150 LET D2$=CHR$(18) 
160 LET NAK$=CHR$(21)   
170 LET RT$=CHR$(21)
180 LET ESC$=CHR$(27)
190 LET DLT$=CHR$(127)
200 LET BEEP$=CHR$(7)
210 LET TB$=CHR$(9)
220 LET CADDR=32768 
230 LET CPGM$=""
240 DIM MNTHS$(12), MDAYS(12)
250 FOR I = 1 TO 12
260 READ MNTHS$(I), MDAYS(I)
270 NEXT
280 DATA JAN,31
290 DATA FEB,29
300 DATA MAR,31
310 DATA APR,30
320 DATA MAY,31
330 DATA JUN,30
340 DATA JUL,31
350 DATA AUG,31
360 DATA SEP,30
370 DATA OCT,31
380 DATA NOV,30
390 DATA DEC,31
400 GOSUB 1080:REM GO->GETSYSTEMDATE 
410 GOSUB 830:REM GO->FORMATDATEANDTIME 
420 GOSUB 530:REM GO->DRAWSCREEN 
430 GOSUB 1470:REM GO->ENTERDATEANDTIME 
440 VTAB TY : POKE 36,38 : PRINT : PRINT
450 IF K$ <> RET$ THEN PRINT "CANCELLED SETTING OF DATE AND TIME." : GOTO 500:REM GO->SKIPSETTINGDATETIME 
460 GOSUB 1020:REM GO->DECODEDATEANDTIME 
470 GOSUB 1250:REM GO->SETSYSTEMDATEANDTIME 
480 PRINT "SUCCESSFULLY SET SYSTEM DATE AND TIME."
490 REM->SKIPSETTINGDATETIME
500 GOSUB 4840:REM GO->CHAIN 
510 END
520 REM->DRAWSCREEN
530 PRINT "DATE: ";DAY$;"-";MNTH$;"-";YEAR$;     "  (DAY-MONTH-YEAR)"
540 PRINT "TIME: ";HOUR$;":";MINUTE$;" ";AMPM$;"M   (TYPE ? FOR HELP)"
550 LET TX = 7 : REM TIME HORIZONTAL POSITION
560 LET DX = 7 : REM DATE HORIZONTAL POSITION
570 CALL -998 : REM MOVE CURSOR UP 1 LINE TO TIME LINE
580 LET TY = PEEK(37) + 1 : REM TIME VERTICAL POSITION
590 CALL -998 : REM MOVE CURSOR UP 1 LINE TO DATE LINE
600 LET DY = PEEK(37) + 1 : REM DATE VERTICAL POSITION
610 RETURN
620 REM->DISPLAYHELP
630 HOME
640 PRINT
650 PRINT "---------------- HELP -----------------"
660 PRINT "RETURN - SET DATA & TIME"
670 PRINT "ESC    - EXIT WITHOUT MAKING CHANGES"
680 PRINT "TAB    - SKIP TO NEXT ELEMENT"
690 PRINT "ARROWS - MOVE ONE CHAR IN ANY DIRECTION"
700 PRINT "SPACE  - MOVE FORWARD ONE CHARACTER"
710 PRINT "DELETE - MOVE BACK ONE CHARACTER"
720 PRINT "+      - INCREMENT CURRENT VALUE"
730 PRINT "-      - DECREMENT CURRENT VALUE"
740 PRINT "---------------------------------------"
750 PRINT
760 GOSUB 530:REM GO->DRAWSCREEN 
770 RETURN
780 REM->FORMATMONTH 
790 LET MNTH$ = MNTHS$(MNTH)
800 IF MNTH$ = "" THEN LET MNTH$ = "JAN" : LET MNTH = 1
810 RETURN 
820 REM->FORMATDATEANDTIME
830 LET YEAR$ = STR$(YEAR)
840 IF LEN(YEAR$) = 1 THEN LET YEAR$ = "0" + YEAR$
850 GOSUB 790:REM GO->FORMATMONTH 
860 LET DAY$ = STR$(DAY)
870 IF LEN(DAY$) = 1 THEN LET DAY$ = "0" + DAY$
880 LET HOUR$ = STR$(HOUR)
890 IF LEN(HOUR$) = 1 THEN LET HOUR$ = "0" + HOUR$
900 LET MINUTE$ = STR$(MINUTE)
910 IF LEN(MINUTE$) = 1 THEN LET MINUTE$ = "0" + MINUTE$
920 RETURN
930 REM->DECODEMONTH 
940 FOR I = 1 TO 12
950 IF MNTHS$(I) = MNTH$ THEN MNTH = I : RETURN 
960 NEXT
970 VTAB 24
980 PRINT
990 PRINT "INVALID MONTH NAME: " + MNTH$
1000 END
1010 REM->DECODEDATEANDTIME
1020 LET YEAR = VAL(YEAR$)
1030 GOSUB 940:REM GO->DECODEMONTH 
1040 LET HOUR = VAL(HOUR$)
1050 LET MINUTE = VAL(MINUTE$)
1060 RETURN
1070 REM->GETSYSTEMDATE
1080 LET DH = PEEK(49041): REM DATE HIGH BYTE
1090 LET DL = PEEK(49040): REM DATE LOW BYTE
1100 LET TH = PEEK(49043): REM TIME HIGH BYTE
1110 LET TL = PEEK(49042): REM TIME LOW BYTE 
1120 LET YEAR = INT (DH / 2)
1130 LET MNTH = ((DH/2 - INT(DH/2)) > 0) * 2 ^ 3 +  INT (DL / 32)
1140 LET DAY = DL
1150 IF DAY >= 128 THEN LET DAY = DAY - 128
1160 IF DAY >= 64  THEN LET DAY = DAY - 64
1170 IF DAY >= 32  THEN LET DAY = DAY - 32
1180 IF TH = 0  THEN            LET HOUR = 12      : LET AMPM$ = "A"
1190 IF TH = 12 THEN            LET HOUR = 12      : LET AMPM$ = "P"
1200 IF TH > 12 THEN            LET HOUR = TH - 12 : LET AMPM$ = "P"
1210 IF 0 < TH AND TH < 12 THEN LET HOUR = TH      : LET AMPM$ = "A"
1220 LET MINUTE = TL
1230 RETURN 
1240 REM->SETSYSTEMDATEANDTIME
1250 IF YEAR >= 100 THEN LET Y2 = VAL(RIGHT$(STR$(YEAR),2))
1260 IF YEAR <  100 THEN LET Y2 = YEAR
1270 LET DH = Y2 * 2 + (MNTH >  = 8)
1280 LET DL = MNTH * 32 - 128 * (MNTH >  = 8) + DAY
1290 IF HOUR =  12 AND AMPM$ = "A" THEN LET TH = 0
1300 IF HOUR =  12 AND AMPM$ = "P" THEN LET TH = 12
1310 IF HOUR <> 12 AND AMPM$ = "P" THEN LET TH = HOUR + 12
1320 IF HOUR <> 12 AND AMPM$ = "A" THEN LET TH = HOUR
1330 LET TL = MINUTE
1340 POKE 49041,DH: REM DATE HIGH BYTE
1350 POKE 49040,DL: REM DATE LOW BYTE
1360 POKE 49043,TH: REM TIME HIGH BYTE
1370 POKE 49042,TL: REM TIME LOW BYTE
1380 RETURN 
1390 REM->SOUNDERROR
1400 PRINT BEEP$
1410 RETURN
1420 REM->TOUPPERCASE 
1430 LET AC = ASC(K$)
1440 IF 141 <= AC AND AC <= 172 THEN LET K$ = CHR$(AC - 76)
1450 RETURN 
1460 REM->ENTERDATEANDTIME
1470 REM->DAYDIGITONE
1480 HTAB DX : VTAB DY
1490 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
1500 IF "0" <= K$ AND K$ <= "3" THEN PRINT K$; : DAY$ = K$ + RIGHT$(DAY$, 1) : GOTO 1660:REM GO->DAYDIGITTWO 
1510 IF K$ = " "             THEN GOTO 1660:REM GO->DAYDIGITTWO 
1520 IF K$ = TB$        THEN GOTO 1890:REM GO->MONTHCHARONE 
1530 IF K$ = RT$ THEN GOTO 1660:REM GO->DAYDIGITTWO 
1540 IF K$ = LT$  THEN GOTO 3840:REM GO->MERIDIEM 
1550 IF K$ = DOWN$ THEN GOTO 3020:REM GO->HOURDIGITONE 
1560 IF K$ = "+"             THEN GOSUB 4060 : PRINT DAY$; : GOTO 1480:REM GO->INCDAY DAYDIGITONE 
1570 IF K$ = "-"             THEN GOSUB 4140 : PRINT DAY$; : GOTO 1480:REM GO->DECDAY DAYDIGITONE 
1580 IF K$ = DLT$ THEN GOTO 3840:REM GO->MERIDIEM 
1590 IF K$ = ESC$ THEN RETURN
1600 IF K$ = RET$ THEN RETURN
1610 IF K$ = "Q"             THEN RETURN
1620 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
1630 GOSUB 1400:REM GO->SOUNDERROR 
1640 GOTO 1480:REM GO->DAYDIGITONE 
1650 REM->DAYDIGITTWO
1660 HTAB DX+1 : VTAB DY
1670 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
1680 IF K$ < "0" OR "9" < K$ THEN GOTO 1740:REM GO->DAYDIGITTWOKEYS 
1690 LET FIRST$ = LEFT$(DAY$, 1)
1700 LET TEST$ = FIRST$ + K$
1710 LET TV = VAL(TEST$)
1720 IF 1 <= TV AND TV <= MDAYS(MNTH) THEN PRINT K$; : DAY$ = TEST$ : DAY = TV : GOTO 1890:REM GO->MONTHCHARONE 
1730 REM->DAYDIGITTWOKEYS
1740 IF K$ = " "             THEN GOTO 1890:REM GO->MONTHCHARONE 
1750 IF K$ = TB$        THEN GOTO 1890:REM GO->MONTHCHARONE 
1760 IF K$ = RT$ THEN GOTO 1890:REM GO->MONTHCHARONE 
1770 IF K$ = LT$  THEN GOTO 1480:REM GO->DAYDIGITONE 
1780 IF K$ = DOWN$ THEN GOTO 3200:REM GO->HOURDIGITTWO 
1790 IF K$ = "+"             THEN GOSUB 4060 : PRINT LT$;DAY$; : GOTO 1660:REM GO->INCDAY DAYDIGITTWO 
1800 IF K$ = "-"             THEN GOSUB 4140 : PRINT LT$;DAY$; : GOTO 1660:REM GO->DECDAY DAYDIGITTWO 
1810 IF K$ = DLT$ THEN GOTO 1480:REM GO->DAYDIGITONE 
1820 IF K$ = ESC$ THEN RETURN
1830 IF K$ = RET$ THEN RETURN
1840 IF K$ = "Q"             THEN RETURN
1850 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
1860 GOSUB 1400:REM GO->SOUNDERROR 
1870 GOTO 1660:REM GO->DAYDIGITTWO 
1880 REM->MONTHCHARONE
1890 HTAB DX+3 : VTAB DY
1900 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
1910 IF K$ = LEFT$(MNTH$, 1) THEN GOTO 2150:REM GO->MONTHCHARTWO 
1920 IF K$ = "J" THEN MNTH$ = "JAN" : MNTH=1  : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1930 IF K$ = "F" THEN MNTH$ = "FEB" : MNTH=2  : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1940 IF K$ = "M" THEN MNTH$ = "MAR" : MNTH=3  : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1950 IF K$ = "A" THEN MNTH$ = "APR" : MNTH=4  : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1960 IF K$ = "S" THEN MNTH$ = "SEP" : MNTH=9  : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1970 IF K$ = "O" THEN MNTH$ = "OCT" : MNTH=10 : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1980 IF K$ = "N" THEN MNTH$ = "NOV" : MNTH=11 : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
1990 IF K$ = "D" THEN MNTH$ = "DEC" : MNTH=12 : PRINT MNTH$; : GOTO 2150:REM GO->MONTHCHARTWO 
2000 IF K$ = " " THEN GOTO 2150:REM GO->MONTHCHARTWO 
2010 IF K$ = TB$        THEN GOTO 2610:REM GO->YEARDIGITONE 
2020 IF K$ = RT$ THEN GOTO 2150:REM GO->MONTHCHARTWO 
2030 IF K$ = LT$  THEN GOTO 1660:REM GO->DAYDIGITTWO 
2040 IF K$ = DOWN$ THEN GOSUB 3430:REM GO->MINUTEDIGITONE 
2050 IF K$ = "+" THEN GOSUB 4220 : PRINT MNTH$; : GOTO 1890:REM GO->INCMONTH MONTHCHARONE 
2060 IF K$ = "-" THEN GOSUB 4280 : PRINT MNTH$; : GOTO 1890:REM GO->DECMONTH MONTHCHARONE 
2070 IF K$ = DLT$ THEN GOTO 1660:REM GO->DAYDIGITTWO 
2080 IF K$ = ESC$ THEN RETURN
2090 IF K$ = RET$ THEN RETURN
2100 IF K$ = "Q" THEN RETURN
2110 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
2120 GOSUB 1400:REM GO->SOUNDERROR 
2130 GOTO 1890:REM GO->MONTHCHARONE 
2140 REM->MONTHCHARTWO
2150 HTAB DX+4 : VTAB DY
2160 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
2170 IF K$ = MID$(MNTH$, 2, 1) THEN GOTO 2380:REM GO->MONTHCHARTHREE 
2180 LET FIRST$ = LEFT$(MNTH$, 1)
2190 IF FIRST$ = "J" AND K$ = "A" THEN MNTH$ = "JAN" : MNTH=1 : PRINT "AN"; : GOTO 2380:REM GO->MONTHCHARTHREE 
2200 IF FIRST$ = "J" AND K$ = "U" THEN MNTH$ = "JUN" : MNTH=6 : PRINT "UN"; : GOTO 2380:REM GO->MONTHCHARTHREE 
2210 IF FIRST$ = "A" AND K$ = "P" THEN MNTH$ = "APR" : MNTH=4 : PRINT "PR"; : GOTO 2380:REM GO->MONTHCHARTHREE 
2220 IF FIRST$ = "A" AND K$ = "U" THEN MNTH$ = "AUG" : MNTH=8 : PRINT "UG"; : GOTO 2380:REM GO->MONTHCHARTHREE 
2230 IF K$ = " "             THEN GOTO 2380:REM GO->MONTHCHARTHREE 
2240 IF K$ = TB$        THEN GOTO 2610:REM GO->YEARDIGITONE 
2250 IF K$ = RT$ THEN GOTO 2380:REM GO->MONTHCHARTHREE 
2260 IF K$ = LT$  THEN GOTO 1890:REM GO->MONTHCHARONE 
2270 IF K$ = DOWN$ THEN GOTO 3610:REM GO->MINUTEDIGITTWO 
2280 IF K$ = "+"             THEN GOSUB 4220 : PRINT LT$;MNTH$; : GOTO 2150:REM GO->INCMONTH MONTHCHARTWO 
2290 IF K$ = "-"             THEN GOSUB 4280 : PRINT LT$;MNTH$; : GOTO 2150:REM GO->DECMONTH MONTHCHARTWO 
2300 IF K$ = DLT$ THEN GOTO 1890:REM GO->MONTHCHARONE 
2310 IF K$ = ESC$ THEN RETURN
2320 IF K$ = RET$ THEN RETURN
2330 IF K$ = "Q"             THEN RETURN
2340 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
2350 GOSUB 1400:REM GO->SOUNDERROR 
2360 GOTO 2150:REM GO->MONTHCHARTWO 
2370 REM->MONTHCHARTHREE
2380 HTAB DX+5 : VTAB DY
2390 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
2400 IF K$ = RIGHT$(MNTH$, 1) THEN GOTO 2610:REM GO->YEARDIGITONE 
2410 LET TWO$ = LEFT$(MNTH$, 2)
2420 IF TWO$ = "MA" AND K$ = "R" THEN MNTH$ = "MAR" : MNTH=3 : PRINT K$; : GOTO 2610:REM GO->YEARDIGITONE 
2430 IF TWO$ = "MA" AND K$ = "Y" THEN MNTH$ = "MAY" : MNTH=5 : PRINT K$; : GOTO 2610:REM GO->YEARDIGITONE 
2440 IF TWO$ = "JU" AND K$ = "N" THEN MNTH$ = "JUN" : MNTH=6 : PRINT K$; : GOTO 2610:REM GO->YEARDIGITONE 
2450 IF TWO$ = "JU" AND K$ = "L" THEN MNTH$ = "JUL" : MNTH=7 : PRINT K$; : GOTO 2610:REM GO->YEARDIGITONE 
2460 IF K$ = " "             THEN GOTO 2610:REM GO->YEARDIGITONE 
2470 IF K$ = TB$        THEN GOTO 2610:REM GO->YEARDIGITONE 
2480 IF K$ = RT$ THEN GOTO 2610:REM GO->YEARDIGITONE 
2490 IF K$ = LT$  THEN GOTO 2150:REM GO->MONTHCHARTWO 
2500 IF K$ = DOWN$ THEN GOTO 3840:REM GO->MERIDIEM 
2510 IF K$ = "+"             THEN GOSUB 4220 : PRINT LT$;LT$;MNTH$; : GOTO 2380:REM GO->INCMONTH MONTHCHARTHREE 
2520 IF K$ = "-"             THEN GOSUB 4280 : PRINT LT$;LT$;MNTH$; : GOTO 2380:REM GO->DECMONTH MONTHCHARTHREE 
2530 IF K$ = DLT$ THEN GOTO 2150:REM GO->MONTHCHARTWO 
2540 IF K$ = ESC$ THEN RETURN
2550 IF K$ = RET$ THEN RETURN
2560 IF K$ = "Q"             THEN RETURN
2570 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
2580 GOSUB 1400:REM GO->SOUNDERROR 
2590 GOTO 2380:REM GO->MONTHCHARTHREE 
2600 REM->YEARDIGITONE
2610 HTAB DX+7 : VTAB DY
2620 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
2630 IF "0" <= K$ AND K$ <= "9" THEN PRINT K$; : YEAR$ = K$ + RIGHT$(YEAR$, 1) : GOTO 2790:REM GO->YEARDIGITTWO 
2640 IF K$ = " "             THEN GOTO 2790:REM GO->YEARDIGITTWO 
2650 IF K$ = TB$        THEN GOTO 3020:REM GO->HOURDIGITONE 
2660 IF K$ = RT$ THEN GOTO 2790:REM GO->YEARDIGITTWO 
2670 IF K$ = LT$  THEN GOTO 2380:REM GO->MONTHCHARTHREE 
2680 IF K$ = DOWN$ THEN GOTO 3840:REM GO->MERIDIEM 
2690 IF K$ = "+"             THEN GOSUB 4340 : PRINT YEAR$; : GOTO 2610:REM GO->INCYEAR YEARDIGITONE 
2700 IF K$ = "-"             THEN GOSUB 4410 : PRINT YEAR$; : GOTO 2610:REM GO->DECYEAR YEARDIGITONE 
2710 IF K$ = DLT$ THEN GOTO 2380:REM GO->MONTHCHARTHREE 
2720 IF K$ = ESC$ THEN RETURN
2730 IF K$ = RET$ THEN RETURN
2740 IF K$ = "Q"             THEN RETURN
2750 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
2760 GOSUB 1400:REM GO->SOUNDERROR 
2770 GOTO 2610:REM GO->YEARDIGITONE 
2780 REM->YEARDIGITTWO
2790 HTAB DX+8 : VTAB DY
2800 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
2810 IF K$ < "0" OR "9" < K$ THEN GOTO 2870:REM GO->YEARDIGITTWOKEYS 
2820 LET FIRST$ = LEFT$(YEAR$, 1)
2830 LET TEST$ = FIRST$ + K$
2840 LET TV = VAL(TEST$)
2850 IF 1 <= TV AND TV <= 99 THEN PRINT K$; : YEAR$ = TEST$ : YEAR = TV : GOTO 3020:REM GO->HOURDIGITONE 
2860 REM->YEARDIGITTWOKEYS
2870 IF K$ = " "             THEN GOTO 3020:REM GO->HOURDIGITONE 
2880 IF K$ = TB$        THEN GOTO 3020:REM GO->HOURDIGITONE 
2890 IF K$ = RT$ THEN GOTO 3020:REM GO->HOURDIGITONE 
2900 IF K$ = LT$  THEN GOTO 2610:REM GO->YEARDIGITONE 
2910 IF K$ = DOWN$ THEN GOTO 3840:REM GO->MERIDIEM 
2920 IF K$ = "+"             THEN GOSUB 4340 : PRINT LT$;YEAR$; : GOTO 2790:REM GO->INCYEAR YEARDIGITTWO 
2930 IF K$ = "-"             THEN GOSUB 4410 : PRINT LT$;YEAR$; : GOTO 2790:REM GO->DECYEAR YEARDIGITTWO 
2940 IF K$ = DLT$ THEN GOTO 2610:REM GO->YEARDIGITONE 
2950 IF K$ = ESC$ THEN RETURN
2960 IF K$ = RET$ THEN RETURN
2970 IF K$ = "Q"             THEN RETURN
2980 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
2990 GOSUB 1400:REM GO->SOUNDERROR 
3000 GOTO 2790:REM GO->YEARDIGITTWO 
3010 REM->HOURDIGITONE
3020 HTAB TX : VTAB TY
3030 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
3040 IF "0" <= K$ AND K$ <= "1" THEN PRINT K$; : HOUR$ = K$ + RIGHT$(HOUR$, 1) : GOTO 3200:REM GO->HOURDIGITTWO 
3050 IF K$ = " "             THEN GOTO 3200:REM GO->HOURDIGITTWO 
3060 IF K$ = TB$        THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3070 IF K$ = RT$ THEN GOTO 3200:REM GO->HOURDIGITTWO 
3080 IF K$ = LT$  THEN GOTO 2790:REM GO->YEARDIGITTWO 
3090 IF K$ = UP$    THEN GOTO 1480:REM GO->DAYDIGITONE 
3100 IF K$ = "+"             THEN GOSUB 4480 : PRINT HOUR$; : GOTO 3020:REM GO->INCHOUR HOURDIGITONE 
3110 IF K$ = "-"             THEN GOSUB 4550 : PRINT HOUR$; : GOTO 3020:REM GO->DECHOUR HOURDIGITONE 
3120 IF K$ = DLT$ THEN GOTO 2790:REM GO->YEARDIGITTWO 
3130 IF K$ = ESC$ THEN RETURN
3140 IF K$ = RET$ THEN RETURN
3150 IF K$ = "Q"             THEN RETURN
3160 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
3170 GOSUB 1400:REM GO->SOUNDERROR 
3180 GOTO 3020:REM GO->HOURDIGITONE 
3190 REM->HOURDIGITTWO
3200 HTAB TX+1 : VTAB TY
3210 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
3220 IF K$ < "0" OR "9" < K$ THEN GOTO 3280:REM GO->HOURDIGITTWOKEYS 
3230 LET FIRST$ = LEFT$(HOUR$, 1)
3240 LET TEST$ = FIRST$ + K$
3250 LET TV = VAL(TEST$)
3260 IF 1 <= TV AND TV <= 12 THEN PRINT K$; : HOUR$ = TEST$ : HOUR = TV : GOTO 3430:REM GO->MINUTEDIGITONE 
3270 REM->HOURDIGITTWOKEYS
3280 IF K$ = " "             THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3290 IF K$ = TB$        THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3300 IF K$ = RT$ THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3310 IF K$ = LT$  THEN GOTO 3020:REM GO->HOURDIGITONE 
3320 IF K$ = UP$    THEN GOTO 1660:REM GO->DAYDIGITTWO 
3330 IF K$ = "+"             THEN GOSUB 4480 : PRINT LT$;HOUR$; : GOTO 3200:REM GO->INCHOUR HOURDIGITTWO 
3340 IF K$ = "-"             THEN GOSUB 4550 : PRINT LT$;HOUR$; : GOTO 3200:REM GO->DECHOUR HOURDIGITTWO 
3350 IF K$ = DLT$ THEN GOTO 3020:REM GO->HOURDIGITONE 
3360 IF K$ = ESC$ THEN RETURN
3370 IF K$ = RET$ THEN RETURN
3380 IF K$ = "Q"             THEN RETURN
3390 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
3400 GOSUB 1400:REM GO->SOUNDERROR 
3410 GOTO 3200:REM GO->HOURDIGITTWO 
3420 REM->MINUTEDIGITONE
3430 HTAB TX+3 : VTAB TY
3440 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
3450 IF "0" <= K$ AND K$ <= "5" THEN PRINT K$; : MINUTE$ = K$ + RIGHT$(MINUTE$, 1) : GOTO 3610:REM GO->MINUTEDIGITTWO 
3460 IF K$ = " "             THEN GOTO 3610:REM GO->MINUTEDIGITTWO 
3470 IF K$ = TB$        THEN GOTO 3840:REM GO->MERIDIEM 
3480 IF K$ = RT$ THEN GOTO 3610:REM GO->MINUTEDIGITTWO 
3490 IF K$ = LT$  THEN GOTO 3200:REM GO->HOURDIGITTWO 
3500 IF K$ = UP$    THEN GOTO 1890:REM GO->MONTHCHARONE 
3510 IF K$ = "+"             THEN GOSUB 4620 : PRINT MINUTE$; : GOTO 3430:REM GO->INCMINUTE MINUTEDIGITONE 
3520 IF K$ = "-"             THEN GOSUB 4690 : PRINT MINUTE$; : GOTO 3430:REM GO->DECMINUTE MINUTEDIGITONE 
3530 IF K$ = DLT$ THEN GOTO 3200:REM GO->HOURDIGITTWO 
3540 IF K$ = ESC$ THEN RETURN
3550 IF K$ = RET$ THEN RETURN
3560 IF K$ = "Q"             THEN RETURN
3570 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
3580 GOSUB 1400:REM GO->SOUNDERROR 
3590 GOTO 3430:REM GO->MINUTEDIGITONE 
3600 REM->MINUTEDIGITTWO
3610 HTAB TX+4 : VTAB TY
3620 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
3630 IF K$ < "0" OR "9" < K$ THEN GOTO 3690:REM GO->MINUTEDIGITTWOKEYS 
3640 LET FIRST$ = LEFT$(MINUTE$, 1)
3650 LET TEST$ = FIRST$ + K$
3660 LET TV = VAL(TEST$)
3670 IF 0 <= TV AND TV <= 59 THEN PRINT K$; : MINUTE$ = TEST$ : MINUTE = TV : GOTO 3840:REM GO->MERIDIEM 
3680 REM->MINUTEDIGITTWOKEYS
3690 IF K$ = " "             THEN GOTO 3840:REM GO->MERIDIEM 
3700 IF K$ = TB$        THEN GOTO 3840:REM GO->MERIDIEM 
3710 IF K$ = RT$ THEN GOTO 3840:REM GO->MERIDIEM 
3720 IF K$ = LT$  THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3730 IF K$ = UP$    THEN GOTO 2150:REM GO->MONTHCHARTWO 
3740 IF K$ = "+"             THEN GOSUB 4620 : PRINT LT$;MINUTE$; : GOTO 3610:REM GO->INCMINUTE MINUTEDIGITTWO 
3750 IF K$ = "-"             THEN GOSUB 4690 : PRINT LT$;MINUTE$; : GOTO 3610:REM GO->DECMINUTE MINUTEDIGITTWO 
3760 IF K$ = DLT$ THEN GOTO 3430:REM GO->MINUTEDIGITONE 
3770 IF K$ = ESC$ THEN RETURN
3780 IF K$ = RET$ THEN RETURN
3790 IF K$ = "Q"             THEN RETURN
3800 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
3810 GOSUB 1400:REM GO->SOUNDERROR 
3820 GOTO 3610:REM GO->MINUTEDIGITTWO 
3830 REM->MERIDIEM
3840 HTAB TX+6 : VTAB TY
3850 GET K$ : GOSUB 1430:REM GO->TOUPPERCASE 
3860 IF K$ = "A" OR K$ = "P" THEN PRINT K$; : AMPM$ = K$ : GOTO 1480:REM GO->DAYDIGITONE 
3870 IF K$ = " "             THEN GOTO 1480:REM GO->DAYDIGITONE 
3880 IF K$ = TB$        THEN GOTO 1480:REM GO->DAYDIGITONE 
3890 IF K$ = RT$ THEN GOTO 1480:REM GO->DAYDIGITONE 
3900 IF K$ = LT$  THEN GOTO 3610:REM GO->MINUTEDIGITTWO 
3910 IF K$ = UP$    THEN GOTO 2610:REM GO->YEARDIGITONE 
3920 IF K$ = "+"             THEN GOSUB 4760 : PRINT AMPM$; : GOTO 3840:REM GO->INCMERIDIEM MERIDIEM 
3930 IF K$ = "-"             THEN GOSUB 4800 : PRINT AMPM$; : GOTO 3840:REM GO->DECMERIDIEM MERIDIEM 
3940 IF K$ = DLT$ THEN GOTO 3610:REM GO->MINUTEDIGITTWO 
3950 IF K$ = ESC$ THEN RETURN
3960 IF K$ = RET$ THEN RETURN
3970 IF K$ = "Q"             THEN RETURN
3980 IF K$ = "/" OR K$ = "?" OR K$ = "H" THEN GOSUB 630 : GOTO 1480:REM GO->DISPLAYHELP DAYDIGITONE 
3990 GOSUB 1400:REM GO->SOUNDERROR 
4000 GOTO 3840:REM GO->MERIDIEM 
4010 REM->PADYEAR
4020 IF YEAR = 0 THEN YEAR$ = "0000": RETURN 
4030 LET YEAR$ = STR$(2000 + YEAR)
4040 RETURN 
4050 REM->INCDAY
4060 LET DAY = VAL(DAY$)
4070 LET DAY = DAY + 1
4080 GOSUB 940:REM GO->DECODEMONTH 
4090 IF DAY > MDAYS(MNTH) THEN DAY = 1
4100 LET DAY$ = STR$(DAY)
4110 IF DAY < 10 THEN DAY$ = "0" + DAY$
4120 RETURN
4130 REM->DECDAY
4140 LET DAY = VAL(DAY$)
4150 LET DAY = DAY - 1
4160 GOSUB 940:REM GO->DECODEMONTH 
4170 IF DAY <= 0 THEN DAY = MDAYS(MNTH)
4180 LET DAY$ = STR$(DAY)
4190 IF DAY < 10 THEN DAY$ = "0" + DAY$
4200 RETURN
4210 REM->INCMONTH
4220 GOSUB 940:REM GO->DECODEMONTH 
4230 LET MNTH = MNTH - 1
4240 IF MNTH < 1 THEN MNTH = 12
4250 GOSUB 830:REM GO->FORMATDATEANDTIME 
4260 RETURN
4270 REM->DECMONTH
4280 GOSUB 940:REM GO->DECODEMONTH 
4290 LET MNTH = MNTH + 1
4300 IF MNTH > 12 THEN MNTH = 1
4310 GOSUB 830:REM GO->FORMATDATEANDTIME 
4320 RETURN
4330 REM->INCYEAR
4340 LET YEAR = VAL(YEAR$)
4350 LET YEAR = YEAR + 1
4360 IF YEAR > 99 THEN YEAR = 0
4370 LET YEAR$ = STR$(YEAR)
4380 IF YEAR < 10 THEN YEAR$ = "0" + YEAR$
4390 RETURN
4400 REM->DECYEAR
4410 LET YEAR = VAL(YEAR$)
4420 LET YEAR = YEAR - 1
4430 IF YEAR < 0  THEN YEAR = 99
4440 LET YEAR$ = STR$(YEAR)
4450 IF YEAR < 10 THEN YEAR$ = "0" + YEAR$
4460 RETURN
4470 REM->INCHOUR
4480 LET HOUR = VAL(HOUR$)
4490 LET HOUR = HOUR + 1
4500 IF HOUR > 12 THEN HOUR = 1
4510 LET HOUR$ = STR$(HOUR)
4520 IF HOUR < 10 THEN HOUR$ = "0" + HOUR$
4530 RETURN
4540 REM->DECHOUR
4550 LET HOUR = VAL(HOUR$)
4560 LET HOUR = HOUR - 1
4570 IF HOUR < 1 THEN HOUR = 12
4580 LET HOUR$ = STR$(HOUR)
4590 IF HOUR < 10 THEN HOUR$ = "0" + HOUR$
4600 RETURN
4610 REM->INCMINUTE
4620 LET MINUTE = VAL(MINUTE$)
4630 LET MINUTE = MINUTE + 1
4640 IF MINUTE > 59 THEN MINUTE = 0
4650 LET MINUTE$ = STR$(MINUTE)
4660 IF MINUTE < 10 THEN MINUTE$ = "0" + MINUTE$
4670 RETURN
4680 REM->DECMINUTE
4690 LET MINUTE = VAL(MINUTE$)
4700 LET MINUTE = MINUTE - 1
4710 IF MINUTE < 0 THEN MINUTE = 59
4720 LET MINUTE$ = STR$(MINUTE)
4730 IF MINUTE < 10 THEN MINUTE$ = "0" + MINUTE$
4740 RETURN
4750 REM->INCMERIDIEM
4760 IF AMPM$ = "A" THEN AMPM$ = "P" : RETURN
4770 IF AMPM$ = "P" THEN AMPM$ = "A"
4780 RETURN
4790 REM->DECMERIDIEM
4800 IF AMPM$ = "A" THEN AMPM$ = "P" : RETURN
4810 IF AMPM$ = "P" THEN AMPM$ = "A"
4820 RETURN
4830 REM->CHAIN
4840 LET LNGTH = PEEK(CADDR)
4850 LET CPGM$ = ""
4860 IF LNGTH = 0 THEN RETURN
4870 FOR I = 1 TO LNGTH
4880 LET C$ = CHR$(PEEK(CADDR + I))
4890 REM CHECK FOR BAD CHARACTER.
4900 IF C$ <> "/" OR C$ < "0" OR "Z" < C$ THEN CPGM$ = "" : RETURN
4910 LET CPGM$ = CPGM$ + C$
4920 NEXT
4930 REM RUN CHAINED PROGRAM.
4940 PRINT D$;"-";CPGM$
4950 RETURN