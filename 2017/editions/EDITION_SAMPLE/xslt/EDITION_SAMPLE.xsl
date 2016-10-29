<?xml version="1.0"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
  <!-- ==================================================================== -->
  <!--                             IMPORTS                                  -->
  <!-- ==================================================================== -->
  
  <xsl:import href="../../../../template_xslt/lib/html_formatting.xsl"/>
  <xsl:import href="../../../../template_xslt/lib/personography_encyclopedia.xsl"/>
  
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  
  <!-- ==================================================================== -->
  <!--                           PARAMETERS                                 -->
  <!-- ==================================================================== -->
  
  <!--Put any edition wide parameters which need to be accessed throughout the template in here.-->
  
  <!-- ==================================================================== -->
  <!--                            HTML Setup                                 -->
  <!-- ==================================================================== -->
  
  <xsl:template match="/">   
<html>
  <head>
    <!-- $head_title 
         This is what will show in the browser tab/title bar. 
         May wan tot keep shorter than edition title. -->
    <title>Edition Title</title>
    
    <!-- $head_extras (Optional) 
         A for-each will pull each of these in, you can include 
         as many css and javascript files as you want. 
         Use choose or if to make calls conditional -->
    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/script.js">&#160;</script>
  </head>
  
  <body>
    <!-- $body_title -->
    <!-- different from the title in <title>, 
         this one can contain <em> or other html tags.
         Can be statically set or pulled from XML file. -->
    <h1>Edition title <em>With Emphasis</em></h1>
    
    <!-- $body_author
         must be in <div class="body_author"> -->
    <div class="body_author">Author Smith <em>A University Name</em></div>
    
    <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. 
         Appending #page_info at the end sets the links to start at the edition head. -->
    <nav>
      <ul>
        <li><a href="intro.html#page_info">Introduction</a></li>
        <li><a href="2016preface.html#page_info">2016 Preface</a></li>
        <li><a href="1867preface.html#page_info">1867 Preface</a></li>
        <li><a href="extracts.html#page_info">Edition</a></li>
        <li><a href="{/TEI/@xml:id}.xml" target="_blank">Page XML &#8659;</a></li>
        <li><a href="extracts.youngidea.xml" target="_blank">Edition XML &#8659;</a></li>
      </ul>
    </nav>
    
    <!-- $edition_controls (Optional) -->
    <!-- Must be in <div class="edition_controls"> -->
    
    <!-- $site_content -->
    <!-- Must be in <div class="main_content"> -->
    <div class="main_content">
      <xsl:apply-templates/>
      
      
      <br/>
      <button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">Click to toggle popover</button>
      <br/>
      
      
      
    </div>
    
  </body>
</html></xsl:template>
  
  
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->
  
  
  
  
  <!-- Individual projects can override matched templates from the
     imported stylesheets above by including new templates here -->
  <!-- Named templates can be overridden if included in matched templates
     here.  You cannot call a named template from directly within the stylesheet tag
     but you can redefine one here to be called by an imported template -->
  
  <!-- The below will override the entire text matching template -->
  <!-- <xsl:template match="text">
      <xsl:call-template name="fake_template"/>
    </xsl:template> -->
  
  <!-- The below will override templates with the same name -->
  <!-- <xsl:template name="fake_template">
      This fake template would override fake_template if it was defined
      in one of the imported files
    </xsl:template> -->
</xsl:stylesheet>