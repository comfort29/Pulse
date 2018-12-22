;
; Pulse_Seekers - Compare and Search functions
;

Structure SK
  StructureUnion
    b.b
    w.w
    l.l
    i.i
  EndStructureUnion
EndStructure

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  #EOL_SIZE=2
  Procedure Pulse_Seeker_NextEol(*seeker.sk, *seeker_end)
    While *seeker < *seeker_end  And *seeker\w <> 2573    ; 0D 0A
      *seeker+1
    Wend
    ProcedureReturn *seeker
  EndProcedure
CompilerElse
  #EOL_SIZE=1
  Procedure Pulse_Seeker_NextEol(*seeker.sk, *seeker_end)
    While *seeker < *seeker_end  And *seeker\b <> 10      ; 0A
      *seeker+1
    Wend
    ProcedureReturn *seeker
  EndProcedure  
CompilerEndIf

Macro Pulse_Seeker_Compare(Mem1, Mem2, Size)    ; We can't improve on PB's function, so wrap to macro.
  CompareMemory(Mem1, Mem2, Size)
EndMacro

ProcedureDLL Pulse_Seeker_CompareNC(*MemAdr1.byte, *MemAdr2.byte, size.l)   ; A no-case memory compare function.
  Protected *MemChr1.byte, *MemChr2.byte
  
  If size>0
    While size>0
      *MemChr1 = ?MCNC_data + *MemAdr1\b
      *MemChr2 = ?MCNC_data + *MemAdr2\b
      If *MemChr1\b <> *MemChr2\b
        ProcedureReturn #False
      EndIf
      *MemAdr1+1 : *MemAdr2+1
      size-1
    Wend
    ProcedureReturn #True
  EndIf
EndProcedure

DataSection
  MCNC_data:
  Data.a   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15 ; chr table - A=a etc..
  Data.a  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31
  Data.a  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47
  Data.a  48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63
  Data.a  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79
  Data.a  80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95
  Data.a  96,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79
  Data.a  80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90, 123, 124, 125, 126, 127
  Data.a 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
  Data.a 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
  Data.a 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
  Data.a 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
  Data.a 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
  Data.a 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
  Data.a 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
  Data.a 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
EndDataSection

Procedure Pulse_Seeker_SkipSpace(*seeker.sk)
  While *seeker\b = 32 Or *seeker\b = 9
    *seeker+1
  Wend
  ProcedureReturn *seeker
EndProcedure

Procedure Pulse_Seeker_FindByte(*seeker.sk, byte.b)
  While *seeker\b <> byte
    *seeker+1
  Wend
  ProcedureReturn *seeker  
EndProcedure
