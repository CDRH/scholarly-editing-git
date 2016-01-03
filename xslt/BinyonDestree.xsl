<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
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
                        <a href="{$siteroot}2016/editions/BinyonDestree.original.html">Original</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/BinyonDestree.translation.html">Translation</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/BinyonDestree.sidebyside.html">Side by Side</a>
                    </li>
                </ul>
           
    </xsl:template>
    
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>
    
    <!-- To have a special div for distinctive body styling -->
    <xsl:template match="//tei:text">
        
        <div class="BinyonDestree">
            <xsl:apply-templates />
        </div>
        
    </xsl:template>
   
   

</xsl:stylesheet>
