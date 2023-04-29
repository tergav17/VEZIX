# Crude hack to set a breakpoint at PC+3, clears existing breakpoints
# The SIMH debugging setup really sucks ngl

ex pc
break $/4
step
go
nobreak all
reg
