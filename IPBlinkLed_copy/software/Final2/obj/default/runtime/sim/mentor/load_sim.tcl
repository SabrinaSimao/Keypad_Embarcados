# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force E:/Users/sabrina/Documents/GitHub/Keypad_Embarcados/IPBlinkLed_copy/software/Final2/mem_init/hdl_sim/niosHello_onchip_memory2_0.dat ./ 
file copy -force E:/Users/sabrina/Documents/GitHub/Keypad_Embarcados/IPBlinkLed_copy/software/Final2/mem_init/hdl_sim/niosHello_program_memory.dat ./ 
file copy -force E:/Users/sabrina/Documents/GitHub/Keypad_Embarcados/IPBlinkLed_copy/software/Final2/mem_init/niosHello_onchip_memory2_0.hex ./ 
file copy -force E:/Users/sabrina/Documents/GitHub/Keypad_Embarcados/IPBlinkLed_copy/software/Final2/mem_init/niosHello_program_memory.hex ./ 
