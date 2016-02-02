<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:param name="page_type"/>
    
    <xsl:param name="fig_location">
        <xsl:text>BinyonDestree/figures/</xsl:text>
    </xsl:param>
    
    <xsl:include href="base.xsl"/>
    <xsl:include href="BinyonDestree_shared.xsl"/>
    
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    
    
    
    
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/BinyonDestree.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/BinyonDestree.index.html">Index of Letters</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/BinyonDestree.original.html">Original</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/BinyonDestree.translation.html">Translation</a>
                    </li>
                    <li id="editionNav5">
                        <a href="{$siteroot}2016/editions/BinyonDestree.sidebyside.html">Side by Side</a>
                    </li>
                    <li id="editionNav4">
                        <a href="BinyonDestree/xml/BinyonDestree.zip">Download XML</a>
                    </li>
                </ul>
           
    </xsl:template>
    
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>
    
    <!-- To have a special div for distinctive body styling -->
    <xsl:template match="//tei:text">
        <div class="binyondestree_edition">
            <div class="frontmatter">
        <h1>
            <xsl:choose>
                <xsl:when test="$page_type='introduction'">Introduction</xsl:when>
                <xsl:when test="$page_type='index'">Index of Letters</xsl:when>
                <xsl:when test="$page_type='original'">Original</xsl:when>
                <xsl:when test="$page_type='translation'">Translation</xsl:when>
            </xsl:choose>
        </h1>
            </div>
        
        
        <xsl:choose>
            <xsl:when test="$page_type = 'index'">
                <xsl:call-template name="index_creator"/>
            </xsl:when>
            <xsl:otherwise>
                <div class="BinyonDestree">
                    <xsl:apply-templates />
                </div>
            </xsl:otherwise>
        </xsl:choose>
        
        </div>
        
    </xsl:template>
   
   <xsl:template name="index_creator">
       <dl>
       <xsl:for-each select="//tei:div[@type='letter']">
           <dt><strong><xsl:value-of select="tei:head"/></strong></dt>
           <dd><xsl:text>View: </xsl:text>
               <a>
                   <xsl:attribute name="href">
                       <xsl:text>BinyonDestree.original.html#</xsl:text>
                       <xsl:text>letter_BinyonDestreeoriginal_</xsl:text>
                       <xsl:value-of select="@n"/>
                   </xsl:attribute>
                   <xsl:text>Original</xsl:text>
               </a>
               
               <xsl:if test="@xml:lang='fr'">
                   <xsl:text> | </xsl:text>
                   
                   <a>
                       <xsl:attribute name="href">
                           <xsl:text>BinyonDestree.translation.html#</xsl:text>
                           <xsl:text>letter_BinyonDestreetranslationl_</xsl:text>
                           <xsl:value-of select="@n"/>
                       </xsl:attribute>
                       <xsl:text>Translation</xsl:text>
                   </a>
               </xsl:if>
               
               
               <xsl:text> | </xsl:text>
               
               <a>
                   <xsl:attribute name="href">
                       <xsl:text>BinyonDestree.sidebyside.html#</xsl:text>
                       <xsl:text>letter_BinyonDestreeoriginal_</xsl:text>
                       <xsl:value-of select="@n"/>
                   </xsl:attribute>
                   <xsl:text>Side By Side</xsl:text>
               </a>
               
               </dd>
       </xsl:for-each>
       </dl>
   </xsl:template>
    
    

</xsl:stylesheet>
