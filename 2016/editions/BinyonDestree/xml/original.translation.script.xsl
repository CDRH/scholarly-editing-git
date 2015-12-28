<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- steps for transforming document:
    1: Use this XSL on BinyonDestree.original.translation.xml, changing code as needed for original or translation
    
    2: Copy resulting template rules into corresp_t_to_o.xsl or corresp_o_to_t.xsl and run that on BinyonDestree.original.xml or BinyonDestree.translation.xml
    
    3: final clean up: search and replace to remove xmlns="" and extra tei namespaces. (need to figure out how to make this step unnecessary)
    -->
    
    
    <!-- need to change substrings before and after below when you change this. Sorry for the laziness. -->
    <xsl:variable name="doctype">t</xsl:variable>
    <xsl:variable name="doctype-other">
        <xsl:choose>
            <xsl:when test="$doctype = 'o'">t</xsl:when>
            <xsl:otherwise>o</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:output indent="yes" />
    
    <xsl:template name="z">
        <xsl:param name="y"/>
        
        <!-- if doctype = o substring-after
             if doctype = t substring-before -->
            <xsl:for-each select="tokenize(substring-before($y,';'),' ')">

                <xsl:element name="xsl:template">
                    <xsl:attribute name="match">
                        <xsl:text>s[@xml:id='</xsl:text>
                        <xsl:value-of select="$doctype"/>
                        <xsl:value-of select="."/>
                        <xsl:text>']</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="exclude-result-prefixes">#all</xsl:attribute>
                    
                    
                    <s>
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="$doctype"/><xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:attribute name="n">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:attribute name="corresp">
                            <!-- if doctype = o substring-before
                                 if doctype = t substring after-->
                            <xsl:for-each select="tokenize(substring-after($y,';'),' ')">
                            <xsl:value-of select="$doctype-other"/><xsl:value-of select="."/>
                                <xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
                            </xsl:for-each>
                        </xsl:attribute>
                        <xsl:element name="xsl:apply-templates"/>
                    </s>
                    
                </xsl:element>
                
            </xsl:for-each>
        
    </xsl:template>
    
    
    
    <xsl:template match="/">
        
        <xsl:element name="xsl:stylesheet">

            <xsl:for-each select="//link">
                
                <xsl:if test="not(starts-with(@type,'0'))">
                    <xsl:call-template name="z">
                        <xsl:with-param name="y"><xsl:value-of select="@xtargets"/></xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
        
            </xsl:for-each>

        </xsl:element>
        
    </xsl:template>
</xsl:stylesheet>