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
  
  <xsl:import href="lib/html_formatting.xsl"/>
  <xsl:import href="lib/personography_encyclopedia.xsl"/>
  <!-- If this file is living in a projects directory, the paths will be
     ../../../scripts/xslt/cdrh_tei_to_html/lib/html_formatting.xsl -->
  
  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->
  
  <xsl:variable name="title">
    <xsl:apply-templates select="/TEI/teiHeader/fileDesc/titleStmt/title[@type='main']"/>
  </xsl:variable>
  
  <xsl:template match="/">   
    <html>
      <head><title><xsl:value-of select="$title/text()"/></title></head>
    <body>
      <h1><xsl:copy-of select="$title"/></h1>
      
      <div class="main_content">
        <xsl:apply-templates/>
      </div>
      
    </body>
    </html></xsl:template>
  
 
</xsl:stylesheet>