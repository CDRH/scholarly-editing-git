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
  
  <xsl:output method="xml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
  
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
        <title>“The Effects of the Seven Sins”: A Critical Edition</title>
        
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
        <h1><em>“The Effects of the Seven Sins”</em>: A Critical Edition</h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Krista A. Murchison, <em>Leiden University</em></div>
        
        <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. Appending #page_info at the end sets the 
         links to start at the edition head. If you add classes on the <li>'s, they will be passed through-->
        <nav>
          <ul>
            <li class="first"><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="original.html#page_info">Original</a></li>
            <li><a href="translation.html#page_info">Translation</a></li>
            <li><a href="sidebyside.html#page_info">Side By Side</a></li>
            <xsl:if test="$idno != 'sidebyside.sevensins'"><li><a href="{$idno}.xml">Page XML &#8659;</a></li></xsl:if>
            <li><a href="extracts.youngidea.xml">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          
          <xsl:if test="$idno = 'sidebyside.sevensins'">
            <div class="full_width"></div>
          </xsl:if>
          
          <div class="row controls text-center regularized" id="controls_sevensins" >
            <div class="col-md-4 text-center">
              <a class="btn btn-default btn-xs" id="button_regularize" href="#" role="button">Regularized</a>
              <a class="btn btn-default btn-xs" id="button_diplomatic" href="#" role="button">Diplomatic</a>
            </div>
            <div class="col-md-4 text-center">
              <!--<a class="btn btn-default btn-xs" id="button_highlight" href="#" role="button">Highlight Quotes</a>
            <a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a>-->
              <a class="btn btn-default btn-xs" id="button_line_breaks" href="#" role="button">Line Breaks</a>
              <!--<a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a>-->
              <!-- <a class="btn btn-default btn-xs" id="button_notes" href="&amp;notes=true" role="button">Display Notes</a>
            <a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a><br/>-->
              <a class="btn btn-default btn-xs" id="button_editorial_marks" href="#" role="button">Editorial Marks</a>
            </div>
            <div class="col-md-4 text-center">
              <a class="btn btn-default btn-xs" id="button_toggle_Bd" href="#" role="button">Toggle Bd</a>
              <a class="btn btn-default btn-xs" id="button_toggle_Tr" href="#" role="button">Toggle Tr</a>
              <a class="btn btn-default btn-xs" id="button_toggle_Em" href="#" role="button">Toggle Em</a>
            </div>
          </div><!-- /row -->
         <!-- <div class="">
            <br/>-->
            
          <!--  <!-\-<a class="btn btn-default btn-xs" id="button_highlight" href="#" role="button">Highlight Quotes</a>
            <a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a>-\->
            <a class="btn btn-default btn-xs" id="button_line_breaks" href="#" role="button">Line Breaks</a>
            <!-\-<a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a>-\->
           <!-\- <a class="btn btn-default btn-xs" id="button_notes" href="&amp;notes=true" role="button">Display Notes</a>
            <a href="#"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span></a><br/>-\->
            <a class="btn btn-default btn-xs" id="button_editorial_marks" href="#" role="button">Editorial Marks</a>
            <br/>
            
            <a class="btn btn-default btn-xs" id="button_toggle_Bd" href="#" role="button">Toggle Bd</a>
            <a class="btn btn-default btn-xs" id="button_toggle_Tr" href="#" role="button">Toggle Tr</a>
            <a class="btn btn-default btn-xs" id="button_toggle_Em" href="#" role="button">Toggle Em</a>-->
            
          <!--</div>-->
          <xsl:choose>
            <xsl:when test="$idno = 'sidebyside.sevensins'">
              <div class="full_width disable_line_breaks regularized" id="sevensins_content">
                <div class="row">
                  <div class="col-xs-6">
                    <xsl:apply-templates select="document('../xml/original.sevensins.xml')/TEI"/>
                  </div><!-- /div -->
                  <div class="col-xs-6">
                    <xsl:apply-templates select="document('../xml/translation.sevensins.xml')/TEI"/>
                </div><!-- /div -->
                </div><!-- /row -->
              </div><!-- /full_width -->
              
            </xsl:when>
            <xsl:otherwise>
              <div class="disable_line_breaks regularized" id="sevensins_content">
                <xsl:apply-templates/>
              </div>
            </xsl:otherwise>
          </xsl:choose>
          
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
  
  <xsl:template match="lb">
    <div class="tei_line_break">&#160;</div>
  </xsl:template>

  <!-- Can't do this unless there's xslt3, only available in commercial saxon -->
  <!--<xsl:template match="anchor/following-sibling::text()">
    zzzzzz[<xsl:apply-templates/>]
  </xsl:template>-->
  
  <xsl:template match="w"><span class="tei_w"><xsl:apply-templates/></span></xsl:template>
  
  <!-- this does not work either, and leads to more duplicates :/ -->
 <!-- <xsl:template match="anchor[following-sibling::app]">

    <div style="background-color:blue"><xsl:apply-templates select="
      
      ./following-sibling::* except following::app
      
      "></xsl:apply-templates></div>
  </xsl:template>-->
  
  <!-- Try this, Nikki provided -->
  
  <!--<xsl:template match="text()
    [preceding::span[1][substring-after(@hand,'#')=preceding::handNote[@scribeRef='#ww']/@xml:id]/translate(@to,'#','')
    =
    following::anchor[1]/@xml:id]">
    <span class="highlight">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>-->
  
  
 <!-- <xsl:template match="handShift">
    <xsl:variable name="handShift_new"><xsl:value-of select="@new"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="preceding::handNote[concat('#',@xml:id)=$handShift_new]/@scribeRef='#ww'"><xsl:text disable-output-escaping='yes'>&lt;span class="marginalia_hand"></xsl:text></xsl:when>
      <xsl:when test="preceding::handShift[1][(substring-after(@new,'#'))=(preceding::handNote[@scribeRef='#ww']/@xml:id)] and not(self::handNote[concat('#',@xml:id)=$handShift_new]/@scribeRef='#ww')"><xsl:text disable-output-escaping='yes'>&lt;/span></xsl:text></xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
  <!--<xsl:template match="text()
    [preceding::span[1][substring-after(@hand,'#')=preceding::handNote[@scribeRef='#ww']/@xml:id]/translate(@to,'#','')
    =
    following::anchor[1]/@xml:id]">
    zzz
  </xsl:template>-->
  
  
  
  <xsl:template match="anchor">
    <span class="ed_mark"><xsl:text> [</xsl:text></span>
   
  </xsl:template>
  
  <!--<xsl:template match="app"/>-->
  
  
  
  <xsl:template match="app" mode="pop">
    <span>
      <xsl:attribute name="class">
        <xsl:text>hide popper-content tei_app</xsl:text>
        <xsl:if test="@from">
          <xsl:text> tei_from_</xsl:text>
          <xsl:value-of select="translate(@from,'#','')"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates mode="pop"/>
    </span>
  </xsl:template>
  
  <xsl:template match="app">
    <span class="ed_mark"><xsl:text>] </xsl:text></span>
    
    <span>
      <xsl:attribute name="class">
        <xsl:text>tei_app</xsl:text>
        <xsl:if test="@from">
          <xsl:text> tei_from_</xsl:text>
          <xsl:value-of select="translate(@from,'#','')"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
    
    <a class="popper" data-toggle="popover" title="test" content="">[*]</a>
    <xsl:apply-templates select="." mode="pop"></xsl:apply-templates>
    
  </xsl:template>
  
  <xsl:template match="lem | rdg" mode="pop">
    <span>
      
      <xsl:attribute name="class">
        <xsl:text>tei_</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:if test="@wit">
          <xsl:text> tei_wit_pop_</xsl:text>
          <xsl:value-of select="translate(@wit,'#','')"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:value-of select="substring-after(@wit,'#')"/>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/><br/>
    </span>
  </xsl:template>
  
  <xsl:template match="lem | rdg">
    <span>
     
      <xsl:attribute name="class">
        <xsl:text>hide tei_</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:if test="@wit">
          <xsl:text> tei_wit_</xsl:text>
          <xsl:value-of select="translate(@wit,'#','')"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:value-of select="substring-after(@wit,'#')"/>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="choice">
    <span class="tei_choice">
      <span class="tei_abbr"><span class="ed_mark">[</span><xsl:apply-templates select="abbr"/><span class="ed_mark">]</span></span>
      <span class="tei_expan"><span class="ed_mark">{</span><xsl:apply-templates select="expan"/><span class="ed_mark">}</span></span>
    </span>
  </xsl:template>
  
  
</xsl:stylesheet>