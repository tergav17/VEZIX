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



## 3: READ

Arguments:

- 