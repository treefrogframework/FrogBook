
.. _helper_reference_validation:

Validation
==========

Sometimes the data sent as a request may not have the format that the developer has specified. For example, some users might put letters where numbers are required. Even if you have implemented Javascript to validate on the client side, tempering with the content of a request is easy, so a server side system for validating content is essential.  

As mentioned earlier, data in received requests is expressed as hash format (see the section of :ref:`this chapter <controller>` for information about how to get). Usually before sending the request data to the model, each value should be verified as having the right format.

First, we will generate a validation class skeleton for validating request data (hash) to blog. Move to the application route, and then implement the following commands.

.. code-block:: bash
  
  $ tspawn validator blog
    created   helpers/blogvalidator.h
    created   helpers/blogvalidator.cpp
    updated   helpers/helpers.pro

The validation rules are set in the construction of the generated BlogValidator class. Following is an example of the writing for the rule that the title variable must be made up of 4 or more and 20 or less letters.

.. code-block:: c++
  
  BlogValidator::BlogValidator() : TFormValidator()
  {
     setRule("title", Tf::MinLength, 4);
     setRule("title", Tf::MaxLength, 20); 
  }

The enum value is the second argument. You can specify, mandatory input, maximum/minimum  string length, integer  of maximum/minimum value, date format,  e-mail address format, user-defined rules (regular expression), and so on (defined in tfnamespace.h).

The fourth argument is setRule(). This sets the validation error message. If you don’t specify a message, the message defined in *config/validation.ini* file is used.

Rules are implicitly set for "mandatory input". If you do NOT want an input to be "mandatory", describe it as follows.

.. code-block:: c++
  
  setRule("title", Tf::Required, false);

Once you have set the rules, you use them in the controller. Include the header file relating to this.
This code validates the request data that is retrieved from the form. If you get a validation error, you get the error message.

.. code-block:: c++
  
  QVariantMap blog = httpRequest().formItems("blog");
  BlogValidator validator;
  if (!validator.validate(blog)) {
      // Retrieve message rules for validation error
      QStringList errs = validator.errorMessages();
      :
  }

Normally, since it should set multiple rules, there will also be multiple error messages. One-by-one processing is a little cumbersome. If, however, you use the following methods, you can export the whole validation error message at once (to be passed to the view). In the second argument, specify a prefix as the variable name for the export object.

.. code-block:: c++
  
  exportValidationErrors(valid, "err_");

**In brief:  Set the rule for the form data, and validate it by using validate().**

Custom validation
-----------------

The above description is about a method of static validation. It can not be used in a dynamic case where the allowable range of the value changes according to what the value is. In this case, you may override the validate() method, and then you can write the code of validation freely.

The following code is an example.

.. code-block:: c++
  
  bool FooValidator::validate(const QVariantMap &hash)
  {
      bool ret = THashValidator::validate(hash);  // ←Validation of static rules
      if (ret) {
          QDate startDate = hash.value("startDate").toDate();
          QDate endDate = hash.value("endDate").toDate();
          
          if (endDate < startDate) {
              setValidationError("error");
              return false;
          }
              :
              :
      }
      return ret;
  }

It compares the value of *endData* and the value of *startDate*.  When it is not correct, it is validation error.