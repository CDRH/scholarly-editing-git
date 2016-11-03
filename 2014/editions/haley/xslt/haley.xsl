<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../legacy/template_xslt/base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/haley.malcolmxfull.html">"The Malcolm X. I Knew"</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/haley.handnotes.html">Handwritten Notes</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/haley.typednotes.html">Typewritten Notes</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/intro.haley.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/haley.malcolmxfull.html">"The Malcolm X. I Knew"</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/haley.handnotes.html">Handwritten Notes</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2014/editions/haley.typednotes.html">Typewritten Notes</a>
                    </li>
                    <li id="editionNav5">
                        <a href="{$siteroot}2014/editions/haley/haleyxml.zip">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2014, Volume 35</h5>
    </xsl:template>

    <!-- to get a special div for styling -->
    <xsl:template match="//tei:body">
        <xsl:variable name="fileID"><xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileID='haley.malcolmxfull'">
                <div class="malcolmxfull">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- pagebreaks -->
    <xsl:template match="//tei:pb">
        <span class="pagebreak">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>haley/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>haley/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>haley/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Page </xsl:text>
                    <xsl:value-of select="@n" />
                    <xsl:text></xsl:text>
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>haley/pages/fullsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
        </span>
    </xsl:template>
    
    <!-- makes the <orig> or <sic> show up in a <choice> (rather than the regularized forms) -->
    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="child::tei:orig">
                <xsl:for-each select="child::tei:orig">
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="child::tei:sic">
                <xsl:for-each select="child::tei:sic">
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
<!-- providing a span for the individual Haley notes -->

    <xsl:template match="//tei:div[@type='note']">
        <xsl:variable name="fileid">
            <xsl:value-of select="./ancestor::tei:TEI/descendant::tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileid='haley.typednotes' or 'haley.handnotes'"><div class="haleynote"><span class="haleynote"><span class="haleynoteID">[Note #<xsl:value-of select="@n"/>]</span><xsl:apply-templates/></span><span class="haleynoteimage"><span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>haley/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>haley/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
                <span class="viewsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>haley/pages/viewsize/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute>
                        <xsl:text>View note</xsl:text>
                    </a>
                </span>
                <br />
                <span class="fullsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>haley/pages/fullsize/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:text>_blank</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Full size in new window</xsl:text>
                    </a>
                </span></span></div></xsl:when>
            <!--<xsl:when test="$fileid='haley.handnotes'"><div class="haleynote"><xsl:apply-templates/></div></xsl:when>-->
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- end Notes and pointers -->
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
            <xsl:choose><xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]"><span class="noteRefIntro">[<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]</span></xsl:when><xsl:otherwise><span class="noteRef">[<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]</span></xsl:otherwise></xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose><xsl:when test="@type='headnote'"><span class="headnote"><xsl:apply-templates/></span></xsl:when><xsl:otherwise><div class="note">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id" />
                </xsl:attribute>
            </a>
            <xsl:value-of select="substring-after(attribute::xml:id,'note')" />.
            <xsl:apply-templates /><a>
                <xsl:attribute name="href">#nr<xsl:value-of
                    select="substring-after(attribute::xml:id,'note')" /></xsl:attribute>
                <img>
                    <xsl:attribute name="src">template_images/goback.png</xsl:attribute>
                    <xsl:attribute name="alt">Go
                        back</xsl:attribute>
                </img>
            </a>
        </div></xsl:otherwise></xsl:choose>
    </xsl:template>
 
    <!-- deletions and additions in the manuscript (I did not do anything with the <subst> stuff at this
point because I thought the styling could be accomplished for this file through this relatively
simple approach -->
    <xsl:template match="//tei:del">
    <xsl:choose><xsl:when test="parent::tei:subst"><span class="del_subst"><xsl:apply-templates/></span></xsl:when><xsl:otherwise><span>
            <xsl:attribute name="class">del_<xsl:value-of select="@rend" /></xsl:attribute><xsl:apply-templates /></span></xsl:otherwise></xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:add">
        <xsl:if test="@type='insertion'">
            <span class="insertionMark">^</span>
        </xsl:if>
        <span><xsl:attribute name="class">add_<xsl:value-of select="@place" /></xsl:attribute><xsl:apply-templates /></span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <xsl:choose>
            <xsl:when test="@reason='illegible'">[illeg.]</xsl:when>
        </xsl:choose>
    </xsl:template>

    <!--<xsl:template match="//tei:subst"><xsl:variable name="substContent"><xsl:copy-of select="normalize-space(.)"/></xsl:variable>
            <xsl:value-of select="$substContent"/>
</xsl:template>-->

    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            
            <xsl:when test="./attribute::type='main'">
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:when>
            
            <xsl:when test="./attribute::type='sub'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <xsl:template match="//tei:fw">
        
            <xsl:choose>
                
                <xsl:when test="@type='header_left'">
                    <span class="fw_header_left">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@type='header_right'">
                    <span class="fw_header_right">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@type='footer_center'">
                    <span class="fw_footer_center">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
            </xsl:choose>
        
    </xsl:template>


</xsl:stylesheet>
