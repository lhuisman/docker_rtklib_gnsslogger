# HD9310 1hz for cmd
!HEX F1 D9 06 42 14 00 00 01 05 00 E8 03 00 00 60 EA 00 00 D0 07 00 00 C8 00 00 00 36 AF

# GPS+GLO+BDS+GAL Single frequency
#!HEX F1 D9 06 0C 04 00 17 24 04 00 55 6C

# GPS+GLO
#!HEX F1 D9 06 0C 04 00 13 24 00 00 4D 54

!WAIT 100

#disable GGA
!HEX F1 D9 06 01 03 00 F0 00 00 FA 0F
#disable GSA
!HEX F1 D9 06 01 03 00 F0 02 00 FC 13
#disable GSV
!HEX F1 D9 06 01 03 00 F0 04 00 FE 17 
#disable ZDA
!HEX F1 D9 06 01 03 00 F0 07 00 01 1D 
#disable RMC
!HEX F1 D9 06 01 03 00 F0 05 00 FF 19 

#track elev mask 0 navigation mask 5
!HEX F1 D9 06 0B 08 00 00 00 00 00 C2 B8 B2 3D 82 E2 

!WAIT 100
#enable RTCM messages
#1005@30
!HEX F1 D9 06 01 03 00 F8 05 1E 25 4F 
#Observations GPS 1077@1, GAL 1097@1, BDS1127@1
!HEX F1 D9 06 01 03 00 F8 4D 01 50 C2 
!HEX F1 D9 06 01 03 00 F8 61 01 64 EA 
!HEX F1 D9 06 01 03 00 F8 7F 01 82 26 
#Navigation messages GPS 1019@60, GAL 1046@60, BDS 1042@60
!HEX F1 D9 06 01 03 00 F8 13 3C 51 89 
!HEX F1 D9 06 01 03 00 F8 2D 3C 6B BD 
!HEX F1 D9 06 01 03 00 F8 2A 3C 68 B7 
#Set ECEF 3924698.12 301124.80 5001905.00
!HEX F1 D9 06 14 0C 00 34 9D 64 17 E0 7A CB 01 24 4D D0 1D F6 6B 

@
# set to 1hz
!HEX F1 D9 06 42 14 00 00 01 05 00 E8 03 00 00 60 EA 00 00 D0 07 00 00 C8 00 00 00 36 AF
