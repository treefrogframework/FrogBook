================
Helper Reference
================

A helper is the helping function or class to complement the treatment.  In TreeFrog Framwork there are many helpers, so that by using them, code can be simple and easy to understand.  The following are examples of helpers. 

  + User authentication
  + Form validation
  + Mailer (Sending mail)
  + Access to the upload file
  + Logging
  + Access control of users

If you make a helper as a class, it can basically be a class without a state (as per object-oriented). In the class with state, the general case is defined as a model since it persists in the DB.
  
In addition, for a similar piece of logic which appears several times in the controller and the view, you should consider whether it is worth cutting it out as a helper. Please see :ref:`this chapter <making_original_helper>` if you want to create a helper on its own. 

.. toctree::
	:maxdepth: 3

	helper-reference/file-upload
	helper-reference/authentication
	helper-reference/validation
	helper-reference/mailer
	helper-reference/logging
	helper-reference/plugin
	helper-reference/image-manipulation
	helper-reference/making-original-helper