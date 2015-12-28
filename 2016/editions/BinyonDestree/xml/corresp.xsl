<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" exclude-result-prefixes="#all"/>
    
    <xsl:template match="@* | node()"  exclude-result-prefixes="#all">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="s[@xml:id='o26']" exclude-result-prefixes="#all">
        <s xml:id="o26" n="26" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o27']" exclude-result-prefixes="#all">
        <s xml:id="o27" n="27" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o28']" exclude-result-prefixes="#all">
        <s xml:id="o28" n="28" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o29']" exclude-result-prefixes="#all">
        <s xml:id="o29" n="29" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o30']" exclude-result-prefixes="#all">
        <s xml:id="o30" n="30" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o31']" exclude-result-prefixes="#all">
        <s xml:id="o31" n="31" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o32']" exclude-result-prefixes="#all">
        <s xml:id="o32" n="32" corresp="zzz">
            <xsl:apply-templates/>
        </s>
    </xsl:template>
    <xsl:template match="s[@xml:id='o33']" exclude-result-prefixes="#all">
        <s xml:id="o33" n="33" corresp="zzz">
            <xsl:apply-templates exclude-result-prefixes="#all"/>
        </s>
    </xsl:template>
    
    
    
</xsl:stylesheet>