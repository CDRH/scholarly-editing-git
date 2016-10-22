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
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'essay.fierst')">
                <xsl:choose>
                    <xsl:when test="starts-with($idno,'essay.fierst_table')">
                        <ul>
                            <li id="essayNav1">
                                <a href="{$siteroot}2012/essays/essay.fierst.html">Back to Essay</a>
                            </li>
                            
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul>
                            <li id="essayNav1">
                                <a href="{$siteroot}2012/essays/essay.fierst_table.html"
                                        >Table: Published Editions of John Tanner's <hi
                                        rend="italic">Narrative</hi></a>
                            </li>
                            <li id="essayNav2"><a><xsl:attribute name="href">../pdf/<xsl:value-of select="$idno"/>.pdf</xsl:attribute><img src="{$siteroot}images/pdf.png"
                                alt="PDF icon"/>&#160;PDF</a></li>
                        </ul>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
<xsl:otherwise><ul>
    <li id="essayNav1"><a><xsl:attribute name="href">../pdf/<xsl:value-of select="$idno"/>.pdf</xsl:attribute><img src="{$siteroot}images/pdf.png"
                        alt="PDF icon"/>&#160;PDF</a></li>
</ul></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$idno='essay.v33intro' or $idno='essay.fierst' or $idno='essay.commonpot' or $idno='essay.broude' or $idno='essay.2012presidentialaddress'"><h5>2012, Volume 33</h5></xsl:when>
            <xsl:when test="$idno='essay.porter' or $idno='essay.calvert' or $idno='essay.2013presidentialaddress' or $idno='essay.v34intro'"><h5>2013, Volume 34</h5></xsl:when>
            <xsl:when test="$idno='essay.pierazzo' or $idno='essay.2014presidentialaddress' or $idno='essay.v35intro'"><h5>2014, Volume 35</h5></xsl:when>
            <xsl:when test="$idno='essay.gagel' or $idno='essay.v36intro' or $idno='essay.gordon' or $idno='essay.2015presidentialaddress'"><h5>2015, Volume 36</h5></xsl:when>
            <xsl:when test="$idno='essay.grayprice' or $idno='essay.v37intro' or $idno='essay.mcgann' or $idno='essay.lupton' or $idno='essay.alpertabrams' or $idno='essay.davies' or $idno='essay.schulze'"><h5>2016, Volume 37</h5></xsl:when>
            <xsl:otherwise><h5>NEED YEAR AND VOL NUMBER</h5></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main'">
                <xsl:choose>
                    <xsl:when test="parent::tei:div">
                        <h3>
                            <xsl:apply-templates />
                        </h3>
                    </xsl:when>
                    <xsl:otherwise>
                        <h1>
                            <xsl:apply-templates />
                        </h1>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="./attribute::type='sub'">
                <xsl:choose>
                    <xsl:when test="parent::tei:div">
                        <h4>
                            <xsl:apply-templates />
                        </h4>
                    </xsl:when>
                    <xsl:otherwise>
                        <h2>
                            <xsl:apply-templates />
                        </h2>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:div[@type='exhibits']">
        <div class="exhibitsList">
            <h2>Exhibits</h2>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="//tei:div[@type='exhibit']">
        <div class="exhibit">
        <a>
        <xsl:attribute name="name">
        <xsl:value-of select="@xml:id" />
        </xsl:attribute>
        </a>            <xsl:apply-templates/>
        </div>
    </xsl:template>
<xsl:template match="//tei:div[@type='section']">
<div class="section"><xsl:apply-templates/></div>
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
    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <xsl:choose>
                    <xsl:when test="starts-with($idno,'reviews.recenteditions')">
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
    <xsl:template match="//tei:del">
        <span>
            <xsl:attribute name="class">del_<xsl:value-of select="@type" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:add">
                <xsl:if test="@rend='caret'">
                    <span class="insertionMark">^</span>
                </xsl:if>
                <span>
                    <xsl:attribute name="class">add_<xsl:value-of select="@place"/></xsl:attribute>
                    <xsl:apply-templates/>
                </span>
        <xsl:if test="@rend='caret'">
            <span class="insertionMark">^</span>
        </xsl:if> 
    </xsl:template>

</xsl:stylesheet>
