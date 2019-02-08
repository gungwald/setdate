10 REM DATEENTRYFORM.BAS - 08/02/2019 - 07h27
20 REM ***********************
30 REM PROGRAM: DATEENTRYFORM
40 REM SYSTEM:  PRODOS
50 REM AUTHOR:  BILL CHATFIELD
60 REM LICENSE: GPL3
70 REM ***********************
80 LET D$=CHR$(4)
90 LET LT$=CHR$(8)
100 LET DOWN$=CHR$(10)
110 LET UP$=CHR$(11)
120 LET RET$=CHR$(13)
130 LET D1$=CHR$(17) 
140 LET D2$=CHR$(18) 
150 LET NAK$=CHR$(21)   
160 LET RT$=CHR$(21)
170 LET ESC$=CHR$(27)
180 LET DLT$=CHR$(127)
190 LET BEEP$=CHR$(7)
200 LET TB$=CHR$(9)
210 LET BX=1
220 LET BY=2
230 DIM MNTHS$(12), MDAYS(12)
240 FOR I = 1 TO 12
250 READ MNTHS$(I), MDAYS(I)
260 NEXT
270 DATA JAN,31
280 DATA FEB,29
290 DATA MAR,31
300 DATA APR,30
310 DATA MAY,31
320 DATA JUN,30
330 DATA JUL,31
340 DATA AUG,31
350 DATA SEP,30
360 DATA OCT,31
370 DATA NOV,30
380 DATA DEC,31
390 PRINT D$;"PR#3" : REM TURN ON 80-COLUMN CARD
400 PRINT D1$       : REM SWITCH TO 40 COLUMNS FOR MOUSE CHARS
410 GOSUB 1280:REM GO->GETSYSTEMDATE 
420 GOSUB 1030:REM GO->FORMATDATEANDTIME 
430 GOSUB 540:REM GO->DRAWSCREEN 
440 GOSUB 1630:REM GO->ENTERDATEANDTIME 
450 GOSUB 1220:REM GO->DECODEDATEANDTIME 
460 GOSUB 1450:REM GO->SETSYSTEMDATEANDTIME 
470 PRINT NAK$ : REM TURN OFF 80-COL CARD
480 HOME
490 PRINT
500 IF K$ = RET$ THEN PRINT "SET SYSTEM DATE: "; : GOSUB 3800 : END:REM GO->PRINTDATE 
510 PRINT "CANCELLED SETTING OF DATE AND TIME."
520 END
530 REM->DRAWSCREEN
540 HTAB BX : VTAB BY
550 PRINT "         SET SYSTEM DATE & TIME"
560 PRINT
570 PRINT
580 PRINT
590 PRINT
600 HTAB BX
610 PRINT "             DAY  MONTH YEAR"
620 PRINT
630 HTAB BX
640 PRINT "        DATE: ";DAY$;" - ";MNTH$;" - ";YEAR$ 
650 PRINT
660 PRINT
670 HTAB BX
680 PRINT "             HOUR MIN MERIDIEM"
690 PRINT
700 HTAB BX
710 PRINT "        TIME: ";HOUR$;" : ";MINUTE$;"  ";AMPM$;"M"
720 PRINT
730 PRINT
740 PRINT
750 PRINT
760 HTAB BX
770 PRINT " RETURN - ACCEPT   "; : GOSUB 900 : PRINT "-D - GOTO YEAR":REM GO->PRINTOPENAPPLE 
780 HTAB BX
790 PRINT "    ESC - CANCEL   "; : GOSUB 900 : PRINT "-M - GOTO MONTH":REM GO->PRINTOPENAPPLE 
800 HTAB BX
810 PRINT "    TAB - NXT FLD  "; : GOSUB 900 : PRINT "-Y - GOTO YEAR":REM GO->PRINTOPENAPPLE 
820 HTAB BX
830 PRINT "   "; : GOSUB 950 : PRINT " - MOVE     "; : GOSUB 900 : PRINT "-H - GOTO HOUR":REM GO->PRINTARROWS PRINTOPENAPPLE 
840 HTAB BX
850 PRINT "      + - INC VAL  "; : GOSUB 900 : PRINT "-N - GOTO MINUTE":REM GO->PRINTOPENAPPLE 
860 HTAB BX
870 PRINT "      - - DEC VAL  "; : GOSUB 900 : PRINT "-R - GOTO MERIDIEM";:REM GO->PRINTOPENAPPLE 
880 RETURN
890 REM->PRINTOPENAPPLE
900 INVERSE
910 PRINT CHR$(27);"A";CHR$(24);
920 NORMAL
930 RETURN
940 REM->PRINTARROWS
950 INVERSE
960 PRINT CHR$(27);"HJKU";CHR$(24);
970 NORMAL
980 RETURN
990 REM->FORMATMONTH
1000 LET MNTH$ = MNTHS$(MNTH)
1010 RETURN
1020 REM->FORMATDATEANDTIME
1030 LET YEAR$ = STR$(YEAR)
1040 IF LEN(YEAR$) = 1 THEN LET YEAR$ = "0" + YEAR$
1050 GOSUB 1000:REM GO->FORMATMONTH 
1060 LET DAY$ = STR$(DAY)
1070 IF LEN(DAY$) = 1 THEN LET DAY$ = "0" + DAY$
1080 LET HOUR$ = STR$(HOUR)
1090 IF LEN(HOUR$) = 1 THEN LET HOUR$ = "0" + HOUR$
1100 LET MINUTE$ = STR$(MINUTE)
1110 IF LEN(MINUTE$) = 1 THEN LET MINUTE$ = "0" + MINUTE$
1120 RETURN
1130 REM->DECODEMONTH
1140 FOR I = 1 TO 12
1150 IF MNTHS$(I) = MNTH$ THEN MNTH = I : RETURN
1160 NEXT
1170 VTAB 24
1180 PRINT
1190 PRINT "INVALID MONTH NAME: " + MNTH$
1200 END
1210 REM->DECODEDATEANDTIME
1220 LET YEAR = VAL(YEAR$)
1230 GOSUB 1140:REM GO->DECODEMONTH 
1240 LET HOUR = VAL(HOUR$)
1250 LET MINUTE = VAL(MINUTE$)
1260 RETURN
1270 REM->GETSYSTEMDATE
1280 LET DH = PEEK(49041): REM DATE HIGH BYTE
1290 LET DL = PEEK(49040): REM DATE LOW BYTE
1300 LET TH = PEEK(49043): REM TIME HIGH BYTE
1310 LET TL = PEEK(49042): REM TIME LOW BYTE 
1320 LET YEAR = INT (DH / 2)
1330 LET MNTH = ((DH/2 - INT(DH/2)) > 0) * 2 ^ 3 +  INT (DL / 32)
1340 LET DAY = DL
1350 IF DAY >= 128 THEN DAY = DAY - 128
1360 IF DAY >= 64  THEN DAY = DAY - 64
1370 IF DAY >= 32  THEN DAY = DAY - 32
1380 IF TH = 0  THEN HOUR = 12      : AMPM$ = "A"
1390 IF TH = 12 THEN HOUR = 12      : AMPM$ = "P"
1400 IF TH > 12 THEN HOUR = TH - 12 : AMPM$ = "P"
1410 IF TH < 12 THEN HOUR = TH      : AMPM$ = "A"
1420 LET MINUTE = TL
1430 RETURN 
1440 REM->SETSYSTEMDATEANDTIME
1450 IF YEAR >= 100 THEN Y2 = VAL(RIGHT$(STR$(YEAR),2))
1460 IF YEAR <  100 THEN Y2 = YEAR
1470 LET DH = Y2 * 2 + (MNTH >  = 8)
1480 LET DL = MNTH * 32 - 128 * (MNTH >  = 8) + DAY
1490 IF HOUR =  12 AND AMPM$ = "A" THEN TH = 0
1500 IF HOUR =  12 AND AMPM$ = "P" THEN TH = 12
1510 IF HOUR <> 12 AND AMPM$ = "P" THEN TH = HOUR + 12
1520 IF HOUR <> 12 AND AMPM$ = "A" THEN TH = HOUR
1530 LET TL = MINUTE
1540 POKE 49041,DH: REM DATE HIGH BYTE
1550 POKE 49040,DL: REM DATE LOW BYTE
1560 POKE 49043,TH: REM TIME HIGH BYTE
1570 POKE 49042,TL: REM TIME LOW BYTE
1580 RETURN 
1590 REM->SOUNDERROR
1600 PRINT BEEP$
1610 RETURN
1620 REM->ENTERDATEANDTIME
1630 REM->DAYDIGITONE
1640 HTAB 15 : VTAB 9
1650 GET K$
1660 IF "0" <= K$ AND K$ <= "3" THEN PRINT K$; : DAY$ = K$ + RIGHT$(DAY$, 1) : GOTO 1790:REM GO->DAYDIGITTWO 
1670 IF K$ = " "             THEN GOTO 1790:REM GO->DAYDIGITTWO 
1680 IF K$ = TB$        THEN GOTO 1990:REM GO->MONTHCHARONE 
1690 IF K$ = RT$ THEN GOTO 1790:REM GO->DAYDIGITTWO 
1700 IF K$ = LT$  THEN GOTO 3650:REM GO->MERIDIEM 
1710 IF K$ = DOWN$ THEN GOTO 2950:REM GO->HOURDIGITONE 
1720 IF K$ = "+"             THEN GOSUB 3940 : PRINT DAY$; : GOTO 1640:REM GO->INCDAY DAYDIGITONE 
1730 IF K$ = "-"             THEN GOSUB 4020 : PRINT DAY$; : GOTO 1640:REM GO->DECDAY DAYDIGITONE 
1740 IF K$ = DLT$ THEN GOTO 3650:REM GO->MERIDIEM 
1750 GOSUB 4720:REM GO->JUMPKEYS 
1760 GOSUB 1600:REM GO->SOUNDERROR 
1770 GOTO 1640:REM GO->DAYDIGITONE 
1780 REM->DAYDIGITTWO
1790 HTAB 16 : VTAB 9
1800 GET K$
1810 IF K$ < "0" OR "9" < K$ THEN GOTO 1870:REM GO->DAYDIGITTWOKEYS 
1820 LET FIRST$ = LEFT$(DAY$, 1)
1830 LET TEST$ = FIRST$ + K$
1840 LET TV = VAL(TEST$)
1850 IF 1 <= TV AND TV <= MDAYS(MNTH) THEN PRINT K$; : DAY$ = TEST$ : DAY = TV : GOTO 1990:REM GO->MONTHCHARONE 
1860 REM->DAYDIGITTWOKEYS
1870 IF K$ = " "             THEN GOTO 1990:REM GO->MONTHCHARONE 
1880 IF K$ = TB$        THEN GOTO 1990:REM GO->MONTHCHARONE 
1890 IF K$ = RT$ THEN GOTO 1990:REM GO->MONTHCHARONE 
1900 IF K$ = LT$  THEN GOTO 1640:REM GO->DAYDIGITONE 
1910 IF K$ = DOWN$ THEN GOTO 2950:REM GO->HOURDIGITONE 
1920 IF K$ = "+"             THEN GOSUB 3940 : PRINT LT$;DAY$; : GOTO 1790:REM GO->INCDAY DAYDIGITTWO 
1930 IF K$ = "-"             THEN GOSUB 4020 : PRINT LT$;DAY$; : GOTO 1790:REM GO->DECDAY DAYDIGITTWO 
1940 IF K$ = DLT$ THEN GOTO 1640:REM GO->DAYDIGITONE 
1950 GOSUB 4720:REM GO->JUMPKEYS 
1960 GOSUB 1600:REM GO->SOUNDERROR 
1970 GOTO 1790:REM GO->DAYDIGITTWO 
1980 REM->MONTHCHARONE
1990 HTAB 20 : VTAB 9
2000 GET K$
2010 IF K$ = LEFT$(MNTH$, 1) THEN GOTO 2220:REM GO->MONTHCHARTWO 
2020 IF K$ = "J" THEN MNTH$ = "JAN" : MNTH=1  : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2030 IF K$ = "F" THEN MNTH$ = "FEB" : MNTH=2  : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2040 IF K$ = "M" THEN MNTH$ = "MAR" : MNTH=3  : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2050 IF K$ = "A" THEN MNTH$ = "APR" : MNTH=4  : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2060 IF K$ = "S" THEN MNTH$ = "SEP" : MNTH=9  : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2070 IF K$ = "O" THEN MNTH$ = "OCT" : MNTH=10 : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2080 IF K$ = "N" THEN MNTH$ = "NOV" : MNTH=11 : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2090 IF K$ = "D" THEN MNTH$ = "DEC" : MNTH=12 : PRINT MNTH$; : GOTO 2220:REM GO->MONTHCHARTWO 
2100 IF K$ = " "             THEN GOTO 2220:REM GO->MONTHCHARTWO 
2110 IF K$ = TB$        THEN GOTO 2600:REM GO->YEARDIGITONE 
2120 IF K$ = RT$ THEN GOTO 2220:REM GO->MONTHCHARTWO 
2130 IF K$ = LT$  THEN GOTO 1790:REM GO->DAYDIGITTWO 
2140 IF K$ = DOWN$ THEN GOSUB 3300:REM GO->MINUTEDIGITONE 
2150 IF K$ = "+"             THEN GOSUB 4100 : PRINT MNTH$; : GOTO 1990:REM GO->INCMONTH MONTHCHARONE 
2160 IF K$ = "-"             THEN GOSUB 4160 : PRINT MNTH$; : GOTO 1990:REM GO->DECMONTH MONTHCHARONE 
2170 IF K$ = DLT$ THEN GOTO 1790:REM GO->DAYDIGITTWO 
2180 GOSUB 4720:REM GO->JUMPKEYS 
2190 GOSUB 1600:REM GO->SOUNDERROR 
2200 GOTO 1990:REM GO->MONTHCHARONE 
2210 REM->MONTHCHARTWO
2220 HTAB 21 : VTAB 9
2230 GET K$
2240 IF K$ = MID$(MNTH$, 2, 1) THEN GOTO 2400:REM GO->MONTHCHARTHREE 
2250 LET FIRST$ = LEFT$(MNTH$, 1)
2260 IF FIRST$ = "A" AND K$ = "P" THEN MNTH$ = "APR" : MNTH=4 : PRINT "PR"; : GOTO 2400:REM GO->MONTHCHARTHREE 
2270 IF FIRST$ = "A" AND K$ = "U" THEN MNTH$ = "AUG" : MNTH=8 : PRINT "UG"; : GOTO 2400:REM GO->MONTHCHARTHREE 
2280 IF K$ = " "             THEN GOTO 2400:REM GO->MONTHCHARTHREE 
2290 IF K$ = TB$        THEN GOTO 2600:REM GO->YEARDIGITONE 
2300 IF K$ = RT$ THEN GOTO 2400:REM GO->MONTHCHARTHREE 
2310 IF K$ = LT$  THEN GOTO 1990:REM GO->MONTHCHARONE 
2320 IF K$ = DOWN$ THEN GOTO 3300:REM GO->MINUTEDIGITONE 
2330 IF K$ = "+"             THEN GOSUB 4100 : PRINT LT$;MNTH$; : GOTO 2220:REM GO->INCMONTH MONTHCHARTWO 
2340 IF K$ = "-"             THEN GOSUB 4160 : PRINT LT$;MNTH$; : GOTO 2220:REM GO->DECMONTH MONTHCHARTWO 
2350 IF K$ = DLT$ THEN GOTO 1990:REM GO->MONTHCHARONE 
2360 GOSUB 4720:REM GO->JUMPKEYS 
2370 GOSUB 1600:REM GO->SOUNDERROR 
2380 GOTO 2220:REM GO->MONTHCHARTWO 
2390 REM->MONTHCHARTHREE
2400 HTAB 22 : VTAB 9
2410 IF K$ = RIGHT$(MNTH$, 1) THEN GOTO 2600:REM GO->YEARDIGITONE 
2420 LET TWO$ = LEFT$(MNTH$, 2)
2430 GET K$
2440 IF TWO$ = "MA" AND K$ = "R" THEN MNTH$ = "MAR" : MNTH=3 : PRINT K$; : GOTO 2600:REM GO->YEARDIGITONE 
2450 IF TWO$ = "MA" AND K$ = "Y" THEN MNTH$ = "MAY" : MNTH=5 : PRINT K$; : GOTO 2600:REM GO->YEARDIGITONE 
2460 IF TWO$ = "JU" AND K$ = "N" THEN MNTH$ = "JUN" : MNTH=6 : PRINT K$; : GOTO 2600:REM GO->YEARDIGITONE 
2470 IF TWO$ = "JU" AND K$ = "L" THEN MNTH$ = "JUL" : MNTH=7 : PRINT K$; : GOTO 2600:REM GO->YEARDIGITONE 
2480 IF K$ = " "             THEN GOTO 2600:REM GO->YEARDIGITONE 
2490 IF K$ = TB$        THEN GOTO 2600:REM GO->YEARDIGITONE 
2500 IF K$ = RT$ THEN GOTO 2600:REM GO->YEARDIGITONE 
2510 IF K$ = LT$  THEN GOTO 2220:REM GO->MONTHCHARTWO 
2520 IF K$ = DOWN$ THEN GOTO 3300:REM GO->MINUTEDIGITONE 
2530 IF K$ = "+"             THEN GOSUB 4100 : PRINT LT$;LT$;MNTH$; : GOTO 2400:REM GO->INCMONTH MONTHCHARTHREE 
2540 IF K$ = "-"             THEN GOSUB 4160 : PRINT LT$;LT$;MNTH$; : GOTO 2400:REM GO->DECMONTH MONTHCHARTHREE 
2550 IF K$ = DLT$ THEN GOTO 2220:REM GO->MONTHCHARTWO 
2560 GOSUB 4720:REM GO->JUMPKEYS 
2570 GOSUB 1600:REM GO->SOUNDERROR 
2580 GOTO 2400:REM GO->MONTHCHARTHREE 
2590 REM->YEARDIGITONE
2600 HTAB 26 : VTAB 9
2610 GET K$
2620 IF "0" <= K$ AND K$ <= "9" THEN PRINT K$; : YEAR$ = K$ + RIGHT$(YEAR$, 1) : GOTO 2750:REM GO->YEARDIGITTWO 
2630 IF K$ = " "             THEN GOTO 2750:REM GO->YEARDIGITTWO 
2640 IF K$ = TB$        THEN GOTO 2950:REM GO->HOURDIGITONE 
2650 IF K$ = RT$ THEN GOTO 2750:REM GO->YEARDIGITTWO 
2660 IF K$ = LT$  THEN GOTO 2400:REM GO->MONTHCHARTHREE 
2670 IF K$ = DOWN$ THEN GOTO 3650:REM GO->MERIDIEM 
2680 IF K$ = "+"             THEN GOSUB 4220 : PRINT YEAR$; : GOTO 2600:REM GO->INCYEAR YEARDIGITONE 
2690 IF K$ = "-"             THEN GOSUB 4290 : PRINT YEAR$; : GOTO 2600:REM GO->DECYEAR YEARDIGITONE 
2700 IF K$ = DLT$ THEN GOTO 2400:REM GO->MONTHCHARTHREE 
2710 GOSUB 4720:REM GO->JUMPKEYS 
2720 GOSUB 1600:REM GO->SOUNDERROR 
2730 GOTO 2600:REM GO->YEARDIGITONE 
2740 REM->YEARDIGITTWO
2750 HTAB 27 : VTAB 9
2760 GET K$
2770 IF K$ < "0" OR "9" < K$ THEN GOTO 2830:REM GO->YEARDIGITTWOKEYS 
2780 LET FIRST$ = LEFT$(YEAR$, 1)
2790 LET TEST$ = FIRST$ + K$
2800 LET TV = VAL(TEST$)
2810 IF 1 <= TV AND TV <= 99 THEN PRINT K$; : YEAR$ = TEST$ : YEAR = TV : GOTO 2950:REM GO->HOURDIGITONE 
2820 REM->YEARDIGITTWOKEYS
2830 IF K$ = " "             THEN GOTO 2950:REM GO->HOURDIGITONE 
2840 IF K$ = TB$        THEN GOTO 2950:REM GO->HOURDIGITONE 
2850 IF K$ = RT$ THEN GOTO 2950:REM GO->HOURDIGITONE 
2860 IF K$ = LT$  THEN GOTO 2600:REM GO->YEARDIGITONE 
2870 IF K$ = DOWN$ THEN GOTO 3650:REM GO->MERIDIEM 
2880 IF K$ = "+"             THEN GOSUB 4220 : PRINT LT$;YEAR$; : GOTO 2750:REM GO->INCYEAR YEARDIGITTWO 
2890 IF K$ = "-"             THEN GOSUB 4290 : PRINT LT$;YEAR$; : GOTO 2750:REM GO->DECYEAR YEARDIGITTWO 
2900 IF K$ = DLT$ THEN GOTO 2600:REM GO->YEARDIGITONE 
2910 GOSUB 4720:REM GO->JUMPKEYS 
2920 GOSUB 1600:REM GO->SOUNDERROR 
2930 GOTO 2750:REM GO->YEARDIGITTWO 
2940 REM->HOURDIGITONE
2950 HTAB 15 : VTAB 14
2960 GET K$
2970 IF "0" <= K$ AND K$ <= "1" THEN PRINT K$; : HOUR$ = K$ + RIGHT$(HOUR$, 1) : GOTO 3100:REM GO->HOURDIGITTWO 
2980 IF K$ = " "             THEN GOTO 3100:REM GO->HOURDIGITTWO 
2990 IF K$ = TB$        THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3000 IF K$ = RT$ THEN GOTO 3100:REM GO->HOURDIGITTWO 
3010 IF K$ = LT$  THEN GOTO 2750:REM GO->YEARDIGITTWO 
3020 IF K$ = UP$    THEN GOTO 1640:REM GO->DAYDIGITONE 
3030 IF K$ = "+"             THEN GOSUB 4360 : PRINT HOUR$; : GOTO 2950:REM GO->INCHOUR HOURDIGITONE 
3040 IF K$ = "-"             THEN GOSUB 4430 : PRINT HOUR$; : GOTO 2950:REM GO->DECHOUR HOURDIGITONE 
3050 IF K$ = DLT$ THEN GOTO 2750:REM GO->YEARDIGITTWO 
3060 GOSUB 4720:REM GO->JUMPKEYS 
3070 GOSUB 1600:REM GO->SOUNDERROR 
3080 GOTO 2950:REM GO->HOURDIGITONE 
3090 REM->HOURDIGITTWO
3100 HTAB 16 : VTAB 14
3110 GET K$
3120 IF K$ < "0" OR "9" < K$ THEN GOTO 3180:REM GO->HOURDIGITTWOKEYS 
3130 LET FIRST$ = LEFT$(HOUR$, 1)
3140 LET TEST$ = FIRST$ + K$
3150 LET TV = VAL(TEST$)
3160 IF 1 <= TV AND TV <= 12 THEN PRINT K$; : HOUR$ = TEST$ : HOUR = TV : GOTO 3300:REM GO->MINUTEDIGITONE 
3170 REM->HOURDIGITTWOKEYS
3180 IF K$ = " "             THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3190 IF K$ = TB$        THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3200 IF K$ = RT$ THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3210 IF K$ = LT$  THEN GOTO 2950:REM GO->HOURDIGITONE 
3220 IF K$ = UP$    THEN GOTO 1640:REM GO->DAYDIGITONE 
3230 IF K$ = "+"             THEN GOSUB 4360 : PRINT LT$;HOUR$; : GOTO 3100:REM GO->INCHOUR HOURDIGITTWO 
3240 IF K$ = "-"             THEN GOSUB 4430 : PRINT LT$;HOUR$; : GOTO 3100:REM GO->DECHOUR HOURDIGITTWO 
3250 IF K$ = DLT$ THEN GOTO 2950:REM GO->HOURDIGITONE 
3260 GOSUB 4720:REM GO->JUMPKEYS 
3270 GOSUB 1600:REM GO->SOUNDERROR 
3280 GOTO 3100:REM GO->HOURDIGITTWO 
3290 REM->MINUTEDIGITONE
3300 HTAB 20 : VTAB 14
3310 GET K$
3320 IF "0" <= K$ AND K$ <= "5" THEN PRINT K$; : MINUTE$ = K$ + RIGHT$(MINUTE$, 1) : GOTO 3450:REM GO->MINUTEDIGITTWO 
3330 IF K$ = " "             THEN GOTO 3450:REM GO->MINUTEDIGITTWO 
3340 IF K$ = TB$        THEN GOTO 3650:REM GO->MERIDIEM 
3350 IF K$ = RT$ THEN GOTO 3450:REM GO->MINUTEDIGITTWO 
3360 IF K$ = LT$  THEN GOTO 3100:REM GO->HOURDIGITTWO 
3370 IF K$ = UP$    THEN GOTO 1990:REM GO->MONTHCHARONE 
3380 IF K$ = "+"             THEN GOSUB 4500 : PRINT MINUTE$; : GOTO 3300:REM GO->INCMINUTE MINUTEDIGITONE 
3390 IF K$ = "-"             THEN GOSUB 4570 : PRINT MINUTE$; : GOTO 3300:REM GO->DECMINUTE MINUTEDIGITONE 
3400 IF K$ = DLT$ THEN GOTO 3100:REM GO->HOURDIGITTWO 
3410 GOSUB 4720:REM GO->JUMPKEYS 
3420 GOSUB 1600:REM GO->SOUNDERROR 
3430 GOTO 3300:REM GO->MINUTEDIGITONE 
3440 REM->MINUTEDIGITTWO
3450 HTAB 21 : VTAB 14
3460 GET K$
3470 IF K$ < "0" OR "9" < K$ THEN GOTO 3530:REM GO->MINUTEDIGITTWOKEYS 
3480 LET FIRST$ = LEFT$(MINUTE$, 1)
3490 LET TEST$ = FIRST$ + K$
3500 LET TV = VAL(TEST$)
3510 IF 0 <= TV AND TV <= 59 THEN PRINT K$; : MINUTE$ = TEST$ : MINUTE = TV : GOTO 3650:REM GO->MERIDIEM 
3520 REM->MINUTEDIGITTWOKEYS
3530 IF K$ = " "             THEN GOTO 3650:REM GO->MERIDIEM 
3540 IF K$ = TB$        THEN GOTO 3650:REM GO->MERIDIEM 
3550 IF K$ = RT$ THEN GOTO 3650:REM GO->MERIDIEM 
3560 IF K$ = LT$  THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3570 IF K$ = UP$    THEN GOTO 1990:REM GO->MONTHCHARONE 
3580 IF K$ = "+"             THEN GOSUB 4500 : PRINT LT$;MINUTE$; : GOTO 3450:REM GO->INCMINUTE MINUTEDIGITTWO 
3590 IF K$ = "-"             THEN GOSUB 4570 : PRINT LT$;MINUTE$; : GOTO 3450:REM GO->DECMINUTE MINUTEDIGITTWO 
3600 IF K$ = DLT$ THEN GOTO 3300:REM GO->MINUTEDIGITONE 
3610 GOSUB 4720:REM GO->JUMPKEYS 
3620 GOSUB 1600:REM GO->SOUNDERROR 
3630 GOTO 3450:REM GO->MINUTEDIGITTWO 
3640 REM->MERIDIEM
3650 HTAB 24 : VTAB 14
3660 GET K$
3670 IF K$ = "A" OR K$ = "P" THEN PRINT K$; : AMPM$ = K$ : GOTO 1640:REM GO->DAYDIGITONE 
3680 IF K$ = " "             THEN GOTO 1640:REM GO->DAYDIGITONE 
3690 IF K$ = TB$        THEN GOTO 1640:REM GO->DAYDIGITONE 
3700 IF K$ = RT$ THEN GOTO 1640:REM GO->DAYDIGITONE 
3710 IF K$ = LT$  THEN GOTO 3450:REM GO->MINUTEDIGITTWO 
3720 IF K$ = UP$    THEN GOTO 2600:REM GO->YEARDIGITONE 
3730 IF K$ = "+"             THEN GOSUB 4640 : PRINT AMPM$; : GOTO 3650:REM GO->INCMERIDIEM MERIDIEM 
3740 IF K$ = "-"             THEN GOSUB 4680 : PRINT AMPM$; : GOTO 3650:REM GO->DECMERIDIEM MERIDIEM 
3750 IF K$ = DLT$ THEN GOTO 3450:REM GO->MINUTEDIGITTWO 
3760 GOSUB 4720:REM GO->JUMPKEYS 
3770 GOSUB 1600:REM GO->SOUNDERROR 
3780 GOTO 3650:REM GO->MERIDIEM 
3790 REM->PRINTDATE
3800 GOSUB 3900:REM GO->PADYEAR 
3810 PRINT YEAR$;"-";
3820 IF MNTH < 10 THEN PRINT "0";
3830 PRINT MNTH;"-";
3840 IF DAY < 10 THEN PRINT "0";
3850 PRINT DAY;" ";HOUR;":";
3860 IF MINUTE < 10 THEN PRINT "0";
3870 PRINT MINUTE;" ";AMPM$;"M"
3880 RETURN 
3890 REM->PADYEAR
3900 IF YEAR = 0 THEN YEAR$ = "0000": RETURN 
3910 LET YEAR$ = STR$(2000 + YEAR)
3920 RETURN 
3930 REM->INCDAY
3940 LET DAY = VAL(DAY$)
3950 LET DAY = DAY + 1
3960 GOSUB 1140:REM GO->DECODEMONTH 
3970 IF DAY > MDAYS(MNTH) THEN DAY = 1
3980 LET DAY$ = STR$(DAY)
3990 IF DAY < 10 THEN DAY$ = "0" + DAY$
4000 RETURN
4010 REM->DECDAY
4020 LET DAY = VAL(DAY$)
4030 LET DAY = DAY - 1
4040 GOSUB 1140:REM GO->DECODEMONTH 
4050 IF DAY <= 0 THEN DAY = MDAYS(MNTH)
4060 LET DAY$ = STR$(DAY)
4070 IF DAY < 10 THEN DAY$ = "0" + DAY$
4080 RETURN
4090 REM->INCMONTH
4100 GOSUB 1140:REM GO->DECODEMONTH 
4110 LET MNTH = MNTH - 1
4120 IF MNTH < 1 THEN MNTH = 12
4130 GOSUB 1030:REM GO->FORMATDATEANDTIME 
4140 RETURN
4150 REM->DECMONTH
4160 GOSUB 1140:REM GO->DECODEMONTH 
4170 LET MNTH = MNTH + 1
4180 IF MNTH > 12 THEN MNTH = 1
4190 GOSUB 1030:REM GO->FORMATDATEANDTIME 
4200 RETURN
4210 REM->INCYEAR
4220 LET YEAR = VAL(YEAR$)
4230 LET YEAR = YEAR + 1
4240 IF YEAR > 99 THEN YEAR = 0
4250 LET YEAR$ = STR$(YEAR)
4260 IF YEAR < 10 THEN YEAR$ = "0" + YEAR$
4270 RETURN
4280 REM->DECYEAR
4290 LET YEAR = VAL(YEAR$)
4300 LET YEAR = YEAR - 1
4310 IF YEAR < 0  THEN YEAR = 99
4320 LET YEAR$ = STR$(YEAR)
4330 IF YEAR < 10 THEN YEAR$ = "0" + YEAR$
4340 RETURN
4350 REM->INCHOUR
4360 LET HOUR = VAL(HOUR$)
4370 LET HOUR = HOUR + 1
4380 IF HOUR > 12 THEN HOUR = 1
4390 LET HOUR$ = STR$(HOUR)
4400 IF HOUR < 10 THEN HOUR$ = "0" + HOUR$
4410 RETURN
4420 REM->DECHOUR
4430 LET HOUR = VAL(HOUR$)
4440 LET HOUR = HOUR - 1
4450 IF HOUR < 1 THEN HOUR = 12
4460 LET HOUR$ = STR$(HOUR)
4470 IF HOUR < 10 THEN HOUR$ = "0" + HOUR$
4480 RETURN
4490 REM->INCMINUTE
4500 LET MINUTE = VAL(MINUTE$)
4510 LET MINUTE = MINUTE + 1
4520 IF MINUTE > 59 THEN MINUTE = 0
4530 LET MINUTE$ = STR$(MINUTE)
4540 IF MINUTE < 10 THEN MINUTE$ = "0" + MINUTE$
4550 RETURN
4560 REM->DECMINUTE
4570 LET MINUTE = VAL(MINUTE$)
4580 LET MINUTE = MINUTE - 1
4590 IF MINUTE < 0 THEN MINUTE = 59
4600 LET MINUTE$ = STR$(MINUTE)
4610 IF MINUTE < 10 THEN MINUTE$ = "0" + MINUTE$
4620 RETURN
4630 REM->INCMERIDIEM
4640 IF AMPM$ = "A" THEN AMPM$ = "P" : RETURN
4650 IF AMPM$ = "P" THEN AMPM$ = "A"
4660 RETURN
4670 REM->DECMERIDIEM
4680 IF AMPM$ = "A" THEN AMPM$ = "P" : RETURN
4690 IF AMPM$ = "P" THEN AMPM$ = "A"
4700 RETURN
4710 REM->JUMPKEYS
4720 IF K$ = ESC$ THEN POP : RETURN
4730 IF K$ = RET$ THEN POP : RETURN
4740 IF PEEK(49249) <= 127 THEN RETURN
4750 IF K$ = "D" THEN POP : GOTO 1640:REM GO->DAYDIGITONE 
4760 IF K$ = "M" THEN POP : GOTO 1990:REM GO->MONTHCHARONE 
4770 IF K$ = "Y" THEN POP : GOTO 2600:REM GO->YEARDIGITONE 
4780 IF K$ = "H" THEN POP : GOTO 2950:REM GO->HOURDIGITONE 
4790 IF K$ = "N" THEN POP : GOTO 3300:REM GO->MINUTEDIGITONE 
4800 IF K$ = "R" THEN POP : GOTO 3650:REM GO->MERIDIEM 
4810 RETURN