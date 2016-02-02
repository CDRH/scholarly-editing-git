<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2012/editions/liveoakwithmoss.html">Edition</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2012/editions/intro.liveoakwithmoss.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2012/editions/liveoakwithmoss.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2012, Volume 33</h5>
    </xsl:template>
    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main-authorial'">
                <xsl:choose>
                    <xsl:when test="parent::tei:lg[@type='cluster']">
                        <xsl:choose>
                            <xsl:when test="@rend='underline'"><h1>
                                <u><xsl:apply-templates /></u>
                            </h1></xsl:when>
                            <xsl:otherwise><h1>
                            <xsl:apply-templates />
                        </h1></xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:when>
                    <xsl:when test="parent::tei:lg[@type='poem']">
                        <h2>
                            <xsl:apply-templates />
                        </h2>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="./attribute::type='main'">
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:when>
            <xsl:when test="./attribute::type='small-main'">
                <h2>
                    <xsl:apply-templates />
                </h2>
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
    <!-- pagebreaks -->
    <xsl:template match="//tei:pb">
        <table class="pagebreak">
            <tr><span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                       
                    </xsl:attribute>
                    <img>
                       
                        <xsl:attribute name="src">
                            <xsl:text>pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs" />
                            
                        </xsl:attribute>
                        
                    </img>
                </a>
            </span>
            </tr>
            <tr>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        
                    </xsl:attribute>
                    <xsl:text>View Page</xsl:text></a>
            </span>
            </tr>
           <tr>
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/fullsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
           </tr>
        </table>
    </xsl:template>
    
    <!-- epistolary tags-->
    <xsl:template match="//tei:signed">
        <span class="signed">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="//tei:salute">
        <span class="salute">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- <opener> and <closer> -->
    <xsl:template match="//tei:opener">
        <span class="opener">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:closer">
        <span class="closer">
            <xsl:apply-templates />
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
            <xsl:choose><xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]"><span class="noteRefIntro">
                
                [<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span></xsl:when><xsl:otherwise><span class="noteRef">
               
                [<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span></xsl:otherwise></xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <div class="note">
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
                    <xsl:attribute name="src">images/goback.png</xsl:attribute>
                    <xsl:attribute name="alt">Go
                        back</xsl:attribute>
                </img>
            </a>
        </div>
    </xsl:template>
    <!-- Special linebreaks for poetic lines -->
    <xsl:template match="//tei:l//tei:lb"
        ><br />&#160;&#160;&#160;&#160;&#160;</xsl:template>
    <!-- deletions and additions in the manuscript (I did not do anything with the <subst> stuff at this
point because I thought the styling could be accomplished for this file through this relatively
simple approach -->
    <xsl:template match="//tei:del">
        <span>
            <xsl:attribute name="class">del_<xsl:value-of select="@type" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:add">
        <xsl:if test="@type='insertion'">
            <span class="insertionMark">^</span>
        </xsl:if>
        <span>
            <xsl:attribute name="class">add_<xsl:value-of select="@place" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <xsl:choose>
            <xsl:when test="@reason='deletion, illegible'">[illeg.]</xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- To get quoted poetic lines to show up in the introduction -->
    <xsl:template match="//tei:quote">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>
    
   <xsl:template match="//tei:note">
       <xsl:variable name="noteNumber">
           <xsl:number count="//tei:note[@type='editorial']" level="any" />
       </xsl:variable>
      <sup> <a>
           <xsl:attribute name="name">
               <xsl:value-of select="concat('note', $noteNumber)"/>
           </xsl:attribute>
           <xsl:attribute name="href">
               <xsl:value-of select="concat('#ref', $noteNumber)"/>
           </xsl:attribute>
           <xsl:value-of select="$noteNumber"/>
       </a>
      </sup>
   </xsl:template>
    
   
</xsl:stylesheet>
