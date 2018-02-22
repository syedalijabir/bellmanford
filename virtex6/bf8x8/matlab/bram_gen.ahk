#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#space::
;6
count := 1
mystring = BRAM_
loop 5
{
click 10,105
;12
winwaitactive New Source Wizard
click 82 ,192
click 410,291
send %mystring%%count%
click 615,530
;18
sleep 3000  ; 
click 615,530
click 615,530
;sleep 500
;if (winexist ISE Project Navigator)
;{
;click 288,141
;}
winwaitactive Block Memory Generator
winmove, 136,2
;24
click 797,711	; Next
click 729,155	; click dropdown menu
sleep 200	; Wait for dropdown menu
click 729,206	; select "True Dual Port"
sleep 200
;30
click 797,711	; Next
click 552,185	; Click on "Write Width"
Send {Backspace}{Backspace}
Send 32		; 32 bit wide data
click 552,210	; click on "Write Depth"
;36
Send {Backspace}{Backspace}
Send 1024
click 797,711	; Next
sleep 500
;click 442,522	; CheckBox "Load Init File"
;42
;click 626,552	; click to enter path for .coe file
;loop 18
;{
;send {Backspace}
;}
;48
;Send D:\Research_Paper_Work\ShortestPath_Fpga\Verilog_Synthesis\Shortest_path\Row%count;%.coe
count := count + 1
;click 797,711	; Next
;click 797,711	; Next
click 886,710	; Generate
sleep 80000	; Wait for Xilinx to create BRAM
;54

}



;60
;Size of Image = 1080,768