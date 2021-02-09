onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /VDP1_tb/VDP1/CE_R
add wave -noupdate /VDP1_tb/VDP1/CE_F
add wave -noupdate /VDP1_tb/VDP1/VRAM_A
add wave -noupdate /VDP1_tb/VDP1/VRAM_D
add wave -noupdate /VDP1_tb/VDP1/VRAM_Q
add wave -noupdate /VDP1_tb/VDP1/VRAM_WE
add wave -noupdate /VDP1_tb/VDP1/VRAM_RD
add wave -noupdate /VDP1_tb/VDP1/CMD_ST
add wave -noupdate /VDP1_tb/VDP1/CMD_READ
add wave -noupdate /VDP1_tb/VDP1/CMD_ADDR
add wave -noupdate -expand /VDP1_tb/VDP1/CMD
add wave -noupdate /VDP1_tb/VDP1/EDSR.CEF
add wave -noupdate /VDP1_tb/VDP1/COPR
add wave -noupdate /VDP1_tb/VDP1/SYS_CLIP
add wave -noupdate /VDP1_tb/VDP1/USR_CLIP
add wave -noupdate /VDP1_tb/VDP1/LOC_COORD
add wave -noupdate /VDP1_tb/VDP1/VRAM_ST
add wave -noupdate /VDP1_tb/VDP1/VRAM_DONE
add wave -noupdate /VDP1_tb/VDP1/CMD_JRET
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6270 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {6059 ns} {6559 ns}
