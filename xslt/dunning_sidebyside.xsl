<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
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
            <!--<span class="{translate(@source, '#:[]', '')}">
              <xsl:apply-templates/>
            </span>-->
            
            <span class="{substring-before(substring-after(@source, '#'), ':')}">
              <xsl:apply-templates/>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <!--<span class="{translate(@xml:id, '#:[]', '')}">
              <xsl:apply-templates/>
            </span>-->
            
            <span class="{@xml:id}">
              <xsl:apply-templates/>
            </span>
          </xsl:otherwise>
        </xsl:choose>
        
        
            
            <!--<xsl:choose>
                <xsl:when test="@source">
                    <span id="{translate(@source, '#:[]', '')}" class="clicktext">
                        <a href="#{translate(@source, '#:[]', '')}">
                            <!-\-<xsl:text> [</xsl:text>
                            <xsl:value-of select="$linktext"/>
                            <xsl:text>] </xsl:text>-\->
                        </a>
                    </span>
                    
                    <xsl:apply-templates/>
                </xsl:when>
              <xsl:when test="@xml:id">
                <span id="{translate(@xml:id, '#:[]', '')}" class="clicktext">
                  <a href="#{translate(@xml:id, '#:[]', '')}">
                    <!-\-<xsl:text> [</xsl:text>
                    <xsl:value-of select="$linktext"/>
                    <xsl:text>] </xsl:text>-\->
                  </a>
                </span>
                
                <xsl:apply-templates/>
              </xsl:when>
                <xsl:otherwise>
                    <!-\-<xsl:apply-templates/>-\->
                </xsl:otherwise>
            </xsl:choose>-->
            
        </span>
    </xsl:template>
  
  <xsl:template match="/">
    <!-- find a better rule for matching bottom of document -->
    <html>
      <head><title>Test Page</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
        <link href="../../css/dunning.css" rel="stylesheet" type="text/css"/>
        <script src="../../js/dunning.js"> &#160; </script>
        <script src="../../js/dunning-sidebyside.js"> &#160; </script>
      </head>
      <body class="dunning">
        <ul class="side_by_side_nav">
          <li><a href="?display_type=a">De oratione dominica, original &amp; translation</a></li>
          <li><a href="?display_type=b">De quinque septenis , original &amp; translation</a></li>
          <li><a href="?display_type=c">De oratione dominica &amp; De quinque septenis (originals)</a></li>
          <li><a href="?display_type=d">On the Lord’s Prayer &amp; On the Five Sevens (translations)</a></li>
          <li><a href="intro.dequinqueseptenis-deorationedominica.dunning.html">Back to edition</a></li>
        </ul>

        
        <div style="height:100%">
          <div style="width:50%; float:left; height:100%;">
            
            <span class="tei_seg_side zzz" ><span class="yyy">This is a test of highlighting
              <br class="br_diplomatic"></br><span class="tei_lb">&#160;</span></span></span>
              
              
            <xsl:choose>
              <xsl:when test="$display_type = 'a'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-oratione-dominica.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'b'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-quinque-septenis.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'c'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-oratione-dominica.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'd'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-oratione-dominica-trans.xml')/TEI"/></xsl:when>
            </xsl:choose>
            </div>
          <div style="width:50%; float:right; height:100%;">
            
            <span class="tei_seg_side zzz" ><span class="yyy">This is also a test of highlighting
              <br class="br_diplomatic"></br><span class="tei_lb">&#160;</span></span></span>
            
            <xsl:choose>
              <xsl:when test="$display_type = 'a'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-oratione-dominica-trans.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'b'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-quinque-septenis-trans.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'c'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-quinque-septenis.xml')/TEI"/></xsl:when>
              <xsl:when test="$display_type = 'd'"><xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-quinque-septenis-trans.xml')/TEI"/></xsl:when>
            </xsl:choose>
           <!-- 
           a - both originals
           b - both translations
           c - dominica orig and translation
           d - septenis orig and translation
           -->
            
            </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="/TEI/text[1]">
    
    
    
    
    <div class="main_content">
      <!--<xsl:choose>
        <xsl:when test="$type='diplomatic'">
          <!-\-<div class="diplomatic">-\->
            <xsl:apply-templates/>
          <!-\-</div>-\->
        </xsl:when>
        <xsl:when test="$type='regularized'">
          <div class="regularized">
            <!-\-<xsl:apply-templates/>-\->
          </div>
        </xsl:when>
        <xsl:otherwise>-->
          <xsl:apply-templates/>
        <!--</xsl:otherwise>
      </xsl:choose>-->
    </div>
    
    
  </xsl:template>
  
  
   






</xsl:stylesheet>
