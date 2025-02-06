| Command | Description | Option | Option Description |
|---------|-------------|--------|--------------------|
| `ls` | List of files and directories | `-l` | Provide detailed info about files and directories |
|  |  | `-a` | Include hidden files in the list |
|  |  | `-h` | Display files and their sizes |
| `cd` | Change directory | `-` | Switch to the previous directory |
|  |  | `~` | Switch to the home directory |
| `pwd` | Print path of current working directory | `-L` | Print logical path of the current directory |
|  |  | `-P` | Print physical path of current directory |
| `cat` | Concatenate – display content of file/s | `-n` | Number all the output lines |
|  |  | `-b` | Number all non-blank output lines |
| `touch` | Create a new empty file or update the timestamp | `-a` | Change access time only |
|  |  | `-m` | Change modification time only |
| `rm` | Remove files or directories | `-r` | Recursive deletion – delete a directory and everything in it |
|  |  | `-f` | Forcefully remove files and directories |
| `mkdir` | Create a new, empty directory | `-p` | Create subdirectories too |
|  |  | `-m` | Set permission modes to the directory |
| `rmdir` | Remove empty directories |  |  |
| `cp` | Copy files and directories | `-r` | Recursive mode – copy directory and its contents |
|  |  | `-i` | Interactive mode to prompt user confirmation before overwriting existing files |
|  |  | `-n` | “No clobber” – prevents `cp` command from overwriting existing files |
| `mv` | Move directories and files | `-i` | Interactive mode, prompt user for confirmation |
|  |  | `-n` | “No clobber” – prevents `mv` command from overwriting existing files |
| `find` | Search for files or string of characters | `-name` | Display files or directories that match the name |
|  |  | `-type` | Filter files based on their type |
|  |  | `-size` | Search files based on their size |
| `sort` | Sort lines of text | `-n` | Sort lines based on numerical value |
|  |  | `-r` | Reverse the sorting order |
| `gzip` | Decompress a compressed file | `-d` | Decompress a compressed file |
| `head` | Preview beginning section of a text file | `-n [num]` | Show the first [num] number of lines |
|  |  | `-c [num]` | Show the first [num] bytes of a file |
| `tail` | Show the end of a file | `-n [num]` | Show the last [num] number of lines |
|  |  | `-c [num]` | Show the last [num] bytes of a file |
