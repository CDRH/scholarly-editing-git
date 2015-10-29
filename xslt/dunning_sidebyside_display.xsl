<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">

 
<xsl:template match="/">
  
  <html><head>
    <style>
      body, div, iframe { height:100%; display:block; margin:0; height: 100vh;        /* Viewport-relative units */
      width: 100vw;}
      iframe {width:100%; height:100%; }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>
      $(function () {
        $("a").click(
          $("#iframe2").attr( "src", "http://cdrhsites.unl.edu/cocoon/scholarly-editing-git/2016/editions/de-oratione-dominica-trans.dunning-sidebyside.html?type=diplomatic#lDQSDOD-5210vb37â€“210vb39" );
        
        );
      });
    </script>
  </head>
    <body>
       <a href="#" style="position:absolute;top:0;right:0;">Test</a>
      <div id="div1" style="width:50%; float:left;">
        <iframe id="iframe1" src="http://cdrhsites.unl.edu/cocoon/scholarly-editing-git/2016/editions/de-oratione-dominica.dunning-sidebyside.html?type=diplomatic"></iframe>
    </div>
      <div id="div2" style="width:50%; float:right;">
 
        <iframe id="iframe2" src="http://cdrhsites.unl.edu/cocoon/scholarly-editing-git/2016/editions/de-oratione-dominica-trans.dunning-sidebyside.html?type=diplomatic"></iframe>
    </div>
  </body></html>
  
  
</xsl:template>




</xsl:stylesheet>
