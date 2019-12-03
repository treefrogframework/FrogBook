
.. _otama:

Otama Template System
=====================

Otama is a template system that completely separates the presentation logic from the templates. It is a system made especially for the TreeFrog Framework.

Views are created for the Otama system when the configuration file (*development.ini*) is edited as the following and then the generator makes a scaffolding.

.. code-block:: ini
  
  TemplateSystem=Otama

The template is written in full HTML (with the .html file extension). A "mark" is used for the tag elements where logic code is to be inserted. The presentation logic file (.otm) is written with the associated C++ code, and the mark. This is then automatically converted to C++ code when the shared view library is built.

.. image:: images/views_conv.png

Basically, a set of presentation logic and template are made for every action. The file names are [action name].html and [action name].otm (case-sensitive). The files are placed in the "views/controller-name/" directory.

Once you have created a new template, in order for this to be reflected in the view shared library, you will need to run "make qmake" in the *view* directory

.. code-block:: bash
  
  $ cd views
  $ make qmake

If you have not already done so, it is recommended that you read the ERB chapter before continuing with this chapter, since there is much in common between the two template systems. Also, there is so much to learn about the Otama system that knowing ERB in advance will make it easier to understand.

Output a String
---------------

We are going to the output of the statement "Hello world".
On the template page, written in HTML , use a custom attribute called data-tf to put a "mark" for the element. The attribute name must start with "@". For example, we write as follows.

.. code-block:: html
  
  <p data-tf="@hello"></p>

We've used paragraph tags (<p> </p>) around the @hello mark.
In the mark you may only use alphanumeric characters and the underscore '_'. Do not use anything else.

Next, we’ll look at the presentation logic file in C++ code. We need to associate the C++ code with the mark made above. We write as follows.

::
  
  @hello ~ eh("Hello world");

We then build, run the app, and then view will output the following results.

.. code-block:: html
  
  <p>Hello world</p>

I'll explain a little.
The tilde (~) that connects the C++ code with the mark that was intended for the presentation logic means effectively "substitute the contents of the right side for the content of the element marked". We remember that the eh() method outputs the value that is passed.

In other words, the content between the p tags (blank in this case) is replaced with "Hello world". The data-tf attribute will then disappear entirely.

In addition, as an alternative way of outputting the same result, it’s also possible to write as follows.

::
  
  @hello ~= "Hello world"

As in ERB; The combination of ~ and eh() method can be rewritten as '~='; similarly, the combination of ~ and echo() method can be rewritten as '~=='.

Although we’ve output a static string here, in order to simplify the explanation, it’s also possible to output a variable in the same way. Of course, it is also possible to output an object that is passed from the controller.

  **In brief: Place a mark where you want to output a variable. Then connect the mark to the code.**

Otama Operator
--------------

The symbols that are sandwiched between the C++ code and the mark are called the Otama operator.

Associate C++ code and elements using the Otama operator, and then decide how these should function. In the presentation logic, note that there must be a space on each side of the Otama operator.

This time, we’ll use a different Otama operator. Let's assume that presentation logic is written as the following (colon).

::
  
  @hello : eh("Hello world");

The Result of View is as Follows.

::
  
  Hello world

The p tag has been removed. This is because the colon has the effect of "replace the whole element marked", with this result. Similar to the above, this could also be written as follows.

::
  
  @hello := "Hello world"

The description is no loner required.

Using an Object Passed from the Controller
------------------------------------------

In order to display the export object passed from the controller, as with ERB, you can use it after fetching by tfetch() macro or T_FETCH() macro. When msg can export an object of QString type, you can describe as follows.

::
  
  @hello : tfetch(QString, msg);  eh(msg);

As with ERB, objects fetched are defined as a local variable.

Typically, C++ code will not fit in one instruction line. To write a C++ code of multiple rows for one mark, write side by side as normal but put a blank line at the end. Up until the blank line is considered to be one set of the parts of the mark. Thus, between one mark and the next a blank line (including a line with only blank characters) acts as a separator in the presentation logic.

  **In brief: logic is delimited by an empty line.**

Next, we look at the case of wanting to display an export object in two different locations. In this case, if you describe it at #init, it will be called first (fetched). After that, it can be used freely in the presentation logic. It should look similar to the following.

::
  
  #init : tfetch(QString, msg); 
  @foo1 := msg  
  @foo2 ~= QString("message is ") + msg

With that said, for exporting objects that are referenced more than once, use the fetch processing at #init.
 
Here is yet another way to export output objects.
Place "$" after the Otama operator. For example, you could write the following to export the output object called *obj1*.

::
  
  @foo1 :=$ obj1

This is, output the value using the eh() method while fetch processing for *obj1*. However, this process is only an equivalent to fetch processing, the local variable is not actually defined.

To obtain output using the echo() method, you can write as follows.

::
  
  @foo1 :==$ obj1

Just like ERB.

    **In brief: for export objects, output using =$ or ~=$.**

Loop
----

Next, I will explain how to use loop processing for repeatedly displaying the numbers in a list.
In the template, we want a text description.

.. code-block:: html
  
  <tr data-tf="@foreach">
    <td data-tf="@id"></td>
    <td data-tf="@title"></td>
    <td data-tf="@body"></td>
  </tr>

That is exported as an object in the list of Blog class named *blogList*. We want to write a loop using a foreach statement (as included in Qt). The while statement will also be similar.

::
  
  @foreach :
  tfetch(QList<Blog>, blogList);    /* Fetch processing */
  foreach (Blog b, blogList) {
      %%
  }
  @id ~= b.id()
  @title ~= b.title()
  @body ~= b.body()

The %% sign in important, it refers to the entire element (@foreach) of the mark. In other words, in this case, it refers to the element fron <tr> up to </ tr>. Therefore, by repeating the tr tags, the foreach statement which sets the value of each content element with *@id*, *@title*, and *@body*, results in the view output being something like the following.

.. code-block:: html
  
  <tr>
     <td>100</td>
     <td>Hello</td>
     <td>Hello world!</td>
  </tr><tr>
     <td>101</td>
     <td>Good morning</td>
     <td>This morning ...</td>
  </tr><tr>
  :    (← Repeat the partial number of the list)

The data-tf attribute will disappear, the same as before.

Adding an Attribute
-------------------

Let's use the Otama operator to add an attribute to the element.
Suppose you have marked such as the following in the template.

.. code-block:: html
  
  <span data-tf="@spancolor">Message</span>

Now, suppose you wrote the following in the presentation logic.

::
  
  @spancolor + echo("class=\"c1\" title=\"foo\"");

As a result, the following is output.

.. code-block:: html
  
  <span class="c1" title="foo">Message</span>

In this way, by using the + operator, you can add only the attribute.
As a side note, you can not use eh() method instead of echo() method, because this will take on a different meaning when the double quotes are escaped.

Another method that we could also use would be written as follows in the presentation logic.

::
  
  @spancolor +== "class=\"c1\" title=\"foo\""

echo() method can be rewritten to '=='.

In addition, it could also be written using the following alternative method. The same result is output.

::
  
  @spancolor +== a("class", "c1") | a("title", "foo")

The a() method creates a THtmlAttribute object that represents the HTML attribute, using | (vertical bar) to concatenate these. It is not an THtmlAttribute object after concatenation but, if you output with the echo() method they are converted to a string of key1="val1”, key2=“val2”…, it means that attributes are added as a result.

You may use more if you wish.

Rewriting the <a> tag
---------------------

The <a> tag can be rewritten using the colon ':' operator. It is as described above.
To recap a little; the a tag is to be marked on the template as follows."

.. code-block:: html
  
  <a class="c1" data-tf="@foo">Back</a>

As an example; we can write the presentation logic of the view (of the Blog), as follows.

::
  
  @foo :== linkTo("Back", urla("index"))

As a result, the view outputs the following.

.. code-block:: html
  
  <a href="/Blog/index/">Back</a>

Since the linkTo() method generates the <a> tag, we can get this result.  Unfortunately, the class attribute that was originally located has disappeared.  The reason is that this operator has the effect of replacing the whole element.
 
If you want to set the attribute you can add it as an argument to the linkTo() method.

::
  
  @foo :== linkTo("Back", urla("index"), Tf::Get, "", a("class", "c1"))

The class attribute will also be output as a result the same as above.
  
Although attribute information could be output, you wouldn’t really want to bother to write such information in the presentation logic.
As a solution there is the \|== operator. This has the effect of merging the contents while leaving the information of the attributes attached to the tag.

So, let’s rewrite the presentation logic as follows.

::
  
  @foo  |== linkTo("Back", urla("index"))

As a result, the view outputs the following.

.. code-block:: html
  
  <a class="c1" href="/Blog/index/">Back</a>

The class attribute that existed originally remains; it does NOT disappear.
 
The \|== operator has a condition to merge the elements. That is the elements must be the same tags. In addition, if the same attribute is present in both, the value of the presentation logic takes precedence.

By using this operator, the information for the design (HTML attributes) can be transferred to the template side.

  **In brief: Leave the attribute related to design at the template and merge it by \|== operator.**

**Note:**
The \|== operator is only available in this format (i.e. \|== ), neither '\|' on its own, nor '\|=' will work.

Form Tag
--------

Do not use the form tag <form> to POST data unless you have enabled the CSRF measures. It does not accept POST data but only describes the form tag in the template. We need to embed the secret information as a hidden parameter.

We use the form tag in the template to do so. After putting the mark to the form tag of the template, merge it with the content of what the formTag() method is outputting

Template:

.. code-block:: html
  
  :
  <form method="post" data-tf="@form">
  :

Presentation logic::
  
  @form |== formTag( ... )

You'll be able to POST the data normally.
 
Please see the chapter on :ref:`security <security>` for those who CSRF measures, if you want to know more details.

Turn Off the Element
--------------------

If you mark *@dummy* elements in the template, it is not output as a view. Suppose you wrote the following to the template.

.. code-block:: html
  
  <div>
    <p>Hello</p>
    <p data-tf="@dummy">message ..</p>
  </div>

Then, the view will make the following results.

.. code-block:: html
  
  <div>
    <p>Hello</p>
  </div>

You use this when you want to keep it in the Web design, but erase it from the view.

Including the Header File
-------------------------

We talked about the presentation logic template being converted to C++ code. The header and user-defined files will not be included automatically and you must write them yourself. However, basic TreeFrog header files can be included.

For example, if you want to include user.h and blog.h files you would write these in at the top of the presentation logic.

.. code-block:: c++
  
  #include "blog.h" 
  #include "user.h"

All the same as the C++ code!
Lines beginning with an #include string are moved directly to the code view.

Otama Operator
--------------

The following table describes the Otama operator which we’ve been discussing.

+----------+------------------------------------------------------------+---------------------+
| Operator | Description                                                | Remarks             |
+==========+============================================================+=====================+
| :        | **Element replacement:**                                   | %% means the        |
|          | The components and subcomponents that are marked, on       | elements            |
|          | the right-hand side of the eh() statement, or the echo()   | themselves that can |
|          | statement is replaced by the string to be output.          | be replaced.        |
+----------+------------------------------------------------------------+---------------------+
| ~        | **Content replacement:**                                   |                     |
|          | The content of marked elements, on the right-hand side of  |                     |
|          | the eh() statement or the echo() statement is replaced by  |                     |
|          | the string to be output.                                   |                     |
+----------+------------------------------------------------------------+---------------------+
| \+       | **Attribute addition:**                                    | += is HTML          |
|          | A string to be output on the right-hand side in the echo() | escaping, perhaps   |
|          | statement, if you want to add to the attributes of the     | not used much.      |
|          | elements that are marked.                                  |                     |
+----------+------------------------------------------------------------+---------------------+
| \|==     | **Element merger:**                                        | '\|' and '\|=' are  |
|          | Based on the marked elements, the specified stringis       | disabled.           |
|          | merged on the right-hand side.                             |                     |
+----------+------------------------------------------------------------+---------------------+

Extended versions of these four operators are as follows.
With the echo() statement and eh() statement no longer being needed, you'll be able to write shorter code.

+----------+-------------------------------------------------------------+
| Operator | Description                                                 |
+----------+-------------------------------------------------------------+
| :=       | Element replaced by an HTML escaped variable.               |
+----------+-------------------------------------------------------------+
| :==      | Element replaced by a variable.                             |
+----------+-------------------------------------------------------------+
| :=$      | Element replaced by an HTML escaped export object.          |
+----------+-------------------------------------------------------------+
| :==$     | Element replaced by an export object.                       |
+----------+-------------------------------------------------------------+
| ~=       | Content replaced by an HTML escaped variable.               |
+----------+-------------------------------------------------------------+
| ~==      | Content replaced by a variable.                             |
+----------+-------------------------------------------------------------+
| ~=$      | Content replaced by an HTML escaped export object.          |
+----------+-------------------------------------------------------------+
| ~==$     | Content replaced by an export object.                       |
+----------+-------------------------------------------------------------+
| \+=      | Add an HTML escaped variable to an attribute.               |
+----------+-------------------------------------------------------------+
| \+==     | Add a variable to an attribute.                             |
+----------+-------------------------------------------------------------+
| \+=$     | Add an HTML escaped export object to an attribute.          |
+----------+-------------------------------------------------------------+
| \+==$    | Add an export object to an attribute.                       |
+----------+-------------------------------------------------------------+
| \|==$    | Element merged with an export object.                       |
+----------+-------------------------------------------------------------+

Comment
-------

Please write in the form of  /\*.. \*/,  if you want to write a comment in the presentation logic.

::
  
  @foo ~= bar    /*  This is a comment */

**Note:** In C++ the format used is "// .." but this can NOT be used in the presentation logic.
