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
  <!-- If this file is living in a projects directory, the paths will be
     ../../../scripts/xslt/cdrh_tei_to_html/lib/html_formatting.xsl -->
  
  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  
  
  <!-- ==================================================================== -->
  <!--                           PARAMETERS                                 -->
  <!-- ==================================================================== -->
  
  <xsl:param name="figures">true</xsl:param>  <!-- true/false Toggle figures on and off  -->
  <xsl:param name="fw">true</xsl:param>       <!-- true/false Toggle fw's on and off  -->
  <xsl:param name="pb">true</xsl:param>       <!-- true/false Toggle pb's on and off  -->
  <xsl:param name="site_url"/>                <!-- the site url (http://codyarchive.org) -->
  <xsl:param name="fig_location"></xsl:param> <!-- set figure location  -->
  
  
  <!-- ==================================================================== -->
  <!--                            HTML Setup                                 -->
  <!-- ==================================================================== -->
  
  <xsl:template match="/">   
    <html>
      <head>
        <!-- $site_head_title -->
        <title>Edition Title</title>
        
        <!-- $site_head_extras (Optional) -->
        <link rel="stylesheet" href="css/style.css"/>
        <script src="js/script.js">&#160;</script>
        <script>
          <![CDATA[
              
          ]]>
        </script>
      </head>
      
      <body>
        <!-- $site_body_title -->
        <h1>Science and Art: A Farce in Two Acts</h1>
        
        <!-- $site_body_author -->
        
        <div class="body_author">Edited by Rebecca Nesvet</div>
        
        <!-- $site_edition_navigation -->
        <nav>
          <ul>
            <li><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="script.html#page_info">Edition</a></li>
            <li><a href="script.scienceart.xml" target="_blank">Edition XML <span class="circle">&#8659;</span></a></li>
          </ul>
        </nav>
        
        <!-- $site_edition_controls (Optional) -->
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