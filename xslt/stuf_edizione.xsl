<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:import href="stuf_common.xsl"/>
  

  
  <xsl:template match="tei:epigraph/tei:stage">
    <center><xsl:apply-templates/></center>
  </xsl:template>
  
  <xsl:template match="tei:speaker">
    <span class="speaker"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  <xsl:template match="tei:ex"><xsl:apply-templates/></xsl:template>
  
  
  <xsl:template match="tei:choice">
    <xsl:choose>
      <xsl:when test="tei:sic">
          <xsl:apply-templates select="tei:corr"/>
      </xsl:when>
      <xsl:when test="tei:orig">
          <xsl:apply-templates select="tei:reg"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:sic">
    <xsl:if test="not(parent::tei:choice)">
      <xsl:apply-templates/> [sic!]
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template match="tei:lb">
    <xsl:if test="@rend='par' ">.</xsl:if>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='apice']">
    <sup><xsl:apply-templates /></sup>
  </xsl:template>
  
  
  <xsl:template match="tei:head[@rend='par']">
    <font size='4'><i><xsl:apply-templates />.</i></font>
  </xsl:template>
  
  <xsl:template match="tei:del"/>
   
  
  
  
  <xsl:template match="tei:add[not(@resp)]">
    <xsl:apply-templates />
  </xsl:template>    

  <!--<xsl:template match="tei:pb">[<xsl:value-of select="@n"/>]</xsl:template>-->
    <!--<a target="_blank">
      <xsl:attribute name="href">img/<xsl:value-of select="@facs"/>.jpg</xsl:attribute>
      <img src="../../img/img.gif" width="30" height="43" border="0" ></img>
    </a>-->
      
  
  <xsl:template match="tei:castItem">
    <p><xsl:apply-templates /></p>
  </xsl:template>
  <xsl:template match="tei:role">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="tei:stage">
    <span class="stage"><i><xsl:apply-templates /></i></span>
  </xsl:template>
  
  <xsl:template match="tei:set/tei:p">
    <p align="center"><xsl:apply-templates /></p>
  </xsl:template>
  
  <xsl:template match="tei:pc">
    <xsl:choose>
      <xsl:when test="contains(@resp, '#ep')">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
    </xsl:template>
  <xsl:template match="tei:q">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>"</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:supplied">[<xsl:apply-templates/>]</xsl:template>
  <xsl:template match="tei:fw"/>
  <xsl:template match="tei:title">
    <i><xsl:apply-templates/></i>
  </xsl:template>
  
  <xsl:template match="tei:trailer">
    <p style="text-transform:uppercase; text-align: center">
      
      <i>
        <xsl:apply-templates/>
      </i>
      
    </p>
  </xsl:template>

  
  <xsl:template match="tei:g[@ref='#par']">
    <xsl:text>.</xsl:text>
  </xsl:template>
 
    <xsl:template match="//tei:front/tei:div/tei:p[1]"><span class="dedication"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="//tei:front/tei:div/tei:p[2]"><span class="dedication"><xsl:apply-templates/></span></xsl:template>

  
</xsl:stylesheet>
  

