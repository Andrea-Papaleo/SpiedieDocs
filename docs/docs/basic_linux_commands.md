---
title: Useful Linux Commands
layout: default
images: []
tags: [Login, Setup, Configuration, New_User]
description: Some useful Linux commands.
category: documentation
---




### Table of Contents  

 1. [Getting Help](#getting_help)
 2. [Exploring Files and Directories](#exploring_directories)
 3. [Manipulating Files and Directories](#manipulating_files_directories)
 4. [Redirection](#redirection)
 5. [Processes and Jobs](#processes_jobs)
 6. [Other Helpful Commands](#other)
 7. [Editors](#editors)
   

 


## <a name="getting_help"></a>1 - Getting Help






As we go through this documentation, we well briefly go over various different command and try to give the just enough information so that the user can be comfortable using it. As a result much about each command will be omitted, such as various options and full descriptions of possible uses. Luckily it is easy to quickly find out more about a command you wish to use.



### <a name="manuals"></a> 1.1 - Manuals




#### <a name="man"></a> man

The manual pages tell you which options a particular command can take, and how each option modifies the behavior of the command. For instance, to learn about the **ls** command, type

```bash
man ls
```
this will give you full documentation of the **ls** command. You can leave the manual page by simply typing **q**






#### <a name="whatis"></a> whatis

If, however you only want a brief description of the command you can type

```bash
whatis ls
```





#### <a name="apropos"></a> apropos

If you aren't sure of the exact name of a command, but have an idea of what your looking for, you can type

```bash
apropos keyword
```
This will list all the commands that have the keyword in their manual page header.

For example, type

```bash
apropos list
```
Again, type **q** to exit.





## <a name="exploring_directories"></a>2 - Exploring Files and Directories




### <a name="listing_files_and_directories"></a> 2.1 - Listing Files and Directories




#### <a name="ls"></a> ls

The **ls** command (short for list) lists the contents of the current working directory. To find out what is in your current directory, type

```bash
ls
```

You can also provide the **ls** command with a path to some directory, and it will list the files in that directory. You can see this by typing

```bash
ls path/to/dir/
```

By default the ls command only lists the names of folders and directories. It will also only list files which are not prefixed with a dot (**.**), a.k.a hidden files. Getting more information from the **ls** command requires the usage of flags, some common ones are given below.

##### Common Flags

| Syntax | Description |
| ------ | ----------- |
| -F    | distinguishes directories |
| -a    | shows hidden files/directories (written as .file/.dir) |
| -l     | shows detailed information about files |
| -lt     | Same as -l, except sorted by date/time |
| -lth    | same as -lt, but cleaner |







### <a id="making_directories"></a> 2.2 - Making Directories






#### <a name="mkdir"></a> mkdir 

The **mkdir** command (short for make directory) is used to create subdirectories in your filesystem. This is useful for organizing your workflow and keeping files separated. To make a new subdirectory called learn_unix in you current directory, type

```bash
mkdir learn_unix
```
You can check to see the directory has been created by using the **ls** command.





### <a id="changing_directories"></a> 2.3 - Changing Directories







#### <a name="cd"></a> cd

The **cd** command (short for change directory) changes the current working directory to the directory specified in the command. To change the current working directory to the one you just created, **learn_unix**, type

``` bash
cd learn_unix
```
If you now type **ls** you will see that this directory is empty.




### <a id="._and_.."></a> 2.4 - The Directories (.) and (..)






If you haven't yet tried using the **-a** flag with the **ls** command, you can do so now in the **learn_unix** directory, type

```bash
ls -a
```

You can see that even though the directory is supposed to be empty, there are two special directories there, (**.**) and (**..**).





#### <a name="current_dir"></a> The current directory (.)

In UNIX, the special directory (**.**) is short for the current directory, so when you type

``` bash
cd .
```
you don't move anywhere in the file system. While this might not be useful for changing directories, having a shorthand for the current directory will be useful in many other commands.





#### <a name="parent_dir"></a> The parrent directory (..)

The other special directory (**..**) we see when running **ls -a** is shorthand for the parent or the current directory. Typing

``` bash
cd ..
```
will move you to one directory up in the file system's hierarchy. If you typed this from the **learn_unix** directory, this will take you to the home directory.





### <a id="pathnames"></a> 2.5 - Path Names







#### <a name="pwd"></a> pwd

The **pwd** command (short for print working directory) gives you the full path of your current working directory. This is useful for knowing exactly where you are in your file system. This command will be particularly useful when transferring files to and from the cluster, as those operations will require the full path of the file or directory to be transferred. To get the full path of your home directory, type **cd** if you are not yet in your home directory, then type

``` bash
pwd
```
The path printed by this command is your full path.




#### <a name="tilde"></a> ~ (home directory)

You can reference your home directory anywhere in the file system by using the tilde (**~**) shorthand. So say you move to some directory deep in the hierarchy **cd path/deep/in/the/hierarchy** and you want to list the contents of your home directory. You can do that by typing

``` bash
ls ~
```
Or you can also change to a subdirectory of the home directory using the **cd** command like so

```bash
cd ~/learn_unix
```




## <a name="manipulating_files_directories"></a>3 - Manipulating Files and Directories





### <a name="creating_files"></a> 3.1 - Creating Empty Files






#### <a name="touch"></a>  touch

The **touch** command is used to update timestamps on files. Every file in the unix system has timestamp information for each file or folder including access time, modify time and change time. It is possible to modify timestamps using the touch command either to update a timestamp to the current time or to modify it to a date in the past.

If the specified file doesn't exist, the **touch** command will create that file and set the access and modification time for the file to the current time. To create a file type

```bash
touch file1
```


### <a name="copying_files"></a> 3.2 - Copying  Files







#### <a name="cp"></a>  cp

The **cp** command (short for copy) makes a copy of a file. Say we had some file called **file1** in the current directory, and we wanted to create a copy of this file in the same directory called **file1**, we could achieve this by typing

```bash
cp file1 file2
```
If, for instance, we had some file in our home directory, and we wanted to copy it to our **learn_unix** directory while keeping the same name, we could do this in one of two ways depending on where we are in the file system. If we are in the **home directory**, type

```bash
cp file1 learn_unix/
```
If instead we are currently in the **learn_unix** directory, we would type

```bash
cp ../file1 .
```
or
```bash
cp ~/file1 .
```
Notice the difference in these two commands. In the former we use the (**..**) shorthand to specify that **file1** is located one folder up in the hierarchy. In the latter we use the (**~**) for the home directory, which allows us to access **file1** regardless of where we are in the file system as long as **file1** is in the home directory.

Also note that in both instances we use the (**.**) shorthand to specify that we are copying the file into our current directory.





### <a name="moving_files"></a> 3.3 - Moving  Files






#### <a name="mv"></a>  mv

The **mv** command (short for move) moves a file from one place to another. This differs from the **cp** command in that in the end there is still only one file. If we wanted to move **file1** to **file2** we could type

```bash
mv file1 file2
```

This effectively renames the file from **file1** to **file2**.

Alternatively, if **file1** is in the home directory and we want to move it to the **learn_unix** directory, we would type

```bash
mv file1 learn_unix/
```
provided we were working from the home directory.




### <a name="removing_files_directories"></a> 3.4 - Removing  Files and Directories







#### <a name="rm"></a>  rm

The **rm** command (short for remove) is used to delete a file or directory. If we has a file called **file1** and we wanted to delete it, we would type

```bash
rm file1
```

The **rm** command also works on directories, however the command differs a little when deleting and empty directory vs. a non-empty directory. To remove an empty directory, **dir1**, type

```bash
rm dir1
```
Now if **dir1** is not empty, we would need to use the **-r** flag. The **-r** flag stands for recursive, and it means "delete this directory and everything in it". So to delete the non-empty directory **dir1**, type

```bash
rm -r dir1
```
***USE CAUTION: REMOVING FILES IN THIS WAY WILL PERMANENTLY DELETE THEM***




### <a name="viewing_files"></a> 3.5 - Viewing Files in the Teminal







There are a handful of commands that let you view a file, or portions of a file without having to open an editor. Before we get into those, its useful to start with a cleared terminal window. To do that, we can use the command **clear**





#### <a name="clear"></a>  clear

The **clear** command will clear all the text in the terminal window, leaving you with a fresh view. To clear you window, type

```bash
clear
```
Once the window is clear, we can start viewing files.



#### <a name="cat"></a>  cat

The **cat** command (short for concatenate) allows you to view contents of a file called **file1** on the screen. Type

```bash
cat file1
```
You can also view multiple files by listing them after **cat**.

If you run the cat command without specifying a file to read, it reads the standard input (the keyboard), and on receiving the 'end of file' (^D), copies it to the standard output (the screen). We will use this later when talking about redirection.


#### <a name="less"></a> less

The **less** command writes a file to the screen one page at a time. Type

```bash
less file1
```

Once the file is displayed, you can use the keyboard to navigate.

| Key | Navigation |
| ----| ---|
| **space-bar** | view next page |
| **b** | go back one page |
| **enter** | scroll down one line |
| **=** | displays information such as line numbers and percentage read |
| **/*word*** | searches for the word ***word*** following the backslash |
| **n** | after searching for a worn, n will search for the next occurrence |
| **q**  | quit reading |



#### <a name="head"></a> head

The command **head** will display the first few lines of a file. Type

```bash
head file1
```
By default, the fist 10 lines of **file1** are shown, but you can specify the number of lines to show by using the **-n** flag followed by the number.

#### <a name="tail"></a> tail

The command **tail** works in the same way as the **head** command except that it displays the last few lines of a file. Type

```bash
tail file1
```

The next two command are useful when trying to compare two files.



#### <a name="diff"></a> diff

The diff command (short for difference) compares the contents of two files and displays the differences. To find the difference between **file1** and **file2** you would type

```bash
diff file1 file2
```
In the output, lines from **file1** will be denoted by **<** and lines from **file2** will be denoted by **>**.




#### <a name="paste"></a> paste

The paste command displays the contents of two or more files next to each-other line by line. To view **file1** and **file2**, type

```bash
paste file1 file2 
```



### <a name="searching_files"></a> 3.6 - Searching Files




We've already seen how we can search for specific words in a file by first viewing the file with the **less** command, then typing **/** followed by the word we wish to find, but what if we don't want to use **less**, or what if what we're searching is not a file, but the output of another command (more on this in later sections). There is a more general way to search in the terminal, and that is using the **grep** command.





#### <a name="grep"></a> grep

The **grep** command (short for global regular expression print) is one of many standard UNIX utilities. It searches for specified words or patterns and displays the lines containing them to the screen. To search for the word **string** in the file **file1**, you would type

```bash
grep string file1
```
One thing to keep in mind is that **grep** is case sensitive, meaning that it won't search for lines containing the word **String**. You can also search for phrases and patterns by enclosing them in single quotes. To search for **this is a string**, you would type

```bash
grep 'this is a string' file1
```
You can gain more control over the **grep** command by using flags.

##### Common Flags
| Syntax | Description |
| ------ | ----------- |
| -i    | ignore case |
| -c     | displays # of times the string is found |
| -v     | displays all lines except those containing the string |
| -n     | include line numbers where string is found |




#### <a name="wc"></a> wc

The **wc** command (short for word count) counts the lines, words, and characters in a file. For a file **file1**, type

```bash
wc file1
```





## <a name="redirection"></a>4 - Redirection









### <a name="redirecting_output"></a> 4.1 - Redirecting Output







We mentioned earlier that using the **cat** command without specifying a file, it reads the standard input and then displays it to the screen. However, we can actually redirect the **cat** command so that instead of displaying to the screen, it will write to a file. We can do this by using the **>** symbol.





#### <a name=">"></a> Redirecting to a new file

To see this in action, we will redirect the output of the **cat** command to a file called **list1**, type

```bash
cat > list1
```
Then type some words. Press **enter** after each one

```bash
Binghamton
Spiedie
Cluster
[^d]
```
Note that **[^d]** means press both **[Ctrl]** and **d** at the same time. Each time we press **enter**, the word we typed gets written to the file **list1**.

You can see this by now typing

```bash
cat list1
```




#### <a name=">"></a> Appending a File

We can append an already existing file by using **>>**. Lets try appending **list1**, type

```bash
cat >> list1
```
Then type some words. Press **enter** after each one

```bash
module
slurm
node
[^d]
```

You can confirm the file has been appended by typing

```bash
cat list1
```





#### <a name="concat"></a> Concatenating Files

Redirecting with **>** and **>>** is not only useful for writing to a file from the standard input, you can also take files as an input. First lets create a new file **list2**, follow the procedure above to create a new list.

Now we can concatenate **list1** and **list2** and redirect the output to an new file called **biglist**, type

```bash
cat list1 list2 > biglist
```
Confirm it worked by typing 

```bash
cat biglist
```




### <a name="redirecting_input"></a> 4.2 - Redirecting Input






We can redirect the input of a command using the **<** symbol. To demonstrate this lets introduce a new command called **sort**.





#### <a name="sort"></a> sort

The sort command takes an input and sorts it, the prints it to the screen. Try it out by typing

```bash
sort
```
Then type some words. Press **enter** after each one

```bash
processor
gpu
compute
memory
^d
```

The output will be the list you just gave sorted alphabetically.

Now we can try redirecting an input into the **sort** command by using **<**, type

```bash
sort < biglist
```

The sorted content of **biglist** should be printed to the screen.

We can do all sorts of chaining with th redirection symbols, lets create a new file **slist** that contains the sorted content of **biglist**, type

```bash
sort < biglist > slist
```

Use **cat** to confirm.





### <a name="pipes"></a> 4.3 - Pipes






As we describes earlier, one way to input a list of items a get a sorted list from them is to first redirect the output of the **cat** command to a file **list1**, the use that file as an input to the **sort** command.

This is a very round about way of doing things, and you can be left with random temporary files which will need to be removed. Ideally what we would like is to route the output of one command into the input of another command. This is accomplished with a **pipe**. The symbol for a pip is a vertical bar **|**.

Try typing

```bash
cat | sort
```

Now enter a list of items as you have done before

```bash
processor
gpu
compute
memory
^d
```
You will see that once you press **^d** the sorted list will be printed to the screen.

Pipes are a very useful tool for chaining various commands.



 ## <a name="processes_jobs"></a>5 - Processes and Jobs







A process is an executing program identified by a unique PID (process identifier). 





#### <a name="ps"></a> ps

The **ps** command ( short for process) is used to see information about your processes, with their associated PID and status. To see the current running processes, type

```bash
ps
```
A process may be in the foreground, in the background, or be suspended. In general the shell does not return the UNIX prompt until the current process has finished executing.


### <a name="background_process"></a> 5.1 - Background Processes


Some processes take a long time to run and hold up the terminal. Backgrounding a long process has the effect that the UNIX prompt is returned immediately, and other tasks can be carried out while the original process continues executing.

For example, typing

```bash
sleep 10
```

will cause the terminal to wait 10 seconds before returning the prompt to the user. Nothing else can be done until the process has completed.

If you want to run processes that take time but retain use of the terminal window, you can run the processes in the background by typing **&** after the command, try typing

```bash
sleep 10 &
```
After typing a command to be run in the background, the terminal will output the job number and the PID of the process, looking something like this

```bash
[1] 12345
```

The job number is the number enclosed in brackets, and the PID is the number tha follows. If you type **ps** while the process is still running you should now see the PID and command listed in the output.

#### <a name="backgrounding_a_process"></a> Backgrounding a Running Process

Now what if you cant anticipate how long a process will run for, or if you decide after the fact that you need to run other processes. Fret not, because it is possible to instruct a currently running process to run in the background instead.

To move a currently running process to the background, first suspend the process by typing **^z** (hold down [**Ctrl**] and type [**z**].

Lets start a long process, type

```bash
sleep 1000
```

Now suspend it with **^z**. Once its suspended you can type

```bash
bg
```

to move it to the background.



#### <a name="Listing_processes"></a> Listing Suspended and Background Processes

We saw one way of listing the current running processes, the **ps** command. The **ps** command can give you information about all the processes running on the system, including the PID. However what if you only want the processes you started in you current session, you can use the **jobs** command.

Try running a command in the background and then type 

```bash
jobs
```
You will get a list of all the running job with an output that looks like

```bash
[#] [state] [job]
```

[**#**] will be the jub number, [**state**] will be the state of the job, either *"Running"* or *"Suspended"*, and [**job**] will be the job thats running, i.e. *"sleep 1000"*.



#### <a name="foregrounding_processes"></a> Move a Process to the Foreground

If you would like to move a background process to the foreground, you can to do using the **fg** command along with the job number. Type

```bash
fg %jobnumber
```

For example to to move a job with job number of **1** to the foreground, type

```bash
fg %1
```

If no jobnumber is given then the last suspended process will be foregrounded.




### <a name="killing_process"></a> 5.2 - Killing Processes



There are many reasons why you might want to stop a process from running. To kill a job running in the foreground you can type **^c** ([**Ctrl**] + [**c**]. 

```bash
sleep 100
```
then
```bash
^c
```

If you want to kill a background process you have to choices to do so, both involving the **kill** command. The first way is to specify the job number of the process you want to kill. 

```bash
kill %jobnumber
```

Alternatively you can kill a process by specifying it's PID.

```bash
kill PID
```

If a process is refusing to be killed, you can use the **-9** option to force it

```bash
kill -9 PID
```


## <a name="other"></a>6 - Other Helpful Commands


#### <a name="alias"></a> alias

The alias command created a temporary/easier/shorter name for a command or series of commands.

```bash
alias name="command"
```


#### <a name="chmod"></a> chmod

```bash
chmod file1
```
Changes write/read/execute permissions for a file



#### <a name="df"></a> df

The **df** (stands for a disk free) command displays the space left on the file system.

```bash
df .
```
Displays the disk usage.




#### <a name="du"></a> du

The **du** command displays the number of kilobytes used by each subdirectory. 

```bash
du
```
You can specify root directory to be searched by typing it after the **du** command. For example, to find the memory used for each subdirectory of a directory **dir1**, type

```bash
du dir1
```

#### <a name="echo"></a> echo

The **echo** command prints the string following the command to the terminal. Try typing

```bash
echo string
```


#### <a name="gzip"></a>  gzip

The **gzip** command is used to reduce the size of a file by compressing it. To reduce a file called **file1** type

```bash
gzip file1
```

the file is compressed and placed into a file called **file1.gz**.

To expand the file you can use the **gunzip** command. To expand **file1.gz** type

```bash
gunzip file1.gz
```


#### <a name="zcat"></a>  zcat

Once you've compressed a file, theres not much you can with it unless you expand it again. However the **zcat** command allows you to read a compressed file. Ypu can read **file1.gz** by typing

```bash
zcat file1.gz
```

Just like the **cat** command, you can pipe the output of **zcat** into another command which makes it easier to manage. You can type

```bash
zcat file1.gz | less
```


#### <a name="find"></a>  find

The **find** command searches through your your directories for files and directories with a given name, date, size, or any other attributes you can specify. For instance if you wanted to search for all files with the **.txt** extension starting at the current directory and print them to the screen you can type

```bash
find . -name "*.txt" -print
```
The wildcard symbol <strong>*</strong> is a way to disregard anything preceding **.txt**.

Finding files based on their size can be done by typing

```bash
find . -size +1M -ls
```

This will display any file over 1Mb in size.



#### <a name="history"></a> history

The commands you type into the command prompt are all stored in the shell. You can view the history of the commands you entered by using the **history** command. Type

```bash
history
```
You can also use the **!** key to recall previously used command, for instance, typing

``` bash
!!
```

will repeat the most recent command typed. You can also specify a command in the list in a few ways. To repeat the 3rd command in history, you can type

```bash
!3
```

If you wanted to repeat the 5th most recent command type

```bash
!-5
```

You can even repeat the last command starting with some command name. For instance if you wanted to repeat the last command starting with **grep**, type

```bash
!grep
```


## <a name="editors"></a>7 - Editors


#### <a name="nano"></a> nano

```bash
nano
```
Opens a new nano editor, will save a new file.

```bash
nano file1
```
Opens file1 in the nano editor





#### <a name="emacs"></a> emacs

```bash
emacs
```
Opens a new emacs editor, will save a new file.

```bash
emacs file1
```
Opens file1 in the emacs editor





#### <a name="vi"></a> vi

```bash
vi
```
Opens a new vi editor, will save a new file.

```bash
vi file1
```
Opens file1 in the vi editor



