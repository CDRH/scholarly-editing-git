<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" />
    
    <xsl:template match="/">
        <linkGrp>
        <xsl:for-each select="//link">
            
            <xsl:choose>
                <xsl:when test="@type='1-1'">
                    <link>
                        <from><xsl:value-of select="substring-before(@xtargets,';')"></xsl:value-of></from>
                        <to><xsl:value-of select="substring-after(@xtargets,';')"></xsl:value-of></to>
                    </link>
                </xsl:when>
                <xsl:when test="starts-with(@type,'0')">
                    <xsl:for-each select="tokenize(substring-after(@xtargets,';'),' ')">
                        <link>
                            <from>NULL</from>
                            <to><xsl:value-of select="."/></to>
                        </link>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="starts-with(@type,'1')">
                <xsl:for-each select="tokenize(substring-after(@xtargets,';'),' ')">
                    <!-- begin research here: http://stackoverflow.com/questions/21603814/xslt-2-0-how-to-tokenize-values-of-multiple-elements-and-correlate-them-together -->
                    <link>
                        <from><xsl:value-of select="@n"/>zzz</from>
                        <to><xsl:value-of select="."/></to>
                    </link>
                </xsl:for-each>
                </xsl:when>
                <!--<xsl:when test="starts-with(@type,'2')">
                    <xsl:for-each select="tokenize(substring-before(@xtargets,';'),' ')">
                        <link>
                            <from><xsl:value-of select="."/></from>
                            <to></to>
                        </link>
                    </xsl:for-each>
                </xsl:when>-->
                <xsl:otherwise>
                    aaa
                </xsl:otherwise>
            </xsl:choose>
            
           
                
                <!--<xsl:for-each select="tokenize(@xtargets, ';')"><from><xsl:value-of select="."></xsl:value-of></from></xsl:for-each>-->
            
        </xsl:for-each>
        </linkGrp>
        
    </xsl:template>
</xsl:stylesheet>