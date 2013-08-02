=======
Install
=======

Installation Instructions
-------------------------

Please install the Qt library in advance.

1. Extract the file you downloaded.
    The following applies to version 'x.x.x'. Please update as appropriate.
  
.. code-block:: bash

  $ tar xvfz treefrog-x.x.x.tar.gz

2. Run build commands. 
    In Windows:
      Please create a binary of two types for the release and for debugging.
      Start the Qt Command Prompt, and then build with the following command. The configuration batch should be run twice.

.. code-block:: bat
    
  > cd treefrog-x.x.x
  > configure --enable-debug
  > cd src
  > mingw32-make install
  > cd ..\tools
  > mingw32-make instal
  > cd ..
  > configure
  > cd src
  > mingw32-make install
  > cd ..\tools
  > mingw32-make instal

In UNIX-based OS Linux, and Mac OS X :   
Enter the following from the command line.
  
.. code-block:: bash

  $ cd treefrog-x.x.x
  $ ./configure
  $ cd src
  $ make
  $ sudo make install
  $ cd ../tools
  $ make
  $ sudo make install

**Note**:  In order to debug the TreeFrog Framework itself, please use the configure option.
Run Type  './configure --enable-debug'.

3. Create a shortcut of TreeFrog Command Prompt (Windows only).
    Right-click on the folder in which you want to create the shortcut, and select "New" – and then click the "shortcut". Set the links as follows.

.. code-block:: bat
   
  C:\Windows\System32\cmd.exe /K  C:\TreeFrog\x.x.x\bin\tfenv.bat

x.x.x is version.


Configure option
----------------

By specifying various options, you can customize to suit your environment.
 
Options available on Windows using “Configure option”:

.. code-block:: bat

  > configure --help
  Usage: configure [OPTION]... [VAR=VALUE]...
  Configuration:
    -h, --help          display this help and exit
    --enable-debug      compile with debugging information

  Installation directories:
  --prefix=PREFIX     install files in PREFIX [C:\TreeFrog\x.x.x]


Options available on Linux, and UNIX-like OS:

.. code-block:: bash

  $ ./configure --help
  Usage: ./configure [OPTION]... [VAR=VALUE]...
  Configuration:
    -h, --help          display this help and exit
    --enable-debug      compile with debugging information

    Installation directories:
    --prefix=PREFIX     install files in PREFIX [/usr]

    Fine tuning of the installation directories:
      --bindir=DIR        user executables [/usr/bin]
      --libdir=DIR        object code libraries [/usr/lib]
      --includedir=DIR    C header files [/usr/include/treefrog]
      --datadir=DIR       read-only architecture-independent data [/usr/share/treefrog]

Options available in Max OS X:

.. code-block:: bash

  $ ./configure --help
  Usage: ./configure [OPTION]... [VAR=VALUE]...
  Configuration:
    -h, --help          display this help and exit
    --enable-debug      compile with debugging information

    Fine tuning of the installation directories:
      --framework=PREFIX  install framework files in PREFIX [/Library/Frameworks]
      --bindir=DIR        user executables [/usr/bin]
      --datadir=DIR       read-only architecture-independent data [/usr/share/treefrog]
