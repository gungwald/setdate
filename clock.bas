10 REM  - C:/USERS/LOZ/DESKTOP/LOZ_CODE/PY_VIRTUALBASIC/VIRTUALBASIC-CODE/CLOCK.BAS - 16/09/2015 - 19h24
20 REM * CONTROL D CHAR
30 D$= CHR$(4)
40 PI= 3.14159:CI= (2 * PI)
50 REM * WIDTH MAX, HEIGHT MAX FOR SCREEN (279, 191, 159)
60 ML%= 279:MW%= ML%:MH%= 191
70 IF PEEK(33) = 80 THEN MH%= 159
80 REM * TRUE RANDOM NUMBER
90 DEF FN ALEA(X) = INT(RND(PEEK(78)+PEEK(79)*256) * X + 1)
100 REM * BEEP AND BUZZ BY DEFAULT
110 BZ%= 3:BE%= 1
120 TEXT:HOME
130 GOSUB 650
140 GOSUB 3500
150 DEF FN HDIGI(X)= INT( ( ML% - (X * 7.75) ) / 2 )
160 DEF FN TEN(X)= INT(X / 10) * 10
170 DE%= 10
180 SN%= 0
190 RY%= 50:DI%= 10
200 DG%= INT( (DI% * 2) + (DI% / 2) + (DI% / 4) )
210 XO%= 140:YO%= 80
220 HH%= 0:MM%= 0:SS%= 0
230 REM->BEGIN
240 BP%= BP% + 1
250 XO%= 140:YO%= 80
260 HH%= 0:MM%= 0:SS%= 0
270 HCOLOR= 3
280 GOSUB 570
290 HCOLOR= 3
300 GOSUB 2850
310 GOSUB 3050
320 FOR B1=0 TO 23
330 GOSUB 2710
340 FOR B2=0 TO 59
350 GOSUB 2550
360 IF B1 * 5 = MM% - 1 OR (B1 - 12) * 5 = MM% - 1 THEN GOSUB 2710
370 FOR B3=0 TO 59
380 GOSUB 2400
390 IF SN% = 1 THEN GOSUB 950
400 KI%= PEEK(49152)
410 IF KI%= 209 THEN GOTO 530
420 IF KI%= 212 THEN GOSUB 3150
430 IF KI%= 196 THEN GOSUB 3360
440 IF KI%= 200 THEN GOSUB 3790
450 IF SN%= 1 AND KI%= 211 THEN SN%= 0:GOTO 480
460 IF KI%= 211 THEN SN%= 1
470 REM->SOUNDEND
480 GOSUB 800
490 FOR B4= 0 TO DE%
500 NEXT : NEXT : NEXT : NEXT
510 IF (BP% < 32) THEN GOTO 240
520 REM->ENDPROGRAM
530 TEXT:HOME:POKE 49168,0
540 GOSUB 720
550 END
560 REM->HGRSCREEN
570 IF PEEK(33) < 41 AND MH% > 159 THEN HG$= "HGR2"
580 IF PEEK(33) < 41 AND MH% <= 159 THEN HG$= "HGR"
590 REM * MOD 80 COLONNES
600 IF PEEK(33) > 40 THEN HG$= "HGR"
610 IF HG$ = "HGR" THEN HGR
620 IF HG$ = "HGR2" THEN HGR2
630 RETURN
640 REM->SPLASH
650 TEXT:HOME
660 VTAB(3):PRINT
670 VTAB(PEEK(37) + 2)
680 S$= "APPLESOFT BASIC CODE":GOSUB 890
690 PRINT S$
700 RETURN
710 REM->CREDITS
720 TEXT:HOME
730 GOSUB 950
740 VTAB(3):PRINT
750 VTAB(PEEK(37) + 2)
760 S$= "BY ANDRES AKA LOZ":GOSUB 890
770 PRINT S$
780 RETURN
790 REM->KEYBOARDCAPTURE
800 REM * CAPTURE LAST KEYBOARD ENTERED
810 KI%= PEEK(49152)
820 REM * RESET
830 POKE 49168,0
840 REM * ACTIONS
850 IF KI% = 155 THEN GOTO 530
860 IF CHR$(KI%) = "T" THEN TEXT
870 RETURN
880 REM->CENTERTEXT
890 T9%= INT( (PEEK(33) - LEN(S$) ) / 2 )
900 REM * IS RESULT IS NULL
910 IF (T9% < 1) THEN T9%= 0
920 HTAB(T9%+1)
930 RETURN
940 REM->BEEP
950 IF (BE% < 2) THEN BE%= 1
960 FOR B9= 1 TO BE%
970 PRINT CHR$(7);
980 NEXT
990 RETURN
1000 REM->A 
1010 X2%= X1%:Y2%= Y1%:RETURN
1020 REM->B 
1030 X2%= X1% + DI%:Y2%= Y1%:RETURN
1040 REM->C 
1050 X2%= X1%:Y2%= Y1% + DI%:RETURN
1060 REM->D 
1070 X2%= X1% + DI%:Y2%= Y1% + DI%:RETURN
1080 REM->E 
1090 X2%= X1%:Y2%= Y1% + (2 * DI%):RETURN
1100 REM->F 
1110 X2%= X1% + DI%:Y2%= Y1% + (2 * DI%):RETURN
1120 REM->ZERO
1130 X1%= XO%:Y1%= YO%
1140 GOSUB 1010:HPLOT X2%,Y2%
1150 GOSUB 1030:HPLOT TO X2%,Y2%
1160 GOSUB 1110:HPLOT TO X2%,Y2%
1170 GOSUB 1090:HPLOT TO X2%,Y2%
1180 GOSUB 1010:HPLOT TO X2%,Y2%
1190 RETURN
1200 REM->ONE
1210 X1%= XO%:Y1%= YO%
1220 GOSUB 1030:HPLOT X2%,Y2%
1230 GOSUB 1110:HPLOT TO X2%,Y2%
1240 RETURN
1250 REM->TWO
1260 X1%= XO%:Y1%= YO%
1270 GOSUB 1010:HPLOT X2%,Y2%
1280 GOSUB 1030:HPLOT TO X2%,Y2%
1290 GOSUB 1070:HPLOT TO X2%,Y2%
1300 GOSUB 1050:HPLOT TO X2%,Y2%
1310 GOSUB 1090:HPLOT TO X2%,Y2%
1320 GOSUB 1110:HPLOT TO X2%,Y2%
1330 RETURN
1340 REM->THREE
1350 X1%= XO%:Y1%= YO%
1360 GOSUB 1010:HPLOT X2%,Y2%
1370 GOSUB 1030:HPLOT TO X2%,Y2%
1380 GOSUB 1070:HPLOT TO X2%,Y2%
1390 GOSUB 1050:HPLOT TO X2%,Y2%
1400 GOSUB 1070:HPLOT TO X2%,Y2%
1410 GOSUB 1110:HPLOT TO X2%,Y2%
1420 GOSUB 1090:HPLOT TO X2%,Y2%
1430 RETURN
1440 REM->FOUR
1450 X1%= XO%:Y1%= YO%
1460 GOSUB 1010:HPLOT X2%,Y2%
1470 GOSUB 1050:HPLOT TO X2%,Y2%
1480 GOSUB 1070:HPLOT TO X2%,Y2%
1490 GOSUB 1110:HPLOT TO X2%,Y2%
1500 GOSUB 1030:HPLOT TO X2%,Y2%
1510 RETURN
1520 REM->FIVE
1530 X1%= XO%:Y1%= YO%
1540 GOSUB 1030:HPLOT X2%,Y2%
1550 GOSUB 1010:HPLOT TO X2%,Y2%
1560 GOSUB 1050:HPLOT TO X2%,Y2%
1570 GOSUB 1070:HPLOT TO X2%,Y2%
1580 GOSUB 1110:HPLOT TO X2%,Y2%
1590 GOSUB 1090:HPLOT TO X2%,Y2%
1600 RETURN
1610 REM->SIX
1620 X1%= XO%:Y1%= YO%
1630 GOSUB 1010:HPLOT X2%,Y2%
1640 GOSUB 1090:HPLOT TO X2%,Y2%
1650 GOSUB 1110:HPLOT TO X2%,Y2%
1660 GOSUB 1070:HPLOT TO X2%,Y2%
1670 GOSUB 1050:HPLOT TO X2%,Y2%
1680 RETURN
1690 REM->SEVEN
1700 X1%= XO%:Y1%= YO%
1710 GOSUB 1010:HPLOT X2%,Y2%
1720 GOSUB 1030:HPLOT TO X2%,Y2%
1730 GOSUB 1110:HPLOT TO X2%,Y2%
1740 RETURN
1750 REM->EIGHT
1760 X1%= XO%:Y1%= YO%
1770 GOSUB 1010:HPLOT X2%,Y2%
1780 GOSUB 1090:HPLOT TO X2%,Y2%
1790 GOSUB 1110:HPLOT TO X2%,Y2%
1800 GOSUB 1070:HPLOT TO X2%,Y2%
1810 GOSUB 1050:HPLOT TO X2%,Y2%
1820 GOSUB 1010:HPLOT TO X2%,Y2%
1830 GOSUB 1030:HPLOT TO X2%,Y2%
1840 GOSUB 1070:HPLOT TO X2%,Y2%
1850 RETURN
1860 REM->NINE
1870 X1%= XO%:Y1%= YO%
1880 GOSUB 1110:HPLOT X2%,Y2%
1890 GOSUB 1030:HPLOT TO X2%,Y2%
1900 GOSUB 1010:HPLOT TO X2%,Y2%
1910 GOSUB 1050:HPLOT TO X2%,Y2%
1920 GOSUB 1070:HPLOT TO X2%,Y2%
1930 RETURN
1940 REM->DIGISECS
1950 IF SS% < 10 THEN S1%= 1:S2%= SS% + 1
1960 IF SS% >= 10 THEN S1%= INT(SS% / 10) + 1:S2%= SS% - FN TEN(SS%) + 1
1970 ON S1% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
1980 XO%= XO% + (DI% + INT(DI% / 4))
1990 ON S2% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
2000 RETURN
2010 REM->DIGIMINS
2020 IF MM% < 10 THEN M1%= 1:M2%= MM% + 1
2030 IF MM% >= 10 THEN M1%= INT(MM% / 10) + 1:M2%= MM% - FN TEN(MM%) + 1
2040 ON M1% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
2050 XO%= XO% + (DI% + INT(DI% / 4))
2060 ON M2% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
2070 RETURN
2080 REM->DIGIHOURS
2090 IF HH% < 10 THEN H1%= 1:H2%= HH% + 1
2100 IF HH% >= 10 THEN H1%= INT(HH% / 10) + 1:H2%= HH% - FN TEN(HH%) + 1
2110 ON H1% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
2120 XO%= XO% + (DI% + INT(DI% / 4))
2130 ON H2% GOSUB 1130, 1210, 1260, 1350, 1450, 1530, 1620, 1700, 1760, 1870
2140 RETURN
2150 REM->SECONDSARROWS
2160 AG= (SS% + 45) * (CI / 60) 
2170 X2= XO% + ( RY% * COS(AG) )
2180 Y2= YO% + ( RY% * SIN(AG) )
2190 X1= XO% + ( (RY%-6) * COS(AG) )
2200 Y1= YO% + ( (RY%-6) * SIN(AG) )
2210 HPLOT X1,Y1 TO X2,Y2
2220 RETURN 
2230 REM->MINUTESARROWS
2240 AG= (MM% + 45) * (CI / 60)
2250 X2= XO% + ( (RY%-10) * COS(AG) )
2260 Y2= YO% + ( (RY%-10) * SIN(AG) )
2270 X1= XO% + ( (RY%-40) * COS(AG) )
2280 Y1= YO% + ( (RY%-40) * SIN(AG) )
2290 HPLOT X1,Y1 TO X2,Y2
2300 RETURN
2310 REM->HOURSARROWS
2320 AG= (HH% + 9) * (CI / 12) 
2330 X2= XO% + ( (RY% - 18) * COS(AG) ) 
2340 Y2= YO% + ( (RY% - 18) * SIN(AG) )
2350 X1= XO% + ( (RY%-40) * COS(AG) )
2360 Y1= YO% + ( (RY%-40) * SIN(AG) )
2370 HPLOT X1,Y1 TO X2,Y2
2380 RETURN
2390 REM->SHOWSECONDE
2400 HCOLOR= 0
2410 XO%= 140:YO%= 80
2420 GOSUB 2160
2430 XO%= FN HDIGI(DI%) :YO%= 160
2440 XO% = XO% + ( DG% * 2 )
2450 GOSUB 1950
2460 HCOLOR= 3
2470 SS%= B3
2480 XO%= 140:YO%= 80
2490 GOSUB 2160
2500 XO%= FN HDIGI(DI%) :YO%= 160
2510 XO% = XO% + ( DG% * 2 )
2520 GOSUB 1950
2530 RETURN
2540 REM->SHOWMINUTE
2550 HCOLOR= 0
2560 XO%= 140:YO%= 80
2570 GOSUB 2240
2580 MM% = 88
2590 XO%= FN HDIGI(DI%) :YO%= 160
2600 XO% = XO% + DG%
2610 GOSUB 2020
2620 HCOLOR= 3
2630 MM%= B2
2640 XO%= 140:YO%= 80
2650 GOSUB 2240
2660 XO%= FN HDIGI(DI%) :YO%= 160
2670 XO% = XO% + DG%
2680 GOSUB 2020
2690 RETURN
2700 REM->SHOWHOUR
2710 HCOLOR= 0
2720 XO%= 140:YO%= 80
2730 GOSUB 2320
2740 HH% = 88
2750 XO%= FN HDIGI(DI%) :YO%= 160
2760 GOSUB 2090
2770 HCOLOR= 3
2780 HH%= B1
2790 XO%= 140:YO%= 80
2800 GOSUB 2320
2810 XO%= FN HDIGI(DI%) :YO%= 160
2820 GOSUB 2090
2830 RETURN
2840 REM->CLOCKDECORATION
2850 S5 = CI / 14
2860 FOR B7= 0 TO CI + 0.1 STEP S5
2870 V1= (RY% + 20) * COS(B7)
2880 V2= (RY% + 20) * SIN(B7)
2890 X2%= INT( XO% + V1 )
2900 Y2%= INT( YO% + V2 )
2910 IF B7 = 0 THEN HPLOT X2%,Y2%
2920 IF B7 > 0 THEN HPLOT TO X2%,Y2%
2930 NEXT
2940 S5 = CI / 6
2950 FOR B7= 0 TO CI + 0.1 STEP S5
2960 V1= (RY% - 46) * COS(B7)
2970 V2= (RY% - 46) * SIN(B7)
2980 X2%= INT( XO% + V1 )
2990 Y2%= INT( YO% + V2 )
3000 IF B7 = 0 THEN HPLOT X2%,Y2%
3010 IF B7 > 0 THEN HPLOT TO X2%,Y2%
3020 NEXT
3030 RETURN
3040 REM->CLOCKCIRCLE
3050 S4 = CI / 12
3060 FOR B6= (S4 * 9) TO ( CI + 0.1 ) + (S4 * 9) STEP S4
3070 V1= (RY% + 5) * COS(B6)
3080 V2= (RY% + 5) * SIN(B6)
3090 X2%= INT( XO% + V1 )
3100 Y2%= INT( YO% + V2 )
3110 HPLOT X2%,Y2%
3120 NEXT
3130 RETURN
3140 REM->SETCLOCK
3150 POKE 49168,0
3160 TEXT:HOME
3170 PRINT
3180 INPUT "HOUR 1/23 ? ";B1
3190 INPUT "MINUTE 1/59 ? ";B2
3200 INPUT "SECOND 1/59 ? ";B3
3210 IF B1 > 23 THEN B1= 23
3220 IF B1 < 0 THEN B1= 0
3230 IF B2 > 59 THEN B2= 59
3240 IF B2 < 0 THEN B2= 0
3250 IF B3 > 59 THEN B3= 59
3260 IF B3 < 0 THEN B3= 0
3270 GOSUB 570
3280 XO%= 140:YO%= 80
3290 GOSUB 2850
3300 GOSUB 3050
3310 GOSUB 2710
3320 GOSUB 2550
3330 GOSUB 2400
3340 RETURN
3350 REM->SETSECONDDURATION
3360 POKE 49168,0
3370 TEXT:HOME
3380 PRINT "ACTUAL DURATION: ";DE%
3390 INPUT "SECOND DURATION 1/1000 ?";DE%
3400 IF DE% <= 0 THEN DE%= 1
3410 GOSUB 570
3420 XO%= 140:YO%= 80
3430 GOSUB 2850
3440 GOSUB 3050
3450 GOSUB 2710
3460 GOSUB 2550
3470 GOSUB 2400
3480 RETURN
3490 REM->HELP
3500 POKE 49168,0
3510 TEXT:HOME
3520 VTAB(PEEK(37) + 2):
3530 S$= "     *** CLOCK  ***    ":GOSUB 890
3540 PRINT S$
3550 VTAB(PEEK(37) + 2):
3560 S$= "     *** BY LOZ ***    ":GOSUB 890
3570 PRINT S$
3580 VTAB(PEEK(37) + 2):
3590 S$= "Q-> QUIT               ":GOSUB 890
3600 PRINT S$
3610 VTAB(PEEK(37) + 2):
3620 S$= "H-> THIS HELP          ":GOSUB 890
3630 PRINT S$
3640 VTAB(PEEK(37) + 2):
3650 S$= "T-> SET TIME           ":GOSUB 890
3660 PRINT S$
3670 VTAB(PEEK(37) + 2):
3680 S$= "D-> SECOND DURATION    ":GOSUB 890
3690 PRINT S$
3700 VTAB(PEEK(37) + 2):
3710 S$= "S-> TOGGLE SOUND ON/OFF":GOSUB 890
3720 PRINT S$
3730 VTAB(PEEK(37) + 2):
3740 S$= "TYPE ENTER TO CONTINUE ":GOSUB 890
3750 PRINT S$
3760 GET S$
3770 RETURN
3780 REM->HELPBIS
3790 GOSUB 3500
3800 GOSUB 570
3810 XO%= 140:YO%= 80
3820 GOSUB 3050
3830 GOSUB 2850
3840 GOSUB 2710
3850 GOSUB 2550
3860 GOSUB 2400
3870 RETURN
