<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mi="http://www.newhaven.edu/ns/nonTEI">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="base.xsl"/>
    <xsl:template match="//tei:teiHeader"/>
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/2016preface.youngidea.html">2016 Preface</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/1867preface.youngidea.html">1867 Preface</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.html">Edition</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="starts-with($idno,'extracts.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/intro.youngidea.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/2016preface.youngidea.html">2016 Preface</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/1867preface.youngidea.html">1867 Preface</a>
                    </li>
                    
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="starts-with($idno,'2016preface.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/intro.youngidea.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/1867preface.youngidea.html">1867 Preface</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.html">Edition</a>
                    </li>
                    
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="starts-with($idno,'1867preface.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/intro.youngidea.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/2016preface.youngidea.html">2016 Preface</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.html">Edition</a>
                    </li>
                    
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <!--<xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2016/editions/intro.youngidea.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/2016preface.youngidea.html">2016 Preface</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.html">Edition</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2016/editions/preface.youngidea.html">McArthur's Preface</a>
                    </li>
                    
                    <li id="editionNav4">
                        <a href="{$siteroot}2016/editions/extracts.youngidea.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>-->
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2016, Volume 37</h5>
    </xsl:template>




    <!-- To have a special div for distinctive body styling -->

    <xsl:template match="//tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='edition']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='youngidea'">
                <div class="youngidea">
                    
                            <xsl:apply-templates/>
                    <!--<xsl:if test="descendant::tei:note"><div class="notesList">
                        <h2>Notes</h2>
                            <ol>
                                <xsl:for-each select="//tei:body//tei:note">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:body//tei:note" level="any" />
                                    </xsl:variable>
                                    <li>
                                        <span class="note_editorial">
                                            <a>
                                                <xsl:attribute name="name">
                                                  <xsl:text>note</xsl:text>
                                                  <xsl:value-of select="$noteNumber" />
                                                </xsl:attribute>
                                            </a>
                                            <xsl:apply-templates />
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:text>#ref</xsl:text>
                                                  <xsl:value-of select="$noteNumber" />
                                                </xsl:attribute>
                                                <img>
                                                  <xsl:attribute name="src"
                                                  >images/goback.png</xsl:attribute>
                                                  <xsl:attribute name="alt">Go back</xsl:attribute>
                                                </img>
                                            </a>
                                        </span>
                                    </li>
                                </xsl:for-each>
                            </ol>
                </div></xsl:if>--></div>
            </xsl:when>
     
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="@type = 'main'">
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:when>
            <xsl:when test="@type = 'sub'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <!-- pagebreaks -->
    <xsl:template match="//tei:pb">
        <span><xsl:attribute name="class">pagebreak<xsl:if test="ancestor::tei:front and attribute::facs='cranch_title_1b'">_blank</xsl:if></xsl:attribute>
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>youngidea/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>youngidea/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs"/>
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>youngidea/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View </xsl:text>
                    <xsl:choose>
                        <xsl:when test="attribute::facs[contains(.,'frontcover')]">Front
                            Cover</xsl:when>
                        <xsl:when test="attribute::facs[contains(.,'backcover')]">Back
                            Cover</xsl:when>
                        <xsl:otherwise>Page<xsl:if test="ancestor::tei:front and attribute::facs='cranch_title_1b'">&#160;(blank)</xsl:if></xsl:otherwise>
                    </xsl:choose>
                </a>
            </span>
            <br/>
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>youngidea/pages/fullsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
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

    <!-- makes the <corr> show up in a <choice> (rather than the regularized forms) -->
    <xsl:template match="//tei:choice">
        <xsl:choose>

            <xsl:when test="child::tei:corr">
                <xsl:for-each select="child::tei:corr">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>



    <!-- Notes and pointers -->
    <xsl:template match="//tei:div[@type='notes']">
        <div class="notesList" style="display:none">
            <h2>Notes</h2>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="//tei:ptr">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="attribute::target"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="attribute::xml:id"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                    <span class="noteRefIntro"> [<xsl:value-of
                            select="substring-after(attribute::target,'#note')"/>] </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef"> [<xsl:value-of
                            select="substring-after(attribute::target,'#note')"/>] </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose>
            <!--<xsl:when test="ancestor::tei:body and not(ancestor::tei:listPerson)">
                <div class="note">
                            <a>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@xml:id" />
                                </xsl:attribute>
                            </a>
                            <xsl:value-of
                                    select="substring-after(attribute::xml:id,'intro')"
                                />.&#160;
                            <xsl:apply-templates />
                            <a>
                                <xsl:attribute name="href">#nr<xsl:value-of
                                    select="substring-after(attribute::xml:id,'intro')"
                                /></xsl:attribute>
                                <img>
                                    <xsl:attribute name="src">images/goback.png</xsl:attribute>
                                    <xsl:attribute name="alt">Go back</xsl:attribute>
                                </img>
                            </a>
                        </div>
               <!-\- <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:body//tei:note" level="any"/>
                </xsl:variable>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>#note</xsl:text>
                        <xsl:value-of select="$noteNumber"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:text>ref</xsl:text>
                        <xsl:value-of select="$noteNumber"/>
                    </xsl:attribute>
                    <span class="noteRef">[<xsl:value-of select="$noteNumber"/>]</span>
                </a>-\->
            </xsl:when>-->
            
                        
            

            <xsl:when test="ancestor::tei:person">
                <xsl:apply-templates/>
            </xsl:when>

            <xsl:otherwise>
                <!--<div class="note">
                    <a>
                        <xsl:attribute name="name">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                    </a>
                    <xsl:value-of select="substring-after(attribute::xml:id,'note')"/>. <xsl:apply-templates/><a>
                        <xsl:attribute name="href">#nr<xsl:value-of
                                select="substring-after(attribute::xml:id,'note')"/></xsl:attribute>
                        <img>
                            <xsl:attribute name="src">images/goback.png</xsl:attribute>
                            <xsl:attribute name="alt">Go back</xsl:attribute>
                        </img>
                    </a>
                </div>--><xsl:apply-templates/>
            </xsl:otherwise>

        </xsl:choose>


    </xsl:template>

    <!-- deletions and additions in the manuscript are set up so that if the reader is looking at the "clean reading text" version, the <del>s will not be visible and the <add>s will not have special styling -->
    <xsl:template match="//tei:del">
      
                <span>
                    <xsl:choose><xsl:when test="@rend"><xsl:attribute name="class">del_<xsl:value-of select="@rend"/></xsl:attribute></xsl:when>
                        <xsl:when test="@type"><xsl:attribute name="class">del_<xsl:value-of select="@type"/></xsl:attribute></xsl:when></xsl:choose>
                    <xsl:apply-templates/>
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
    </xsl:template>
    <xsl:template match="//tei:gap">
        <span class="gap">[<xsl:value-of select="@reason"/>]</span>
    </xsl:template>

    <xsl:template match="//tei:unclear">
        <xsl:choose>
            <xsl:when test="@cert='medium'">
                <span class="unclear_medium">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unclear_high">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- To get quoted poetic lines to show up in the introduction -->
    <!--   <xsl:template match="//tei:quote">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>-->


<!--new fw template for alternating page numbers-->

    <xsl:template match="//tei:fw">
        <div class="formework">
            <xsl:choose>
                <xsl:when test="@type='pagNum'">
                    <span><xsl:attribute name="class">fw_pagNum<xsl:choose>
                        <xsl:when test="@rend='align(right)'">_right</xsl:when><xsl:when test="@rend='align(left)'">_left</xsl:when>
                    </xsl:choose></xsl:attribute>
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                
            </xsl:choose>
        </div>
    </xsl:template>

    <xsl:template match="//tei:milestone">
        <xsl:choose>
            <xsl:when test="@rend='asterisks'">
                <span class="asterisks"
                    >*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*</span>
            </xsl:when>
            <!--new milestone rule--><xsl:when test="@rend='short-bar'"><span class="horizontal_bar">&#160;&#160;&#160;&#160;&#160;</span></xsl:when>
            <xsl:when test="@rend='long-bar'"><span class="long-horizontal_bar">&#160;</span></xsl:when>
        </xsl:choose>

    </xsl:template>

    

    <!-- A method for integrating personography notes into the mentions of the name in the text -->



    <xsl:template match="//tei:body//tei:persName">

        <xsl:choose>
            <xsl:when test="attribute::ref">
                <xsl:variable name="persNameID">
                    <xsl:value-of select="substring-after(@ref, '#')" />
                </xsl:variable><span class="showNote">
                    <a href="#" onclick="return false;" class="personNote">
                        <xsl:apply-templates />
                    </a>
                </span>
                <span>
                    <xsl:attribute name="class">appEntry</xsl:attribute>
                    <a href="#" class="closenote"><xsl:text>X</xsl:text></a>
                    <xsl:for-each
                        select="document('../2016/editions/youngidea/personography.youngidea.xml')//tei:person">
                        <xsl:if test="child::tei:persName//attribute::xml:id = $persNameID">
                            <div class="rdgNote">
                                <h4>
                                    <xsl:apply-templates select="child::tei:persName" />
                                </h4>
                                <span class="personNote">
                                    <xsl:apply-templates select="child::tei:note" />
                                </span>
                            </div>
                        </xsl:if></xsl:for-each></span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose></xsl:template>

    <xsl:template match="//tei:body//mi:shipName">
        
        <xsl:choose>
            <xsl:when test="attribute::ref">
                <xsl:variable name="shipNameID">
                    <xsl:value-of select="substring-after(@ref,'#')"/>
                </xsl:variable>
                
                <span class="showNote">
                    <a href="#" onclick="return false;" class="personNote"><xsl:apply-templates/></a>
                </span>
                <span>
                    <xsl:attribute name="class">appEntry</xsl:attribute>
                    <a href="#" class="closenote">X</a>
                    
                    <xsl:for-each select="document('../2016/editions/youngidea/shipography.youngidea.xml')//tei:org">
                        <xsl:if test=".//attribute::xml:id=$shipNameID">
                            <div class="rdgNote">
                                <!--<h4>
                                    <xsl:apply-templates select="child::tei:orgName"/>
                                </h4>-->
                                <span class="personNote">
                                    <xsl:apply-templates select="child::tei:desc"/>
                                </span>
                            </div>
                        </xsl:if>
                    </xsl:for-each>
                    
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:body//tei:placeName">
        <xsl:variable name="currentPlaceName"><xsl:for-each select="."><xsl:value-of select="."/></xsl:for-each></xsl:variable>
        <xsl:choose>
            <xsl:when test="attribute::ref">
                <xsl:variable name="placeNameID">
                    <xsl:value-of select="substring-after(@ref,'#')"/>
                </xsl:variable>
                
                <span class="showNote">
                    <a href="#" onclick="return false;" class="personNote"><xsl:apply-templates/></a>
                </span>
                <span>
                    <xsl:attribute name="class">appEntry</xsl:attribute>
                    <a href="#" class="closenote">X</a>
                    
                    <xsl:for-each select="document('../2016/editions/youngidea/placeography.youngidea.xml')//tei:place">
                        <xsl:if test="child::tei:placeName//attribute::xml:id=$placeNameID">
                            <xsl:variable name="geo1"><xsl:value-of select="substring-before(descendant::tei:geo,' ')"/></xsl:variable><xsl:variable name="geo2"><xsl:value-of select="substring-after(descendant::tei:geo,' ')"/></xsl:variable>
<xsl:variable name="gettyID"><xsl:value-of select="substring-after(descendant::tei:note,':')"/></xsl:variable>
                            <div class="rdgNote">
                                <h4>
                                    <xsl:value-of select="$currentPlaceName"/> is now known as <xsl:apply-templates select="child::tei:placeName"/>
                                </h4>
                                <span class="personNote">
                                    <ul>
                                        <li>See this place on a <a target="_blank"><xsl:attribute name="href">https://www.google.com/maps/@<xsl:value-of select="$geo1"/>,<xsl:value-of select="$geo2"/>,15z</xsl:attribute>Google map</a></li>
                                        <li>See the entry for this place on the <a target="_blank"><xsl:attribute name="href">http://www.getty.edu/vow/TGNServlet?english=Y&amp;find=<xsl:value-of select="$gettyID"/>&amp;place=&amp;page=1&amp;nation=</xsl:attribute>Getty Thesaurus of Geographic Names</a></li>
</ul>
                                </span>
                            </div>
                        </xsl:if>
                    </xsl:for-each>
                    
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <xsl:template match="//tei:note//tei:title">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <xsl:template match="//tei:epigraph">
        <span class="epigraph">
            <xsl:choose>
                <xsl:when test="@rend='align(center)'">
                    <span class="center">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@rend='align(center) case(allcaps)'">
                    <span class="centerCaps">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="//tei:epigraph//tei:bibl">
        <span class="epigraph_bibl">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:div[@type='article']//tei:bibl">
        <span class="article_bibl">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="//tei:desc//tei:bibl | //tei:person//tei:note//tei:bibl">
<xsl:choose>
    <xsl:when test="child::tei:author and not(child::tei:pubPlace)"><xsl:apply-templates/></xsl:when>
    <xsl:when test="child::tei:title and not(child::tei:pubPlace)"><em><xsl:apply-templates/></em></xsl:when>
    <xsl:when test="child::tei:pubPlace"><span class="authority_bibl">
        <xsl:apply-templates select="child::tei:author"/>, <em><xsl:apply-templates select="child::tei:title"/></em> (<xsl:apply-templates select="child::tei:pubPlace"/>: <xsl:apply-templates select="child::tei:publisher"/>), <xsl:apply-templates select="child::tei:date"/>.
    </span></xsl:when>
    <xsl:otherwise><span class="authority_bibl"><xsl:apply-templates/></span></xsl:otherwise>
</xsl:choose>
    </xsl:template>


    <xsl:template match="tei:floatingText/child::tei:body">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>

<!-- letter elements for the letters to the editor -->
    <xsl:template match="//tei:opener">
        <span class="opener">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:closer">
        <span class="closer">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:signed">
        <span class="signed">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//tei:dateline">
        <span class="dateline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="@type = 'ordered'">
                <xsl:choose>
                    <xsl:when test="child::tei:item/attribute::n">
                        <ul>
                            <xsl:apply-templates />
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ol>
                            <xsl:apply-templates />
                        </ol>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when><xsl:when test="@type='bulleted'">
                <ol class="bulleted">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:item">
        <li><xsl:if test="attribute::n"><xsl:value-of select="@n"/>.&#160;</xsl:if>
            <xsl:apply-templates/>
        </li>
    </xsl:template>


<!--thank you, git -->

</xsl:stylesheet>
