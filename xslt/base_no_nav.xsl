<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:include href="config.xsl"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Scholarly Editing: The Annual of the Association for Documentary
                    Editing</title>
                <link href="{$siteroot}css/style.css" rel="stylesheet" type="text/css"/>
                <link href="{$siteroot}js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"
                    rel="stylesheet" type="text/css"/>
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"> &#160; </script>
                <script src="{$siteroot}js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js"> &#160; </script>
                <script src="{$siteroot}js/javascript.js"> &#160; </script>
            </head>
            <body>
                <div id="content">
                    <div class="nav">
                        <ul>
                            <li id="nav1">
                                <a href="">Issues</a>
                            </li>
                            <li id="nav2">
                                <a href="">Editions</a>
                            </li>
                            <li id="nav3">
                                <a href="">Essays</a>
                            </li>
                            <li id="nav4">
                                <a href="">Reviews</a>
                            </li>
                            <li id="about">
                                <a href="">About</a>
                            </li>
                        </ul>
                    </div>
                    <div class="masthead">
                        <h1>
                            <a href="">
                                <span>Scholarly Editing</span>
                            </a>
                        </h1>
                        <h4>The Annual of the Association for Documentary Editing</h4>
                        <xsl:call-template name="volCitation"/>
                    </div>
                    <xsl:apply-templates select="//tei:titleStmt"/>
                    <xsl:variable name="idno">
                        <xsl:value-of select="//tei:idno"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="starts-with($idno,'se.')">
                            <div class="list">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno,'intro')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div class="edition">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
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
                                <img src="images/adelogo.png"
                                    alt="Logo of the Association for Documentary Editing"/>
                            </a>
                        </span>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <!-- This is probably a wholly inadequate way to begin dealing with some of the metadata in the teiheader. 
        We will probably want to standardize the way we do this to some degree, at least in the sense of
        providing a standard masthead and way of crediting the editors. -->
    <xsl:template match="//tei:titleStmt">
        <div class="editionHeader">
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
        </div>
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
            <!--<xsl:when test="//tei:idno/@type = 'edition'">-->
                <xsl:when test="//tei:idno[@type='edition'] = 'utctopsy'">
<xsl:choose>
    <xsl:when test="//tei:idno[@type='file'] = 'intro.utctopsy'"><p>
        <xsl:apply-templates/>
    </p></xsl:when>
<xsl:otherwise><div class="p">
                    <xsl:apply-templates/>
                </div></xsl:otherwise>
</xsl:choose>
                    
                    
                
                <!-- This is the test to see if the parent is a "note" -->
                <!--<xsl:if test="name(parent::node()) = 'note'"></xsl:if>-->
                

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
    <!-- basic <hi> rendering -->
    <xsl:template match="//tei:hi">
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
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- Figures -->
    <xsl:template match="//tei:figure">
        <xsl:choose>
            <xsl:when test="parent::tei:ref[@type='figure']"/>
            <xsl:otherwise>
                <span><xsl:attribute name="class"><xsl:choose><xsl:when test="@place='margin-left'">figure_left</xsl:when><xsl:when test="@place='margin-right'">figure_right</xsl:when><xsl:when test="@place='center'">figure_center</xsl:when><xsl:otherwise>figure</xsl:otherwise></xsl:choose></xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:value-of select="child::tei:graphic/attribute::url"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="child::tei:figDesc"/>
                        </xsl:attribute>
                    </img>
                    <span class="fig_caption">
                        <xsl:for-each select="child::tei:head">
                            <h3>
                                <xsl:apply-templates/>
                            </h3>
                        </xsl:for-each>
                        <xsl:for-each select="child::tei:p">
                            <p>
                                <xsl:apply-templates/>
                            </p>
                        </xsl:for-each>
                    </span>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- for Tables -->
    <xsl:template match="//tei:table">
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
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:l">
        <span class="poem_line">
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
                <xsl:when test="preceding-sibling::tei:byline">and <xsl:apply-templates/></xsl:when>
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
                        
                        
                        
                        <xsl:variable name="refTarget">
                            <xsl:value-of select="attribute::target"/>
                        </xsl:variable>
                        <xsl:variable name="refContent"><xsl:for-each select=".">
                            <xsl:apply-templates />
                        </xsl:for-each></xsl:variable>
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
                        
                        
                        
                        
                        
                        
                        
                        
                    </xsl:when>
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                </xsl:choose>
                
                
            </xsl:when>
            <xsl:when test="@type='figure'">
                <span class="viewsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$editionName"/>
                            <xsl:text>/pages/viewsize/</xsl:text>
                            <xsl:value-of select="descendant::tei:graphic/attribute::url"/>
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="child::tei:figure/child::tei:head"/>
                            <xsl:if test="string(child::tei:figure/child::tei:p)">
                                <xsl:value-of
                                    select="concat('&lt;br &gt;',child::tei:figure/child::tei:p[normalize-space()])"
                                />
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </span>
            </xsl:when>
            <xsl:otherwise>
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
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
