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
        <h1>“The Effects of the Seven Sins”: A Critical Edition</h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Edited by Krista A. Murchison</div>
        
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
            <li><a href="sevensins.zip">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          
          <div>
            <xsl:attribute name="class">
              <xsl:if test="$idno = 'intro.sevensins'">sevensins_intro</xsl:if>
            </xsl:attribute>
            
          
          <xsl:if test="$idno = 'sidebyside.sevensins'">
            <div class="full_width"></div>
          </xsl:if>
          
          <xsl:if test="$idno != 'intro.sevensins'">
            <div class="controls regularized" id="controls_sevensins" >
            <div class="row">
            
            <div class="col-md-1 text-center">
              <a class="btn btn-primary btn-xs" type="button" data-toggle="collapse" data-target="#toggle_key_text" aria-expanded="true" aria-controls="collapseExample">
                Key
              </a>
            </div>
       
            
            <div class="col-md-4 text-center">
              <a class="btn btn-default btn-xs" id="button_line_breaks" href="#" role="button">Line Breaks</a>
              <a class="btn btn-default btn-xs" id="button_editorial_marks" href="#" role="button">Editorial Marks</a>
            </div>
            <div class="col-md-3 text-center">
              <xsl:if test="$idno != 'translation.sevensins'">
              <a class="btn btn-default btn-xs" id="button_regularize" href="#" role="button">Regularized</a>
              <a class="btn btn-default btn-xs" id="button_diplomatic" href="#" role="button">Diplomatic</a>
              </xsl:if>
              
            </div>
            <div class="col-md-4 text-center">
              <a class="btn btn-default btn-xs" id="button_toggle_Bd" href="#" role="button">Toggle Bd</a>
                <a class="popper" data-toggle="popover" title="" content="" data-original-title="test">[?]</a>
                <span class="hide popper-content"><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness[@xml:id='Bd']"/></span>
              <a class="btn btn-default btn-xs" id="button_toggle_Tr" href="#" role="button">Toggle Tr</a>
                <a class="popper" data-toggle="popover" title="" content="" data-original-title="test">[?]</a>
                <span class="hide popper-content"><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness[@xml:id='Tr']"/></span>
              <a class="btn btn-default btn-xs" id="button_toggle_Em" href="#" role="button">Toggle Em</a>
                <a class="popper" data-toggle="popover" title="" content="" data-original-title="test">[?]</a>
                <span class="hide popper-content"><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness[@xml:id='Em']"/></span>
            </div>
            
           </div><!-- /row -->
               
              <div class="collapse" id="toggle_key_text">
                <div class="well">
             
                
                <h4>Editorial Marks</h4>
                
                <p>Curly brackets { } mark an expanded abbreviation<br/>
                  Square brackets [ ] mark a section of the text for which variant readings exist</p>
                
                <p>Clicking on [*] will show the variant readings. In these, the following abbreviations are used:<br/>
                Bd - Oxford, Bodleian Library, MS Fr.e.22<br/>
                Tr - Trinity College, Cambridge MS B.14.39<br/>
                Em - Cambridge, Emmanuel College MS I.4.4 (83)<br/>
                <strong>Bold type</strong> is used to mark preferred readings</p>
                
                </div>
              </div>
              
            
            
           
          
              
              
            </div>
          </xsl:if>
         
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
        </div><!-- /intro div -->
      </body>
    </html>
  </xsl:template>
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->

  
  <!-- Paragraphs -->
  
  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="$idno = 'intro.sevensins'"><p><xsl:apply-templates/></p></xsl:when>
      <!-- HTML does not allow a p in a p -->
      <xsl:when test="ancestor::p or child::figure">
        <div class="p">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="following-sibling::*[1]/name() = 'note'">
        <p>
          <xsl:apply-templates/> 
          <xsl:apply-templates select="following-sibling::note[1]" mode="mode_decide"/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <p><xsl:apply-templates/></p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Notes -->
  <xsl:template match="note">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*[1]/name() = 'p' or
                      preceding-sibling::*[1]/name() = 'head' or 
                      (parent::p/preceding-sibling::*[1]/name() = 'head' and ancestor::figure)"><!-- do nothing, handled in p --></xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="mode_decide"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <!-- Sends note to editorial or non_editorial -->
  <xsl:template match="note" mode="mode_decide">
    <xsl:choose>
      <xsl:when test="@type='editorial'">
        <xsl:apply-templates select="." mode="editorial"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="non_editorial"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- editorial notes are found in intro -->
  <xsl:template match="note" mode="editorial">
    <a>
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:text>footnote</xsl:text>
        <xsl:number level="any" from="/TEI/text"/>
      </xsl:attribute>
      <!-- Ended here, trying to get the numbering to start at 1 -->
      <xsl:attribute name="id">inline<xsl:number level="any" from="/TEI/text"/></xsl:attribute>
      <xsl:attribute name="class">edition_notes</xsl:attribute>
      <sup>
        <xsl:text> [</xsl:text>
        <xsl:number level="any" from="/TEI/text"/>
        <xsl:text>]</xsl:text>
      </sup>
    </a>
  </xsl:template>
  
  <!-- non editorial notes are found in the edition -->
  <xsl:template match="note" mode="non_editorial">
    <a class="popper" data-toggle="popover" title="" content="" data-original-title="test"><small>[note]</small></a>
    <span class="hide popper-content"><xsl:apply-templates/></span>
  </xsl:template>
  
  <!-- template to create footnotes out of the editorial notes -->
  <xsl:template match="note" mode="footnotes">
    <p class="footnote">
      <xsl:attribute name="id">
        <xsl:text>footnote</xsl:text>
        <xsl:number level="any" from="/TEI/text"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@n">
          <xsl:value-of select="@n"/>
        </xsl:when>
        <xsl:when test="@xml:id">
          <xsl:value-of select="@xml:id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:number level="any" from="/TEI/text"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>. </xsl:text>
      <span class="note_text">
        <xsl:apply-templates/>
      </span>
      <xsl:text> [</xsl:text>
      <a>
        <xsl:attribute name="href">
          <xsl:text>#inline</xsl:text>
          <xsl:choose>
            <xsl:when test="@n">
              <xsl:value-of select="@n"/>
            </xsl:when>
            <xsl:when test="@xml:id">
              <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:number level="any" from="/TEI/text"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:text>back</xsl:text>
      </a>
      <xsl:text>]</xsl:text>
    </p>
  </xsl:template>
  
  <!-- list match which handles notes directly inside list -->
  <xsl:template match="list">
    <!-- when there is a head, place it above the ul -->
    <xsl:if test="head">
      <xsl:for-each select="head">
        <div class="tei_list_head">
          <xsl:apply-templates select="./node()"/>
          <xsl:choose>
            <xsl:when test="following-sibling::*[1]/name() = 'note'">
              <xsl:apply-templates select="following-sibling::note[1]" mode="mode_decide"/>
            </xsl:when>
            <xsl:when test="preceding-sibling::*[1]/name() = 'note'">
              <xsl:apply-templates select="preceding-sibling::note[1]" mode="mode_decide"/>
            </xsl:when>
          </xsl:choose>
        </div>
      </xsl:for-each>
    </xsl:if>
    
    <!-- when there is a note, handle elsewhere -->
    <xsl:if test="note">
      <xsl:for-each select="note">
        <xsl:choose>
          <xsl:when test="preceding-sibling::head"><!-- do nothing, handle above --></xsl:when>
          <!-- alternate handling of this, right now handled by first list below -->
          <xsl:when test="not(preceding-sibling::*)">
            <!--<xsl:text>*</xsl:text><xsl:apply-templates select="." mode="editorial"/>-->
          </xsl:when>
          <xsl:otherwise><!-- do nothing, handled elsewhere --></xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
    
    <ul>
      <xsl:apply-templates select="*"/><br/>
    </ul>
  </xsl:template>
  
  <xsl:template match="list/head"></xsl:template>

  <!-- item match which handles notes directly before or after an item -->
  <xsl:template match="item">
    <xsl:choose>
      <!-- when the next item is a note, move the note inside the li -->
      <xsl:when test="following-sibling::*[1]/name() = 'note'">
        <li>
          <xsl:apply-templates/>
          <xsl:apply-templates select="following-sibling::note[1]" mode="mode_decide"></xsl:apply-templates>
        </li>
      </xsl:when>
      <!-- when the previous item is a note and is not preceded by a head, move into the next li. 
             if it is preceded by a head, it will be handled by the first if in the list match -->
      <xsl:when test="preceding-sibling::*[1]/name() = 'note'">
        <xsl:choose><xsl:when test="not(preceding-sibling::*[1]/preceding-sibling::head[1])">
          <li>
            <xsl:apply-templates/>
            <xsl:apply-templates select="preceding-sibling::note[1]" mode="mode_decide"></xsl:apply-templates>
          </li>
        </xsl:when>
          <xsl:otherwise>
            <li>
              <xsl:apply-templates/>
            </li>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- turn line breaks into divs so they can be toggled -->
  <xsl:template match="lb">
    <span class="tei_line_break">&#160;</span>
  </xsl:template>
  
  <!-- add a span around w - could possible be added into base template -->
  <xsl:template match="w"><span class="tei_w"><xsl:apply-templates/></span></xsl:template>

  <!-- surround the text after the anchor and before the app with [ ] The end ] is in the app rule -->
  <xsl:template match="anchor">
    <span class="ed_mark"><xsl:text> [</xsl:text></span>
  </xsl:template>

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
      
      <xsl:choose>
        <xsl:when test="name() = 'lem'">
          <strong><xsl:apply-templates/></strong>
        </xsl:when>
        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
      </xsl:choose>
      <!--<xsl:apply-templates/>-->
      
      <br/>
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
  
  <xsl:template match="figure" priority="1">
    <div class="tei_figure">
      <img src="images/{graphic/@url}"></img>
      <br/>
      
      <xsl:apply-templates/>
    </div>
    
  </xsl:template>
  
  <!--<xsl:template match="figure/head">
    <h4><xsl:apply-templates/></h4>
  </xsl:template>-->
  
  <!-- head taken from html_formatting and added here to deal with notes next to heads -->
  <xsl:template match="head">
    <xsl:choose>
      <xsl:when test="following-sibling::p[1]/child::note and parent::figure">
        <h4><xsl:apply-templates/> <xsl:apply-templates select="following-sibling::p" mode="mode_decide"/></h4>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'p']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test="following-sibling::*[1]/name() = 'note'">
        <h4><xsl:apply-templates/><xsl:text> </xsl:text><xsl:apply-templates select="following-sibling::note[1]" mode="mode_decide"/></h4>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'figure']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      
      <!-- I added the div1 code for OSCYS, but I assume it will pop up elsewhere. 
    First I test if the div1 has a head. If it does not, I start the div2's on the h3's and work from there. - karin
    -->
      <xsl:when test="//div1">
        <xsl:choose>
          <xsl:when test="//div1/head">
            <xsl:choose>
              <xsl:when test="parent::div1">
                <h3>
                  <xsl:apply-templates/>
                </h3>
              </xsl:when>
              <xsl:when test="parent::div2">
                <h4>
                  <xsl:apply-templates/>
                </h4>
              </xsl:when>
              <xsl:when test="parent::div3">
                <h5>
                  <xsl:apply-templates/>
                </h5>
              </xsl:when>
              <xsl:when test="parent::div4 or parent::div5 or parent::div6 or parent::div7">
                <h6>
                  <xsl:apply-templates/>
                </h6>
              </xsl:when>
              <xsl:otherwise>
                <h3>
                  <xsl:apply-templates/>
                </h3>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="parent::div2">
                <h3>
                  <xsl:apply-templates/>
                </h3>
              </xsl:when>
              <xsl:when test="parent::div3">
                <h4>
                  <xsl:apply-templates/>
                </h4>
              </xsl:when>
              <xsl:when test="parent::div4">
                <h5>
                  <xsl:apply-templates/>
                </h5>
              </xsl:when>
              <xsl:when test="parent::div5 or parent::div6 or parent::div7">
                <h6>
                  <xsl:apply-templates/>
                </h6>
              </xsl:when>
              <xsl:otherwise>
                <h3>
                  <xsl:apply-templates/>
                </h3>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <xsl:when test=".[@type = 'sub']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <!--<xsl:when test="preceding::*[name() = 'head']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>-->
      <xsl:otherwise>
        <h3>
          <xsl:apply-templates/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="pb">
    <xsl:choose>
      <xsl:when test="$idno = 'translation.sevensins'"><!-- do nothing --></xsl:when>
      <xsl:otherwise>
        <xsl:variable name="image_name">
          <xsl:choose>
            <xsl:when test="@facs"><xsl:value-of select="@facs"/></xsl:when>
            <xsl:when test="@n"><xsl:value-of select="@n"/></xsl:when>
          </xsl:choose>
        </xsl:variable>
        <span>
          <xsl:attribute name="class">
            <xsl:text>pagebreak</xsl:text>
          </xsl:attribute>
          <span class="tei_thumbnail">
            <a>
              <xsl:attribute name="href">
                <xsl:text>images/viewsize/</xsl:text>
                <xsl:value-of select="$image_name"/>
                <xsl:text>.jpg</xsl:text>
              </xsl:attribute>
              <img>
                <xsl:attribute name="src">
                  <xsl:text>images/thumbs/</xsl:text>
                  <xsl:value-of select="$image_name"/>
                  <xsl:text>.jpg</xsl:text>
                </xsl:attribute>
              </img>
            </a>
          </span>
          <span class="viewsize">
            <a>
              <xsl:attribute name="href">
                <xsl:text>images/viewsize/</xsl:text>
                <xsl:value-of select="$image_name"/>
                <xsl:text>.jpg</xsl:text>
              </xsl:attribute>
              <xsl:text>View Page</xsl:text>
            </a>
          </span>
          <br/>
          <span class="fullsize">
            <a>
              <xsl:attribute name="href">
                <xsl:text>images/fullsize/</xsl:text>
                <xsl:value-of select="$image_name"/>
                <xsl:text>.jpg</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
              </xsl:attribute>
              <xsl:text>Full size in new window</xsl:text>
            </a>
          </span>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <xsl:template match="ab">
    <xsl:apply-templates/><br/><br/>
  </xsl:template>
  
  
</xsl:stylesheet>