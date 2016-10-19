<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="base.xsl" />
    <xsl:template match="//tei:teiHeader" />
<xsl:template name="essayNav"/>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav"> </xsl:template>
    <xsl:template name="volCitation"> </xsl:template>
    <xsl:template name="witnessName"> </xsl:template>
    

<xsl:template match="tei:body/tei:head">
        <h1>
            <xsl:apply-templates />
        </h1>
    </xsl:template>


    <xsl:template match="tei:div/tei:head">
        <h2>
            <xsl:apply-templates />
        </h2>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="attribute::type='simple'">
                <ul><xsl:if test="@xml:id"><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute></xsl:if>
                    <xsl:apply-templates />
                </ul>
            </xsl:when>
            <xsl:when test="attribute::type='bulleted'">
                <ul class="bulleted">
                    <xsl:apply-templates />
                </ul>
            </xsl:when>
            <xsl:when test="attribute::type='ordered'">
                <ol>
                    <xsl:apply-templates />
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates />
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:list/tei:head[@type='main']">
        
        <xsl:choose><xsl:when test="ancestor::tei:item"><h4><xsl:apply-templates/></h4></xsl:when><xsl:otherwise><h3>
            <xsl:apply-templates />
        </h3></xsl:otherwise></xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:item">
        <xsl:choose>
            
            <xsl:when test="child::tei:bibl">
                <xsl:choose><xsl:when test="./attribute::xml:id='editors_craft' or ./attribute::xml:id='joint_presidential'"><span class="editors_craft"><span class="series_title"><xsl:apply-templates select="child::tei:title[@level='s']"/></span><li class="biblItem">
                    <xsl:apply-templates select="child::tei:bibl" />
                    
                </li></span></xsl:when><xsl:otherwise><li class="biblItem">
                    <xsl:apply-templates select="child::tei:bibl" />
                    
                </li></xsl:otherwise></xsl:choose>
                
            </xsl:when>
            <xsl:otherwise>
                <li class="menuItem">
                    <xsl:apply-templates />
                </li>
            </xsl:otherwise>
        </xsl:choose></xsl:template> 


    <xsl:template match="tei:bibl">
        <xsl:variable name="authorCount">
            <xsl:value-of select="count(./child::tei:author)" />
        </xsl:variable>
        <xsl:variable name="editorCount">
            <xsl:value-of select="count(./child::tei:editor)" />
        </xsl:variable>
        <xsl:for-each select="./child::tei:title">
            <span class="indextitle">
                <xsl:choose>
                    <xsl:when test="./attribute::level='s'"><span class="series_title"><xsl:apply-templates/></span></xsl:when>
                    <xsl:when test="./attribute::level='a'"><xsl:apply-templates /><xsl:if test="child::tei:ref">&#160;[<a><xsl:attribute name="href"><xsl:value-of select="$siteroot"/><xsl:value-of select="substring-after(ancestor::tei:div/attribute::xml:id,'_')"></xsl:value-of>/pdf/<xsl:value-of select="@xml:id"/>.pdf</xsl:attribute><!--<img src="{$siteroot}images/pdf.png"
                        alt="PDF icon"/>&#160;-->PDF</a>]</xsl:if></xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates />
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:for-each>
        <xsl:if test="$authorCount = 1">
            <span class="indexauthor">by <xsl:apply-templates select="./child::tei:author" /></span>
        </xsl:if>
        <xsl:if test="$authorCount = 2">
            <span class="indexauthor">by <xsl:apply-templates select="./child::tei:author[1]" /> and
                <xsl:apply-templates select="./child::tei:author[last()]" /></span>
        </xsl:if>
        <xsl:if test="$authorCount = 3">
            <span class="indexauthor">by <xsl:apply-templates select="./child::tei:author[1]" />,
                <xsl:for-each select="./child::tei:author[position()=2]"><xsl:apply-templates select="." />,&#160;</xsl:for-each>
                <xsl:for-each select="./child::tei:author[position()=3]">and <xsl:apply-templates select="." /></xsl:for-each></span>
        </xsl:if>
        <xsl:if test="$editorCount = 1">
            <span class="indexeditor">edited by <xsl:apply-templates select="./child::tei:editor"
                 /></span>
        </xsl:if>
        <xsl:if test="$editorCount = 2">
            <span class="indexeditor">edited by <xsl:apply-templates select="./child::tei:editor[1]" /> and
                <xsl:apply-templates select="./child::tei:editor[last()]" /></span>
        </xsl:if>
        <xsl:if test="$editorCount = 3"><xsl:choose>
            <xsl:when test="parent::tei:item"><span class="indexauthor">edited by <xsl:apply-templates select="./child::tei:editor[1]" />,
                <xsl:for-each select="./child::tei:editor[position()=2]"><xsl:apply-templates select="." />,&#160;</xsl:for-each>
                <xsl:for-each select="./child::tei:editor[position()=3]">and <xsl:apply-templates select="." /></xsl:for-each></span></xsl:when>
        </xsl:choose>
            
        </xsl:if>
        <!--<xsl:if test="$editorCount >= 3">
            <span class="indexeditor">edited by <xsl:value-of select="./child::tei:editor[1]" />,
                    <xsl:for-each select="./child::tei:editor[position()>1]">
                    <xsl:choose>
                        <xsl:when test="position()=last()">and <xsl:value-of select="."
                             /></xsl:when>
                        <xsl:otherwise><xsl:value-of select="." />, </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each></span>
        </xsl:if>-->
        <!--<xsl:apply-templates select="following-sibling::tei:list"/>-->
        </xsl:template> 
    <xsl:template match="//tei:address">
        <span class="address">
            <xsl:for-each select="child::tei:addrLine">
                <span class="addrLine">
                    <xsl:apply-templates />
                </span>
            </xsl:for-each>
        </span>
    </xsl:template>

<xsl:template match="//tei:author/child::tei:affiliation">(<xsl:apply-templates/>)</xsl:template>
    <xsl:template match="//tei:editor/child::tei:affiliation">(<xsl:apply-templates/>)</xsl:template>

<xsl:template match="//tei:div">
<span><xsl:attribute name="class"><xsl:choose>
    <xsl:when test="./attribute::xml:id/substring(.,5,8)='2013' or ./attribute::xml:id/substring(.,5,8)='2015'">current_issue</xsl:when><xsl:otherwise>issue</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates/></span></xsl:template>

</xsl:stylesheet>
