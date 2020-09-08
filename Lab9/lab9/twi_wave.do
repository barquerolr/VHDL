onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /twi_testbench/CLK_sig
add wave -noupdate /twi_testbench/RESET_sig
add wave -noupdate /twi_testbench/A_I_sig
add wave -noupdate /twi_testbench/D_I_sig
add wave -noupdate /twi_testbench/MSG_I_sig
add wave -noupdate /twi_testbench/STB_I_sig
add wave -noupdate /twi_testbench/DONE_O_sig
add wave -noupdate /twi_testbench/ERR_O_sig
add wave -noupdate /twi_testbench/SCL_sig
add wave -noupdate /twi_testbench/SDA_sig
add wave -noupdate /twi_testbench/D_O_sig
add wave -noupdate /twi_testbench/LED_sig
add wave -noupdate /twi_testbench/DUT/state
add wave -noupdate /twi_testbench/DUT/busState
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {198048 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
configure wave -valuecolwidth 71
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {315 us}
