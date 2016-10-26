<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
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
      <xsl:apply-templates select="expan"/>​ 
    </xsl:attribute>
    <xsl:apply-templates select="abbr"/>
  </a>​
</xsl:template>

<!-- ================================================ -->
<!--                       ADD                        -->
<!-- ================================================ -->

<xsl:template match="add">
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
</xsl:template>

<!-- ================================================ -->
<!--                       BOLD                       -->
<!-- ================================================ -->

<!-- See "Strong" below -->
  
<!-- ================================================ -->
<!--                       BYLINE                     -->
<!-- ================================================ -->
  
  <xsl:template match="//tei:byline">
    <span class="byline">
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
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>
  

<!-- ================================================ -->
<!--                      DATES                       -->
<!-- ================================================ -->

<xsl:template name="extractDate">
  <xsl:param name="date" />
  <!--This template converts a date from format YYYY-MM-DD to mm D, YYYY (MM, MM-DD, optional)-->
  
  <xsl:variable name="YYYY" select="substring($date,1,4)" />
  <xsl:variable name="MM" select="substring($date,6,2)" />
  <xsl:variable name="DD" select="substring($date,9,2)" />

  <xsl:choose>
    <xsl:when test="($DD != '') and ($MM != '') and ($DD != '')">
      <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM" /></xsl:call-template><xsl:text> </xsl:text> <xsl:number format="1" value="$DD" />, <xsl:value-of select="$YYYY" />
    </xsl:when>
    <xsl:when test="($YYYY != '') and ($MM != '')">
      <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM" /></xsl:call-template>, <xsl:value-of select="$YYYY" />
    </xsl:when>
    <xsl:when test="($DD != '') and ($MM != '')">
      <xsl:call-template name="lookUpMonth"><xsl:with-param name="numValue" select="$MM" /></xsl:call-template>, <xsl:value-of select="$YYYY" />
    </xsl:when>
    <xsl:when test="($YYYY != '')">
      <xsl:value-of select="$YYYY" />
    </xsl:when>
    <xsl:otherwise>
      N.D.
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="lookUpMonth">
  <xsl:param name="numValue" />
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
    <xsl:otherwise></xsl:otherwise></xsl:choose>
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

<!-- ================================================ -->
<!--                  DIV1 and DIV2                   -->
<!-- ================================================ -->

<xsl:template match="div1 | div2 | div3 | div4">
  <xsl:choose>
    <xsl:when test="@type='html'">
      <xsl:copy-of select="."/>
    </xsl:when>
    <xsl:otherwise>
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
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  

 
<!-- ================================================ -->
<!--                  Figure                  -->
<!-- ================================================ -->
  
  <xsl:template match="//tei:figure" priority="1">
    <xsl:variable name="editionName">
      <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'edition']"/>
    </xsl:variable>
    <xsl:variable name="fileName">
      <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'file']"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="parent::tei:ref[@type = 'figure']"/>
      
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:text>figure</xsl:text>
          </xsl:attribute>
          <xsl:for-each select="child::tei:graphic">
            <img>
              <xsl:attribute name="src">
                <xsl:value-of select="./attribute::url"/>
              </xsl:attribute>
              <xsl:attribute name="alt">
                <xsl:value-of select="child::tei:figDesc"/>
              </xsl:attribute>
            </img>
          </xsl:for-each>
          <span class="fig_caption">
            <xsl:for-each select="descendant::tei:head">
                  <h3>
                    <xsl:apply-templates/>
                  </h3>
            </xsl:for-each>
            <xsl:for-each select="descendant::tei:p">
              <div class="p">
                <xsl:apply-templates/>
              </div>
            </xsl:for-each>
            
          </span>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
 <!-- <xsl:template match="figure">
    
    <span>
      <xsl:attribute name="class">
        <xsl:text>tei_figure</xsl:text>
        <xsl:if test="@place">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@place"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:for-each select="child::graphic">
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="./attribute::url"/>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:value-of select="child::figDesc"/>
          </xsl:attribute>
        </img>
      </xsl:for-each>
      <span class="fig_caption">
        <xsl:for-each select="descendant::head">
              <h3>
                <xsl:apply-templates/>
              </h3>
        <xsl:for-each select="descendant::p">
          <div class="p">
            <xsl:apply-templates/>
          </div>
        </xsl:for-each>
          
        </xsl:for-each>
      </span>
    </span>
  </xsl:template>-->

<!-- ================================================ -->
<!--                  Form Work (FW)                  -->
<!-- ================================================ -->
  
  <xsl:template match="fw">
    
    <xsl:choose>
      <xsl:when test="ancestor::p">
        <span class="h6"><xsl:apply-templates/></span>
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
    
  </xsl:template>
  
  <!-- ================================================ -->
  <!--                        FRONTMATTER               -->
  <!-- ================================================ -->
  
  <xsl:template match="//tei:front">
    <div class="frontmatter">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!-- ================================================ -->
<!--                        GAP                       -->
<!-- ================================================ -->

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
    First I test if the div1 has a head. If it does not, I start the div2's on the h3's and work from there. - karin
    -->
    <xsl:when test="//div1">
      <xsl:choose>
        <xsl:when test="//div1/head">
          <xsl:choose>
            <xsl:when test="parent::div1">
              <h3><xsl:apply-templates/></h3>
            </xsl:when>
            <xsl:when test="parent::div2">
              <h4><xsl:apply-templates/></h4>
            </xsl:when>
            <xsl:when test="parent::div3">
              <h5><xsl:apply-templates/></h5>
            </xsl:when>
            <xsl:when test="parent::div4 or parent::div5 or parent::div6 or parent::div7  ">
              <h6><xsl:apply-templates/></h6>
            </xsl:when>
            <xsl:otherwise>
              <h4><xsl:apply-templates/></h4>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="parent::div2">
              <h3><xsl:apply-templates/></h3>
            </xsl:when>
            <xsl:when test="parent::div3">
              <h4><xsl:apply-templates/></h4>
            </xsl:when>
            <xsl:when test="parent::div4">
              <h5><xsl:apply-templates/></h5>
            </xsl:when>
            <xsl:when test="parent::div5 or parent::div6 or parent::div7  ">
              <h6><xsl:apply-templates/></h6>
            </xsl:when>
            <xsl:otherwise>
              <h4><xsl:apply-templates/></h4>
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
  
<!-- ================================================ -->
<!--                        HI                        -->
<!-- ================================================ -->
  
  <xsl:template match="hi[@rend]" priority="2">
    <span>
      <xsl:attribute name="class">
        <xsl:text>tei_rend_</xsl:text>
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="hi[@rend='italic'] | hi[@rend='italics']" priority="1">
    <em>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  
  <xsl:template match="hi[@rend='quoted']" priority="1">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>"</xsl:text>
  </xsl:template>
  
  <xsl:template match="hi[@rend='subscript']" priority="1">
    <sub><xsl:apply-templates/></sub>
  </xsl:template>
  
  <!--  Underline  -->
  
  <xsl:template match="hi[@rend='underlined'] | hi[@rend='underline']" priority="1">
    <u><xsl:apply-templates/></u>
  </xsl:template>
  
  <!--  Positioning -->
  
  <xsl:template match="hi[@rend='right'] | hi[@rend='center']" priority="1">
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

<xsl:template match="teiHeader | revisionDesc | publicationStmt | sourceDesc | figDesc">
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

<xsl:template match="ab[@rend='italics'] | p[@rend='italics']">
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
<!--                       LINKS                      -->
<!-- ================================================ -->

<xsl:template match="list">
  <xsl:if test="head">
    <div class="tei_list_head"><xsl:apply-templates select="head/node()"/></div>
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

<!-- ================================================ -->
<!--               MISC -> SPANS OR EMS               -->
<!-- ================================================ -->

<xsl:template match="term | foreign | emph | biblScope[@type='volume']">
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

<xsl:template
  match="byline | docDate | sp | speaker | letter | 
  notesStmt | titlePart | docDate | ab | trailer | 
  front | lg | l | bibl | dateline | salute | trailer | titlePage | closer | floatingText | date">
  <span>
    <xsl:attribute name="class">
      <xsl:value-of select="name()"/>
      <xsl:if test="@type"><xsl:text> </xsl:text><xsl:value-of select="@type"/></xsl:if>
      <xsl:if test="@rend"><xsl:text> </xsl:text><xsl:value-of select="@rend"/></xsl:if>
      <!--<xsl:if test="not(parent::p)"><xsl:text> p</xsl:text></xsl:if>--> <!-- this is breaking some displays but commeting it out might break others. May need more consideration -todo KMD -->
    </xsl:attribute>
    <xsl:choose>
      <!-- This is for CWW, check to see if this is done correctly, will it add two handwritten classes? -KMD -->
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
  </span>
</xsl:template>
  
  
  <!-- ================================================ -->
  <!--              Notes and Footnotes                 -->
  <!-- ================================================ -->
  
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
      <span>
        <xsl:attribute name="class">
          <xsl:text>pagebreak</xsl:text>
        </xsl:attribute>
        <span class="thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>pages/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
              <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>pages/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
                <xsl:text>_thumb.jpg</xsl:text>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>pages/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
              <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>pages/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
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
    <xsl:otherwise><p><xsl:apply-templates/></p></xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- ================================================ -->
<!--                     QUOTES                       -->
<!-- ================================================ -->



<xsl:template match="quote">
  <xsl:choose>
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
  </xsl:choose>
</xsl:template>

<xsl:template match="q">
  <span class="inline_quote">
    <xsl:apply-templates/>
  </span>
</xsl:template>
  
  
  <!-- ================================================ -->
  <!--               References/Links                   -->
  <!-- ================================================ -->
  
  <xsl:template match="ref">
    <xsl:choose>
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
      <xsl:otherwise>
        <!-- the below will generate a footnote / in page link -->
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
  
  
  <xsl:template match="xref[@n]">
    <a href="{@n}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

<!-- ================================================ -->
<!--                       SEG                        -->
<!-- ================================================ -->

<!-- Handwritten From CWW - move into project file? -->
<xsl:template match="seg[@type='handwritten']">
  <span>
    <xsl:attribute name="class">
      <xsl:text>handwritten</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- ================================================ -->
<!--                       SEG                        -->
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
      <xsl:apply-templates select="corr"/>​ 
    </xsl:attribute>
    <xsl:apply-templates select="sic"/>
  </a>
  </xsl:template>

<!-- ================================================ -->
<!--                    SIGNATURE                     -->
<!-- ================================================ -->

<xsl:template match="//signed">
  <br/>
  <xsl:apply-templates/>
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

<xsl:template match="item/label | hi[@rend='bold']">
  <strong><xsl:apply-templates/></strong>
</xsl:template>


<!-- ================================================ -->
<!--              SUPER AND SUB SCRIPT                -->
<!-- ================================================ -->

  <xsl:template match="p[@rend='superscript'] | p[@rend='sup'] | hi[@rend='super'] | hi[@rend='superscript']">
  <sup><xsl:apply-templates/></sup>
</xsl:template>

<!-- ================================================ -->
<!--                      TABLES                      -->
<!-- ================================================ -->
  
  <!-- remove heads in table by default, they are not allowed -->
  <xsl:template match="table/head"></xsl:template>
  
  <!-- called from table match -->
  <xsl:template match="table/head" mode="show"><div class="tei_table_head"><xsl:apply-templates/></div></xsl:template>

<xsl:template match="table">
  
  <xsl:for-each select="head">
    <xsl:apply-templates select="." mode="show"/>
  </xsl:for-each>
  
  
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




</xsl:stylesheet>