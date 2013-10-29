superlocate
===========

 Welcome to superlocate, a locate wrapper that makes browsing hierarchical filesystems easier. It launches locate on your first argument, and then filters the results so that each of the arguments are included. This way, you no longer need to remember where your files are; just remembering the filename, as well as a few of the directories (which you can now see as tags), in any order, will suffice.

 What it does:
 It launches locate with your first argument. If the only result is a directory, it will automatically cd to it. If the only result is a file, it will cd to the directory that contains it. If there are more than one results, you can refine your search by adding more arguments.

### Dependencies
- locate from the findutils or mlocate metapackage
- dmenu from the suckless-tools metapackage
- [idirname](https://github.com/Antithesisx/idirname)
 
### Installation
- Resolve the dependencies;
- place sl in your PATH and make sure it's executable (sl stands for superlocate):

```
sudo cp sl /usr/bin/
sudo chmod +x /usr/bin/sl
```
- If you hadn't installed locate before, update your database.

`sudo updatedb`

- Add an alias to your ~/.zshrc (or ~/.bashrc, if you use bash):

`alias sl='source sl'`

### Examples
#### Example 1
`user@localhost$ sl strawberry beatles`

 This will search for any file or directory containing both the strings "Strawberry" and "Beatles". This way, you can locate the song "Strawberry Fields Forever" without needing to remember that it was on The Magical Mystery Tour.

 But wait a second! The song appears on multiple records, and because you are such a Beatles fan, you've got a copy of them all. Here's the output of our command:

```
/home/user/music/Beatles/The_Magical_Mystery_Tour/Strawberry_Fields_Forever.ogg
/home/user/music/Beatles/Imagine/Strawberry_Fields_Forever.ogg
/home/user/music/Beatles/Love/Strawberry_Fields_Forever.ogg
/home/user/music/Beatles/Anthology_2_CD_2/Strawberry_Fields_Forever.ogg
```

 In order to get the version on The Magical Mystery Tour, all we have to do is add another filter.

```
user@localhost$ !! tour
user@localhost$ sl strawberry beatles tour
```

 Output:

`/home/user/music/Beatles/The_Magical_Mystery_Tour/Strawberry_Fields_Forever.ogg`

 You have now been cd'd into /home/user/music/Beatles/The_Magical_Mystery_Tour and all you have to do to play the song is xdg-open Strawberry_Fields_Forever.ogg.


#### Example 2

 Let's say you want to play the whole Magical Mystery Tour album. At first you'd probably try:

`user@localhost$ sl mystery tour`

 However, this will output all the songs on the album as well, since they match the query. The output will be:

```
/home/user/music/Beatles/The_Magical_Mystery_Tour/
/home/user/music/Beatles/The_Magical_Mystery_Tour/Magical_Mystery_Tour.ogg
/home/user/music/Beatles/The_Magical_Mystery_Tour/The_Fool_on_the_Hill.ogg
/home/user/music/Beatles/The_Magical_Mystery_Tour/Flying.ogg
/home/user/music/Beatles/The_Magical_Mystery_Tour/Blue_Jay_Way.ogg
etc.
```

 Because both locate and grep take regexp, this can be prevented very easily:

`user@localhost$ sl mystery tour$`

 The $ means the string has to end there, so anything inside the directory is not included. The directory will be the only result, and you will be cd'd into it.


 NEW: from now on, if there's more than one result, an instance of dmenu will be launched to let you choose from the results.

### Some notes
 - everything is case-insensitive;
 - the order of your arguments doesn't matter. You can now think in terms of tags, not hierarchies!
 - The OS X version uses find because its locate doesn't take regex. It searches all files and folders in the working directory recursively.

### To-do
 - Automatically rearrange the arguments from bigger strings to fewer, in order to reduce search time. locate a | grep verylongstring takes longer than locate verylongstring | grep a, for example;
 - if all results will bring you to the same directory, skip the dmenu and go to that directory immediately;
 - add command-line switches, for example if an operation must be case-sensitive, or only directories are to be located.

### fasd
 This program was inspired by fasd. The main differences:
 - fasd keeps track of its own database, which is built by cd'ing to directories, while superlocate uses locate's database, which includes the entire filesystem, not just the directories you've used before;
 - fasd takes a little bit of time to update the database each time you use cd. Superlocate is updated when crond updates locate's database, or when you manually initialize updatedb. This way, it does not interfere with your workflow;
 - most importantly, superlocate does not care about the order of the arguments. This way, you don't have to memorize what your filesystem hierarchy looks like.


