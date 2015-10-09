<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <!--<xsl:strip-space elements="*" />-->

    <xsl:param name="utctopsy_notes">undefined</xsl:param>
    <xsl:param name="sevenplanets_abbr">undefined</xsl:param>
    <xsl:include href="config.xsl"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <xsl:preserve-space elements="tei:*" />
<!--<xsl:template name="volCitation"/>
    <xsl:template name="essayNav"/>
    <xsl:template name="editionNav"/>-->
    <xsl:template match="/">
        <html>
            <head>
                <!--<link><xsl:attribute name="href">http://fonts.googleapis.com/css?family=Gentium+Basic:400,700,400italic,700italic&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css</xsl:attribute></link> -->
                <title>Scholarly Editing: The Annual of the Association for Documentary
                    Editing</title>
                
                <link href="{$siteroot}css/style.css" rel="stylesheet" type="text/css"/>
                <link href="{$siteroot}js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"
                    rel="stylesheet" type="text/css"/>
                
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
                <script src="{$siteroot}js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js"> &#160; </script>
                <script src="{$siteroot}js/javascript.js"> &#160; </script>
                <script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-29415214-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
            </head>
            <body>
                <div id="content">
                    <div class="nav">
                        <ul>
                            <li id="nav1">
                                <a href="{$siteroot}se.index.issues.html">Issues</a>
                            </li>
                            <li id="nav2">
                                <a href="{$siteroot}se.index.editions.html">Editions</a>
                            </li>
                            <li id="nav3">
                                <a href="{$siteroot}se.index.essays.html">Essays</a>
                            </li>
                            <li id="nav4">
                                <a href="{$siteroot}se.index.reviews.html">Reviews</a>
                            </li>
                            <li id="about">
                                <a href="{$siteroot}se.about.html">About</a>
                            </li>
                        </ul>
                    </div>
                    <div class="masthead">
                        <h1>
                            <a href="{$siteroot}">
                                <span>Scholarly Editing</span>
                            </a>
                        </h1>
                        <h4>The Annual of the Association for Documentary Editing</h4>
                        <xsl:call-template name="volCitation"/>
                    </div>
                    <xsl:apply-templates select="//tei:titleStmt"/>
                    <xsl:variable name="idno">
                        <xsl:value-of select="//tei:idno[@type='file']"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="starts-with($idno,'se.')">
                            <div class="list">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'intro')">
                            <xsl:choose>
                                <xsl:when test="$idno='intro.sevenplanets'"><div class="essay"><div class="sevenplanetsintro">
                                    <xsl:apply-templates/></div>
                                </div></xsl:when>
                                <xsl:otherwise><div class="essay">
                                    <xsl:apply-templates/>
                                </div></xsl:otherwise>
                            </xsl:choose>
                            
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'about')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'main')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'help')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'essay')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'review')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'juxta')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div class="edition">
                                <xsl:if test="descendant::tei:sourceDesc//tei:listWit"><xsl:apply-templates select="//tei:sourceDesc//tei:listWit"/><xsl:call-template name="witnessName"/></xsl:if>
                                <xsl:apply-templates/>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="$idno='main.baroness'"><a href="http://v-machine.org/"><img class="pbvm" src="./includes/images/poweredby.gif" alt="powered by the Versioning Machine, version 4.0"/></a></xsl:if>
                    <div class="footer">
                        <span class="creativecommons"><a rel="license"
                                href="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                                <img alt="Creative Commons License" style="border-width:0"
                                    src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png"/>
                            </a><br/>This work is licensed under a <a rel="license"
                                href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative
                                Commons Attribution-NonCommercial-ShareAlike 3.0 Unported
                                License</a>.</span>

                        <span class="adelogo">
                            <a href="http://www.documentaryediting.org">
                                <img src="{$siteroot}images/adelogo.png"
                                    alt="Logo of the Association for Documentary Editing"/>
                            </a>
                        </span><span class="cdrh">Sponsored by the <a href="http://cdrh.unl.edu">Center for Digital Research in the Humanities at the University of Nebraska-Lincoln</a>.</span>
                        <span class="issn">ISSN 2167-1257</span>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
 

    <xsl:template match="//tei:titleStmt">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:variable name="editionIdno"><xsl:value-of select="//tei:idno[@type='edition']"/></xsl:variable>
<xsl:choose>
    <xsl:when test="starts-with($idno,'essay')">
        <div class="essayHeader"><h1 class="essaysTitle">Essays</h1></div>
        <span class="essayNav"><xsl:call-template name="essayNav"/></span>
    </xsl:when>
    <xsl:when test="starts-with($idno,'review')">
        <div class="essayHeader"><h1 class="essaysTitle">Reviews</h1></div>
        <span class="essayNav"><xsl:call-template name="essayNav"/></span>
    </xsl:when>
    <xsl:when test="$editionIdno='cwnewspaperpoetry'">
        <div class="editionHeader"><h1 class="editionTitle">"Will not these days be by thy poets sung": Poems of the <em>Anglo-African</em> and <em>National Anti-Slavery Standard</em>, 1863&#8211;1864</h1><span class="editor">Edited by Elizabeth Lorang and R. J. Weir</span>
        <span class="editionNav"><xsl:call-template name="editionNav"/></span></div>



    </xsl:when>
    
    <xsl:otherwise><div class="editionHeader">
            <xsl:for-each select="child::tei:title">
                <xsl:choose>
                    <xsl:when test="attribute::type='sub'"/>
                    <xsl:otherwise>
                        <h1 class="editionTitle">
                            <xsl:apply-templates/>
                        </h1>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:for-each select="child::tei:author">
                <span class="author">by <xsl:apply-templates/></span>
            </xsl:for-each>
            <xsl:apply-templates select="child::tei:editor"/>
            <span class="editionNav">
                <xsl:choose>
                    <xsl:when test="ancestor::tei:TEI//tei:idno[@type='edition']='utctopsy'">
                        <span id="editionNavLong">
                            <xsl:call-template name="editionNav"/>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="editionNav"/>
                    </xsl:otherwise>
                </xsl:choose>


            </span>
        </div></xsl:otherwise>

</xsl:choose>
        
    </xsl:template>
    <!-- renders name(s) of editors -->
    <xsl:template match="//tei:titleStmt/child::tei:editor">
        <xsl:choose>
            <xsl:when test="./following-sibling::tei:editor">
                <span class="editor">Edited by <xsl:value-of select="."/> and <xsl:value-of
                        select="following-sibling::tei:editor"/></span>
            </xsl:when>
            <xsl:when test="./preceding-sibling::tei:editor"/>
            <xsl:otherwise>
                <span class="editor">Edited by <xsl:value-of select="."/></span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- basic paragraph rendering -->
    <xsl:template match="tei:p">

        <xsl:choose>
           
            <xsl:when
                test="//tei:idno[@type='edition'] = 'utctopsy'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type='file'] = 'intro.utctopsy'">
                        <p>
                            <xsl:apply-templates />
                        </p>
                    </xsl:when>
                    <xsl:when test="//tei:idno[@type='file'] = 'juxta.utctopsy'">
                        <p>
                            <xsl:apply-templates />
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates />
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when
                test="//tei:idno[@type='edition'] = 'sevenplanets'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type='file'] = 'intro.sevenplanets'">
                        <div class="p">
                            <xsl:apply-templates />
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates />
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when
                test="//tei:idno[@type='edition'] = 'haley'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type='file'] = 'haley.handnotes'">
                        <p>
                            <xsl:apply-templates />
                        </p>
                    </xsl:when>
                    <xsl:when test="//tei:idno[@type='file'] = 'haley.typednotes'">
                        <p>
                            <xsl:apply-templates />
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates />
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when
                test="//tei:idno[@type='edition'] = 'cwnewspaperpoetry'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type='file'] = 'intro.cwpoems'">
                        <xsl:choose><xsl:when test="parent::tei:note"><div class="p"><xsl:apply-templates/></div></xsl:when><xsl:otherwise><p>
                            <xsl:apply-templates />
                        </p></xsl:otherwise></xsl:choose>
                    </xsl:when>
                    <xsl:when test="parent::tei:note[@type='editorial']"><xsl:choose><xsl:when test="following-sibling::tei:p"><div class="p">
                        <xsl:apply-templates />
                    </div><div class="blank_line">&#160;</div></xsl:when><xsl:otherwise><div class="p">
                        <xsl:apply-templates />
                    </div></xsl:otherwise></xsl:choose></xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates />
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
                    
                    
            <xsl:otherwise>
                
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>
    <!-- linebreak rendering -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
<!-- basic <emph> rendering -->
<xsl:template match="//tei:emph"><xsl:choose>
    <xsl:when test="@rend='smallcaps'"><span class="smallcaps"><xsl:apply-templates/></span></xsl:when>
    <xsl:when test="@rend='italic'"><em><xsl:apply-templates/></em></xsl:when>
    <xsl:otherwise><em><xsl:apply-templates/></em></xsl:otherwise>
</xsl:choose></xsl:template>


    <!-- basic <hi> rendering -->
    <xsl:template match="//tei:hi">
    <xsl:variable name="rendvalue"><xsl:value-of select="@rend"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="./attribute::rend='italics'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:when test="./attribute::rend='italic'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:when test="./attribute::rend='bold'">
                <strong>
                    <xsl:apply-templates/>
                </strong>
            </xsl:when>
            <xsl:when test="./attribute::rend='small-caps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when>
            <xsl:when test="./attribute::rend='smallcaps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when>
            <xsl:when test="./attribute::rend='small caps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when><xsl:when test="./attribute::rend='decorated initial'">
                <span class="decoratedinitial">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='highlighting stroke'">
                <span class="highlightingstroke">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='superscript'">
                <span class="superscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='italic superscript'">
                <span class="italicsuperscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='bold superscript'">
                <span class="boldsuperscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='bold background(red)'">
                <span class="boldbackgroundred">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="starts-with($rendvalue,'color')">

                <span><xsl:attribute name="style">color:#<xsl:value-of select="substring($rendvalue,7,6)"/></xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend='underline'">
                <u>
                    <xsl:apply-templates/>
                </u>
            </xsl:when>
            <xsl:when test="./attribute::rend='persign'"><span class="persign"><img src="{$siteroot}images/persign.png" alt="[per sign]" height="10px"/></span></xsl:when>
            <xsl:when test="./attribute::rend='longS'"><span class="longS"><xsl:apply-templates/></span></xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- Figures -->
    <xsl:template match="//tei:figure">
        <xsl:variable name="editionName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type='edition']" />
        </xsl:variable>
        <xsl:variable name="fileName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="attribute::type='inline'">
                <img class="inline">
                    <xsl:attribute name="src">
                        <xsl:value-of select="child::tei:graphic/attribute::url" />
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select="child::tei:figDesc" />
                    </xsl:attribute>
                </img>
            </xsl:when>
            <xsl:when test="parent::tei:ref[@type='figure']" />
            <xsl:when test="attribute::type='enlargeOnClick'">
                <span class="enlargeOnClick">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:choose>
                                <xsl:when test="$editionName='sevenplanets'">
                                    <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="child::tei:graphic/attribute::url" />
                                </xsl:when>
                                <xsl:when test="$fileName='essay.calvert' or $fileName='essay.porter'">
                                    <xsl:text>images/viewsize/</xsl:text>
                                    <xsl:value-of select="substring(child::tei:graphic/attribute::url,8)" />
                                </xsl:when>
                                
                                <xsl:otherwise>
                                    <xsl:text>/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="child::tei:graphic/attribute::url" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <img width="600px">
                            <xsl:attribute name="src">
                                <xsl:choose>
                                    <xsl:when test="$editionName='sevenplanets'"
                                        >sevenplanets/<xsl:value-of
                                        select="child::tei:graphic/attribute::url" /> </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="child::tei:graphic/attribute::url" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                          
                            <xsl:attribute name="alt">
                                <xsl:value-of select="child::tei:figDesc" />
                            </xsl:attribute>
                        </img>
                    </a>
                    <span class="fig_caption">
                        <xsl:choose>
                            <xsl:when test="descendant::tei:floatingText">
                                <xsl:for-each select="child::tei:head">
                                    <h3>[Click on image to enlarge]
                                        <xsl:apply-templates />
                                    </h3>
                                </xsl:for-each>
                            <xsl:for-each select="descendant::tei:div">
                                        <span class="fig_floatingText_div"><xsl:for-each select="child::tei:head"><h3><xsl:apply-templates/></h3></xsl:for-each>
                                           <xsl:for-each select="descendant::tei:p"><p><xsl:apply-templates/></p></xsl:for-each></span>
                                </xsl:for-each>
</xsl:when><xsl:otherwise> <xsl:for-each select="descendant::tei:head">
                            <h3>[Click on image to enlarge]
                                <xsl:apply-templates />
                            </h3>
                        </xsl:for-each>
                        <xsl:for-each select="descendant::tei:p">
                            <p>
                                <xsl:apply-templates />
                            </p>
                        </xsl:for-each></xsl:otherwise>
                        </xsl:choose>
                       
                    </span>
                </span>
          
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="@place='margin-left'">figure_left</xsl:when>
                            <xsl:when test="@place='margin-right'">figure_right</xsl:when>
                            <xsl:when test="@place='center'">figure_center</xsl:when>
                            <xsl:otherwise>figure</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:for-each select="child::tei:graphic"><img>
                        <xsl:attribute name="src">
                            <xsl:choose>
                                <xsl:when test="$editionName='sevenplanets'"
                                    >sevenplanets/<xsl:value-of
                                    select="./attribute::url" /> </xsl:when>
                                <xsl:when test="$editionName='cwnewspaperpoetry'"
                                    >cwnewspaperpoetry/<xsl:value-of
                                        select="./attribute::url" /> </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="./attribute::url" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$editionName='sevenplanets'">
                                <xsl:attribute name="height">
                                    <xsl:value-of select="./attribute::height" />
                                </xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="child::tei:figDesc" />
                        </xsl:attribute>
                    </img></xsl:for-each>
                    <span class="fig_caption">
                        <xsl:for-each select="descendant::tei:head">
                            <h3>
                                <xsl:apply-templates />
                            </h3>
                        </xsl:for-each>
                        <xsl:for-each select="descendant::tei:p">
                            <p>
                                <xsl:apply-templates />
                            </p>
                        </xsl:for-each>
                    </span>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- for use of <graphic> in a <table> but not in a <figure> element -->

<xsl:template match="//tei:cell/tei:graphic">
    <xsl:variable name="editionName">
        <xsl:value-of select="//tei:publicationStmt/tei:idno[@type='edition']"/>
    </xsl:variable>
<img>
        <xsl:choose>
            <xsl:when test="$editionName='sevenplanets'"><xsl:attribute name="src">sevenplanets/<xsl:value-of select="./attribute::url"/>
            </xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="./attribute::height"></xsl:value-of></xsl:attribute>
            
</xsl:when>

<xsl:otherwise><xsl:attribute name="src">
            <xsl:value-of select="./attribute::url"/>
        </xsl:attribute></xsl:otherwise></xsl:choose>

<!-- the following is an experiment to see if the height and width attributes in the XML of intro.sevenplanets can be transformed to pixel sizes effectively -->
    <!--<xsl:attribute name="height">
            <xsl:value-of select="substring(./attribute::height,1,4)"/></xsl:attribute>
    <xsl:attribute name="width">
        <xsl:value-of select="substring(./attribute::width,1,4)"/></xsl:attribute>-->

    </img>

</xsl:template>

    <!-- for Tables -->
    <xsl:template match="//tei:table">
<xsl:for-each select="child::tei:head"><h2><xsl:apply-templates/></h2></xsl:for-each>
        <table>
            <xsl:for-each select="child::tei:row">
                <tr>
                    <xsl:for-each select="child::tei:cell">
                        <td>
                            <xsl:apply-templates/>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <!-- For Poetry -->
    <xsl:template match="//tei:lg">
        <xsl:choose>
            <xsl:when test="@type='poem'">
                <div class="poem">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='cluster'">
                <div class="cluster">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='stanza'">
                <div><xsl:attribute name="class">stanza<xsl:if test="@rend='center'">_center</xsl:if></xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='chorus'">
                <div class="stanza">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:l">
        <span><xsl:attribute name="class">poem_line<xsl:if test="@rend">_<xsl:value-of select="@rend"/></xsl:if></xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!-- Blockquotes -->
    <xsl:template match="//tei:q[attribute::rend='block']">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <!-- For bylines in documents -->
    <xsl:template match="//tei:byline">
        <span class="byline">
            <xsl:choose>
                <xsl:when test="preceding-sibling::tei:byline"><xsl:choose><xsl:when test="following-sibling::tei:byline"><xsl:apply-templates/></xsl:when><xsl:otherwise>and <xsl:apply-templates/></xsl:otherwise></xsl:choose></xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <!-- for front matter, like heads and bylines -->
    <xsl:template match="//tei:front">
        <div class="frontmatter">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- This is for email addresses;  apparently this protects the email addresses from being harvested
by bots, spammers, and other evildoers -->
    <xsl:template match="//tei:milestone[@unit='email']">
        <xsl:choose>
            <xsl:when test="@type='andyemail'">
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
            <xsl:when test="@type='amandaemail'">
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
    <xsl:template match="//tei:ref">

        <xsl:variable name="editionName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type='edition']"/>
        </xsl:variable>
        <xsl:choose>
<xsl:when test="$editionName='utctopsy'">
<xsl:choose>
    <xsl:when test="@target">
<xsl:choose>
    <xsl:when test="ancestor::tei:div[@type='notes']">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
                <xsl:choose>
                    <xsl:when test="@type='url'"/>
                    <xsl:when test="@type='html'">.html</xsl:when>
                    <xsl:when test="@type='pdf'">.pdf</xsl:when>
                    <xsl:when test="@type='xml'">.xml</xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="@n">
                <xsl:attribute name="class">ref<xsl:value-of select="@n"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </a>
</xsl:when>
    <xsl:when test="./ancestor::tei:TEI/descendant::tei:idno[@type='file']='intro.utctopsy'">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
                <xsl:choose>
                    <xsl:when test="@type='url'"/>
                    <xsl:when test="@type='html'">.html</xsl:when>
                    <xsl:when test="@type='pdf'">.pdf</xsl:when>
                    <xsl:when test="@type='xml'">.xml</xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:attribute>
            
            <xsl:apply-templates/>
        </a>
    </xsl:when>
    <xsl:when test="./ancestor::tei:TEI/descendant::tei:idno[@type='file']='juxta.utctopsy'">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
                
            </xsl:attribute>
            
            <xsl:apply-templates/>
        </a>
    </xsl:when>

<xsl:otherwise>
        

            
            <xsl:variable name="refTarget">
                <xsl:value-of select="attribute::target"/>
            </xsl:variable>
            <xsl:variable name="refContent"><xsl:for-each select="."><xsl:apply-templates/></xsl:for-each></xsl:variable>
            <xsl:variable name="fileID">
                <xsl:value-of select="ancestor::tei:TEI/descendant::tei:idno[@type='file']"/>
                
            </xsl:variable>
            
            <xsl:for-each select="document('../2012/editions/utctopsy/utc_variants.xml')/tei:TEI">
                <xsl:for-each select="descendant::tei:item/tei:app">
                    <xsl:variable name="appID">
                        <xsl:for-each select="./attribute::loc">
                            <xsl:value-of select="substring-after(.,'#')"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="ptrID">
                        <xsl:for-each select="./following-sibling::tei:ptr/attribute::target">
                            <xsl:value-of select="substring-after(.,'#')"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="rdgWit">
                        <xsl:for-each select="child::tei:rdg"><xsl:value-of select="attribute::wit"/></xsl:for-each>
                        
                    </xsl:variable>
                    
                    <xsl:if test="$appID = $refTarget">
                        
                        <div class="showNote">
                            <!-- &#8620; &#9776;-->
                            <xsl:if test="$utctopsy_notes='undefined'">
                                
                                <a href="#" onclick="return false;"><xsl:copy-of select="$refContent"/></a>
                                
                            </xsl:if>
                        </div>
                        <div>
                            <xsl:attribute name="class">
                                <xsl:choose>
                                    <xsl:when test="$utctopsy_notes='undefined'">appEntry</xsl:when>
                                    <xsl:when test="$utctopsy_notes='show'">appEntryShow</xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="$utctopsy_notes='undefined'"><a href="#" class="closenote">X</a></xsl:when>
                                <xsl:when test="$utctopsy_notes='show'"><!--no x needed if all notes are shown--></xsl:when>
                            </xsl:choose>
                            <xsl:apply-templates select="."/>
                            <xsl:for-each select="//tei:note[@xml:id = $ptrID]">
                                <div class="rdgNote">
                                    <h4>Note</h4>
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
            
</xsl:otherwise>
</xsl:choose>      
        





</xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose>
    

</xsl:when>
<xsl:when test="@type='figure'"><span class="viewsize"><a><xsl:attribute name="href"><xsl:choose><xsl:when test="$editionName='baroness'"><xsl:value-of select="descendant::tei:graphic/attribute::url"/></xsl:when><xsl:otherwise><xsl:value-of select="$editionName"/><xsl:text>/pages/viewsize/</xsl:text><xsl:value-of select="descendant::tei:graphic/attribute::url"/><xsl:text>.jpg</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute><xsl:attribute name="title">    <xsl:value-of select="child::tei:figure/child::tei:head"/><xsl:if test="string(child::tei:figure/child::tei:p)"><xsl:value-of select="concat('&lt;br &gt;',child::tei:figure/child::tei:p[normalize-space()])"/></xsl:if></xsl:attribute><xsl:apply-templates/></a></span></xsl:when>

<xsl:otherwise>

<a>
                    <xsl:attribute name="href">
                        <xsl:if test="@type='email'">mailto:</xsl:if>
                        <xsl:if test="$editionName='cwnewspaperpoetry'"><xsl:if test="contains(@target, 'pp')">cwnewspaperpoetry/pages/issues/fullsize/</xsl:if></xsl:if>
                            <xsl:value-of select="@target"/>
                        <xsl:choose>
                            <xsl:when test="$editionName='cwnewspaperpoetry'"><xsl:choose><xsl:when test="contains(@target, 'pp')">.jpg</xsl:when><xsl:otherwise>.html</xsl:otherwise></xsl:choose></xsl:when>
                            <xsl:when test="@type='url'"/>
                            <xsl:when test="@type='html'">.html</xsl:when>
                            <xsl:when test="@type='pdf'">.pdf</xsl:when>
                            <xsl:when test="@type='xml'">.xml</xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:if test="@n">
                        <xsl:attribute name="class">ref<xsl:value-of select="@n"/></xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/></a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>




    <!-- to get the witness list in <sourceDesc> into a list of options-->
    <xsl:template match="//tei:sourceDesc//tei:listWit">
        <ul class="listWit">
            <li><span class="listWitHead">Select a Witness</span>
                <div><ul>
               
            <xsl:for-each select="./child::tei:witness">
                <li><a><xsl:attribute name="href"><xsl:value-of select="$siteroot"/>2013/editions/<xsl:value-of select="//tei:idno[@type='edition']"/>_<xsl:value-of select="@xml:id"/>.html</xsl:attribute><xsl:value-of select="@xml:id"/>.&#160;<xsl:apply-templates/></a></li>
            </xsl:for-each>
           </ul></div></li> 
        </ul>
        
    </xsl:template>


</xsl:stylesheet>
