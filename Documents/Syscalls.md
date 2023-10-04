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

Arguments:

- BC = File create mode

- HL = Path to file

Returned Values:

- A = Returns >127 on an error

- C = File descriptor



Creates a new file or re-creates an existing file. If the file already exist, it maintains its existing mode and is truncated to 0 bytes long. If the file does not exist, it is given the mode found in the BC register. The format of the mode is the same as the CHMOD syscall.



Additionally, the syscall will return a new file descriptor that is open to writing. This is regardless of what the mode has been set to.



## 9: LINK

Arguments:

- DE = Path #1

- HL = Path #2

Returned Values:

- A = Returns >127 on an error



Creates a symbolic link from path #2 to the file at pointed to by path #1. Both files must be on the same file system.



## 10: UNLINK

Arguments:

- HL = Path to file

Returned Values:

- A = Returns >127 on an error



Removes a symboliclink to a file. If all links to a file are removed, than the file is destroyed and its contents deallocated. If a file is currently open when this happens, it will be postponed until the file is closed.



## 11: EXEC

Arguments:

- DE = Path to executable file

- HL = Argument list

Returned Values:

- A = Returns >127 on an error



Replaces the current core image with a new one from an executable file. After that, execution is started at the beginning of the image. The original core image is lost. Files will remain open across exec calls, as will ignored signals. Any caught signal is reset, however. 



The argument list takes the form of an array of pointers to null terminated strings. The pointer array itself it also null terminted. This argument list will be copied to the top of the stack in the new core image.



## 12: CHDIR

Arguments: 

- HL = Path to directory

Returned Values:

- A = Returns >127 on an error



Changes to working path to the directory pointed to by register HL. 



## 13: TIME

Arguments:

- None

Returned Values:

- A = 0

- BC = Lower 16 bits of time

- DE = Upper 16 bits of time



Returns the number of seconds since 00\:00\:00 GMT, Janurary 1st, 1970. Value is unsigned.



## 14: MKNOD

Arguments:

- BC = File mode

- DE = Major / minor number

- HL = Path to file

Returned Values:

- A = Returns >127 on an error



Creates a new special file or directory. The type of file creates depends on the contents of mode value in register BC. If a special file is create, it will be given the major / minor number of DE. Only the superuser may execute this function.



## 15: CHMOD

Arguments:

- BC = File mode

- HL = Path to file

Returned Values:

- A = Returns >127 on error 



Changes the mode of a file. The mode can only be changed by the superuser or owner of the file. The mode bits are as follows:

         4000 set user ID on execution
         2000 set group ID on execution
         0400 read by owner
         0200 write by owner
         0100 execute (search on directory) by owner
         0070 read, write, execute (search) by group
         0007 read, write, execute (search) by others

## 16: CHOWN

Arguments:

- B = New owner

- C = New group

- HL = Path to file

Returned Values:

- A = Returns >127 on error



Updates the owner and group of a given file. Only the superuser may execute this function.



## 17: BREAK

Arguments:

- HL = Address of break

Returned Values:

- A = Returns >127 on error



Changes the break of the current executable. Any data that is above the break and below the stack is off-limits to the user program, and is liable to overwriting at any time. The break defaults to the top of the BSS section.



## 18: STAT

Arguments:

- DE = Address of buffer

- HL = Path to file

Returned Values:

- A = Returns >127 on error



Transfers the on-disk inode record of the given file to the address pointed to by DE.



TODO: Include struct of on-disk inode



## 19: LSEEK

Arguments:

- B = Ptrname

- C = File descriptor

- DE = Lower 16 bits of offset

- HL = Upper 16 bits of offset

Returned Values:

- A = Returns >127 on error

- DE = Lower 16 bits of pointer

- HL = Upper 16 bits of offset



Changes the read pointer for an open file. The value of register B determines what effect the offset has on the pointer.

- 0: Pointer is set to offset

- 1: Pointer is set to current location + offset

- 2: Pointer is set to size of file + offset



## 20: GETPID

Arguments:

- None

Returned Values:

- A = Returns >127 on error

- BC = ID of current process



Returns the PID of the current process.



## 21: MOUNT

Arguments:

- C = Read/write flag

- DE = Major / minor number

- HL = Mount path

Returned Values:

- A = Returns >127 on error



Mounts a block device onto the file system. The new file system will need to be mounted onto a path in the existing file system. This path must exist as a directory, file, or special file. When the new file system is mounted, the mount point on the old file system will become inaccessable.



The register C should be set to 0 if the file system can be written to. Read-only block devices must be mounted with writing disabled to avoid errors.



## 22: UMOUNT

Arguments:

- BC = Major / minor number

Returned Values:

- A = Returns >127 on error



Signals to the operating system that a block device should be un-mounted from the file system. All buffers will be written, and the original mount point will revert to its original state. 



## 23: SETUID

Arguments:

- C = User ID

Returned Values:

- A = Returns >127 on error



Sets the user ID of the current process. Both the effective and the real user ID are set. Only the superuser may execute this function, or if register BC is the real user ID.



## 24: GETUID

Arguments:

- None

Returned Values:

- A = Returns >127 on error

- B = Effective user ID

- C = Real user ID



Returns the effective and real user ID of the current process.



## 25: STIME

Arguments:

- BC = Lower 16 bits of time

- DE = Upper 16 bits of time

Returned Values:

- A = Returns >127 on error



Sets the current time. Same format as TIME syscall. Only the superuser may execute this function.



## 28: FSTAT

Arguments:

- C = File descriptor

- DE = Address of buffer

Returned Values:

- A = Returns >127 on error



Operates the same as the STAT function, but uses a file descriptor instead of a file path.



## 31: IOCTL

Arguments:

- C = File descriptor

- DE = Request #

- HL = Address of buffer

Returned Values:

- A = Returns >127 on error



Replaces the STTY and GTTY function calls. The actual operation depends on the character device being operated on. Requests can both read and write from the buffer.



## 34: NICE

Arguments:

- C = Process priority

Returned Values:

- A = Returns >127 on error



Sets the priority of the process.



## 35: SLEEP

Arguments:

- BC = Number of seconds to sleep

Returned Values:

- A = Returns >127 on error



Sets the process to sleep for a certain amount of seconds.



## 36: SYNC

Arguments:

- None

Returned Values:

- A = Returns >127 on error



Writes out all of the buffers in core. Prepares the file system for shutdown.



## 37: KILL

Arguments:

- BC = Process ID to kill

Returned Values:

- A = Returns >127 on error



Sends a kill signal to a process. The process must have the same effective ID, otherwise the function is restricted to the superuser. 



## 41: DUP

Arguments:

- C = Original file descriptor

Returned Values:

- A = Returns >127 on error

- B = New file descriptor



Duplicates a file descriptor. The new file descriptor will take the lowest available slot.



## 42: PIPE

Arguments:

- None

Returned Values:

- A = Returns >127 on error

- B = Read pipe descriptor

- C = Write pipe descriptor



Creates a new symbolic pipe. Data written to the pipe will be buffered, after that the writing process will be suspended.



## 46: SETGID

Arguments:

- C = New group ID

Returned Values:

- A = Returns >127 on error



Sets the group ID of the current process. Both the effective and the real group ID are set. Only the superuser may execute this function, or if register BC is the real group ID.



## 47: GETGID

Arguments:

- None

Returned Values:

- A = Returns >127 on error

- B = Effective group ID

- C = Real group ID



Returns the effective and real group ID of the current process.