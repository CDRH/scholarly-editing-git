<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
  
  <xsl:include href="config.xsl"/>
  <xsl:include href="BinyonDestree_shared.xsl"/>
  

<xsl:param name="display_type"></xsl:param>

  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->

  <!--  <xsl:output method="xml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>-->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PARAMETERS
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- Left for project display rules, currently unused -->
 <!-- <xsl:param name="pagetype"/>
  <xsl:param name="subpagetype"/>-->
  <xsl:param name="type"/>

  <xsl:param name="figures">true</xsl:param>
  <!-- true/false Toggle figures on and off  -->
  <xsl:param name="fw">true</xsl:param>
  <!-- true/false Toggle fw's on and off  -->
  <xsl:param name="pb">true</xsl:param>
  <!-- true/false Toggle pb's on and off  -->

  <!-- link locations - unsure about how these will work in the "real world" -->
  <xsl:param name="fig_location">
    <xsl:text></xsl:text>
  </xsl:param>
  <!-- set figure location  -->
  <!-- delete -->
  <xsl:param name="keyword_link">
    <xsl:text>../../</xsl:text>
  </xsl:param>
  <!-- set keyword link location  -->
  
  <xsl:variable name="idno">
    <xsl:value-of select="normalize-space(//idno[@type='file'])"/>
  </xsl:variable>
  
 

<xsl:template match="s" priority="2">
  <xsl:choose>
    <xsl:when test="@corresp">
      <span>
        <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
        <xsl:attribute name="class">
          <xsl:text>tei_s </xsl:text>
          <xsl:value-of select="@corresp"/>
          <xsl:text> corresponded</xsl:text>
        </xsl:attribute>
       
        <xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <span>
        <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
        <xsl:attribute name="class"><xsl:text>tei_s </xsl:text><xsl:value-of select="@corresp"/></xsl:attribute>
        <xsl:apply-templates/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
  
</xsl:template>
  
  


  <xsl:template match="seg" priority="1">
      &#160;&#160;<span class="tei_seg_side">
            <xsl:variable name="idno">
                <xsl:value-of select="normalize-space(//idno[@type='file'])"/>
            </xsl:variable>
           
            <xsl:variable name="linktext">
                <xsl:choose>
                  <xsl:when test="$idno = 'deorationedominica' or $idno = 'dequinqueseptenis'">translation</xsl:when>
                  <xsl:when test="$idno = 'deorationedominica.trans' or $idno = 'dequinqueseptenis.trans'">original</xsl:when>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="oppositelinktext">
                <xsl:choose>
                    <xsl:when test="$linktext = 'translation'">original</xsl:when>
                    <xsl:when test="$linktext = 'original'">translation</xsl:when>
                </xsl:choose>
            </xsl:variable>
        
        <xsl:choose>
          <xsl:when test="@source">
            
            
            <span class="{substring-before(substring-after(@source, '#'), ':')}">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:otherwise>
            
            
            <span class="{@xml:id}">
              <xsl:apply-templates/>
            </span>
          </xsl:otherwise>
        </xsl:choose>
        
        
            
        </span>
    </xsl:template>
  
  <xsl:template match="/" priority="1">
    <!-- find a better rule for matching bottom of document -->
    <html>
      <head><title>Side by Side View</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
        <link href="../../css/BinyonDestree.css" rel="stylesheet" type="text/css"/>
        <script src="../../js/BinyonDestree.js"> &#160; </script>
        <script src="../../js/BinyonDestree-sidebyside.js"> &#160; </script>
      </head>
      <body class="BinyonDestree side_by_side">
        
        <div class="sidebysideEditionHeader">
          
          <div class="compressedMasthead">
            <a href="http://www.scholarlyediting.org/"><img src="images/compressed_logo.png"/></a>
            
          </div>
          
          
          <h1 class="editionTitle">A Transnational Literary Network Around 1900: The Correspondence between Laurence Binyon and Olivier-Georges Destrée</h1><span class="author">Edited by Eloise Forestier, Gero Guttzeit, and Marysa Demoor</span></div>
        
        
        <div class="comparison_choice_container">
        <a>
          <xsl:attribute name="href">BinyonDestree.html</xsl:attribute>
          <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
          <span>Back to edition</span>
        </a>
        </div>
          
          <xsl:for-each select="//body/div">
            <div class="sidebyside_set">
            <div>
              <xsl:attribute name="class">
                <xsl:text>sidebyside_div sidebyside_orig</xsl:text>
              </xsl:attribute>
            <div class="sidebyside_inner">
            <xsl:apply-templates/>
            </div>
            </div>
            
            <xsl:if test="@xml:lang='fr'">
              <div>
                <xsl:attribute name="class">
                  <xsl:text>sidebyside_div sidebyside_trans</xsl:text>
                </xsl:attribute>
                
                <xsl:variable name="n" select="@n"/>
               
                
                <xsl:apply-templates select="document('../2016/editions/BinyonDestree/xml/BinyonDestree.translation.xml')//div[@n=$n]"></xsl:apply-templates>
              </div>
            </xsl:if>
              
            </div>
           
            
          </xsl:for-each>
        
        <div style="clear:both">
          <div class="notesList">
            <h2>Notes</h2>
            
            <xsl:apply-templates select="//back"/>
          </div>

        </div>
        
        
        
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="/TEI/text[1]">
    
    
    
    
    <div class="main_content">
      
          <xsl:apply-templates/>
       
    </div>
    
    
  </xsl:template>
  
 





</xsl:stylesheet>
