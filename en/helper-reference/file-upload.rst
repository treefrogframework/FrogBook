File Upload
===========

Let's make a form for file upload. Below is an example of writing in the ERB. By specifying true for the third argument of the formTag() method, a form as multipart/form-data is generated.

.. code-block:: html
  
  <%== formTag(urla("upload"), Tf::Post, true) %>
    <p>
      File: <input name="picture" type="file">
    </p>
    <p> 
      <input type="submit" value="Upload">
    </p>
  </form>

In this example, the destination of the file upload is the upload action in the same controller.

In the action that receives the upload file, you can rename the file by using the following method. The uploaded file is dealt with as a temporary file; if you do rename it now, the file is automatically deleted after the action ends.

.. code-block:: c++
  
  TMultipartFormData &formdata = httpRequest().multipartFormData();
  formdata.renameUploadedFile("picture", "dest_path");

The original file name can be obtained using the following methods.

.. code-block:: c++
  
 QString origname = formdata.originalFileName("picture");

It may not be much use, but you can get a temporary file name just after uploading by using the following method. Random file names have been attached to make sure that they do not overlap.

.. code-block:: c++
  
  QString upfile = formdata.uploadedFile("picture");

Upload multiple files
---------------------

TreeFrog Framework also supports the upload of multiple files. You can upload files of variable number when you use the Javascript library.  Here, I’ll explain an easier way of uploading two files (or more).

First we create a form as follows.

.. code-block:: html
  
  <%== formTag(urla("upload"), Tf::Post, true) %>
    <p>
      File1: <input name="picture[]" type="file">
      File2: <input name="picture[]" type="file">
    </p>
    <p> 
      <input type="submit" value="Upload">
    </p>
  </form>

In the upload action to receive the upload file, you can access the two files through the TMimeEntity object as follows. It’s important to use the iterator.

.. code-block:: c++
  
  QList<TMimeEntity> lst = httpRequest().multipartFormData().entityList( "picture[]" );
    for (QListIterator<TMimeEntity> it(lst); it.hasNext(); ) {
      TMimeEntity e = it.next();
      QString oname = e.originalFileName();   // original name
      e.renameUploadedFile("dst_path..");     // rename file
      ...
    }

Also as for upload files of variable number, you can access these in the same way as above.