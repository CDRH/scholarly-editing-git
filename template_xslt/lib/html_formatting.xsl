<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0" exclude-result-prefixes="xsl tei xs">
  <xsl:variable name="editionName"/>
 
  <!-- ================================================ -->
  <!--         Email address protection                 -->
  <!-- ================================================ -->

  <xsl:template match="//tei:milestone[@unit = 'email']">
    <xsl:choose>
      <xsl:when test="@type = 'andyemail'">
        <script type="text/javascript">
          // protected email script by Joe Maller
          // JavaScripts available at http://www.joemaller.com
          // this script is free to use and distribute
          // but please credit me and/or link to my site
          
          emailE =('ajewell@' + 'unlnotes.unl.edu')
          document.write('<a href="mailto:' + emailE + '">' + emailE + '</a>
          ')
          //</script>
      </xsl:when>
      <xsl:when test="@type = 'amandaemail'">
        <script type="text/javascript">
          // protected email script by Joe Maller
          // JavaScripts available at http://www.joemaller.com
          // this script is free to use and distribute
          // but please credit me and/or link to my site
          
          emailE =('agailey2@' + 'unlnotes.unl.edu')
          document.write('<a href="mailto:' + emailE + '">' + emailE + '</a>
          ')
          //</script>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ~~~~~ Applying Classes based on Elements and rends ~~~~~~ -->

  <xsl:template
    match="
      body | front | back | docDate | sp | speaker | letter |
      notesStmt | titlePart | docDate | ab | trailer |
      lg | l | dateline | salute | trailer | titlePage | closer |
      floatingText | date | epigraph | title">
    <span>
      <xsl:attribute name="class">
        <xsl:text>tei_</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="tokenize(@type, ' ')">
          <xsl:text> tei_type_</xsl:text>
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="tokenize(@rend, ' ')">
          <xsl:text> tei_rend_</xsl:text>
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="tokenize(@level, ' ')">
          <xsl:text> tei_rend_</xsl:text>
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- put all footnotes at bottom, make inline with javascript -->
  <xsl:template match="text">
    <xsl:apply-templates/>
    <xsl:if
      test="
        //body//note[@type = 'editorial']
        or //body//note[@place = 'foot']
        or //back//note">
      <div class="notesList">
        <h2>Notes</h2>
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

  <!-- ================================================ -->
  <!--              Notes and Footnotes                 -->
  <!-- ================================================ -->

  <!-- If div type="notes" or in back? -->
  <!-- or, if immidiate sibline is also a note? -->
  <!-- <note place="foot" xml:id="ftn26" n="26"> -->
  <!-- <note type="editorial" xml:id="n4"><p>Charles Henry ... -->
  <!-- note place="foot" xml:id="ftn26" n="26">E. Pierazzo -->
  
  <xsl:template match="div[@type='notes']">
    <div class="notesList">
      
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="div[@type='appendix']">
    <br/>
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="note" priority="2">
    <p class="footnote">
    <xsl:choose>
      <xsl:when test="@place = 'foot' or (@type = 'editorial' and @xml:id)">
        <a>
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:attribute name="id">inline<xsl:value-of select="@xml:id"/></xsl:attribute>
          <xsl:attribute name="class">edition_notes</xsl:attribute>
          <sup>
            <xsl:text>[</xsl:text>
            <xsl:choose>
              <xsl:when test="@n">
                <xsl:value-of select="@n"/>
              </xsl:when>
              <xsl:when test="@xml:id">
                <xsl:value-of select="substring-after(@xml:id, 'n')"/>
              </xsl:when>
            </xsl:choose>
            <xsl:text>]</xsl:text>
          </sup>
        </a>
      </xsl:when>
      <!--<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>-->
    </xsl:choose>
    </p>
  </xsl:template>

  <xsl:template match="note" mode="footnotes" priority="1">
    <xsl:choose>
      <xsl:when test="@n">
        <xsl:value-of select="@n"/>
      </xsl:when>
      <xsl:when test="@xml:id">
        <xsl:value-of select="substring-after(@xml:id,'note')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:number/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text>. </xsl:text>
    <span class="note_text">
      <xsl:apply-templates/>
    </span>
    <span class="footnote_back">
      <xsl:text> [</xsl:text>
      <a>
        <xsl:attribute name="href">
          <xsl:text>#inline</xsl:text>
          <xsl:value-of select="@xml:id"/>
        </xsl:attribute>
        <xsl:text>back</xsl:text>
      </a>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <!-- ~~~~~~ Add Code to deal with ptr's ~~~~~~~ -->

  <!-- Text.<ptr target="#note1" xml:id="nr1" n="1"/>
  
  <div type="notes">
    <note xml:id="note1">"Note"</note>
  </div>-->

  <xsl:template match="ptr">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:text>inline</xsl:text>
        <xsl:value-of select="substring-after(@target, '#')"/>
      </xsl:attribute>
      <xsl:attribute name="class">edition_notes</xsl:attribute>
      <sup>[<xsl:value-of select="@n"/>]</sup>
    </a>
  </xsl:template>

  <!-- ================================================ -->
  <!--               References/Links                   -->
  <!-- ================================================ -->

  <!-- external links -->
  <!--<ref type="url" target="http://www.columbia.edu/cu/ccbh/mxp/">
    <emph>The Malcolm X Project at Columbia University,</emph></ref>-->

  <!-- internal links within the edition  -->
  <!--<ref target="markonthewall_ho17.html">"The Mark on the Wall."</ref>-->

  <!--<ref target="#intro3" xml:id="nr3" n="3">a growing field
    of scholarly inquiry</ref>
  <note xml:id="intro3"> ... </note>
  -->


  <xsl:template match="ref">
    <xsl:choose>
      <xsl:when test="starts-with(@target, '#')">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:attribute name="id">inline<xsl:value-of select="substring-after(@target, '#')"/></xsl:attribute>
          <xsl:attribute name="class">edition_notes</xsl:attribute>
          <xsl:choose>
            <xsl:when test="text()">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>[1]</xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:when>
      <!-- external links -->
      <xsl:when test="@type='url' or @type='link' or starts-with(@target, 'http://') or starts-with(@target, 'https://')">
        <a>
          <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type = 'figure'">
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>figures/viewsize/</xsl:text>
              <xsl:value-of select="descendant::tei:graphic/attribute::url"/>
              <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="child::tei:figure/child::tei:head"/>
              <xsl:if test="string(child::tei:figure/child::tei:p)">
                <xsl:value-of select="concat('&lt;br &gt;', child::tei:figure/child::tei:p[normalize-space()])" />
              </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
          </a>
        </span>
      </xsl:when>
      <!-- Scholarly editing links are type=html -->
      <xsl:when test="@type='html'">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="@target"/>
            <xsl:text>.html</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat('#', @target)"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>internal_link</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- ================================================ -->
  <!--                   ABBREVIATION                   -->
  <!-- ================================================ -->

  <xsl:template match="choice[child::abbr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>abbr</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="expan"/>​ </xsl:attribute>
      <xsl:apply-templates select="abbr"/>
    </a>​ </xsl:template>

  <!-- ================================================ -->
  <!--                       ADD                        -->
  <!-- ================================================ -->

  <!--<add rend="caret" place="above" hand="#cpc">more intimate</add>-->
  <!--If a mark has been used in the original text to signal an addition, than the addition will be displayed with a caret. If the addition was made above or below a line, then it will be displayed above or below the line in the edition-->

  <xsl:template match="add">
    <xsl:choose>
      <xsl:when test="@place = 'superlinear' or @place = 'supralinear'">
        <sup>
          <xsl:apply-templates/>
        </sup>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- ================================================ -->
  <!--                       BOLD                       -->
  <!-- ================================================ -->

  <!-- See "Strong" below -->

  <!-- ================================================ -->
  <!--                       BYLINE                     -->
  <!-- ================================================ -->

  <xsl:template match="byline">
    <h4 class="byline">
      <xsl:choose>
        <xsl:when test="preceding-sibling::byline">
          <xsl:choose>
            <xsl:when test="following-sibling::byline">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>and <xsl:apply-templates/></xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <!--formatting titles-->
          <span class="byline"><xsl:if test="ancestor::front"><!--<xsl:text>by </xsl:text>--></xsl:if><xsl:apply-templates/></span><br/>
        </xsl:otherwise>
      </xsl:choose>
    </h4>
  </xsl:template>

  <!-- ================================================ -->
  <!--                       CHOICE                      -->
  <!-- ================================================ -->

  <xsl:template match="choice[child::corr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>sic</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="corr"/>​ </xsl:attribute>
      <xsl:apply-templates select="sic"/>
    </a>
  </xsl:template>

  <!-- ================================================ -->
  <!--                      DATES                       -->
  <!-- ================================================ -->

  <xsl:template name="extractDate">
    <xsl:param name="date"/>
    <!--This template converts a date from format YYYY-MM-DD to mm D, YYYY (MM, MM-DD, optional)-->

    <xsl:variable name="YYYY" select="substring($date, 1, 4)"/>
    <xsl:variable name="MM" select="substring($date, 6, 2)"/>
    <xsl:variable name="DD" select="substring($date, 9, 2)"/>

    <xsl:choose>
      <xsl:when test="($DD != '') and ($MM != '') and ($DD != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"/></xsl:call-template><xsl:text> </xsl:text>
        <xsl:number format="1" value="$DD"/>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($YYYY != '') and ($MM != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"/></xsl:call-template>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($DD != '') and ($MM != '')">
        <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM"/></xsl:call-template>, <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:when test="($YYYY != '')">
        <xsl:value-of select="$YYYY"/>
      </xsl:when>
      <xsl:otherwise> N.D. </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

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

  <!-- ================================================ -->
  <!--                      DAMAGE                      -->
  <!-- ================================================ -->

  <xsl:template match="damage">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>

  <!-- ================================================ -->
  <!--                      DELETE                      -->
  <!-- ================================================ -->

  <!-- <del rend="strikethrough" hand="#cpc">in</del> -->

  <xsl:template match="del">
    <xsl:choose>
      <xsl:when test="@type = 'overwrite'">
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

  <!-- ================================================ -->
  <!--                  DIV1 and DIV2                   -->
  <!-- ================================================ -->

  <xsl:template match="div1 | div2 | div3 | div4">

        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
            <xsl:if test="@subtype">
              <xsl:text> </xsl:text>
              <xsl:value-of select="@subtype"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="substring-after(@corresp, '#')"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </div>
  </xsl:template>



  <!-- ================================================ -->
  <!--                  Figure                  -->
  <!-- ================================================ -->

  <!-- From Schol Ed Page https://sites.google.com/site/insidescholarlyediting/xml-for-an-introduction -->

  <!--<figure>
    <head>From Henry Inman's 1828 portrait of John Tanner, Cephas G. Childs      
      prepared the lithograph that appears as the frontispiece to the 1830 edition of   
      Tanner’s <hi rend="italic">Narrative</hi>.</head>
    
    <figDesc>From Henry Inman's 1828 portrait of John Tanner, Cephas G. Childs
      prepared the lithograph that appears as the frontispiece to the 1830 edition of
      Tanner’s Narrative.</figDesc>
    
    <graphic url="images/essay.fierst.01.jpg" />
  </figure>-->

  <!-- Scalable Images -->
  <!--<figure type="enlargeOnClick">
    
    <graphic url="images/essay.calvert.01.jpg"/>
    
    <head>Figure 1: This page is a relatively legible example of Dickinson's
      manuscripts, which became much worse in his later years. Preliminary 
      analysis suggests the page is from a draft of an eleventh "Fabius" 
      letter (RRL/HSP). Dickinson published a set of nine "Fabius Letters" 
      in 1788 to advocate ratification of the Constitution and drafts of a 
      tenth letter in 1794. All images reproduced with permission from the     
      Historical Society of Pennsylvania.</head>
  </figure>-->


<!--  <xsl:template match="figure/graphic">
    <img>
      <xsl:attribute name="src">
        <xsl:text>images/viewsize/</xsl:text>
        <xsl:value-of select="./attribute::url"/>
      </xsl:attribute>
      <xsl:attribute name="alt">
        <xsl:value-of select="child::figDesc[1]"/>
      </xsl:attribute>
    </img>
  </xsl:template>-->

  <!--<xsl:template match="figure/head">
    <h5>
      <xsl:apply-templates/>
    </h5>
  </xsl:template>-->

  <xsl:template match="figure" priority="1">

        
        <xsl:choose>
          <xsl:when test="@type='enlargeOnClick'">
            
            <span>
              <xsl:attribute name="class">
                <xsl:text>figure_center</xsl:text>
                <xsl:if test="contains(child::graphic/@url,'pereira')">
                  <xsl:text> figure_lightbox figure_center_</xsl:text>
                  <xsl:value-of select="translate(substring-before(substring-after(child::graphic/@url,'images/essay.'),'.jpg'),'.','')"/>
                </xsl:if>
              </xsl:attribute>
              
              <!--<a href="images{substring-after(child::graphic/attribute::url,'images')}">-->
              <img>
                <xsl:attribute name="src">
                  <xsl:text>images</xsl:text>
                  <xsl:value-of select="substring-after(child::graphic/attribute::url,'images')"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="child::figDesc"/>
                </xsl:attribute>
              </img>
              <!--</a>-->
              
              <span class="cap"><h5>
                <strong><xsl:text>[</xsl:text><!--click image for larger, or </xsl:text> --><a href="images{substring-after(child::graphic/attribute::url,'images')}" target="_blank">view full sized image in new window</a><xsl:text>] </xsl:text> <xsl:apply-templates select="child::head"/></strong>
              </h5>
                
              </span>
              
            </span>
            
          </xsl:when>
          <xsl:otherwise>
            <span>
              <xsl:attribute name="class">
                <xsl:text>figure_center</xsl:text>
                <xsl:if test="contains(child::graphic/@url,'pereira')">
                  <xsl:text> figure_center_</xsl:text>
                  <xsl:value-of select="translate(substring-before(substring-after(child::graphic/@url,'images/essay.'),'.jpg'),'.','')"/>
                </xsl:if>
              </xsl:attribute>
              
              <img>
                <xsl:attribute name="src">
                  <xsl:text>images</xsl:text>
                  <xsl:value-of select="substring-after(child::graphic/attribute::url,'images')"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="child::figDesc"/>
                </xsl:attribute>
              </img></span>
            <span class="cap"><h5>
              <strong><xsl:apply-templates select="child::head"/></strong>
            </h5>
              
            </span>
          </xsl:otherwise>
        </xsl:choose>
    
    
  </xsl:template>


  <!-- ================================================ -->
  <!--                  Form Work (FW)                  -->
  <!-- ================================================ -->

  <xsl:template match="fw">

    <xsl:choose>
      <xsl:when test="ancestor::p">
        <span class="h6">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="not(@type = 'sub')">
          <h6>
            <xsl:attribute name="class">
              <xsl:value-of select="name()"/>
            </xsl:attribute>
            <xsl:apply-templates/>
          </h6>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>



  <!-- ================================================ -->
  <!--                        GAP                       -->
  <!-- ================================================ -->

  <!--<gap reason="faded"/>-->
  <!-- [...] or [faded] -->

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

  <!-- ================================================ -->
  <!--                       HEADS                      -->
  <!-- ================================================ -->

  <!-- Started heads at h3 because h1 is the site title and h2 is normally the page title, which is pulled from solr or a database.  -->

  <xsl:template match="head">
    <!-- need to fix for handwritten text -KD -->
    <xsl:choose>
      <xsl:when test="contains(preceding::idno[@type='file'],'review.')">
        <br/>
        <h4><xsl:apply-templates/></h4>
        <br/>
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
      <xsl:when test="parent::div[@type='appendix']">
        <xsl:choose>
          <xsl:when test="@type='sub'"><h4><strong><xsl:apply-templates/></strong></h4></xsl:when>
          <xsl:otherwise><h3 class="tei_titlePart"><strong><xsl:apply-templates/></strong></h3></xsl:otherwise></xsl:choose>
      </xsl:when>

      <!-- I added the div1 code for OSCYS, but I assume it will pop up elsewhere. 
    First I test if the div1 has a head. If it does not, I start the div2's on the h3's and work from there. - karin
    -->
      <xsl:when test="//div">
        <h3>
          <xsl:if test="starts-with(parent::div/@xml:id,'v')">
            <xsl:if test="not(position() = 1)">
            <xsl:attribute name="class"><xsl:text>volume_head</xsl:text></xsl:attribute>
            </xsl:if>
          </xsl:if>
          <xsl:apply-templates/></h3>
      </xsl:when>
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
  
  <xsl:template match="//front//head">
    <xsl:choose>
      <xsl:when test="@type='sub'">
        <h3><xsl:apply-templates/></h3>
      </xsl:when>
      <xsl:otherwise>
        <h2><xsl:apply-templates/></h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ================================================ -->
  <!--                        HI                        -->
  <!-- ================================================ -->

 <!-- <xsl:template match="hi[@rend]" priority="2">
    <span>
      <xsl:attribute name="class">
        <xsl:text>tei_rend_</xsl:text>
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->

  <xsl:template match="hi[@rend = 'italic'] | hi[@rend = 'italics']" priority="1">
    <em>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="hi[@rend = 'quoted']" priority="1">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <xsl:template match="hi[@rend = 'subscript']" priority="1">
    <sub>
      <xsl:apply-templates/>
    </sub>
  </xsl:template>

  <!--  Underline  -->

  <xsl:template match="hi[@rend = 'underlined'] | hi[@rend = 'underline']" priority="1">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>

  <!--  Positioning -->

  <xsl:template match="hi[@rend = 'right'] | hi[@rend = 'center']" priority="1">
    <div>
      <xsl:attribute name="class">
        <xsl:text>tei_rend_</xsl:text>
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- ================================================ -->
  <!--                        HIDE                      -->
  <!-- ================================================ -->

  <xsl:template match="teiHeader | revisionDesc | publicationStmt | sourceDesc">
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- ================================================ -->
  <!--           HORIZONTAL RULE (MILESTONE)            -->
  <!-- ================================================ -->

  <xsl:template match="milestone">
    <div>
      <xsl:attribute name="class">
        <xsl:text>milestone </xsl:text>
        <xsl:value-of select="@unit"/>
      </xsl:attribute>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>

  <!-- ================================================ -->
  <!--                      ITALICS                     -->
  <!-- ================================================ -->

  <xsl:template match="ab[@rend = 'italics'] | p[@rend = 'italics']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em>
        <xsl:apply-templates/>
      </em>
    </div>
  </xsl:template>

  <!-- ================================================ -->
  <!--                    LINE BREAKS                   -->
  <!-- ================================================ -->

  <xsl:template match="lb">
    <xsl:apply-templates/>
    <br class="tei_lb"/>
  </xsl:template>

  <!-- ================================================ -->
  <!--                    LINE GROUP AND LINE           -->
  <!-- ================================================ -->

  <xsl:template match="//tei:lg">
    <div class="tei_lg">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="//tei:l">
    <span>
      <xsl:attribute name="class">
        <xsl:text>poem_line tei_l</xsl:text>
        <xsl:if test="@rend">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@rend"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>


  <!-- ================================================ -->
  <!--                       LISTS                      -->
  <!-- ================================================ -->

  <xsl:template match="list">
    
    <xsl:if test="head">
      <div class="tei_list_head">
        <xsl:apply-templates select="head/node()"/>
      </div>
    </xsl:if>
    
   <!-- <xsl:if test="note">
      <div class="tei_list_note tei_note">
        <xsl:apply-templates select="note/node()"/>
      </div>
    </xsl:if>-->
   
        <ul>
          <xsl:if test="@type">
            <xsl:attribute name="class">
              <xsl:text>tei_list_type_</xsl:text>
              <xsl:value-of select="@type"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates select="item"/>
        </ul>
  </xsl:template>

  <xsl:template match="item">
    <xsl:choose>
      <!-- special formatting for presidential addresses on index pages -->
      <xsl:when test="./attribute::xml:id='joint_presidential' or ./attribute::n='presidential'">
        <li><span class="well">
          <xsl:apply-templates></xsl:apply-templates>
        </span></li>
      </xsl:when>
      <xsl:when test="./attribute::xml:id='editors_craft' or @n='editorscraft'">
        <li><span class="well editors_craft">
          <xsl:apply-templates></xsl:apply-templates>
        </span></li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:otherwise>
    </xsl:choose>
   
  </xsl:template>

  <!-- ================================================ -->
  <!--               MISC -> SPANS OR EMS               -->
  <!-- ================================================ -->

  <xsl:template match="term | foreign | emph | biblScope[@type = 'volume']">
    <em>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
        <xsl:if test="@rend">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@rend"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </em>
  </xsl:template>


  <!-- ================================================ -->
  <!--                  ORIG AND REG                    -->
  <!-- ================================================ -->

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



  <!-- ================================================ -->
  <!--                    Page Breaks                   -->
  <!-- ================================================ -->

  <xsl:template match="pb">
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
  </xsl:template>

  <!-- ================================================ -->
  <!--                    PARAGRAPHS                    -->
  <!-- ================================================ -->

  <!-- still need to find a way to identify more p's in p's - html template? -kmd -->

  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="ancestor::p">
        <div class="p">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- ================================================ -->
  <!--                     QUOTES                       -->
  <!-- ================================================ -->

  <xsl:template match="quote">
        <br/><br/><span class="blockquote">
          <xsl:apply-templates/>
        </span><br/><br/>
  </xsl:template>

  <xsl:template match="q">
    <xsl:choose>
      <xsl:when test="@rend='block'">
        <xsl:choose>
          <!--<xsl:when test="following-sibling::q[@rend='block'][1] and not(following-sibling::text()[1])">-->
          <xsl:when test="following-sibling::node()[1][self::q[@rend='block']] or following-sibling::node()[1][self::text()[not(normalize-space())]] and following-sibling::node()[2][self::q[@rend='block']]">
            <br/><br/><span class="blockquote">
              <xsl:apply-templates/>
            </span>
          <!--</xsl:when>-->
          </xsl:when>
          <xsl:otherwise><br/><br/><span class="blockquote">
          <xsl:apply-templates/>
        </span><br/><br/></xsl:otherwise></xsl:choose>
      </xsl:when>
      <xsl:otherwise><span class="inline_quote">
      <xsl:apply-templates/>
    </span></xsl:otherwise></xsl:choose>
  </xsl:template>

  <xsl:template match="xref[@n]">
    <a href="{@n}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <!-- ================================================ -->
  <!--                       SEG                        -->
  <!-- ================================================ -->

  <!-- Handwritten From CWW - move into project file? -->
  <xsl:template match="seg">
    <xsl:choose><xsl:when test="@type='handwritten'"><span>
      <xsl:attribute name="class">
        <xsl:text>handwritten</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span></xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ================================================ -->
  <!--                       STAGE                      -->
  <!-- ================================================ -->
  
  <xsl:template match="stage">
    <xsl:choose><xsl:when test="following-sibling::stage"><span class="align_center"><xsl:apply-templates/></span></xsl:when>
      <xsl:otherwise><span class="align_center"><xsl:apply-templates/></span><br/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="castItem">
    <!--<table><tr><td class="table_cell"><strong><xsl:apply-templates select="role"/></strong></td><td><xsl:apply-templates select="roleDesc"/></td></tr></table>-->
    <xsl:apply-templates/><br/>
  </xsl:template>
  
  <xsl:template match="castItem/role">
    <span class="cast_role"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="castItem//note">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="castItem/roleDesc">
    <span class="align_right"><xsl:apply-templates/></span>
  </xsl:template>
  
  <!-- ================================================ -->
  <!--                    SIGNATURE                     -->
  <!-- ================================================ -->

  <xsl:template match="//signed">
    <xsl:choose>
      <xsl:when test="contains(preceding::idno[@type='file'],'review.')">
        <span class="byline"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise><br/>
    <xsl:apply-templates/></xsl:otherwise></xsl:choose>
  </xsl:template>

  <!-- ================================================ -->
  <!--                     SPACE                        -->
  <!-- ================================================ -->

  <!-- CWW Specific, move into project stylesheet? -->
  <xsl:template match="space">
    <span class="teispace">
      <xsl:text>[no handwritten text supplied here]</xsl:text>
    </span>
  </xsl:template>

  <!-- ================================================ -->
  <!--                     STRONG                       -->
  <!-- ================================================ -->

  <xsl:template match="item/label | hi[@rend = 'bold']">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>


  <!-- ================================================ -->
  <!--              SUPER AND SUB SCRIPT                -->
  <!-- ================================================ -->

  <xsl:template match="p[@rend = 'superscript'] | p[@rend = 'sup'] | hi[@rend = 'super'] | hi[@rend = 'superscript']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>

  <!-- ================================================ -->
  <!--                      TABLES                      -->
  <!-- ================================================ -->

  <!-- remove heads in table by default, they are not allowed -->
  <xsl:template match="table/head"/>

  <!-- called from table match -->
  <xsl:template match="table/head" mode="show">
    <div class="tei_table_head">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="table">

    <xsl:for-each select="head">
      <xsl:apply-templates select="." mode="show"/>
    </xsl:for-each>


    <xsl:choose>
      <xsl:when test="@rend = 'handwritten'">
        <table>
          <xsl:attribute name="class">
            <xsl:text>handwritten</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <table class="table">
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

  <!-- ================================================ -->
  <!--                     UNCLEAR                      -->
  <!-- ================================================ -->

  <!--<unclear reason="written over">o en</unclear>-->
  <!-- Unclear text is usually displayed in gray (css) -->

  <xsl:template match="unclear">
    <span>
      <xsl:attribute name="class">
        <xsl:text>unclear </xsl:text>
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>

<!-- ================================================ -->
  <!--                     AUTHORS AND EDITORS          -->
  <!-- ================================================ -->
  <xsl:template match="bibl">
    
    <xsl:apply-templates select="title"/>
    <xsl:if test="contains(child::title/@xml:id,'essay') or contains(child::title/@xml:id,'review')">
      <xsl:variable name="year"><xsl:value-of select="substring(title/ref[1]/@target,1,4)"/></xsl:variable>
      <xsl:variable name="href"><xsl:value-of select="$year"/>/pdf/<xsl:value-of select="child::title/@xml:id"/>.pdf</xsl:variable>
      <xsl:text> [</xsl:text>
      <a href="{$href}">PDF</a>
      <xsl:text>] </xsl:text>
    </xsl:if>
    <span class="indexauthor"><xsl:apply-templates select="author"/></span>
    <span class="indexeditor"><xsl:apply-templates select="editor"/></span>
    
  </xsl:template>
  
<xsl:template match="div/bibl/editor">
  <!--<span class="editor_list"><xsl:apply-templates/></span><br/>-->
</xsl:template>
  
  <xsl:template match="list//bibl//author">
    <span class="tei_author">
    <xsl:choose>
      <xsl:when test="not(preceding-sibling::author)"><xsl:text>by </xsl:text><xsl:apply-templates/></xsl:when>
      <xsl:when test="preceding-sibling::author and following-sibling::author"><xsl:text>, </xsl:text><xsl:apply-templates/><xsl:text>, </xsl:text></xsl:when>
      <xsl:when test="preceding-sibling::author and not(following-sibling::author)"><xsl:text> and </xsl:text><xsl:apply-templates/></xsl:when>
      <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose>
    </span>
  </xsl:template>

<xsl:template match="affiliation">
  <xsl:choose>
    <xsl:when test="contains(preceding::idno[@type='file'],'review.')">
      <br/><xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise><span class="tei_affiliation">
  <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
  </span></xsl:otherwise></xsl:choose>
</xsl:template>
  
  <xsl:template match="list//bibl//editor">
    <xsl:choose><xsl:when test="not(preceding-sibling::editor)"><xsl:text>edited by </xsl:text><xsl:apply-templates/></xsl:when>
      <xsl:when test="preceding-sibling::editor and following-sibling::editor"><xsl:text>, </xsl:text><xsl:apply-templates/><xsl:text>, </xsl:text></xsl:when>
      <xsl:when test="preceding-sibling::editor and not(following-sibling::editor)"><xsl:text> and </xsl:text><xsl:apply-templates/></xsl:when>
      <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ================================================ -->
  <!--                     ADDRESS                      -->
  <!-- ================================================ -->
  
  <xsl:template match="address">
    <span class="address"><xsl:apply-templates/></span><br/>
  </xsl:template>
  
  <xsl:template match="addrLine">
    <span class="addrLine"><xsl:apply-templates/></span>
  </xsl:template>

</xsl:stylesheet>