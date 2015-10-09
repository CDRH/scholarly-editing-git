<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0"
    exclude-result-prefixes="xsl tei xs">
    
    <xsl:output method="xhtml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        
        <xsl:apply-templates select="//head"></xsl:apply-templates>
        
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:variable name="position" select="position()"/>
        <a><xsl:value-of select="."></xsl:value-of></a>
        <b><xsl:value-of select="document('de-oratione-dominica-trans.xml')//head[position()=$position]"></xsl:value-of></b>
        <c><xsl:value-of select="$position"/></c>
    </xsl:template>
    
</xsl:stylesheet>