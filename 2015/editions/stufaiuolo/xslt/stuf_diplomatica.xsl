<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:import href="stuf_common.xsl"/>


    
    
    
    <xsl:template match="tei:dim">
        <xsl:apply-templates/><xsl:value-of select="@unit"/>
    </xsl:template>
    <xsl:template match="tei:watermark"><xsl:text>; watermark: </xsl:text><xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:locus">
        <xsl:choose>
            <xsl:when test="parent::tei:material">
                <xsl:text> (</xsl:text><xsl:apply-templates/><xsl:text>) </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:speaker">
    <span class="speaker"><xsl:apply-templates/></span>
</xsl:template>
    
  <!--<xsl:template match="sp/p">
      <p><xsl:apply-templates/></p>
  </xsl:template>-->
    
    <xsl:template match="tei:sp">
        <div class="sp">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:epigraph/tei:stage">
<center><xsl:apply-templates/></center>
</xsl:template>
    
    <xsl:template match="tei:unclear">
<xsl:apply-templates/> [?]
</xsl:template>

    <xsl:template match="tei:g">
    <xsl:choose>
        <xsl:when test="@ref='#qm'">
            <!--<xsl:text>./</xsl:text>-->
            <xsl:text>.~</xsl:text>
        </xsl:when>
        <xsl:when test="@ref='#par'">
            <xsl:text>:~</xsl:text>
        </xsl:when>
    </xsl:choose>
</xsl:template>

<!-- Original template from Elena-->

<!--<xsl:template match="pb">
    <a target="_blank">
        <xsl:attribute name="href">../../../img/<xsl:value-of select="@facs"/>.jpg</xsl:attribute>
        <img src="../../../img/img.gif" width="30" height="43" border="0" ></img>
    </a><br/>
<hr/>[p. <xsl:apply-templates select="@n" />]
</xsl:template>-->

    <!-- pagebreaks -->
    <xsl:template match="tei:pb">
        <xsl:choose><xsl:when test="./attribute::facs"><span><xsl:attribute name="class">pagebreak</xsl:attribute>
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>stufaiuolo/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>stufaiuolo/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs"/>
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>stufaiuolo/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    [f. <xsl:apply-templates select="@n" />]
                </a>
            </span>
            <br/>
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>stufaiuolo/pages/fullsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
        </span></xsl:when><xsl:otherwise><span class="pagebreak">[p. <xsl:apply-templates select="@n" />]</span></xsl:otherwise></xsl:choose>
    </xsl:template>

    <xsl:template match="tei:pc">
    <xsl:if test="contains(@resp,'#doni')">
        <xsl:apply-templates/>
    </xsl:if>
</xsl:template>

    <xsl:template match="tei:ex">[<xsl:apply-templates />]</xsl:template>

    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="tei:sic">
                <xsl:apply-templates select="tei:sic"/> [sic]
            </xsl:when>
            <xsl:when test="tei:orig">
                <xsl:apply-templates select="tei:orig"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    


    <xsl:template match="tei:lb[not(@rend)]">
        <br/><xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:hi[@rend='apice']">
<sup><xsl:apply-templates /></sup>
</xsl:template>


    

<xsl:template match="tei:lb">
    <xsl:choose>
        <xsl:when test="@rend='h1'">
            –<br />
        </xsl:when>
        <xsl:when test="@rend='h2'">
            =<br />
        </xsl:when>
        <xsl:when test="@rend='h3'"> 
            –<br />
        </xsl:when>
        <xsl:when test="@rend='h4'">
            =<br />
        </xsl:when>
        <xsl:otherwise><br/></xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template match="tei:div[@type='scena']/tei:head">
    
    <font size='4' > <i><xsl:apply-templates /><xsl:if test="@rend='par'">:~</xsl:if></i></font>
</xsl:template>

    <xsl:template match="tei:stage[@rend='underlined']">
<u><xsl:apply-templates /></u>
</xsl:template>

    <xsl:template match="tei:del">
<s><xsl:apply-templates />
  </s>
  </xsl:template>
 
 
 <xsl:template match="tei:add[not(@*)]">
  [<xsl:apply-templates />]
 </xsl:template>
 
 <xsl:template match="tei:add[@resp='ed']"></xsl:template>
 
 <xsl:template match="tei:add[@place='interlinear']">
  <sup><xsl:apply-templates />
  </sup>
 </xsl:template>

<xsl:template match="tei:castItem">
<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="tei:role">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="tei:stage">
<span class="stage"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="tei:set/tei:p">
<center><xsl:apply-templates /></center>
</xsl:template>
    
    <xsl:template match="tei:emph">
        <i><xsl:apply-templates/></i>
    </xsl:template>

    <xsl:template match="tei:trailer">
        <p align="center">
            
            <i>
                <xsl:apply-templates/>
            </i>
            
        </p>
    </xsl:template>
</xsl:stylesheet>
