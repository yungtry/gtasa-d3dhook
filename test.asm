[ENABLE]

aobscanmodule(INJECT,gta_sa.exe,68 08 02 00 00 E8 76)
alloc(newmem,$1000)

label(code)
label(return)

newmem:

code:
  push 0000022F
  jmp return

INJECT:
  jmp newmem
return:
registersymbol(INJECT)

[DISABLE]

INJECT:
  db 68 08 02 00 00

unregistersymbol(INJECT)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: "gta_sa.exe"+3A530

"gta_sa.exe"+3A51E: 90                    -  nop 
"gta_sa.exe"+3A51F: 90                    -  nop 
"gta_sa.exe"+3A520: 68 C9 01 00 00        -  push 000001C9
"gta_sa.exe"+3A525: E8 86 FB FF FF        -  call gta_sa.exe+3A0B0
"gta_sa.exe"+3A52A: 59                    -  pop ecx
"gta_sa.exe"+3A52B: C3                    -  ret 
"gta_sa.exe"+3A52C: 90                    -  nop 
"gta_sa.exe"+3A52D: 90                    -  nop 
"gta_sa.exe"+3A52E: 90                    -  nop 
"gta_sa.exe"+3A52F: 90                    -  nop 
// ---------- INJECTING HERE ----------
"gta_sa.exe"+3A530: 68 08 02 00 00        -  push 00000208
// ---------- DONE INJECTING  ----------
"gta_sa.exe"+3A535: E8 76 FB FF FF        -  call gta_sa.exe+3A0B0
"gta_sa.exe"+3A53A: 59                    -  pop ecx
"gta_sa.exe"+3A53B: C3                    -  ret 
"gta_sa.exe"+3A53C: 90                    -  nop 
"gta_sa.exe"+3A53D: 90                    -  nop 
"gta_sa.exe"+3A53E: 90                    -  nop 
"gta_sa.exe"+3A53F: 90                    -  nop 
"gta_sa.exe"+3A540: 68 1B 02 00 00        -  push 0000021B
"gta_sa.exe"+3A545: E8 66 FB FF FF        -  call gta_sa.exe+3A0B0
"gta_sa.exe"+3A54A: 59                    -  pop ecx
}