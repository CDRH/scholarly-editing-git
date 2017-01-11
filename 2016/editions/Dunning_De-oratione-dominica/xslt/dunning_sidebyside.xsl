<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
  <xsl:include href="../../../../config/config.xsl"/>
  <xsl:include href="dunning_shared.xsl"/>

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
    <xsl:text>Dunning_De-oratione-dominica/figures/</xsl:text>
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
  
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Stylesheet Rules from Andy's Sheet
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
  
  

  <!-- =========================================
  Copied from stuf_diplomatica and elsewhere
  ============================================-->



    <xsl:template match="seg" priority="1">
      &#160;&#160;<span class="tei_seg_side">
            <xsl:variable name="idno">
                <xsl:value-of select="normalize-space(//idno[@type='file'])"/>
            </xsl:variable>
            <xsl:variable name="linksource">
                <xsl:choose>
                    <xsl:when test="$idno = 'deorationedominica'"
                        >de-oratione-dominica-trans.dunning.html</xsl:when>
                    <xsl:when test="$idno = 'deorationedominica.trans'"
                        >de-oratione-dominica.dunning.html</xsl:when>
                  <xsl:when test="$idno = 'dequinqueseptenis'"
                    >de-quinque-septenis-trans.dunning.html</xsl:when>
                  <xsl:when test="$idno = 'dequinqueseptenis.trans'"
                    >de-quinque-septenis.dunning.html</xsl:when>
                </xsl:choose>
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
  
  <xsl:template match="/">
    <!-- find a better rule for matching bottom of document -->
    <html>
      <head><title>Side by Side view</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
        <script src="../../js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js"> &#160; </script>
        <link href="../editions/Dunning_De-oratione-dominica/css/dunning.css" rel="stylesheet" type="text/css"/>
        <link href="../../js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css" rel="stylesheet" type="text/css"/>
        <!--<script src="../editions/Dunning_De-oratione-dominica/js/javascript.js"> &#160; </script>-->
        <script src="../editions/Dunning_De-oratione-dominica/js/dunning.js"> &#160; </script>
        <script src="../editions/Dunning_De-oratione-dominica/js/dunning-sidebyside.js"> &#160; </script>
      </head>
      <body class="dunning side_by_side dunning_{$display_type}">
        
        
        
        
        
        <div class="sidebysideEditionHeader">
          
          <div class="compressedMasthead">
            <a href="{$siteroot}"><img src="../../template_images/compressed_logo.png"/></a>
            
          </div>
          
          
          <h1 class="editionTitle">Hugh of St Victor's De quinque septenis (On the Five Sevens) and its Versification in Samuel Presbiter's De oratione dominica (On the Lord's Prayer)</h1><span class="author">edited by Andrew Dunning</span></div>
        
        
        
        <div class="comparison_choice_container">
          <a>
            <xsl:attribute name="href">?display_type=a</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
            <span>De oratione dominica &amp; De quinque septenis (originals)</span>
          </a>
          
          <a>
            <xsl:attribute name="href">?display_type=b</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
            <span>On the Lord’s Prayer &amp; On the Five Sevens (translations)</span>
          </a>
          
          <a>
            <xsl:attribute name="href">?display_type=c</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
            <span>De oratione dominica, original &amp; translation</span>
          </a>
          
          <a>
            <xsl:attribute name="href">?display_type=d</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
            <span>De quinque septenis, original &amp; translation</span>
          </a>
          
          <a>
            <xsl:attribute name="href">intro.dunning.html</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>comparison_choice</xsl:text></xsl:attribute>
            <span>Back to edition</span>
          </a>
        </div>
        
       
        <div class="regularized">
        
        <div style="height:100%">
          <div style="width:50%; float:left; height:100%;">
            
           
              
              
            <xsl:choose>
              <xsl:when test="$display_type = 'a'"><xsl:apply-templates select="document('../xml/de-oratione-dominica.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'b'"><xsl:apply-templates select="document('../xml/de-oratione-dominica-trans.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'c'"><xsl:apply-templates select="document('../xml/de-oratione-dominica.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'd'"><xsl:apply-templates select="document('../xml/de-quinque-septenis.xml')/TEI"/></xsl:when>
              
            </xsl:choose>
            </div>
          <div style="width:50%; float:right; height:100%;">
            
           
            
            <xsl:choose>
              <xsl:when test="$display_type = 'a'"><xsl:apply-templates select="document('../xml/de-quinque-septenis.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'b'"><xsl:apply-templates select="document('../xml/de-quinque-septenis-trans.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'c'"><xsl:apply-templates select="document('../xml/de-oratione-dominica-trans.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'd'"><xsl:apply-templates select="document('../xml/de-quinque-septenis-trans.xml')/TEI"/></xsl:when>
              
            </xsl:choose>
           <!-- 
           a - dominica orig and translation
           b - septenis orig and translation
           c - both originals
           d - both translations
           
           -->
          </div>
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
