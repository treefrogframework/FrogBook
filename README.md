===========================================
TreeFrog Framework Documentation
===========================================

-------
Install
-------

Linux
-----		
	
	1. Ubuntu(debian like)::

		sudo apt-get install python-setuptools
		sudo easy_install -U Sphinx
		sudo easy_install -U rst2pdf

	2. Fedora/Red Hat/CentOS::

		yum install python-setuptools
		easy_install -U Sphinx
		easy_install -U rst2pdf

	3. Or download tar (https://bitbucket.org/birkenfeld/sphinx/get/default.tar.bz2) or zip (https://bitbucket.org/birkenfeld/sphinx/get/default.zip) file.

Mac or Windows
--------------

	1. Need python (http://www.python.org/download/) and setuptools(https://pypi.python.org/pypi/setuptools/0.9.8#installation-instructions) installed.

	2. Run::

		easy_install -U Sphinx
		easy_install -U rst2pdf

------------------------
Generating documentation
------------------------

Linux
-----		
	
	1. Enter the directory of the documentation::

		cd /path/to/FrogBook/

	2. Run::

		make <format>
			
		ex.:

		make html

	3. Output is the::

		/path/to/FrogBook/build/<format>

		ex.:

		/path/to/FrogBook/build/html

Windows
-------
		
	*soon.*

Mac
----

	*soon.*