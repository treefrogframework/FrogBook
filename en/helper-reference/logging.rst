
.. _helper_reference_logging:

Logging
=======

Web app will log four outputs as follows.

+--------------+---------------+------------------------------------------------------------------------+
| Log          | File name     | Content                                                                |
+==============+===============+========================================================================+ 
| App log      | app.log       | Logging of Web application.                                            |
|              |               | Developers output the log here.  See below about output method.        |
+--------------+---------------+------------------------------------------------------------------------+
| Access log   | access.log    | Logging access from the browser.                                       |
|              |               | Including access to a static file.                                     |
+--------------+---------------+------------------------------------------------------------------------+
| TreeFrog log | treefrog.log  | Logging of the TreeFrog system.                                        |
|              |               | Since it is the log that the system output, when an error occurs, some |
|              |               | information may be available here.                                     |
+--------------+---------------+------------------------------------------------------------------------+
| Query log    | query.log     | Query log issued to the database.  Specify the file name in the file   |
|              |               | value of SqlQueryLog in the configuration file.                        |
|              |               | When stopping the output, empty it.  Because there is overhead when    |
|              |               | the log is outputting, it is a good idea to stop the output when you   |
|              |               | operate a formal Web application.                                      |
+--------------+---------------+------------------------------------------------------------------------+

Output of the Application Log
-----------------------------

The application log is used for logging Web application. Use the following method if you want to output the application log.

  + tFatal()
  + tError()
  + tWarn()
  + tInfo()
  + tDebug()
  + tTrace()

Arguments that can be passed are the same as the printf-format of  format string and a variable number.  For example, like this.

.. code-block:: c++
  
  tError("Invalid Parameter : value : %d", value);

Then, the following log will be output to the *log/app.log* file.

.. code-block:: ini
  
  2011-04-01 21:06:04 ERROR [12345678] Invalid Parameter : value : -1

Line feed code is not required at the end of the format string.

Changing Log Layout
-------------------

It is possible to change the layout of the log output, by setting FileLogger.Layout parameters in the configuration file *logger.ini*.

.. code-block:: c++
  
  # Specify the layout of FileLogger.
  #  %d : date-time
  #  %p : priority (lowercase)
  #  %P : priority (uppercase)
  #  %t : thread ID (dec)
  #  %T : thread ID (hex)
  #  %i : PID (dec)
  #  %I : PID (hex)
  #  %m : log message
  #  %n : newline code
  FileLogger.Layout="%d %5P [%t] %m%n"

The date and time when the log was generated is inserted as indicated by the '%d' in the log layout.  
The date format is specified in the FileLogger.DateTimeFormat parameter.  The format that can be specified is the same value to the argument of QDateTime::toString().  Please refer to the Qt document for further detail. 

.. code-block:: c++
  
  # Specify the date-time format of FileLogger, see also QDateTime
  # class reference.
  FileLogger.DateTimeFormat="yyyy-MM-dd hh:mm:ss"

Changing the Logging Level
--------------------------

You can set log output level at the following parameter in *logger.ini*.

.. code-block:: c++
  
  # Outputs the logs of equal or higher priority than this.
  FileLogger.Threshold=debug

In this example, the log level is higher than debug.

**In brief: Output the debug log (necessary for development) using the tDebug() function.**
