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
        <title>Science and Art</title>
        
        <!-- $head_extras (Optional) 
     A for-each will pull each of these in, you can include as many css and javascript files as you want. 
     Use choose or if to make calls conditional -->
        <link rel="stylesheet" href="css/style.css"/>
        <script src="js/script.js">&#160;</script>
      </head>
      
      <body>
        <!-- $body_title -->
        <!-- different from the title in <title>, this one can contain <em> or other html tags.
         Can be statically set or pulled from XML file. -->
        <h1><em>Science and Art, a Farce, in Two Acts</em></h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Edited by Rebecca Nesvet</div>
        
        <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. Appending #page_info at the end sets the 
         links to start at the edition head. If you add classes on the <li>'s, they will be passed through-->
        <nav>
          <ul>
            <li class="first"><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="script.html#page_info">Script</a></li>
            <li><a href="{$idno}.xml">Page XML &#8659;</a></li>
            <li><a href="scienceart.zip">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          <xsl:apply-templates/>
        </div>  
      </body>
    </html>
  </xsl:template>
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->
  
  <!-- Individual projects can override matched templates from the
     imported stylesheets above by including new templates here -->
  <!-- Named templates can be overridden if included in matched templates
     here.  You cannot call a named template from directly within the stylesheet tag
     but you can redefine one here to be called by an imported template -->
  
  <xsl:template match="text">
    <xsl:apply-templates/>
    <xsl:if
      test="
      //body//note[@type = 'editorial']
      or //body//note[@place = 'foot']
      or //back//note">
      <div class="notesList">
        <xsl:if test="contains(preceding::idno[@type='file'], 'script')"><br/></xsl:if>
        <h2>Notes</h2>
        <xsl:if test="preceding::bibl//note[@type='project']"><div class="footnote"><xsl:apply-templates select="preceding::bibl//note[@type='project']"/></div></xsl:if>
        <xsl:for-each select="//text//note">
          <div class="footnote">
            <xsl:attribute name="id">
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates select="." mode="footnotes"/>
          </div>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="note[@type='project']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="note" mode="footnotes">
    <xsl:variable name="noteCount" select="count(preceding::note)"/>
    <p><xsl:value-of select="$noteCount"/>
    
    <xsl:text>. </xsl:text>
    <span class="note_text">
      <xsl:apply-templates/>
    </span>
    <xsl:text> [</xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:text>#inline</xsl:text>
        <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
      <xsl:text>back</xsl:text>
    </a>
    <xsl:text>]</xsl:text></p>
  </xsl:template>
  
  <xsl:template match="supplied">
    <span class="supplied"><!--<xsl:text>[</xsl:text>--><xsl:apply-templates/><!--<xsl:text>]</xsl:text>--></span>
  </xsl:template>
  
  <xsl:template match="figure" priority="1">
    <span class="figure_center">
      <!--<xsl:attribute name="class">
        <xsl:text>tei_figure</xsl:text>
      </xsl:attribute>-->
      <img>
        <xsl:attribute name="src">
          <xsl:text>images/viewsize/</xsl:text>
          <xsl:value-of select="child::graphic/attribute::url"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="child::figDesc"/>
        </xsl:attribute>
      </img></span>
    <span class="cap"><h5>
      <strong><xsl:apply-templates select="child::head"/></strong><xsl:text>: </xsl:text><xsl:apply-templates select="child::figDesc"/>
    </h5>
      
    </span>
  </xsl:template>
  
  <xsl:template match="//tei:lg">
    <div class="tei_lg">
      <xsl:apply-templates/><br/>
    </div>
  </xsl:template>
  
  <xsl:template match="//tei:l">
    <span>
      <xsl:attribute name="class">
        <xsl:text>poem_line tei_l lineindent</xsl:text>
        <xsl:if test="@rend">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@rend"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>