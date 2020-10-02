create or replace PACKAGE      "XLIB_HTTP"
AS
/*=========================================================================
  $Id: xlib_http.pks 60 2015-10-05 15:08:20Z dietmar.aust $

  Purpose  : Make http callouts
  
  License  : Copyright (c) 2010 Dietmar Aust (opal-consulting.de)
             Licensed under a BSD style license (license.txt)
             http://www.opal-consulting.de/pls/apex/f?p=20090928:14
             
  $LastChangedDate: 2015-10-05 17:08:20 +0200 (Mon, 05 Oct 2015) $
  $LastChangedBy: dietmar.aust $ 
  
 Version Date        Author           Comment
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         19.02.2007  D. Aust          initial creation
         07.08.2008  D. Aust          - added check_get_request
                                      - display_url_raw: pass all request headers
                                          to the client
         05.08.2012  D. Aust		      suppress mime header TRANSFER-ENCODING,
                                        causes lots of problems with XMLDB listener
                                        and others choking.
 2.3.0.0 19.05.2014  D. Aust          - #294 - Fix chunked encoding problem in 
                                          xlib_http.get_report
                                      - added version information to this package
 2.3.0.0 09.05.2015  D. Aust          pass JSESSIONID from backend J2EE server to client 
                                        for image rendering in html reports                                         
 2.6.1   28.09.2020  D. Aust          - #40 - APEX 20.1 security bundle (PSE 30990551) rejects response header "Cache-Control: private"

=========================================================================*/

   c_success   CONSTANT CHAR (1) := '1';
   c_fail      CONSTANT CHAR (1) := '0';
   
  -- version of this package
  version_c constant varchar2(20 char) := '2.6.1';   
  
  TYPE vc_arr_t IS TABLE OF VARCHAR2 (32767) INDEX BY BINARY_INTEGER;
  g_empty_vc_arr vc_arr_t;

/* Function: MyFunction
 *
 * Parameters:
 *
 *    x - Description of x.
 *    y - Description of y.
 *    z - Description of z.
 */
   PROCEDURE display_url_raw (
      p_url                       VARCHAR2,
      p_mime_type_override   IN   VARCHAR2 DEFAULT NULL,
      p_charset              IN   VARCHAR2 DEFAULT NULL,
      p_header_name_arr      IN   vc_arr_t default g_empty_vc_arr,
      p_header_value_arr     IN   vc_arr_t default g_empty_vc_arr
   );

/* Procedure: retrieve_blob_from_url

   Multiplies two integers.

   Parameters:

      p_url - url to be called

      o_blob - output: the resulting out blob
      o_mime_type - output: the resulting out mime type from the call 

   Returns:

      The two integers multiplied together.
      o_blob - the resulting out blob

   See Also:

      <escape_form_data>
*/
   PROCEDURE retrieve_blob_from_url (
      p_url               VARCHAR2,
      o_blob        OUT   BLOB,
      o_mime_type   OUT   VARCHAR2
   );

/* 
Function: escape_form_data 
Here is some describing text ... 

--- SQL
declare
  l_i number;
begin
  null;

  Select count(*)
    into l_count
    from dual;
end;
---


Parameters:
  s - string to be escaped

Returns: 
the escaped data
*/
   FUNCTION escape_form_data (s VARCHAR2)
      RETURN VARCHAR2;

/*
Function: check_get_request

Parameters:
   This is where you would describe the parameters.

Returns:
   This is where you would describe the return value.
   returns a char

See Also:
   This is where you would include relevant links.
*/
   FUNCTION check_get_request (p_url VARCHAR2)
      RETURN CHAR;
END;
/