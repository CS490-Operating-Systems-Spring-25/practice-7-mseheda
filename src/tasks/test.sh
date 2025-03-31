#!/bin/bash
 
 aarch64-linux-gnu-as -o task-1.o part-1.S
 aarch64-linux-gnu-ld -o task task-1.o
 ./task
 echo -e $"\nReturn code {$?}"
