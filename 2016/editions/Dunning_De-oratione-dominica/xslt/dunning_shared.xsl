<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
    exclude-result-prefixes="xsl tei xs">
    
    <xsl:output indent="no"/>
  
  <xsl:param name="edition_type"></xsl:param>

  
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Add info to top of document
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
  <xsl:variable name="url_part">
    <xsl:choose>
      <xsl:when test="$edition_type = 'sidebyside'"><xsl:text>sidebysite</xsl:text></xsl:when>
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


  <xsl:template match="tei:note[@type='editorial']" priority="3">
    <span class="showNote">
      <a href="#" onclick="return false;"><xsl:text> [</xsl:text><xsl:value-of select="substring-after(@xml:id,'n')"/><xsl:text>]</xsl:text></a>
    </span>
    <span class="appEntry" style="display: block;">
      <a href="#" class="closenote">X</a>
      <span class="rdgNote">
        <br/> <xsl:apply-templates/><!-- todo: ask andy if he has any ideas -->
      </span></span>
  </xsl:template>
  
  <xsl:template match="tei:note[@type='editorial']/p" priority="1">
    <xsl:apply-templates/><br/><br/>
  </xsl:template>
  

<xsl:template name="rendrules">
  <xsl:text> tei_attr_</xsl:text><xsl:value-of select="."/>
</xsl:template>

  <xsl:template match="supplied"><span class="tei_supplied"><span class="tei_supplied_bracket">&#10216;</span><xsl:apply-templates/><span class="tei_supplied_bracket">&#10217;</span></span></xsl:template>
    
    <xsl:template match="pc">
        <xsl:choose>
            <xsl:when test="@rend='hyphen'">
                <span class="tei_attr_hyphen tei_pc">
                    <xsl:apply-templates/><xsl:text>-</xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="tei_pc"><xsl:apply-templates/></span>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
  
  <xsl:template match="num | am | add | expan | am | ex" priority="1">
    <span>
      <xsl:attribute name="class">
        <xsl:text> tei_</xsl:text><xsl:value-of select="name()"/>
        <xsl:for-each select="tokenize(@rend, ' ')">
          <xsl:call-template name="rendrules"/>
        </xsl:for-each>
       <xsl:if test="@hand">
         <xsl:text> tei_attr_hand tei_hand_attr_</xsl:text>
         <xsl:value-of select="translate(@hand,'#','')"/>
       </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="hi" priority="1">
    <xsl:choose>
      <xsl:when test="@rend='sup'">
        <sup><xsl:apply-templates/></sup>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:text> tei_</xsl:text><xsl:value-of select="name()"/>
            <xsl:for-each select="tokenize(@rend, ' ')">
              <xsl:call-template name="rendrules"/>
            </xsl:for-each>
            <xsl:if test="@hand">
              <xsl:text> tei_attr_hand tei_hand_attr_</xsl:text>
              <xsl:value-of select="translate(@hand,'#','')"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
 
  
    
    <xsl:template match="surplus">
        <span>
            <xsl:attribute name="class">
                <xsl:text>tei_surplus </xsl:text>
                <xsl:for-each select="tokenize(@rend, ' ')">
                    <xsl:call-template name="rendrules"/>
                </xsl:for-each>
            </xsl:attribute>
          
          
          <span class="tei_surplus_bracket"><xsl:text>[</xsl:text></span>
          <xsl:apply-templates/>
          <span class="tei_surplus_bracket"><xsl:text>]</xsl:text></span>
          
        </span>
      
      <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="abbr">
        
        <xsl:choose>
          <xsl:when test="(text() = 'l' and @rend = 'stroke') and $type ='diplomatic'">
                <!-- See issue https://github.com/CDRH/scholarly-editing-git/issues/15
                That l<am>&#xF1C7;</am> should have been <abbr rend="stroke">l</abbr>. I would suggest rendering it as ł (U+0142) in the diplomatic view.-->
                <span>
                    <xsl:attribute name="class">
                        <xsl:text> tei_</xsl:text><xsl:value-of select="name()"/>
                        <xsl:for-each select="tokenize(@rend, ' ')">
                            <xsl:call-template name="rendrules"/>
                        </xsl:for-each>
                    </xsl:attribute>&#322;</span>
            </xsl:when>
                    
            <xsl:otherwise>
              <span>
                    <xsl:attribute name="class">
                        <xsl:text> tei_</xsl:text><xsl:value-of select="name()"/>
                      <!-- in the regularized view, @rend can be ignored, but its contents should still be displayed. -->
                        <xsl:if test="$type ='diplomatic'">
                          <xsl:for-each select="tokenize(@rend, ' ')">
                            <xsl:call-template name="rendrules"/>
                        </xsl:for-each></xsl:if>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </span>
              
            </xsl:otherwise>
        </xsl:choose>

        
    </xsl:template>
  
  <xsl:template match="l" priority="1">
    
    <span class="tei_l poem_line"><xsl:apply-templates/></span>
    <br/>

    
  </xsl:template>
  
  
  <xsl:template match="milestone">
    <span>
      <xsl:attribute name="class">
        <xsl:for-each select="tokenize(@rend, ' ')">
          <xsl:call-template name="rendrules"/>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:if test="contains(@rend,'paraph')"><xsl:text>¶</xsl:text></xsl:if>
      
    </span>

  </xsl:template>
 


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
        <xsl:when test="$idno = 'deorationedominica' or $idno = 'dequinqueseptenis'">translation</xsl:when>
        <xsl:when test="$idno = 'deorationedominica.trans' or $idno = 'dequinqueseptenis.trans'">original</xsl:when>
      </xsl:choose>
    </xsl:variable>

<span class="tei_seg">

  <xsl:apply-templates/>
</span>

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

  <xsl:template match="figure" priority="2">
    <div class="intro_figure">
    
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$fig_location"/>
        <xsl:text>large/</xsl:text>
        <xsl:value-of select="substring-after(graphic/@url,'/')"/>
        <!--<xsl:text>.jpg</xsl:text>-->
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>display</xsl:text><xsl:text> intro_image</xsl:text></xsl:attribute>
    </img>
     
      
      <p><xsl:apply-templates select="head"/></p>
    
    </div>
  </xsl:template>

  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Page breaks and page images
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
  
 <!-- <xsl:template match="cb">
    <br/>
    <span class="tei_cb_label"><xsl:value-of select="@n"/></span>
  </xsl:template>-->

  <xsl:template match="pb">
    
      
    
    <br/>
    <span class="tei_pb_label"><xsl:value-of select="@n"/></span>
    <!--<span class="pageimage" style="background-color:blue;width:100px;height:100px;">zzz</span>-->
   
    
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
                <xsl:when test="normalize-space(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='file']) = 'deorationedominica'
                  or normalize-space(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='file']) = 'deorationedominica.trans'">
                  <xsl:text>pembroke-115-</xsl:text>
                </xsl:when>
                <xsl:when test="normalize-space(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='file']) = 'dequinqueseptenis'
                  or normalize-space(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='file']) = 'dequinqueseptenis.trans'">
                  <xsl:text>mazarine-717-</xsl:text>
                </xsl:when>
                <!--<xsl:when test="$url_part = 'de-oratione-dominica'">
                  <xsl:text>pembroke-115-</xsl:text>
                </xsl:when>
                <xsl:when test="$url_part = 'de-quinque-septenis' or $url_part = 'sidebyside'">
                  <xsl:text>mazarine-717-</xsl:text>
                </xsl:when>-->
                <!--<xsl:otherwise>
                  <xsl:text>mazarine-717-</xsl:text>
                </xsl:otherwise>-->
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


      <!--<span class="hr">&#160;</span>-->
        <!--<span class="tei_pb_label"><xsl:value-of select="@n"/></span>-->
    <div class="pagebreak">
      <span>
        <xsl:attribute name="class">
          <xsl:text>pageimage thumbnail</xsl:text>
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
        <br/>
        <span class="folio_reference">
          <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/settlement"/>
          <xsl:text>, </xsl:text>
          <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/repository"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="@n"/></span>
      </span><br/>
      
      
      <span class="view_fullsize">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$fig_location"/>
            <xsl:text>fullsize/</xsl:text>
            <xsl:value-of select="$figure_id"/>
            <xsl:text>.jpg</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          View Fullsize
        </a>
      </span>
    
    </div>
    
    
    
    
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
        
      </xsl:attribute>
          <xsl:apply-templates/>
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

<xsl:template match="div">
  <div>
    <xsl:attribute name="class">
      <xsl:if test="@type">
        <xsl:value-of select="@type"/>
      </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates/>
  </div>
</xsl:template>

  <!-- Div types for styling -->
  <!-- directly from CWW - should we keep, is there a better way? -KMD -->

  <!--<xsl:template match="div1 | div2">
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


  </xsl:template>-->

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






  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    HEADS
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- Started heads at h3 because h1 is the site title and h2 is normally the page title, which is normally pulled from solr or a database.  -->

  <xsl:template match="head">
    

    <xsl:choose>
      <xsl:when test="@rend='red'">
        <h3>
          <xsl:attribute name="class">
            <xsl:for-each select="tokenize(@rend, ' ')">
              <xsl:call-template name="rendrules"/>
            </xsl:for-each>
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

  <xsl:template match="text//lb" priority="1">
    <xsl:variable name="number"><xsl:number level="any"/></xsl:variable>
    
    
    <xsl:if test="preceding::*[1]/name() != 'pb'">
      <br>
        <xsl:if test="@break='no'">
          <xsl:attribute name="class">
            <xsl:text>br_diplomatic</xsl:text>
          </xsl:attribute>
        </xsl:if>
      </br>
    </xsl:if>
    <span class="tei_lb">
      
      <xsl:if test="$number mod 5 = 0">
        <xsl:value-of select="$number"/>
      </xsl:if>
      <xsl:text>&#160;</xsl:text>
      <xsl:if test="preceding::*[1]/name() = 'cb'">
        
        <xsl:value-of select="preceding::cb[1]/@n"/>
      </xsl:if>
    </span>
    <xsl:apply-templates/>
    
   
    
  </xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Tables
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="table">
   
        <table>
          <xsl:apply-templates/>
        </table>
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
      <xsl:when test="@type='ordered'">
        <ol>
          <xsl:apply-templates select="item"/>
        </ol>
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

<!-- moved to main stylesheet so it does not appear in side by side view.  -->
  <!--<xsl:template match="quote">

    <span class="quote" title="{@source}">
      <a>
        <xsl:attribute name="href">
          <xsl:text>http://data.perseus.org/citations/</xsl:text>
          <xsl:value-of select="@source"/>
        </xsl:attribute>
      
      <xsl:apply-templates/>
      </a>
    </span>
  </xsl:template>-->

  <xsl:template match="q">
    <q>
      <xsl:apply-templates/>
    </q>
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
    Delete
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <xsl:template match="del">
    <xsl:choose>
      <xsl:when test="contains(@rend,'expunct')">
       <del>
        <xsl:analyze-string select="." regex=".">
          <xsl:matching-substring>
            <xsl:value-of select="." /><xsl:text>&#x323;</xsl:text>
          </xsl:matching-substring>
        </xsl:analyze-string>
       </del>
      </xsl:when>
      <xsl:when test="@type='overwrite'">
        <!-- Don't show overwritten text -->
      </xsl:when>
      <xsl:otherwise>
        <del>
          <xsl:attribute name="class">
            <xsl:if test="@reason">
              <xsl:value-of select="@reason"/>
            </xsl:if>
            <xsl:for-each select="tokenize(@rend, ' ')">
              <xsl:call-template name="rendrules"/>
            </xsl:for-each>
          </xsl:attribute>

          


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
    <xsl:choose>
      <xsl:when test="$type ='diplomatic'">
        <span>
          <xsl:attribute name="rel">
            <xsl:text>tooltip</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>sic</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:apply-templates select="corr"/>​ </xsl:attribute><xsl:apply-templates select="sic"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="rel">
            <xsl:text>tooltip</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>sic</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:apply-templates select="corr/@resp"/>​ </xsl:attribute><xsl:apply-templates select="corr"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
     ​</xsl:template>


  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Orig and Reg
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

  <!-- to fix - breaks over pagebreaks -KMD -->
  <xsl:template match="choice[child::orig]">
  
    <xsl:apply-templates select="orig"/>
  </xsl:template>
  
  <xsl:template match="reg">
    <span class="tei_reg"><xsl:apply-templates/></span>
  </xsl:template>

 

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


<!-- Footnotes -->
    
    <!-- Notes and pointers -->
   
    <xsl:template match="//tei:div[@type='notes']">
        <xsl:if test="normalize-space(/TEI/teiHeader[1]/fileDesc/publicationStmt/idno[@type='file']) = 'intro.dunning'">
        <div class="notesList">
            <h2>Notes</h2>
            <xsl:apply-templates />
        </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="//tei:ptr">
        <xsl:if test="normalize-space(/TEI/teiHeader[1]/fileDesc/publicationStmt/idno[@type='file']) = 'intro.dunning'">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="attribute::target" />
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="attribute::xml:id" />
            </xsl:attribute>
            <span class="noteRef">
                [<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span>
        </a>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="normalize-space(/TEI/teiHeader[1]/fileDesc/publicationStmt/idno[@type='file']) = 'intro.dunning'">
                <div class="note">
                    <a>
                        <xsl:attribute name="name">
                            <xsl:value-of select="@xml:id" />
                        </xsl:attribute>
                    </a>
                    <xsl:value-of select="substring-after(attribute::xml:id,'note')" />.
                    <xsl:apply-templates /><a>
                        <xsl:attribute name="href">#nr<xsl:value-of
                            select="substring-after(attribute::xml:id,'note')" /></xsl:attribute>
                        <img>
                            <xsl:attribute name="src">template_images/goback.png</xsl:attribute>
                            <xsl:attribute name="alt">Go
                                back</xsl:attribute>
                        </img>
                    </a>
                </div>
                <br/>
            </xsl:when>
            <xsl:otherwise>
              <span class="note">
                <xsl:apply-templates/>
              </span>
            </xsl:otherwise>
        </xsl:choose>
       
        
    </xsl:template>



    
</xsl:stylesheet>