#***************************************************#
# Clean Work Library
#***************************************************#
if [file exists "work"] {vdel -all}
vlib work

#***************************************************#
# Start a new Transcript File
#***************************************************#
#transcript file log/fifo_run_log.log
# better make one for each test

#***************************************************#
# Compile RTL and TB files
#***************************************************#
vlog -f fifo_dut.f
vlog -f fifo_tb.f

#***************************************************#
# Optimizing Design with vopt
#***************************************************#
vopt fifo_top -o top_opt -debugdb  +acc +cover=sbecf+synch_fifo(rtl).

#***************************************************#
# Simulation of a Test
#***************************************************#
transcript file log/fifo_test.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=fifo_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value fifo_test
coverage save coverage/fifo_test.ucdb

#***************************************************#
# Close the Transcript file
#***************************************************#
transcript file ()

#***************************************************#
# save the coverage in text files
#***************************************************#

vcover report coverage/fifo_test.ucdb -cvg -details -output coverage/fun_coverage.txt
vcover report coverage/fifo_test.ucdb  -output coverage/code_coverage.txt