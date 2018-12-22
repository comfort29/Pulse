
;
; Pulse_Seeker
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
    While *seeker<*seeker_end  And *seeker\w <> 2573
      *seeker+1
    Wend
    ProcedureReturn *seeker
  EndProcedure
CompilerElse
  #EOL_SIZE=1
  Procedure Pulse_Seeker_NextEol(*seeker.sk, *seeker_end)
    While *seeker<*seeker_end  And *seeker\b <> 10
      *seeker+1
    Wend
    ProcedureReturn *seeker
  EndProcedure  
CompilerEndIf

Macro Pulse_Seeker_Compare(Mem1, Mem2, Size)
  CompareMemory(Mem1, Mem2, Size)
EndMacro

Procedure Pulse_Seeker_SkipSpace(*seeker.sk)
  While *seeker\b = 32 Or *seeker\b = 9
    *seeker+1
  Wend
  ProcedureReturn *seeker
EndProcedure

Procedure Pulse_Seeker_FindByte(*seeker.sk, byte.b)
  While *seeker\b<>byte
    *seeker+1
  Wend
  ProcedureReturn *seeker  
EndProcedure
