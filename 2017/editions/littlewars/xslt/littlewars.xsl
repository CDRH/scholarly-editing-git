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
        <title>LITTLE WARS</title>
        
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
        <h1><em>LITTLE WARS</em>, by H. G. Wells</h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Edited by Nigel Lepianka and Deanna Stover</div>
        
        <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. Appending #page_info at the end sets the 
         links to start at the edition head. If you add classes on the <li>'s, they will be passed through-->
        <nav>
          <ul>
            <li class="first"><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="fulltext.html#page_info">Text</a></li>
            <li><a href="rules.html#page_info">Streamlined Rules</a></li>
            <li><a href="{$idno}.xml">Page XML &#8659;</a></li>
            <li><a href="littlewars.zip">Edition XML &#8659;</a></li>
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
        <h2>Notes</h2>
        <xsl:if test="preceding::bibl//note[@type='project']"><div class="footnote"><xsl:apply-templates select="preceding::bibl//note[@type='project']"/></div><br/></xsl:if>
        <xsl:for-each select="//text//note[not(@place='bottom')][not(@place='foot')]">
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
  
  <!--ptr template adjusted to accommodate notes in <head> tags-->
  <xsl:template match="ptr">
    <xsl:choose>
      <xsl:when test="parent::head"><span class="head_note"><a>
        <xsl:attribute name="href">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
        <xsl:attribute name="id">
          <xsl:text>inline</xsl:text>
          <xsl:value-of select="substring-after(@target, '#')"/>
        </xsl:attribute>
        <xsl:attribute name="class">edition_notes</xsl:attribute>
        <sup>[<xsl:value-of select="@n"/>]</sup>
      </a></span></xsl:when>
      <xsl:otherwise><a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:text>inline</xsl:text>
        <xsl:value-of select="substring-after(@target, '#')"/>
      </xsl:attribute>
      <xsl:attribute name="class">edition_notes</xsl:attribute>
      <sup>[<xsl:value-of select="@n"/>]</sup>
    </a></xsl:otherwise></xsl:choose>
  </xsl:template>
  
  <xsl:template match="note[@type='project']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!--apparatus footnotes-->
  <xsl:template match="note[not(@place='bottom')]" mode="footnotes">
    <xsl:variable name="noteCount" select="count(preceding::note[not(@place='foot' or @place='bottom')])"/>
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
  
  <!--primary text footnotes-->
  <xsl:template match="note[@place='bottom']">
    <xsl:choose>
      <xsl:when test="ancestor::list"><br/><br/><span class="WellsNote_list"><xsl:text>* </xsl:text><xsl:apply-templates/></span></xsl:when>
      <xsl:otherwise><br/><br/><xsl:text>* </xsl:text><span class="WellsNote"><xsl:apply-templates/></span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="ref">
    <xsl:choose>
      <xsl:when test="starts-with(@target, '#fig')">
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
      <xsl:when test="starts-with(@target, '#pg')">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="@target"/>
          </xsl:attribute>
              <xsl:apply-templates/>
        </a>
      </xsl:when>
      <!-- external links -->
      <xsl:when test="@type='url' or @type='link' or starts-with(@target, 'http://') or starts-with(@target, 'https://')">
        <a>
          <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--title page and printer statement-->
  <xsl:template match="front//titlePart">
    <xsl:choose><xsl:when test="@type='sub'"><br/><br/><h4 class="tei_titlePart"><xsl:apply-templates/></h4><br/></xsl:when>
      <xsl:when test="@type='main'"><br/><br/><h2 class="tei_titlePart"><xsl:apply-templates/></h2><br/></xsl:when>
      <xsl:otherwise><br/><br/><h4 class="tei_titlePart"><xsl:apply-templates/></h4><br/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="front//byline">
    <br/><br/><h5 class="tei_titlePart"><xsl:apply-templates/></h5>
  </xsl:template>
  
  <xsl:template match="front//docAuthor">
    <br/><br/><xsl:apply-templates/><br/><br/>
  </xsl:template>
  
  <xsl:template match="front//docImprint">
    <br/><br/><br/><h5 class="tei_titlePart"><xsl:apply-templates/></h5>
  </xsl:template>
  
  <xsl:template match="byline[preceding-sibling::div]">
    <br/><span class="printer"><xsl:apply-templates/></span>
  </xsl:template>
  
  <!--formeworks-->
  <xsl:template match="fw">
    <xsl:choose>
      <xsl:when test="ancestor::list"><br/><span class="fw_list"><xsl:apply-templates/></span></xsl:when>
      <xsl:otherwise><br/><xsl:apply-templates/></xsl:otherwise></xsl:choose>
  </xsl:template>

  <!--pb templates adjusted according to parent element-->
  <xsl:template match="pb">
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::figure]"><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak</xsl:text>
        </xsl:attribute></span></xsl:when>
      <xsl:otherwise><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak</xsl:text>
        </xsl:attribute>
        <span class="tei_thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>images/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>Full size in new window</xsl:text>
          </a>
        </span>
      </span></xsl:otherwise></xsl:choose>
    <xsl:if test="@n"><span class="page_number"><xsl:apply-templates select="@n"/></span></xsl:if>
  </xsl:template>
  
  <xsl:template match="list[not(ancestor::list)]/item/pb | list[not(ancestor::list)]/item/p/pb | list[not(ancestor::list)]/pb">
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::figure]"><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list</xsl:text>
        </xsl:attribute></span></xsl:when>
      <xsl:otherwise><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list</xsl:text>
        </xsl:attribute>
        <span class="tei_thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>images/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>Full size in new window</xsl:text>
          </a>
        </span>
      </span></xsl:otherwise></xsl:choose>
    <xsl:if test="@n"><span class="page_number_list"><xsl:apply-templates select="@n"/></span></xsl:if>
  </xsl:template>
  
  <xsl:template match="list[not(ancestor::list)]/item/list/item/p/pb">
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::figure]"><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list_misc</xsl:text>
        </xsl:attribute></span></xsl:when>
      <xsl:otherwise><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list_misc</xsl:text>
        </xsl:attribute>
        <span class="tei_thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>images/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>Full size in new window</xsl:text>
          </a>
        </span>
      </span></xsl:otherwise></xsl:choose>
    <xsl:if test="@n"><span class="page_number_list_misc"><xsl:apply-templates select="@n"/></span></xsl:if>
  </xsl:template>
  
  <xsl:template match="list/item/list/item/pb">
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::figure]"><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_doubleList</xsl:text>
        </xsl:attribute></span></xsl:when>
      <xsl:otherwise><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_doubleList</xsl:text>
        </xsl:attribute>
        <span class="tei_thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>images/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>Full size in new window</xsl:text>
          </a>
        </span>
      </span></xsl:otherwise></xsl:choose>
    <xsl:if test="@n"><span class="page_number_doubleList"><xsl:apply-templates select="@n"/></span></xsl:if>
  </xsl:template>
  
  <xsl:template match="list/item/list/pb">
    <xsl:choose>
      <xsl:when test="following-sibling::*[1][self::figure]"><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list_misc</xsl:text>
        </xsl:attribute></span></xsl:when>
      <xsl:otherwise><span>
        <xsl:if test="@xml:id"><xsl:attribute name="id" select="@xml:id"/></xsl:if>
        <xsl:attribute name="class">
          <xsl:text>pagebreak_list_misc</xsl:text>
        </xsl:attribute>
        <span class="tei_thumbnail">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <img>
              <xsl:attribute name="src">
                <xsl:text>images/thumbs/</xsl:text>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="viewsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:text>View Page</xsl:text>
          </a>
        </span>
        <br/>
        <span class="fullsize">
          <a>
            <xsl:attribute name="href">
              <xsl:text>images/fullsize/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:text>Full size in new window</xsl:text>
          </a>
        </span>
      </span></xsl:otherwise></xsl:choose>
    <xsl:if test="@n"><span class="page_number_doubleList"><xsl:apply-templates select="@n"/></span></xsl:if>
  </xsl:template>
  
  <!--lines and line groups in notes-->
  <xsl:template match="lg[ancestor::note]">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="l[ancestor::note]">
        <br/><span class="in_note"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="preceding::idno='rules.littlewars'"><ul><xsl:apply-templates/></ul></xsl:when>
      <xsl:otherwise><xsl:choose>
      <xsl:when test="descendant::label"><ul class="paragraph_list"><xsl:apply-templates/></ul></xsl:when>
      <!--this one--><xsl:otherwise><ul class="hanging_list"><xsl:apply-templates/></ul></xsl:otherwise>
    </xsl:choose></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="item">
    <xsl:choose>
      <xsl:when test="child::label"><p><xsl:apply-templates/></p></xsl:when>
      <!--this one--><xsl:otherwise><li><xsl:apply-templates/></li></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="cell[@rend='indent']">
    <td class="indent">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <xsl:template match="cell[not(following-sibling::cell)]">
    <td class="right"><xsl:apply-templates/></td>
  </xsl:template>
  
  <xsl:template match="hi">
    <xsl:choose>
      <xsl:when test="@bold">
      <strong><xsl:apply-templates/></strong>
    </xsl:when>
    <xsl:when test="@italic">
      <em><xsl:apply-templates/></em>
    </xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="figure">
    <xsl:choose>
      <xsl:when test="ancestor::list"><!--adjust width for this one-->
        <xsl:choose>
          <xsl:when test="ancestor::p">
            <span class="figure_list_p">
              <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
              </xsl:attribute>
              <img class="list">
                <xsl:attribute name="src">
                  <xsl:text>images/viewsize/</xsl:text>
                  <xsl:value-of select="child::graphic/attribute::url"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="child::figDesc"/>
                </xsl:attribute>
              </img></span>
            <span class="cap"><h5 class="figure_list_p">
              <strong><xsl:apply-templates select="child::head"/></strong><xsl:text> </xsl:text><xsl:apply-templates select="child::figDesc"/>
            </h5>
            </span>
          </xsl:when>
          <xsl:otherwise><span class="figure_list">
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <img class="list">
            <xsl:attribute name="src">
              <xsl:text>images/viewsize/</xsl:text>
              <xsl:value-of select="child::graphic/attribute::url"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
              <xsl:value-of select="child::figDesc"/>
            </xsl:attribute>
          </img></span>
        <span class="cap"><h5 class="figure_list">
          <strong><xsl:apply-templates select="child::head"/></strong><xsl:text> </xsl:text><xsl:apply-templates select="child::figDesc"/>
        </h5>
        </span></xsl:otherwise></xsl:choose>
      </xsl:when>
      <xsl:otherwise><span class="figure">
      <xsl:attribute name="id">
        <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
      <img class="normal">
        <xsl:attribute name="src">
          <xsl:text>images/viewsize/</xsl:text>
          <xsl:value-of select="child::graphic/attribute::url"/>
        </xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="child::figDesc"/>
        </xsl:attribute>
      </img></span>
    <span class="cap"><h5>
      <strong><xsl:apply-templates select="child::head"/></strong><xsl:text> </xsl:text><xsl:apply-templates select="child::figDesc"/>
    </h5>
    </span></xsl:otherwise></xsl:choose>
  </xsl:template>
  
  <xsl:template match="head[not(ancestor::figure)]">
    <!-- need to fix for handwritten text -KD -->
    <xsl:choose>
      <xsl:when test="@type='label'"><span class="figure_list"><xsl:apply-templates/></span></xsl:when>
      <xsl:when test="@type='sub'"><xsl:choose>
        <xsl:when test="following-sibling::list"><h4 class="sub_head_list"><xsl:apply-templates/></h4>
        </xsl:when>
        <xsl:when test="parent::list"><h4 class="head_list"><xsl:apply-templates/></h4></xsl:when>
        <xsl:otherwise><h4 class="sub_head"><xsl:apply-templates/></h4></xsl:otherwise></xsl:choose></xsl:when>
      <xsl:when test="ancestor::list">
        <h3><span class="head_list"><xsl:apply-templates/></span></h3>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'p']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      
      <!-- I added the div1 code for OSCYS, but I assume it will pop up elsewhere. 
    First I test if the div1 has a head. If it does not, I start the div2's on the h3's and work from there. - karin
    -->
      <xsl:when test="//div">
        <xsl:choose>
          <xsl:when test="preceding-sibling::pb[@n='101'] and following-sibling::head"><h3 class="appendix"><xsl:apply-templates/></h3></xsl:when>
          <xsl:otherwise><h3><xsl:apply-templates/></h3></xsl:otherwise>
        </xsl:choose>
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
 
 <xsl:template match="p[contains(preceding::idno[@type='file'],'intro')]">
   <span class="tei_intro"><p><xsl:apply-templates/></p></span>
 </xsl:template>
  
  
</xsl:stylesheet>