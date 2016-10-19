<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
  <xsl:output indent="no"/>

  <xsl:include href="../../../../template_xslt/base.xsl"/>
  <xsl:include href="dunning_shared.xsl"/>
  


  <!--  <xsl:output method="xml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>-->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PARAMETERS
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- Left for project display rules, currently unused -->
  <xsl:param name="pagetype"/>
  <xsl:param name="subpagetype"/>
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

  <!-- =========================================
  Copied from stuf_diplomatica and elsewhere
  ============================================-->

  <xsl:template name="volCitation">
    <h5>2016, Volume 37</h5>
  </xsl:template>

  <xsl:template name="witnessName"/>

  <xsl:template name="essayNav"/>

  <xsl:template name="editionNav">

    <ul>
      <li id="editionNavPre">Go to:</li>
      <li id="editionNav1">
        <a href="intro.dunning.html">Introduction</a>
      </li>
      <li id="editionNav2">
        <a href="de-oratione-dominica.dunning.html?type=regularized">De oratione dominica (On the Lord’s Prayer)</a>
      </li>
      <li id="editionNav3">
        <a href="de-quinque-septenis.dunning.html?type=regularized">De quinque septenis (On the Five Sevens)</a>
      </li>
      <li id="editionNav4">
        <a href="dunning-sidebyside.html?display_type=a">Side by Side View</a>
      </li>
      <li id="editionNav4">
        <a href="Dunning_De-oratione-dominica/xml/dequinqueseptenis-deorationedominica.zip">Download XML</a>
      </li>
      

    </ul>


  </xsl:template>
  
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Add info to bottom of document
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
  <xsl:template match="text">
    <!-- find a better rule for matching bottom of document -->
    
      
    
    <xsl:apply-templates/>
    
    
    <xsl:if test="//note[@place='foot']">
      <br/>
      <hr/>
    </xsl:if>
    <div class="footnotes">
      <xsl:text> </xsl:text>
      <xsl:for-each select="//note[@place='foot']">
        <p>
          <span class="notenumber"><xsl:value-of select="substring(@xml:id, 2)"/>.</span>
          <xsl:text> </xsl:text>
          <xsl:apply-templates/>
          <xsl:text> </xsl:text>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:text>body</xsl:text>
              <xsl:value-of select="@xml:id"/>
              
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:text>foot</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:text>[back]</xsl:text>
          </a>
        </p>
      </xsl:for-each>
    </div>
  </xsl:template>
  
  <!-- This is here so it does not link in the side by side view. -->
  
  <xsl:template match="quote">
    
    <span class="quote" title="{@source}">
      <a>
        <xsl:attribute name="href">
          <xsl:text>http://data.perseus.org/citations/</xsl:text>
          <xsl:choose>
            <xsl:when test="contains(@source,' ')">
              <xsl:value-of select="substring-before(@source,' ')"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="@source"/></xsl:otherwise>
          </xsl:choose>
          
        </xsl:attribute>
        
        <xsl:apply-templates/>
      </a>
    </span>
  </xsl:template>
  
  <xsl:template match="/TEI/text[1]">
    
   

    
   
    
    <div class="main_content">
      
      
      <xsl:call-template name="options_menu"/>
      
      <xsl:call-template name="frontmatter"/>
      
      <xsl:choose>
        <xsl:when test="$type='diplomatic'">
          <div class="diplomatic">
            
            <xsl:apply-templates/>
          </div>
        </xsl:when>
        <xsl:when test="$type='regularized'">
          <div class="regularized">
            <xsl:apply-templates/>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    
  </xsl:template>  
  
  <xsl:template name="frontmatter">
    <div class="frontmatter">
      <xsl:choose>
        <xsl:when test="$idno = 'intro.dunning'">
          <h1>Introduction</h1>
          <span class="byline">Andrew Dunning</span>
        </xsl:when>
        <xsl:otherwise>
          <h1><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title[1]"/></h1>
          <span class="byline"><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author[1]"/></span>
        </xsl:otherwise>
      </xsl:choose>
      
    </div>
  </xsl:template>


  
  
<xsl:template name="options_menu">
  
  <!--<p>
      <xsl:value-of select="$idno"/>
    </p>
     <p>[[[<xsl:value-of select="$url_part"/>]]]</p> -->
  
  <xsl:if test="$url_part = 'de-oratione-dominica' or $url_part = 'de-quinque-septenis'">
    <div class="controls_dunning">
      <div class="orig_trans_toggle">
        <div class="original_container">
          <a>
            <xsl:attribute name="href"><xsl:value-of select="$url_part"/><xsl:text>.dunning.html?type=diplomatic</xsl:text></xsl:attribute>
            <xsl:attribute name="class"><xsl:text>original toggle toggleleft</xsl:text>
              <xsl:if test="$idno = 'deorationedominica' or $idno = 'dequinqueseptenis'"><xsl:text> selected</xsl:text></xsl:if></xsl:attribute>
            <span>Original</span>
          </a>
          <xsl:if test="$idno = 'deorationedominica' or $idno = 'dequinqueseptenis'">
            <div class="reg_dip_toggle">
              <div class="regularized_toggle_container">
                <a>
                  <xsl:attribute name="href"><xsl:value-of select="$url_part"/><xsl:text>.dunning.html?type=regularized</xsl:text></xsl:attribute>
                  <xsl:attribute name="class">
                    <xsl:text>diplomatic_toggle toggle toggleleft</xsl:text>
                    <xsl:if test="$type='regularized'"> selected</xsl:if>
                  </xsl:attribute>
                  <span>Regularized</span></a>
              </div>
              <div class="diplomatic_toggle_container">
                <a>
                  <xsl:attribute name="href"><xsl:value-of select="$url_part"/><xsl:text>.dunning.html?type=diplomatic</xsl:text></xsl:attribute>
                  <xsl:attribute name="class">
                    <xsl:text>diplomatic_toggle toggle toggleright</xsl:text>
                    <xsl:if test="$type='diplomatic'"> selected</xsl:if>
                  </xsl:attribute>
                  <span>Diplomatic</span></a>
              </div>
            </div>
          </xsl:if>
        </div>
        <div class="translation_container">
          <a>
            <xsl:attribute name="href"><xsl:value-of select="$url_part"/><xsl:text>-trans.dunning.html?type=diplomatic</xsl:text></xsl:attribute>
            <xsl:attribute name="class"><xsl:text>original toggle toggleright</xsl:text>
              <xsl:if test="$idno = 'deorationedominica.trans' or $idno = 'dequinqueseptenis.trans'"><xsl:text> selected</xsl:text></xsl:if></xsl:attribute>
            <!--href="{$url_part}-trans.dunning.html" class="translation toggle toggleright">--><span>Translation</span></a>
        </div>
        <br/>
        <div class="options_container">
          <h4 class="options">Options</h4>
          
          <a>
            <xsl:attribute name="href">#</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>highlight_quotes button</xsl:text></xsl:attribute>
            <span>Highlight Quotes</span></a> <span id="highlight_quotes_link">(<a href="#">?</a>)</span> <div id="highlight_quotes_note">Highlight Quotes: Show quotations of De quinque septenis in De oratione dominica. <br/>(Note: Quotes may appear farther below, scroll down to view)</div>
          <a>
            <xsl:attribute name="href">#</xsl:attribute>
            <xsl:attribute name="class"><xsl:text>line_breaks button</xsl:text></xsl:attribute>
            <span>Disable Line Breaks</span></a> <span id="line_breaks_link">(<a href="#">?</a>)</span> <div id="line_breaks_note">Line Breaks: Toggle display of line breaks used in the manuscript.</div>
          
          <xsl:if test="$idno = 'dequinqueseptenis'">
            <a>
              <xsl:attribute name="href">#</xsl:attribute>
              <xsl:attribute name="class"><xsl:text>handwritten_text button</xsl:text></xsl:attribute>
              <span>Display Annotations</span>
            </a>
            <span id="handwritten_text_link">(<a href="#">?</a>)</span> <div id="handwritten_text_note">Display Annotations: Show later additions to the manuscript. <br/>(Note: Annotations may appear farther below, scroll down to view)</div>
          </xsl:if>
          <!--<a>
              <xsl:attribute name="href">#</xsl:attribute>
              <xsl:attribute name="class"><xsl:text>translation_links button</xsl:text></xsl:attribute>
              <span>Hide Translation Links</span></a>-->
        </div>
      </div>
      
    </div>
    
  </xsl:if>
  
</xsl:template>




</xsl:stylesheet>
