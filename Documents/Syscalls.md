# VEZIX Syscalls



## 1: EXIT

Arguments:

- A = Status

Returned Values:

- None



Terminates the current process



## 2: FORK

Arguments:

- None

Returned Values:

- A: Returns 0 if the process if a child, 1 if the parent process, and >127 on an error



Spawns a new process. The parent process's core image is duplicated to create the child process. The value returned in A is the only difference between the two processes. Additionally, all open files that previously existed are shared between parent and child processes. 



## 3: READ

Arguments:

- C = File descriptor

- DE = Number of bytes to read

- HL = Address of buffer

Returned Values:

- A = Returns >127 on an error

- DE = Number of bytes read