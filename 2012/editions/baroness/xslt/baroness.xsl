<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../template_xslt/base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2012/editions/baroness/main.baroness.html">Main Page</a>
                    </li><li id="editionNav2">
                        <a href="{$siteroot}2012/editions/baroness/intro.baroness.html">Introduction</a>
                    </li><li id="editionNav3">
                        <a href="{$siteroot}2012/editions/baroness/help.baroness.html">Help</a>
                    </li><li id="editionNav4">
                        <a href="{$siteroot}2012/editions/baroness/about.baroness.html">About</a>
                    </li>
                    <li id="editionNav5">
                        <a href="{$siteroot}2012/editions/baroness/versions/firstling.html">Edition (HTML)</a>
                    </li>
                    <li id="editionNav6">
                        <a href="{$siteroot}2012/editions/baroness/versions/firstling.xml">Edition (XML)</a>
                    </li>
                </ul>
           
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2012, Volume 33</h5>
    </xsl:template>
    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            
            <xsl:when test="./attribute::type='main'">
<xsl:choose>
    <xsl:when test="parent::tei:div | parent::tei:list"><h2><xsl:apply-templates/></h2></xsl:when>
    <xsl:when test="parent::tei:body"><h2><xsl:apply-templates/></h2></xsl:when>
<xsl:when test="parent::tei:front"><h1>
                    <xsl:apply-templates />
                </h1></xsl:when>
    <xsl:otherwise><h1>
        <xsl:apply-templates />
    </h1></xsl:otherwise>
</xsl:choose>
                
            </xsl:when>
            
            <xsl:when test="./attribute::type='sub'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Notes and pointers -->
    <xsl:template match="//tei:div[@type='notes']">
        <div class="notesList">
            <h2>Notes</h2>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="//tei:ptr">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="attribute::target" />
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="attribute::xml:id" />
            </xsl:attribute>
            <xsl:choose><xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]"><span class="noteRefIntro">
                <!-- <a>
                    <xsl:attribute name="name"> <xsl:value-of select="@xml:id" /></xsl:attribute>
                    </a>-->
                [<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span></xsl:when><xsl:otherwise><span class="noteRef">
                <!-- <a>
                    <xsl:attribute name="name"> <xsl:value-of select="@xml:id" /></xsl:attribute>
                </a>-->
                [<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span></xsl:otherwise></xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
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
                    <xsl:attribute name="src">../images/goback.png</xsl:attribute>
                    <xsl:attribute name="alt">Go
                        back</xsl:attribute>
                </img>
            </a>
        </div>
    </xsl:template>
   
    <!-- deletions and additions in the manuscript (I did not do anything with the <subst> stuff at this
point because I thought the styling could be accomplished for this file through this relatively
simple approach -->
    <xsl:template match="//tei:del">
        <span>
            <xsl:attribute name="class">del_<xsl:value-of select="@type" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:add">
        <xsl:if test="@type='insertion'">
            <span class="insertionMark">^</span>
        </xsl:if>
        <span>
            <xsl:attribute name="class">add_<xsl:value-of select="@place" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <xsl:choose>
            <xsl:when test="@reason='deletion, illegible'">[illeg.]</xsl:when>
        </xsl:choose>
    </xsl:template>
   

    <!-- simple lists -->
    <xsl:template match="//tei:list">
        
        <xsl:choose>
            <xsl:when test="@type='simple'">
                 <ul><xsl:if test="parent::tei:div[@xml:id='bibl']"><xsl:attribute name="class">workscited</xsl:attribute></xsl:if>
                            <xsl:apply-templates />
                        </ul>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:apply-templates />
                </ol>
            </xsl:when>
            <xsl:when test="@type='bulleted'">
                <ol class="bulleted">
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
    <xsl:template match="//tei:item">
        <li>
            <xsl:apply-templates />
        </li>
    </xsl:template>


    <xsl:template match="//tei:signed">
        <div class="signature">
            <xsl:for-each select="child::tei:name"><span class="name"><xsl:apply-templates></xsl:apply-templates></span></xsl:for-each>
            <xsl:for-each select="child::tei:affiliation"><span class="affiliation"><xsl:apply-templates></xsl:apply-templates></span></xsl:for-each>
        </div></xsl:template>


</xsl:stylesheet>
