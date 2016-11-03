<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teiE="http://www.tei-c.org/ns/Examples">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../legacy/template_xslt/base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav" />
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/hejinian.edition.html">Edition</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/hejinian.missing.html"
                            >"What's Missing from <i>My Life</i>" by Lyn Hejinian</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/intro.hejinian.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/hejinian.edition.html">Edition</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2015/editions/hejinian.missing.html"
                            >"What's Missing from <i>My Life</i>" by Lyn Hejinian</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>

    <!-- To have a special div for distinctive body styling -->
    <xsl:template match="//tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']" />
        </xsl:variable>
        <div class="hejinian">
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <h1>
            <xsl:apply-templates />
        </h1>
    </xsl:template>


    <!-- Notes and pointers -->
    <xsl:template match="//tei:div[@type='notes']">
        <div class="notesList">
            <h2>Notes</h2>
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="//tei:div[@type='section']">
        <div class="section">
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
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                    <span class="noteRefIntro"> [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />] </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef"> [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />] </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="@type='editorial'">
                <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:note[@type='editorial']" level="any" />
                </xsl:variable>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>#note</xsl:text>
                        <xsl:value-of select="$noteNumber" />
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:text>ref</xsl:text>
                        <xsl:value-of select="$noteNumber" />
                    </xsl:attribute>
                    <span class="noteRef">[<xsl:value-of select="$noteNumber" />]</span>
                </a>
            </xsl:when>
            <xsl:when test="@type='headnote'">
                <span class="headnote">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            
            
            <xsl:otherwise>
                <div class="note"> <a> <xsl:attribute name="name"> <xsl:value-of select="@xml:id" />
                    </xsl:attribute> </a> <xsl:value-of
                    select="substring-after(attribute::xml:id,'note')"
                     />. <xsl:apply-templates /><a> <xsl:attribute name="href">#nr<xsl:value-of
                    select="substring-after(attribute::xml:id,'note')" /></xsl:attribute> <img>
                    <xsl:attribute name="src">template_images/goback.png</xsl:attribute> <xsl:attribute
                    name="alt">Go back</xsl:attribute> </img> </a> </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:apply-templates/>
                </ol>
            </xsl:when><xsl:when test="@type='bulleted'">
                <ol class="bulleted">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


    
</xsl:stylesheet>
