<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="../../../../legacy/template_xslt/base.xsl" />
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav" />
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
                        <a href="{$siteroot}2015/editions/swayzedrama.html">Edition</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/swayzedrama.xml">Edition XML</a>
                    </li>
                    <li id="editionNav3">
                        <a href="http://www.juxtacommons.org/shares/xNx0Ac">Compare to Colman's <i>Inkle and Yarico</i> (1825 U.S. edition)</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/intro.swayzedrama.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/swayzedrama.xml">Edition XML</a>
                    </li>
                    <li id="editionNav3">
                        <a href="http://www.juxtacommons.org/shares/xNx0Ac">Compare to Colman's <i>Inkle and Yarico</i> (1825 U.S. edition)</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>
    <!-- To have a special div for distinctive body styling -->
    <xsl:template match="//tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='swayzedrama'">
                <div class="swayzedrama">
                    <xsl:apply-templates />
                </div>
            </xsl:when>
            <xsl:when test="$fileIDsubstring='intro.swayzedrama'">
                <div class="introswayzedrama">
                    <xsl:apply-templates />
                    <!--<xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>
                                <xsl:for-each select="//tei:note[@type='editorial']">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:note[@type='editorial']"
                                            level="any" />
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
                        </div>
                    </xsl:if>-->
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
<xsl:when test="contains(@rend,'align(center)')"><h1>
            <xsl:apply-templates />
        </h1></xsl:when>
<xsl:when test="parent::tei:div[@type='scene']"><span class="scene_head"><xsl:apply-templates/></span></xsl:when>
            <xsl:when test="./attribute::type='main'">
                <xsl:choose><xsl:when test="parent::tei:div"><h2><xsl:apply-templates/></h2></xsl:when><xsl:otherwise>
                    <h1>
                        <xsl:apply-templates/>
                    </h1></xsl:otherwise></xsl:choose>
            </xsl:when>
            <xsl:when test="./attribute::type='sub'">
                
                    <h2>
                        <xsl:apply-templates/>
                    </h2>
            </xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise></xsl:choose>
     
    </xsl:template>
    <!-- pagebreaks -->
    <xsl:template match="//tei:pb">
        <span>
            <xsl:attribute name="class">pagebreak<xsl:if
                test="ancestor::tei:front and attribute::facs='cranch_title_1b'"
                >_blank</xsl:if></xsl:attribute>
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>swayzedrama/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>swayzedrama/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>swayzedrama/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View </xsl:text>
                    <xsl:choose>
                        <xsl:when test="attribute::facs[contains(.,'frontcover')]"
                            >Front
                            Cover</xsl:when>
                        <xsl:when test="attribute::facs[contains(.,'backcover')]"
                            >Back
                            Cover</xsl:when>
                        <xsl:otherwise>Page<xsl:if
                            test="ancestor::tei:front and attribute::facs='cranch_title_1b'"
                            >&#160;(blank)</xsl:if></xsl:otherwise>
                    </xsl:choose>
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>swayzedrama/pages/fullsize/</xsl:text>
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
    <!-- makes the <corr> show up in a <choice> (rather than the regularized forms) -->
    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="child::tei:corr">
                <xsl:for-each select="child::tei:corr">
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
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                    <span class="noteRefIntro"> [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />] </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef"> [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />] </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="@type='editorial'">
                <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:note[@type='editorial']" level="any" />
                </xsl:variable>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>#note</xsl:text>
                        <xsl:value-of select="$noteNumber" />
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:text>ref</xsl:text>
                        <xsl:value-of select="$noteNumber" />
                    </xsl:attribute>
                    <span class="noteRef">[<xsl:value-of select="$noteNumber" />]</span>
                </a>
            </xsl:when>
            <xsl:when test="@type='headnote'">
                <span class="headnote">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            <xsl:when test="attribute::resp='#cpc'">
                <span>
                    <xsl:attribute name="class">note_authorial<xsl:value-of
                        select="./attribute::place" /></xsl:attribute>
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            <xsl:when test="ancestor::tei:person">
                <xsl:apply-templates />
            </xsl:when>
            <xsl:otherwise>
                <div class="note"> <a> <xsl:attribute name="name"> <xsl:value-of select="@xml:id" />
                    </xsl:attribute> </a> <xsl:value-of
                    select="substring-after(attribute::xml:id,'note')"
                     />. <xsl:apply-templates /><a> <xsl:attribute name="href">#nr<xsl:value-of
                    select="substring-after(attribute::xml:id,'note')" /></xsl:attribute> <img>
                    <xsl:attribute name="src">template_images/goback.png</xsl:attribute> <xsl:attribute
                    name="alt">Go back</xsl:attribute> </img> </a> </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- deletions and additions in the manuscript are set up so that if the reader is looking at the "clean reading text" version, the <del>s will not be visible and the <add>s will not have special styling -->
    <xsl:template match="//tei:del">
        
                <span>
                    <xsl:choose>
                        <xsl:when test="@rend">
                            <xsl:attribute name="class">del_<xsl:value-of select="@rend"
                                 /></xsl:attribute>
                        </xsl:when>
                        <xsl:when test="@type">
                            <xsl:attribute name="class">del_<xsl:value-of select="@type"
                                 /></xsl:attribute>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates />
                </span>
    </xsl:template>
    <xsl:template match="//tei:add">
        
                <xsl:if test="@rend='caret'">
                    <span class="insertionMark">^</span>
                </xsl:if>
                <span>
                    <xsl:attribute name="class">add_<xsl:value-of select="@place" /></xsl:attribute>
                    <xsl:apply-templates />
                </span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <span class="gap">[<xsl:value-of select="@reason" />]</span>
    </xsl:template>
    <xsl:template match="//tei:unclear">
        <xsl:choose>
            <xsl:when test="@cert='medium'">
                <span class="unclear_medium">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unclear_high">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- To get quoted lines to show up properly in the introduction -->
       <xsl:template match="//tei:quote">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>
    <!--new fw template for alternating page numbers-->
    <xsl:template match="//tei:fw">
        <div class="formework">
            <xsl:choose>
                <xsl:when test="@type='pagNum'">
                    <span>
                        <xsl:attribute name="class">fw_pagNum<xsl:choose> <xsl:when
                            test="@rend='align(right)'">_right</xsl:when><xsl:when
                            test="@rend='align(left)'">_left</xsl:when>
                            </xsl:choose></xsl:attribute>
                        <xsl:apply-templates />
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
            <!--new milestone rule-->
            <xsl:when test="@rend='short-bar'">
                <span class="horizontal_bar">&#160;&#160;&#160;&#160;&#160;</span>
            </xsl:when>
            <xsl:when test="@rend='long-bar'">
                <span class="long-horizontal_bar">&#160;</span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:metamark">
        <span>
            <xsl:attribute name="class">metamark_<xsl:value-of select="attribute::place"
                 /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <!-- A method for integrating personography notes into the mentions of the name in the text -->
    <xsl:template match="//tei:body//tei:persName">
        <xsl:choose>
            <xsl:when test="attribute::ref">
                <xsl:variable name="persNameID">
                    <xsl:value-of select="substring-after(@ref,'#')" />
                </xsl:variable>
                <div class="showNote">
                    <a href="#" onclick="return false;" class="personNote">
                        <xsl:apply-templates />
                    </a>
                </div>
                <div>
                    <xsl:attribute name="class">appEntry</xsl:attribute>
                    <a href="#" class="closenote">X</a>
                    <xsl:for-each select="ancestor::tei:TEI//tei:listPerson/tei:person">
                        <xsl:if test="@xml:id=$persNameID">
                            <div class="rdgNote">
                                <h4>
                                    <xsl:for-each select="child::tei:persName/tei:forename"
                                        ><xsl:apply-templates />&#160;</xsl:for-each>
                                    <xsl:for-each select="child::tei:persName/tei:surname">
                                        <xsl:apply-templates />
                                        <xsl:if test="following-sibling::tei:surname"
                                            >&#160;</xsl:if>
                                    </xsl:for-each>
                                    <xsl:if test="child::tei:persName/following-sibling::tei:birth"
                                        >,&#160;</xsl:if>
                                    <xsl:value-of select="child::tei:birth" />
                                    <xsl:value-of select="child::tei:death" />
                                </h4>
                                <span class="personNote">
                                    <xsl:apply-templates select="child::tei:note" />
                                </span>
                            </div>
                        </xsl:if>
                    </xsl:for-each>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:note//tei:title">
        <i>
            <xsl:apply-templates />
        </i>
    </xsl:template>
    <xsl:template match="//tei:epigraph">
        <span class="epigraph">
            <xsl:choose>
                <xsl:when test="@rend='align(center)'">
                    <span class="center">
                        <xsl:apply-templates />
                    </span>
                </xsl:when>
                <xsl:when test="@rend='align(center) case(allcaps)'">
                    <span class="centerCaps">
                        <xsl:apply-templates />
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates />
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="//tei:epigraph//tei:bibl">
        <span class="epigraph_bibl">
            <xsl:apply-templates />
        </span>
    </xsl:template>
<!--    <xsl:template match="tei:floatingText/child::tei:body">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>-->

    <xsl:template match="//tei:stage">
        <xsl:variable name="stage_type">
            <xsl:value-of select="@type" />
        </xsl:variable>
        <span>
            <xsl:attribute name="class">stage<xsl:if test="@type">_<xsl:value-of
                select="$stage_type" /></xsl:if></xsl:attribute>
            <xsl:choose>
                
                <xsl:when test="attribute::rend">
                        <xsl:choose>
                            <xsl:when test="@rend='underline'">
                                <u>
                                    <xsl:apply-templates />
                                </u>
                            </xsl:when>
                            <xsl:otherwise><span><xsl:attribute name="class"><xsl:choose>
                                <xsl:when test="@rend='align(right)'">align_right</xsl:when>
                                <xsl:when test="@rend='align(left)'">align_left</xsl:when>
                                <xsl:when test="@rend='align(center)'">center</xsl:when>
                                <xsl:when test="@rend='underline align(center)'">underline_center</xsl:when>
                            </xsl:choose></xsl:attribute><xsl:apply-templates /></span></xsl:otherwise>
                        </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates />
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="//tei:speaker"><span class="speaker"><xsl:apply-templates/></span></xsl:template>
    <xsl:template match="//tei:sp"><span class="sp"><xsl:apply-templates/></span></xsl:template>


    <!--<xsl:template match="tei:app"><xsl:for-each select="child::tei:lem[@wit='#NSweetheartsc1858']"><div class="lem_1858"><xsl:apply-templates/></div></xsl:for-each><xsl:for-each select="child::tei:rdg[@wit='#Colman1825']"><div class="rdg_1825"><xsl:apply-templates/></div></xsl:for-each></xsl:template>-->


<!-- A method for getting the 1828 text to be linked from the Swayze onclick -->
    <xsl:template match="//tei:app"><xsl:variable name="descendant_sp"><xsl:value-of select="count(descendant::tei:lem/descendant::tei:sp)"/></xsl:variable>
        <xsl:for-each select="child::tei:lem[@wit='#NSweetheartsc1858']">
            <!--   <div class="showNote"><a href="#" onclick="return false;"><span class="variantNote" style="color: #007a32">Perhaps</span></a></div>     -->
            <div class="lem_1858"><xsl:apply-templates /></div>
            <div class="showNote"><a href="#" onclick="return false;" class="ColmanLink">See related passage from Colman (1825)</a></div>
                
            </xsl:for-each>
            <div>
                <xsl:attribute name="class">appEntry</xsl:attribute>
                <!--<xsl:attribute name="style">margin-top: <xsl:choose>
                    <xsl:when test="$descendant_sp=1">-100px</xsl:when>
                    <xsl:when test="$descendant_sp=(6 to 9)">-750px</xsl:when>
                    <xsl:when test="$descendant_sp>9">-1000px</xsl:when>
                </xsl:choose></xsl:attribute>-->
                <a href="#" class="closenote">X</a>
                <xsl:for-each select="child::tei:rdg[@wit='#Colman1825']">
                    
                        <div class="rdgNote">
                            <h2>From George Colman's <i>Inkle and Yarico.</i> (New York: Charles Wiley, 1825) <xsl:value-of select="@n"/>:</h2>
                            <xsl:apply-templates/>
                        </div>
                        
                    
                </xsl:for-each><xsl:for-each select="child::tei:note[@type='annotation']"><span class="annotation"><h2>Editorial Note:</h2><xsl:apply-templates/></span></xsl:for-each>
            </div>
        
        
        
    </xsl:template>

    <xsl:template match="//tei:div[@type='section']">
        <div class="section">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="attribute::type='simple'">
                <ul><xsl:if test="@xml:id"><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute></xsl:if>
                    <xsl:apply-templates />
                </ul>
            </xsl:when>
            <xsl:when test="attribute::type='bulleted'">
                <ul class="bulleted">
                    <xsl:apply-templates />
                </ul>
            </xsl:when>
            <xsl:when test="attribute::type='ordered'">
                <ol>
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
            <xsl:apply-templates/>
        </li>
    </xsl:template>

</xsl:stylesheet>
