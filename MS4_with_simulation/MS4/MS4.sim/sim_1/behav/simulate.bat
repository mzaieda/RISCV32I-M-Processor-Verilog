@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim RISCVHandler_tb_behav -key {Behavioral:sim_1:Functional:RISCVHandler_tb} -tclbatch RISCVHandler_tb.tcl -view C:/Users/CSE.CAL/Desktop/omar2/MS4/RISCVHandler_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
