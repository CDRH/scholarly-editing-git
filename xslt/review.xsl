<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="editionNav" />
    <xsl:template name="witnessName"> </xsl:template>
    <xsl:template name="essayNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable><ul>
        <li id="essayNav1"><a><xsl:attribute name="href">../pdf/<xsl:value-of select="$idno"/>.pdf</xsl:attribute><img src="{$siteroot}images/pdf.png"
            alt="PDF icon"/>&#160;PDF</a></li>
    </ul></xsl:template>
        
        
    
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$idno='review.crocker' or $idno='review.quaker' or $idno='review.recenteditions2012'"><h5>2012, Volume 33</h5></xsl:when>
            <xsl:when test="$idno='review.emerson' or $idno='review.thurman' or $idno='review.recenteditions2013'"><h5>2013, Volume 34</h5></xsl:when>
            <xsl:when test="$idno='review.pinckney' or $idno='review.burton-rose' or $idno='review.recenteditions2014'"><h5>2014, Volume 35</h5></xsl:when>
            <xsl:when test="$idno='review.roosevelt' or $idno='review.twain' or $idno='review.beverley' or $idno='review.recenteditions2015'"><h5>2015, Volume 36</h5></xsl:when>
            <xsl:when test="$idno='review.ovid'or $idno='review.recenteditions2016' or $idno='review.sherrer'"><h5>2016, Volume 37</h5></xsl:when>
            <xsl:otherwise>NEED YEAR AND VOL NUMBER</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main'">
                <xsl:choose>
                    <xsl:when test="parent::tei:front"><h1><xsl:apply-templates/></h1></xsl:when>
               
                <xsl:otherwise><h3>
                            <xsl:apply-templates />
                        </h3></xsl:otherwise>
                  </xsl:choose>   
            </xsl:when>
            <xsl:when test="./attribute::type='sub'">
               
                        <h4>
                            <xsl:apply-templates />
                        </h4>
                    
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <xsl:choose>
                    <xsl:when test="starts-with($idno,'review.recenteditions')">
                        <ul class="recenteditions">
                            <xsl:apply-templates />
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul>
                            <xsl:apply-templates />
                        </ul>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:apply-templates />
                </ol>
            </xsl:when>
            <xsl:when test="@type='bulleted'">
                <ol class="bulleted">
                    <xsl:apply-templates />
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates />
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:item">
        <li>
            <xsl:apply-templates />
        </li>
    </xsl:template>
    <xsl:template match="//tei:item/child::tei:label">
        <span class="list-label">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:epigraph">
        <xsl:for-each select="descendant::tei:quote">
            <blockquote class="epigraph">
                <xsl:apply-templates />
            </blockquote>
        </xsl:for-each>
        <xsl:for-each select="descendant::tei:bibl">
            <span class="epigraph_bibl">
                <xsl:apply-templates />
            </span>
        </xsl:for-each>
    </xsl:template>

<xsl:template match="//tei:signed">
<xsl:variable name="signatureCount"><xsl:value-of select="count(child::tei:name)"/></xsl:variable>
<div class="signature">
<xsl:choose><xsl:when test="$signatureCount>1">
    <xsl:for-each select="child::tei:name[1]"><span class="name"><xsl:apply-templates/></span></xsl:for-each>
    <xsl:for-each select="child::tei:affiliation[1]"><span class="affiliation"><xsl:apply-templates/></span></xsl:for-each>
<span class="secondSignature">
    <xsl:for-each select="child::tei:name[2]"><span class="name"><xsl:apply-templates/></span></xsl:for-each>
    <xsl:for-each select="child::tei:affiliation[2]"><span class="affiliation"><xsl:apply-templates/></span></xsl:for-each>
</span>
</xsl:when><xsl:otherwise><xsl:for-each select="child::tei:name"><span class="name"><xsl:apply-templates/></span></xsl:for-each>
    <xsl:for-each select="child::tei:affiliation"><span class="affiliation"><xsl:apply-templates/></span></xsl:for-each></xsl:otherwise></xsl:choose>

</div></xsl:template>

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
                    <span class="noteRefIntro"
                        >
                        
                        [<xsl:value-of
                            select="substring-after(attribute::target,'#note')" />] </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef">
                        <xsl:choose>
                            <xsl:when test="./attribute::target='#note_pre'">&#42;</xsl:when>
                            <xsl:otherwise>[<xsl:value-of
                                select="substring-after(attribute::target,'#note')"
                            />] </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="@resp='editor'">
                <span class="inTextEditorialNote">[<xsl:apply-templates />]</span>
            </xsl:when>
            <xsl:otherwise>
                <div class="note">
                    <a>
                        <xsl:attribute name="name">
                            <xsl:value-of select="@xml:id" />
                        </xsl:attribute>
                    </a>
                    <xsl:choose>
                        <xsl:when test="./attribute::xml:id='note_pre'" />
                        <xsl:otherwise><xsl:value-of
                            select="substring-after(attribute::xml:id,'note')"
                        />.&#160;</xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates />
                    <a>
                        <xsl:attribute name="href">#nr<xsl:value-of
                            select="substring-after(attribute::xml:id,'note')"
                        /></xsl:attribute>
                        <img>
                            <xsl:attribute name="src">images/goback.png</xsl:attribute>
                            <xsl:attribute name="alt">Go back</xsl:attribute>
                        </img>
                    </a>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
