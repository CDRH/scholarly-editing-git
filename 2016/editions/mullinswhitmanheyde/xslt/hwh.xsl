<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="edition_type"/>
    
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="../../../../template_xslt/base.xsl" />
    
    <xsl:template match="/tei:TEI/tei:text">
        
        <xsl:choose>
            <xsl:when test="$edition_type = 'edition'">
                <xsl:variable name="files" select="collection('../2016/editions/mullinswhitmanheyde/xml?recurse=yes;select=*.xml')"/>
                <ul>
                <xsl:for-each select="$files">
                    <xsl:sort select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date/@when"/>
                    <xsl:sort select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date/@when-iso"/>
                    <!--[<xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date/@when"/>]-->
                   
                    <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>
                    
                    <!-- Split the filename using '\.' -->
                    <xsl:variable name="filenamepart" select="substring-before($filename, '.xml')"/>
                    
                    <!-- if not intro -->
                   
                    <xsl:if test="normalize-space(//tei:idno[@type='file']) != 'intro.mullinswhitmanheydeletters'">
                        
                    <li>
                        <a>
                        <xsl:attribute name="href">
                            <xsl:text>mullinswhitmanheyde.</xsl:text>
                            <xsl:value-of select="$filenamepart"/>
                            <xsl:text>.html</xsl:text>
                        </xsl:attribute>
                            <xsl:value-of select="//tei:title[@type='main']"/>
                    </a>
                        
                    </li>
                        
                    </xsl:if>
                   
                    
                </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:when test="$idno = 'intro.mullinswhitmanheydeletters'">
                <span class="whitmanhydeintro">
                    <!--[[[<xsl:value-of select="$idno"/>]]]-->
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="whitmanhyde">
                    <xsl:apply-templates/>
            </span></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno" />
        </xsl:variable>
        <ul>
            <li id="editionNavPre">Go to:</li>
            <li id="editionNav1">
                <a href="{$siteroot}2016/editions/mullinswhitmanheyde.html">Introduction</a>
            </li>
            <li id="editionNav2">
                <a href="{$siteroot}2016/editions/mullinswhitmanheyde.edition.html">Index of Letters</a>
            </li>
            <li id="editionNav4">
                <a href="mullinswhitmanheyde/xml/mullinswhitmanheyde.zip">Download XML</a>
            </li>
        </ul>
        
        <!--<xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="mullinswhitmanheyde.edition.html">Edition</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="mullinswhitmanheyde.html"
                            >Introduction</a>
                    </li>
                    <!-\-<li id="editionNav2">
                        <a href="{$siteroot}2012/editions/liveoakwithmoss.xml">Edition XML</a>
                    </li>-\->
                </ul>
            </xsl:otherwise>
        </xsl:choose>-->
    </xsl:template>
    
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2016, Volume 37</h5>
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
        
        <span class="whitmanheydepagebreak">
            <span class="whitmanheydethumbnailbox">
            <span class="whitmanheydethumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>mullinswhitmanheyde/figures/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:text>Image courtesy of </xsl:text>
                        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:orgName"/>
                    </xsl:attribute>
                
                    <img src="mullinswhitmanheyde/figures/thumbs/{@facs}"/>
                </a>
                
            </span>
            
            <span class="whitmanheydeviewsize">
                <a href="mullinswhitmanheyde/figures/viewsize/{@facs}">View Page</a>
            </span>
            <span class="whitmanheydefullsize">
                <a href="mullinswhitmanheyde/figures/fullsize/{@facs}" target="_blank">Full size in new window</a>
            </span>
            </span>
            
        </span><!-- /whitmanheydethumbnailbox -->
        
        
       
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
    
    <xsl:template match="//tei:note" priority="2">
<xsl:choose>
    <xsl:when test="@type='authorial'"><xsl:apply-templates/></xsl:when>
<xsl:otherwise><div class="note">
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
        </div></xsl:otherwise>
</xsl:choose>
        
    </xsl:template>
    
    <!-- Special linebreaks for poetic lines -->
    <xsl:template match="//tei:l//tei:lb"><br />&#160;&#160;&#160;&#160;&#160;</xsl:template>
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
    
    <xsl:template match="tei:note[@type='editorial']" priority="3">
        <span class="showNote">
            <a href="#" onclick="return false;"><xsl:text> [</xsl:text><xsl:value-of select="substring-after(@xml:id,'n')"/><xsl:text>]</xsl:text></a>
        </span>
        <span class="appEntry" style="display: block;">
            <a href="#" class="closenote">X</a>
            <span class="rdgNote">
           <br/> <!--<xsl:value-of select="."/>--><xsl:apply-templates/><!-- todo: ask andy if he has any ideas -->
        </span></span>
    </xsl:template>
    
    <xsl:template match="tei:note[@type='editorial']/p" priority="1">
        <xsl:apply-templates/><br></br>/<br/>
    </xsl:template>
    
    <xsl:template match="//tei:choice" priority="2">
        <xsl:choose>
            <xsl:when test="tei:abbr">
                <xsl:apply-templates select="tei:abbr" />
            </xsl:when>
            <xsl:when test="tei:sic">
                <xsl:apply-templates select="tei:sic" />
               <!-- <xsl:text> [sic]</xsl:text>-->
            </xsl:when>
            <xsl:otherwise>
                
            </xsl:otherwise>
        </xsl:choose>
        
            
        
    </xsl:template>
    
    <xsl:template match="//tei:choice" priority="1">
        
        <xsl:apply-templates select="tei:abbr" />
        
    </xsl:template>
    
    <!-- To get quoted poetic lines to show up in the introduction -->
    <xsl:template match="//tei:quote">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>
    
   <xsl:template match="//tei:note" priority="1">
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
    
    <!-- figure matching template overriding base in order to override the base xsl -->
    <xsl:template match="//tei:figure" priority="2">
        <span>
            <xsl:attribute name="class">
                <xsl:text>whitmanhydefigure</xsl:text>
                <xsl:choose>
                    <xsl:when test="@rend='right'">
                        <xsl:text> whitmanhydefigureright</xsl:text>
                    </xsl:when>
                    <xsl:when test="@rend='left'">
                        <xsl:text> whitmanhydefigureleft</xsl:text>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            
            <img src="mullinswhitmanheyde/figures/intro/{tei:graphic/@url}"/>
           
            <span class="whitmanhydefigurehead"><xsl:value-of select="tei:head"/></span>
            <span class="whitmanhydefigurep"><xsl:choose>
                <xsl:when test="child::*"><xsl:apply-templates select="tei:p"></xsl:apply-templates></xsl:when><xsl:otherwise><xsl:value-of select="tei:p"/></xsl:otherwise>
            </xsl:choose></span>
        </span>
       
        
    </xsl:template>
    
   
</xsl:stylesheet>
