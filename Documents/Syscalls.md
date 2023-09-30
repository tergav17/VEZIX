# VEZIX Syscalls

System calls are executed by user programs by calling the syscall vector located at `HEADER+5`. The system call is selected by the current contents of the A register.

## 1: EXIT

Arguments:

- C = Status

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



A maximum of DE bytes are read into the buffer pointed to by HL from file descriptor C. It is not guaranteed that the maximum number of bytes will be read. In any case, the total number of bytes read will be returned by DE. If DE = 0, the end of file has been reached.



## 4: WRITE

Arguments:

- C = File descriptor

- DE = Number of bytes to read

- HL = Address of buffer

Returned Values:

- A = Returns >127 on an error

- DE = Number of bytes written



A maximum of DE bytes are written into the file descriptor C from the buffer pointed to be HL. As with READ, the number of bytes actually written will be returned in DE. It should be regarded as an error if this does not equal the original value.



Transfers on 512 byte boundaries are the most efficient when writing to files and block devices.



## 5: OPEN

Arguments:

- C = File open mode

- HL = Path to file

Returned Values:

- A = Returns >127 on an error

- C = File descriptor



Open a named file. A file can either be opened for reading (C = 0), writing (C = 1), or both (C = 2). HL points to a null-terminated string that represents the path to the file.



## 6: CLOSE

Arguments:

- C = File descriptor

Returned Values:

- A = Returns >127 on an error



Closes a single file.



## 7: WAIT

Arguments:

- C = None

Returned Values:

- A = Returns >127 on an error

- C = Status

- DE = Process ID



When called, the process will sleep until one of its child processes terminates. If any child processes have died since the last wait, the return is immediate. Calling the function with no child processes will result in an error.



## 8: CREAT