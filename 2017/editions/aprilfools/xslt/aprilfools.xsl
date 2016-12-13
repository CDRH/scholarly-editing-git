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
  <xsl:import href="print.xsl"/>
  
  
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  
  <!-- ==================================================================== -->
  <!--                           PARAMETERS                                 -->
  <!-- ==================================================================== -->
  
  <!--Put any edition wide parameters which need to be accessed throughout the template in here.-->
  
  <xsl:variable name="idno" select="//idno[@type='file']"/>
  
  <!-- ==================================================================== -->
  <!--                            HTML Setup                                 -->
  <!-- ==================================================================== -->
  
  <xsl:template match="/">   
    <html>
      <head>
        <!-- $head_title 
     This is what will show in the browser tab/title bar. May want to keep shorter than edition title. -->
        <title>Mark Twain: April Fool, 1884</title>
        
        <!-- $head_extras (Optional) 
     A for-each will pull each of these in, you can include as many css and javascript files as you want. 
     Use choose or if to make calls conditional -->
        <!--<link rel="stylesheet" href="css/mtp.css"/>
        <link rel="stylesheet" href="css/print.css"/>-->
        <link rel="stylesheet" href="css/aprilfools.css"/>
        <script src="js/script.js">&#160;</script>
      </head>
      
      <body>
        <!-- $body_title -->
        <!-- different from the title in <title>, this one can contain <em> or other html tags.
         Can be statically set or pulled from XML file. -->
        
        <h1>Mark Twain: April Fool, 1884</h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Leslie Myrick and Christopher Ohge <small>Mark Twain Project, University of California, Berkeley</small></div>
        
        <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. Appending #page_info at the end sets the 
         links to start at the edition head. If you add classes on the <li>'s, they will be passed through-->
        <nav>
          <ul>
            <li class="first"><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="sun.html#page_info">Sun</a></li>
            <li><a href="graph/index.html">Network Graph</a></li>
            <li><a href="{$idno}.xml">Page XML &#8659;</a></li>
            <li><a href="extracts.youngidea.xml">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          
          <!--<xsl:copy-of select="/" xpath-default-namespace=""></xsl:copy-of>-->
          
          
          <xsl:apply-templates/>
          
          
          
          
         
          
          
          
          
        </div>  
      </body>
    </html>
  </xsl:template>
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->
  
 
  
  <xsl:template exclude-result-prefixes="#all" match="tei:date">
    <xsl:if test="ancestor::head"><br/></xsl:if><span class="tei_date"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template exclude-result-prefixes="#all" match="tei:sourceline">
    <br/><span class="tei_sourceline"><xsl:apply-templates/></span>
  </xsl:template>
  
  <!-- Individual projects can override matched templates from the
     imported stylesheets above by including new templates here -->
  <!-- Named templates can be overridden if included in matched templates
     here.  You cannot call a named template from directly within the stylesheet tag
     but you can redefine one here to be called by an imported template -->
  
</xsl:stylesheet>