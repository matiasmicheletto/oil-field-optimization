# Oil field optimization

This repository provides the source code for a command-line based optimization software.  

## Problem description
The program computes the optimal selection of pumpjacks whose rates must be adjusted in order to increase or reduce the total gross production of an oil field, while maximizing the total net production.  

In some way, the problem is similar to the subset sum problem, as a subset of wells must be chosen to minimize the subset size and maximize the net values.  

This problem becomes relevant when the field production is limited by the storing battery, and production rate (in m³/day) needs to be modified.  

## Preparing the system model

To compile the program use:
```bash
make VERBOSE=true
```
The ```VERBOSE``` argument is used to print loging and debugging data

## Running the model optimization

To solve the model ```wells.csv``` and ```distances``` for a goal target of 1500 m³/day +/- 50 m³/day gross, use:
```bash
optimize -p wells.csv -d distances.csv -o results.csv -g 1500 -l 50 -t 120  
```
The ```t``` argument is used as timeout in seconds. In this case is configured to 2 minutes.
This will print the output to the ```results.csv``` file.


## Automate analysis of multiple instances
A python script can be used to automate the program compilation and execution of a batch of runs with different configurations.

For example, [this python script](python/paretoPlot.py) runs multiple configurations and reads the results from the .csv file to make a chart of the resulting Pareto Front plots.