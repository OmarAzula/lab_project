# Guidelines
This repository contains code for 1,2 and 3 stage pipeline processor converted from a 32-bit single cycle processor.

## Circuit Diagram of a 3 stage piple converted from a single cycle processor 

![SCP_TO_3StagePipileine drawio](https://github.com/OmarAzula/lab_project/assets/131664202/127294e8-28b6-4d83-8bf9-8f6b596ad3b4)

## Compilation


project can compiled with the command: 

``` 
vlog names_of_all_system_verilog_files
```

or simply:

``` 
vlog *.sv 
```

Compilation creates a ``` work ``` folder in your current working directory in which all the files generated after compilation are stored.
 
## Simulation

The compiled project can be simulated with command:

``` 
vsim -c name_of_toplevel_module -do "run -all"
```

Then
``` 
vsim -c top_processor
``` 

Simulation creates a ``` .vcd ``` file. This files contains all the simulation behaviour of design.

## Viewing the VCD Waveform File

To view the waveform of the design run the command:

```
gtkwave dumpfile_name.vcd
```
Here dumpfile_name will be ```processor.vcd```

This opens a waveform window. Pull the required signals in the waveform and verify the behaviour of the design.


