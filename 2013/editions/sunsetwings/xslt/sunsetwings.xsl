<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../legacy/template_xslt/base.xsl" />
    <xsl:param name="sunsetwings_version">undefined</xsl:param>
    <xsl:variable name="sunsetwings_version_plus_1"><xsl:value-of select="$sunsetwings_version"
         />1</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_2"><xsl:value-of select="$sunsetwings_version"
         />2</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_3"><xsl:value-of select="$sunsetwings_version"
         />3</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_4"><xsl:value-of select="$sunsetwings_version"
         />4</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_5"><xsl:value-of select="$sunsetwings_version"
         />5</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_6"><xsl:value-of select="$sunsetwings_version"
         />6</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_7"><xsl:value-of select="$sunsetwings_version"
         />7</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_8"><xsl:value-of select="$sunsetwings_version"
         />8</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_9"><xsl:value-of select="$sunsetwings_version"
         />9</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_0"><xsl:value-of select="$sunsetwings_version"
         />0</xsl:variable>
    <xsl:variable name="sunsetwings_version_plus_space">
        <xsl:value-of select="$sunsetwings_version" />
        <xsl:text> </xsl:text>
    </xsl:variable>
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav" />
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
                        <a href="{$siteroot}2013/editions/sunsetwings_v1.html">Edition</a>
                    </li>
                    <li id="editionNav2">
                        <!--<a href="{$siteroot}2013/editions/sunsetwings/vm_version/versions/sunsetwings.html">Compare Versions</a>-->
                        <a href="http://juxtacommons.org/shares/WHf02o" target="new">Compare Versions</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/map.sunsetwings.html" target="new">Map</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/intro.sunsetwings.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="http://juxtacommons.org/shares/WHf02o" target="new">Compare Versions</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/map.sunsetwings.html" target="new">Map</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2013/editions/sunsetwings.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2013, Volume 34</h5>
    </xsl:template>
    <!-- The witness name is needed for each edition which, like "Sunset Wings," uses an apparatus entry system to track variations among multiple witnesses -->
    <xsl:template name="witnessName">
        <span class="witnessName">
            <xsl:for-each select="//tei:listWit/tei:witness"><xsl:choose><xsl:when test="./attribute::xml:id=substring($sunsetwings_version,2)"><xsl:apply-templates/></xsl:when></xsl:choose></xsl:for-each>
        </span><xsl:call-template name="sunsetwingspageimage"/>
    </xsl:template>
    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main'">
                
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:app">
        <xsl:for-each select="child::tei:rdg">
            <xsl:variable name="witName">
                <xsl:value-of select="./attribute::wit" />
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="contains($witName, $sunsetwings_version)">
                    <xsl:choose>
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_space)">
                            <xsl:apply-templates />
                        </xsl:when>
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_1)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_2)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_3)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_4)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_5)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_6)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_7)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_8)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_9)" />
                        <xsl:when test="contains($witName, $sunsetwings_version_plus_0)" />
                        <xsl:otherwise>
                            <xsl:apply-templates />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
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
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                    <span class="noteRefIntro">[<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />]</span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef">
                        <!-- <a>
                    <xsl:attribute name="name"> <xsl:value-of select="@xml:id" /></xsl:attribute>
                </a>-->
                [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />]
            </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <div class="note"> <a> <xsl:attribute name="name"> <xsl:value-of select="@xml:id" />
            </xsl:attribute> </a> <xsl:value-of select="substring-after(attribute::xml:id,'note')"
             />.
            <xsl:apply-templates /><a> <xsl:attribute name="href">#nr<xsl:value-of
            select="substring-after(attribute::xml:id,'note')" /></xsl:attribute> <img>
            <xsl:attribute name="src">template_images/goback.png</xsl:attribute> <xsl:attribute name="alt"
            >Go
                        back</xsl:attribute> </img> </a> </div>
    </xsl:template>
    <!-- Special linebreaks for poetic lines -->
    <xsl:template match="//tei:l//tei:lb"><br />&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <!-- signatures and bylines -->
    <xsl:template match="//tei:signed"><span class="signed"><xsl:apply-templates/></span></xsl:template>


<!-- page images -->
    <xsl:template name="sunsetwingspageimage">
        <span class="sunsetwingspageimage">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sunsetwings/pages/viewsize/</xsl:text>
                        <xsl:value-of select="substring($sunsetwings_version,2)" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>sunsetwings/pages/thumbs/</xsl:text>
                            <xsl:value-of select="substring($sunsetwings_version,2)" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sunsetwings/pages/viewsize/</xsl:text>
                        <xsl:value-of select="substring($sunsetwings_version,2)" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Page</xsl:text>
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sunsetwings/pages/fullsize/</xsl:text>
                        <xsl:value-of select="substring($sunsetwings_version,2)" />
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

</xsl:stylesheet>
