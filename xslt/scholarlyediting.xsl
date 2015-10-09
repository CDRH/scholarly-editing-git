<?xml version="1.0" encoding="ASCII"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xalan="http://xml.apache.org/xalan"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Scholarly Editing: The Annual of the Association for Documentary
                    Editing</title>
                <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <div id="content">
                    <div class="masthead"><h2>Scholarly Editing</h2><h4>The Annual of the
Association for Documentary Editing</h4><p>2012, Volume 33</p></div>
                    <xsl:apply-templates select="//tei:titleStmt"/>
                    <xsl:apply-templates />
                </div>
            </body>
        </html>
    </xsl:template>
    <!-- Information from <teiHeader> for providing title, credits, etc. -->
    <xsl:template match="//tei:teiHeader" />

    
    <xsl:template match="tei:text">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <xsl:template match="//tei:head">
        <h4>
            <xsl:apply-templates />
        </h4>
    </xsl:template>

<!-- This is a wholly inadequate way to begin dealing with some of the metadata in the teiheader. 
We will probably want to standardize the way we do this to some degree, at least in the sense of
providing a standard masthead and way of crediting the editors. -->
    <xsl:template match="//tei:titleStmt">
        <xsl:for-each select="child::tei:title">
            <xsl:choose>
                <xsl:when test="@type='main'">
                    <h1>
                        <xsl:apply-templates />
                    </h1>
                    <xsl:for-each select="following-sibling::tei:author">
                        <span class="author">by <xsl:apply-templates /></span>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="@type='sub'">
                    <h2>
                        <xsl:apply-templates />
                    </h2>
                </xsl:when>
                <xsl:otherwise>
                    <h1>
                        <xsl:apply-templates />
                    </h1>
                    <xsl:for-each select="following-sibling::tei:author">
                        <span class="author">by <xsl:apply-templates /></span>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:for-each select="child::tei:principal">
            <h2 class="editor">Edited by <xsl:apply-templates /></h2>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="//tei:pb"><span class="pagebreak">&#8212;&#8212;&#8212;&#8212;&#8212;</span></xsl:template>

<!-- for Tables -->
    <xsl:template match="//tei:table">
        <table>
            <xsl:for-each select="child::tei:row">
                <tr>
                    <xsl:for-each select="child::tei:cell">
                        <td>
                            <xsl:apply-templates />
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>


<!-- Figures -->

    <xsl:template match="//tei:figure">
        <span class="figure">
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="child::tei:graphic/attribute::url" />
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="child::tei:figDesc" />
                </xsl:attribute>
            </img>
            <span class="fig_caption">
                <xsl:for-each select="child::tei:head">
                    <h3>
                        <xsl:apply-templates />
                    </h3>
                </xsl:for-each>
                <xsl:for-each select="child::tei:p">
                    <p>
                        <xsl:apply-templates />
                    </p>
                </xsl:for-each>
            </span>
        </span>
    </xsl:template>


<!-- Title Page -->

    <xsl:template match="//tei:titlePage">
        <div class="titlePage">
            <xsl:for-each select="descendant::tei:titlePart">
                <xsl:choose>
                    <xsl:when test="./attribute::type='main'">
                        <h2>
                            <xsl:apply-templates />
                        </h2>
                    </xsl:when>
                    <xsl:when test="./attribute::type='sub'">
                        <h4>
                            <xsl:apply-templates />
                        </h4>
                    </xsl:when>
                    <xsl:otherwise>
                        <h2>
                            <xsl:apply-templates />
                        </h2>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:for-each select="child::tei:byline">
                    <span class="titlepageByline">
                        <xsl:apply-templates />
                    </span>
                </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="child::tei:docImprint">
                <span class="titlepageImprint">
                    <xsl:apply-templates />
                </span>
            </xsl:for-each>
        </div>
    </xsl:template>

<!-- Forme Works (omitted for now) -->

<xsl:template match="//tei:fw"></xsl:template>

<xsl:template match="//tei:lb"><br/></xsl:template>
<xsl:template match="//tei:hi">
<xsl:choose>
    <xsl:when test="./attribute::rend='italics'"><em><xsl:apply-templates/></em></xsl:when>
    <xsl:when test="./attribute::rend='italic'"><em><xsl:apply-templates/></em></xsl:when>
    <xsl:when test="./attribute::rend='bold'"><strong><xsl:apply-templates/></strong></xsl:when>
    <xsl:when test="./attribute::rend='small-caps'"><small><xsl:value-of select="upper-case(.)"/></small></xsl:when>
    <xsl:when test="./attribute::rend='smallcaps'"><small><xsl:value-of select="upper-case(.)"/></small></xsl:when>
    <xsl:when test="./attribute::rend='small caps'"><small><xsl:value-of select="upper-case(.)"/></small></xsl:when>
</xsl:choose>
    
</xsl:template>

</xsl:stylesheet>
