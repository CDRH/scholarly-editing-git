<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">

 

  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->

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
  
  <xsl:variable name="idno">
    <xsl:value-of select="normalize-space(//tei:idno[@type='file'])"/>
  </xsl:variable>
  
  

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
        <a href="intro.dequinqueseptenis-deorationedominica.dunning.html">Intro</a>
      </li>
      <li id="editionNav2">
        <a href="de-oratione-dominica.dunning.html?type=diplomatic">De oratione dominica</a>
      </li>
      <li id="editionNav3">
        <a href="de-oratione-dominica-trans.dunning.html">On the Lord’s Prayer</a>
      </li>
      <li id="editionNav4">
        <a href="de-quinque-septenis.dunning.html?type=diplomatic">De quinque septenis</a>
      </li>
      <li id="editionNav5">
        <a href="de-quinque-septenis-trans.dunning.html">On the Five Sevens</a>
      </li>

    </ul>


  </xsl:template>



    <xsl:template match="seg" priority="1">
        <span class="seg">
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
                    <span id="{$linktext}{translate(@source, '#:[]', '')}" class="clicktext">
                        <a href="#{$oppositelinktext}{translate(@source, '#:[]', '')}">
                            <xsl:text> [</xsl:text>
                            <xsl:value-of select="$linktext"/>
                            <xsl:text>] </xsl:text>
                        </a>
                    </span>
                    
                    <xsl:apply-templates/>
                </xsl:when>
              <xsl:when test="@xml:id">
                <span id="{$linktext}{translate(@xml:id, '#:[]', '')}" class="clicktext">
                  <a href="#{$oppositelinktext}{translate(@xml:id, '#:[]', '')}">
                    <xsl:text> [</xsl:text>
                    <xsl:value-of select="$linktext"/>
                    <xsl:text>] </xsl:text>
                  </a>
                </span>
                
                <xsl:apply-templates/>
              </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            
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
        <div style="height:100%">
          <div style="width:50%; float:left; height:100%;"><xsl:apply-templates/></div>
          <div style="width:50%; float:right; height:100%;">
            
            <xsl:choose>
              <xsl:when test="$idno = 'dequinqueseptenis'">
                <xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-quinque-septenis-trans.xml')/tei:TEI"/>
              </xsl:when>
              <xsl:when test="$idno = 'deorationedominica'">
                <xsl:apply-templates select="document('../2016/editions/Dunning_De-oratione-dominica/xml/de-oratione-dominica-trans.xml')/tei:TEI"/>
              </xsl:when>
            </xsl:choose>
            
            </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="/TEI/text[1]">
    
    
    
    
    <div class="main_content">
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
  
  
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
        ===================================================================================
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
    ===================================================================================
    
    DUPLICATION BEGINS AFTER THIS
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
    ===================================================================================
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
    ===================================================================================-->   



  <!-- ===================================================================================
    TEMPLATES: Header and Footer
    =================================================================================== -->
  
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Add info to top of document
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
  <xsl:variable name="url_part">
    <xsl:choose>
      <xsl:when test="$idno = 'deorationedominica' or $idno = 'deorationedominica.trans'">
        <xsl:text>de-oratione-dominica</xsl:text>
      </xsl:when>
      <xsl:when test="$idno = 'dequinqueseptenis' or $idno = 'dequinqueseptenis.trans'">
        <xsl:text>de-quinque-septenis</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  


  <!-- ========================================
  New Additions -kmd
  =========================================-->

 

<xsl:template name="rendrules">
  
 
  <xsl:if test="@rend='red'"><xsl:text> tei_attr_red</xsl:text></xsl:if>
  <xsl:if test="@rend='strike'"><xsl:text> tei_attr_strike</xsl:text></xsl:if>
  <xsl:if test="@rend='enlarged'"><xsl:text> tei_attr_enlarged</xsl:text></xsl:if>
  <xsl:if test="@rend='supraline'"><xsl:text> tei_attr_supraline</xsl:text></xsl:if>
  <xsl:if test="@rend='alt'"><xsl:text> tei_attr_alt</xsl:text></xsl:if>
  <xsl:if test="@rend='hyphen'"><xsl:text> tei_attr_hyphen</xsl:text></xsl:if>
  <xsl:if test="@rend='stroke'"><xsl:text> tei_attr_stroke</xsl:text></xsl:if>
  <xsl:if test="@rend='expunct'"><xsl:text> tei_attr_expunct</xsl:text></xsl:if>
  <xsl:if test="@rend='erased'"><xsl:text> tei_attr_erased</xsl:text></xsl:if>
  <xsl:if test="@rend='strikethrough'"><xsl:text> tei_attr_strikethrough</xsl:text></xsl:if>
  <xsl:if test="@rend='overstrike'"><xsl:text> tei_attr_overstrike</xsl:text></xsl:if>
  <xsl:if test="@rend='above'"><xsl:text> tei_attr_above</xsl:text></xsl:if>
  <xsl:if test="@rend='spaced'"><xsl:text> tei_attr_spaced</xsl:text></xsl:if>
  <xsl:if test="@rend='longa'"><xsl:text> tei_attr_longa</xsl:text></xsl:if>
  <xsl:if test="@rend='inline'"><xsl:text> tei_attr_inline</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="supplied">
  <!-- omitted -->
  <xsl:apply-templates/>
</xsl:template>
  
  <xsl:template match="hi | abbr | num | pc | am | del | add | expan | am | ex" priority="1">
    <span>
      <xsl:attribute name="class">
        <xsl:text> tei_</xsl:text><xsl:value-of select="name()"/>
        <xsl:call-template name="rendrules"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="milestone">
    <div>
      <xsl:attribute name="class">
        <xsl:text>milestone </xsl:text>
        <xsl:value-of select="@unit"/>
      </xsl:attribute>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>
  
  <!--<xsl:template match="add">
    <!-\- inline -\->
    <xsl:apply-templates/>
  </xsl:template>-->
  
  <!--<xsl:template match="expan">
    <span class="tei_expan">
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->

  <!--<xsl:template match="am">
    <span class="tei_am">
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->

  <!--<xsl:template match="ex">
    <span class="tei_ex">
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->


  <xsl:template match="seg">
    <xsl:variable name="idno">
      <xsl:value-of select="normalize-space(//idno[@type='file'])"/>
    </xsl:variable>
    <xsl:variable name="linksource">
      <xsl:choose>
        <xsl:when test="$idno = 'deorationedominica'"
          >de-oratione-dominica-trans.dunning.html</xsl:when>
        <xsl:when test="$idno = 'deorationedominica.trans'"
          >de-oratione-dominica.dunning.html</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="linktext">
      <xsl:choose>
        <xsl:when test="$idno = 'deorationedominica'">translation</xsl:when>
        <xsl:when test="$idno = 'deorationedominica.trans'">original</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="@source">
        <span id="l{translate(@source, '#:[]', '')}">
          <a href="{$linksource}#l{translate(@source, '#:[]', '')}">
            <xsl:text> [</xsl:text>
            <xsl:value-of select="$linktext"/>
            <xsl:text>] </xsl:text>
          </a>
        </span>

        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>


 




  <!-- ===================================================================================
    TEMPLATES: Param controlled
    =================================================================================== -->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    FW (Form Work)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="fw">
    <xsl:if test="$fw = 'true'">
      <xsl:choose>
        <xsl:when test="ancestor::p">
          <span class="h6">
            <xsl:apply-templates/>
          </span>
        </xsl:when>

        <xsl:otherwise>
          <xsl:if test="not(@type='sub')">
            <h6>
              <xsl:attribute name="class">
                <xsl:value-of select="name()"/>
              </xsl:attribute>
              <xsl:apply-templates/>
            </h6>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>



  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Figures
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="figure">
    <xsl:if test="$figures = 'true'">
      <xsl:choose>
        <!-- Is this specific to everyweek, should it be in here? -KMD -->
        <xsl:when test="@n='flag'"/>
        <xsl:otherwise>
          <div class="inline_figure">
            <div class="p">[illustration]</div>
            <xsl:apply-templates/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Page breaks and page images
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="pb">
    <xsl:if test="$pb = 'true'">

      <!-- grab the figure id, first looking in @facs, then @xml:id, and if there is a .jpg, chop it off -->
      <xsl:variable name="figure_id">
        <xsl:variable name="figure_id_full">
          <xsl:choose>
            <xsl:when test="@facs">
              <xsl:value-of select="@facs"/>
            </xsl:when>
            <xsl:when test="@xml:id">
              <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:when test="@n">
              
              <xsl:choose>
                <xsl:when test="$url_part = 'de-oratione-dominica'">
                  <xsl:text>pembroke-115-</xsl:text>
                </xsl:when>
                <xsl:when test="$url_part = 'de-quinque-septenis'">
                  <xsl:text>mazarine-717-</xsl:text>
                </xsl:when>
              </xsl:choose>
              
              <xsl:value-of select="@n"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
          <xsl:when test="contains($figure_id_full,'.jpg')">
            <xsl:value-of select="substring-before($figure_id_full,'.jpg')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$figure_id_full"/>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:variable>


      <span class="hr">&#160;</span>
      <span>
        <xsl:attribute name="class">
          <xsl:text>pageimage</xsl:text>
        </xsl:attribute>

        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$fig_location"/>
            <xsl:text>large/</xsl:text>
            <xsl:value-of select="$figure_id"/>
            <xsl:text>.jpg</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="rel">
            <xsl:text>prettyPhoto[pp_gal]</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>&lt;a href="</xsl:text>
            <xsl:value-of select="$fig_location"/>
            <xsl:text>large/</xsl:text>
            <xsl:value-of select="$figure_id"/>
            <xsl:text>.jpg</xsl:text>
            <xsl:text>" target="_blank" &gt;open image in new window&lt;/a&gt;</xsl:text>
          </xsl:attribute>

          <img>
            <xsl:attribute name="src">
              <xsl:value-of select="$fig_location"/>
              <xsl:text>thumbnails/</xsl:text>
              <xsl:value-of select="$figure_id"/>
              <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
              <xsl:text>display</xsl:text>&#160; </xsl:attribute>
          </img>
        </a>
      </span>
    </xsl:if>
  </xsl:template>


  <!-- ===================================================================================
    TEMPLATES: Basic Styles
    =================================================================================== -->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Things to hide
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="teiHeader | revisionDesc | publicationStmt | sourceDesc | figDesc">
    <!-- hide -->
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Add classes for styling TEI
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- Div's -->
  <xsl:template
    match="byline | docDate | sp | speaker | letter | 
    notesStmt | titlePart | docDate | ab | trailer | 
    front | lg | l | bibl | dateline | salute | trailer | titlePage | closer | floatingText">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
        <xsl:if test="@type">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@type"/>
        </xsl:if>
        <xsl:if test="@rend">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@rend"/>
        </xsl:if>
        <!--<xsl:if test="not(parent::p)"><xsl:text> p</xsl:text></xsl:if>-->
        <!-- this is breaking some displays but commeting it out might break others. May need more consideration -todo KMD -->
      </xsl:attribute>
      <xsl:choose>
        <!-- This is for CWW, check to see if this is done correctly, will it add two handwritten classses? -KMD -->
        <xsl:when test="@type='handwritten'">
          <span>
            <xsl:attribute name="class">
              <xsl:text>handwritten</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Don't know why this was here, commenting out for now -KMD -->
      <!--<xsl:text> </xsl:text>-->
    </span>
  </xsl:template>

  <!-- Special case, if encoding is fixed, can fold into rule above-->

  <xsl:template match="ab[@rend='italics']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em>
        <xsl:apply-templates/>
      </em>
    </div>
  </xsl:template>

  <!-- Div types for styling -->
  <!-- directly from CWW - should we keep, is there a better way? -KMD -->

  <xsl:template match="div1 | div2">
    <xsl:choose>
      <xsl:when test="@type='html'">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>

            <xsl:attribute name="class">
              <xsl:if test="preceding-sibling::div1">
                <xsl:text> doublespace</xsl:text>
              </xsl:if>
              <xsl:text> </xsl:text>
              <xsl:value-of select="@subtype"/>
            </xsl:attribute>

          </xsl:attribute>

          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="substring-after(@corresp, '#')"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:apply-templates/>

        </div>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>

  <!-- SPAN's -->

  <xsl:template match="docAuthor | persName | placeName ">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <!-- <xsl:text> </xsl:text> -->
    </span>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Text Styles
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="term | foreign | emph | title[not(@level='a')] | biblScope[@type='volume']">
    <em>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </em>
  </xsl:template>



  <!-- CWW Specific, move into project stylesheet? -->
  <xsl:template match="space">
    <span class="teispace">
      <xsl:text>[no handwritten text supplied here]</xsl:text>
    </span>
  </xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    HEADS
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- Started heads at h3 because h1 is the site title and h2 is normally the page title, which is normally pulled from solr or a database.  -->

  <xsl:template match="head">
    <!-- need to fix for handwritten text -KD -->

    <xsl:choose>
      <xsl:when test="@rend='red'">
        <h3>
          <xsl:attribute name="class">
            <xsl:call-template name="rendrules"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </h3>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'p']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'figure']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>

      <!-- I added the div1 code for OSCYS, but I assume it will pop up elsewhere. 
      First I test if the div1 has a head. If it does not, I start the div2's on the h3's and work from there.
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
              <xsl:when test="parent::div4 or parent::div5 or parent::div6 or parent::div7  ">
                <h6>
                  <xsl:apply-templates/>
                </h6>
              </xsl:when>
              <xsl:otherwise>
                <h4>
                  <xsl:apply-templates/>
                </h4>
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
              <xsl:when test="parent::div5 or parent::div6 or parent::div7  ">
                <h6>
                  <xsl:apply-templates/>
                </h6>
              </xsl:when>
              <xsl:otherwise>
                <h4>
                  <xsl:apply-templates/>
                </h4>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test=".[@type='sub']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <xsl:when test="preceding::*[name() = 'head']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <xsl:otherwise>
        <h3>
          <xsl:apply-templates/>
        </h3>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Paragraphs
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->






  <!-- todo - build a better sheet. Right now, paragraphs could appear in other paragraphs, need to find a way to account for the weirdest encoding -KMD -->
  <!--<xsl:template match="p">
   <p><xsl:apply-templates/></p>-->

  <!--</xsl:template>-->



  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Notes / Footnotes
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="note">
    <xsl:choose>
      <xsl:when test="@place='foot'">
        <span>
          <xsl:attribute name="class">
            <xsl:text>foot</xsl:text>
          </xsl:attribute>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:text>foot</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:text>body</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>

            <xsl:text>(</xsl:text>
            <xsl:value-of select="substring(@xml:id, 2)"/>
            <xsl:text>)</xsl:text>
          </a>
        </span>
      </xsl:when>
      <xsl:when test="@type='editorial'"/>
      <xsl:otherwise>
        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="name()"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    References
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- we need a better way to determine when references are notes, when they are internal to the site, and then they are external links -->
  <xsl:template match="ref">
    <xsl:choose>
      <!-- When target starts with #, assume it is an in page link (anchor) -->
      <xsl:when test="starts-with(@target, '#')">
        <xsl:variable name="n" select="@target"/>
        <xsl:text> </xsl:text>
        <a>
          <xsl:attribute name="id">
            <xsl:text>ref</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>inlinenote</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="href">
            <xsl:text>#note</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:text>[note </xsl:text>
          <xsl:apply-templates/>
          <xsl:text>]</xsl:text>
        </a>
        <xsl:text> </xsl:text>
      </xsl:when>
      <!-- when marked as link, treat as an external link -->
      <xsl:when test="@type='link'">
        <a href="{@target}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <!-- external link -->
      <xsl:when test="starts-with(@target, 'http://') or starts-with(@target, 'https://')">
        <a href="{@target}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <!-- if the above are not true, it is assumed to be an internal to the site link -->
      <xsl:when test="@type='sitelink'">
        <a href="../{@target}" class="internal_link">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <!-- TODO talk to jessica about relative vs absolute links - maybe se should use sub domains to make everything absolute?
      Right now I am using relative, assuming documents will always be one level up-->
      <xsl:otherwise>
        <a href="../doc/{@target}" class="internal_link">
          <xsl:apply-templates/>
        </a>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Links
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="xref[@n]">
    <a href="{@n}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

 

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Line Breaks
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="lb" priority="1">
    <xsl:apply-templates/>
    <br class="br_diplomatic"/>
    <!-- <xsl:choose>
      <xsl:when test="$type='diplomatic'">
        <xsl:apply-templates/>
        <br class="br_diplomatic"/>
      </xsl:when>
      <xsl:when test="$type='regularized'">
        <br class="br_regularized"/>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
        <br/>
      </xsl:otherwise>
    </xsl:choose> -->
    
  </xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="table">
    <xsl:choose>
      <xsl:when test="@rend='handwritten'">
        <table>
          <xsl:attribute name="class">
            <xsl:text>handwritten</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <table>
          <xsl:apply-templates/>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Lists
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="list">
    <xsl:if test="head">
      <div class="tei_list_head">
        <xsl:apply-templates select="head/node()"/>
      </div>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="@type='handwritten'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>handwritten</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates select="item"/>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <ul>
          <xsl:apply-templates select="item"/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Quotes
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="quote">
    <!--<xsl:choose>
      <xsl:when test="descendant::*[name() = 'lg']">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
      </xsl:when>
      <xsl:otherwise>
        <blockquote>
          <p>
            <xsl:apply-templates/>
          </p>
        </blockquote>
      </xsl:otherwise>
    </xsl:choose>-->

    <span class="quote" title="{@source}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="q">
    <span class="inline_quote">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Letters
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- ___Signed___ -->
  <xsl:template match="//signed">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>




  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Gap
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="gap">
    <span>
      <xsl:attribute name="class">
        <xsl:text>gap </xsl:text>
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@reason"/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Unclear
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="unclear">
    <span>
      <xsl:attribute name="class">
        <xsl:text>unclear </xsl:text>
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>?]</xsl:text>
    </span>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Add
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!--<xsl:template match="add">
    <xsl:choose>
      <xsl:when test="@place='superlinear' or @place='supralinear'">
        <sup>
          <xsl:apply-templates/>
        </sup>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Delete
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="del">
    <xsl:choose>
      <xsl:when test="@type='overwrite'">
        <!-- Don't show overwritten text -->
      </xsl:when>
      <xsl:otherwise>
        <del>

          <xsl:if test="@reason">
            <xsl:attribute name="class">
              <xsl:value-of select="@reason"/>
            </xsl:attribute>
          </xsl:if>


          <xsl:apply-templates/>
          <!-- <xsl:text>[?]</xsl:text> -->
        </del>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Sic and Corr
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="choice[child::corr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>sic</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="corr"/>​ </xsl:attribute><xsl:apply-templates select="sic"/>
    </a> ​</xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Orig and Reg
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- to fix - breaks over pagebreaks -KMD -->
  <xsl:template match="choice[child::orig]">
    <!-- Hidden because it breaks over pagebreaks -->
    <!--<a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>orig</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="reg"/>​ </xsl:attribute><xsl:apply-templates select="orig"
      /></a>​-->
    <xsl:apply-templates select="orig"/>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Abbr and Expan
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!--<xsl:template match="choice[child::abbr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>abbr</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="expan"/>​ </xsl:attribute><xsl:apply-templates select="abbr"
      /></a>​</xsl:template>-->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Damage
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="damage">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>









  <!-- ===================================================================================
    HELPER TEMPLATES
    =================================================================================== -->

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    EXTRACT DATE
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="extractDate">
    <xsl:param name="date"/>
    <!--This template converts a date from format YYYY-MM-DD to mm D, YYYY (MM, MM-DD, optional)-->


    <xsl:variable name="YYYY" select="substring($date,1,4)"/>
    <xsl:variable name="MM" select="substring($date,6,2)"/>
    <xsl:variable name="DD" select="substring($date,9,2)"/>
    <!--
            (Y:"<xsl:value-of select="$YYYY" />" M:"<xsl:value-of select="$MM" />" D:"<xsl:value-of select="$DD" />")
        -->
    <xsl:choose>
      <xsl:when test="($DD != '') and ($MM != '') and ($DD != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"
          /></xsl:call-template><xsl:text> </xsl:text>
        <xsl:number format="1" value="$DD"/>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($YYYY != '') and ($MM != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"
          /></xsl:call-template>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($DD != '') and ($MM != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"
          /></xsl:call-template>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($YYYY != '')">
        <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:otherwise> N.D. </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LOK UP MONTH (used by extract date)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template name="lookUpMonth">
    <xsl:param name="numValue"/>
    <xsl:choose>
      <xsl:when test="$numValue = '01'">January</xsl:when>
      <xsl:when test="$numValue = '02'">February</xsl:when>
      <xsl:when test="$numValue = '03'">March</xsl:when>
      <xsl:when test="$numValue = '04'">April</xsl:when>
      <xsl:when test="$numValue = '05'">May</xsl:when>
      <xsl:when test="$numValue = '06'">June</xsl:when>
      <xsl:when test="$numValue = '07'">July</xsl:when>
      <xsl:when test="$numValue = '08'">August</xsl:when>
      <xsl:when test="$numValue = '09'">September</xsl:when>
      <xsl:when test="$numValue = '10'">October</xsl:when>
      <xsl:when test="$numValue = '11'">November</xsl:when>
      <xsl:when test="$numValue = '12'">December</xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>











</xsl:stylesheet>
