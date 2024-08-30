# random-installer.sh

Use bash to generate some Large file into the random directory

> [!WARNING]
> It's a very evil script, think about the consequence before the joke.\
> Check for yourself the filenames are easy to search, and the path prefix is in the expected(default is ~/.local/share/)

## Introduce

Here is the thing, I opened a Code With Me Invent link and followed the client download command.\
It's all right up here. But they don't tell me how to uninstall that, it makes me search and search again.\
I just want to uninstall this client which was installed via an **unconventional** script...

It really makes me angry, so I made this even more evil script

## Usage

Run with `help | --help | -h` as the first argument to get more information

This snapshot may well out of date:

```text
Usage: installer.sh <MODE> [...]
MODE list: help; general [confirm]; evil [confirm];
If the MODE has no 'confirm' argument, it means dry-run
```

## Mode descriptions

### General mode

Generate **one** **16MiB** file into a random director(in ~/.local/share/)

The script will print its full path, rest assured of that

It's ok if someone loss the script output at time, the filename of this mode is fixed,\
it is: `Evil_Installer_Test_File_8868f8c0-f08a-432c-8a6e-9bddc2b5ea35.bin`\
Although, it dose take some time

### Evil mode

**Evil**!!!

It will generate **twelve** **64-512MiB** files, each file's directory same as the [#General mode](#general-mode)

The filename is randomized now(by `uuidgen` command).\
They look like: `7e66fc14-73de-44e0-a2e9-c69ed4db7c5b.bin`

And it also won't print those file paths, but that doesn't mean user can't find them.\
The list of them are storage in the `~/.evil_installer_file_path_list.txt`

## Todo

- NULL
