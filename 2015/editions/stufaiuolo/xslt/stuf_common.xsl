<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:param name="stuf_version">undefined</xsl:param>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="../../../../legacy/template_xslt/base.xsl" />
    <xsl:template name="essayNav" />
    <xsl:template name="witnessName" />
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
                        <a href="{$siteroot}2015/editions/stufaiuolo.riccardiana_reading.html"
                            >Riccardiana MS</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/stufaiuolo.valentiniana_reading.html"
                            >Valentiniana MS</a>
                    </li>
                    <li id="editionNav2">
                        <a href="http://juxtacommons.org/shares/ehF60q"
                            >Manuscript comparison in Juxta</a>
                    </li>
                    
                </ul>
            </xsl:when>
            <xsl:when test="contains($idno,'valentiniana')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/intro.stufaiuolo.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/stufaiuolo.riccardiana_reading.html"
                            >Riccardiana MS</a>
                    </li>
                    
                    <li id="editionNav3">
                        <a href="{$siteroot}2015/editions/stufaiuoloxml.zip">Edition XML</a>
                    </li>
                    <li id="editionNav4">
                        <a href="http://juxtacommons.org/shares/ehF60q"
                            >Manuscript comparison in Juxta</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/intro.stufaiuolo.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2015/editions/stufaiuolo.valentiniana_reading.html"
                            >Valentiniana MS</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2015/editions/stufaiuoloxml.zip">Edition XML</a>
                    </li>
                    <li id="editionNav4">
                        <a href="http://juxtacommons.org/shares/ehF60q"
                            >Manuscript comparison in Juxta</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>
    <xsl:template match="//tei:teiHeader" />
    <xsl:template match="//tei:text">
        <div><xsl:attribute name="class">stufaiuolo<xsl:if test="ends-with($stuf_version,'diplomatic')"> stuf_diplomatic</xsl:if></xsl:attribute><!--<span class="ms_description"><xsl:for-each select="//tei:msDesc">
            <div class="showNote"><a href="#" onclick="return: false;"><h2>Manuscript Description</h2></a></div>
            <div class="appEntry" style="display: none"><a href="#" class="closenote">X</a>
                <h1>Manuscript Description</h1>
                <p><xsl:for-each select="//tei:msIdentifier/*">
                    <xsl:apply-templates/><xsl:if test="following-sibling::*"><xsl:text>, </xsl:text></xsl:if>
                </xsl:for-each></p>
                <xsl:variable name="mspart">
                    <xsl:choose>
                        <xsl:when test="//tei:TEI[@xml:id='ric']"><xsl:copy-of select="tei:msPart/tei:physDesc"></xsl:copy-of></xsl:when>
                        <xsl:otherwise><xsl:copy-of select="tei:physDesc"></xsl:copy-of></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="mspartpath" select="$mspart"/>
                <xsl:for-each select="$mspart">
                    <h4>Physical Description</h4>
                    <p><strong>Material</strong>: </p>
                    <xsl:for-each select=".//tei:support/tei:material"><p><xsl:apply-templates/></p></xsl:for-each>
                    <p><strong>Dimensions</strong>: 
                        <xsl:for-each select=".//tei:extent/tei:dimensions">
                            <xsl:apply-templates select="tei:width"/><xsl:text>mm x</xsl:text>
                            <xsl:apply-templates select="tei:height"/><xsl:text>mm</xsl:text>
                        </xsl:for-each></p>
                    <p><xsl:apply-templates select=".//tei:foliation"/></p>
                    <p><xsl:apply-templates select=".//tei:collation"/></p>
                    <p><xsl:apply-templates select=".//tei:supportDesc/tei:condition"/></p>
                    <p><strong>Layout</strong>: <xsl:apply-templates select=".//tei:layoutDesc"/></p>
                    <p>Autograph; scripts: <ul><xsl:for-each select=".//tei:handNote">
                        <li><xsl:apply-templates/></li></xsl:for-each></ul></p>
                    <p><strong>Decorations</strong>:</p>
                    <div style="margin-left:15pt"><xsl:if test=".//tei:decoNote[@type='frontespiece']"><p>Frontespiece: </p>
                        <ul> <xsl:for-each select=".//tei:decoNote[@type='frontespiece']">
                            <li><xsl:apply-templates/></li>
                        </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='penwork-initials']"><p>Penwork initials: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='penwork-initials']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='drop-capital']"><p>Drop capitals: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='drop-capital']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='headpiece']"><p>Head pieces: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='headpiece']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='tailpiece']"><p>Tail pieces: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='tailpiece']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='cadel']"><p>Cadels: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='cadel']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='cartouche']"><p>Cartouces: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='cartouche']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if>
                        <xsl:if test=".//tei:decoNote[@type='panle']"><p>Panels: </p>
                            <ul> <xsl:for-each select=".//tei:decoNote[@type='panel']">
                                <li><xsl:apply-templates/></li>
                            </xsl:for-each></ul></xsl:if></div>
                    <xsl:if test=".//tei:additions">
                        <p><strong>Additions and annotations</strong>: <xsl:apply-templates select=".//tei:additions"/></p>
                    </xsl:if>
                    <xsl:if test=".//tei:bindingDesc"><xsl:apply-templates select=".//tei:bindingDesc/tei:p"/></xsl:if>
                    <xsl:if test=".//tei:accMat">
                        <p><strong>Accompaining Material</strong>: <xsl:apply-templates select=".//tei:accMat"/></p>
                    </xsl:if>
                </xsl:for-each>
            </div>
            
        </xsl:for-each></span>-->
            <xsl:if test="//tei:idno[@type='file']!='intro.stufaiuolo'"><div class="stufaiuolo_nav">
                <h1>[<xsl:choose>
                    <xsl:when test="starts-with($stuf_version,'ricc')">Riccardiana</xsl:when>
                    <xsl:when test="starts-with($stuf_version,'cam')">Valentiniana</xsl:when>
                </xsl:choose> Manuscript]</h1>
<ul><li id="editionNavPre">View <xsl:choose>
                <xsl:when test="starts-with($stuf_version,'ricc')">Riccardiana</xsl:when>
                <xsl:when test="starts-with($stuf_version,'cam')">Valentiniana</xsl:when>
            </xsl:choose> manuscript's:</li>
                <li id="editionNav1"><span class="ms_description"><xsl:for-each select="//tei:msDesc">
                    <div class="showNote"><a href="#" onclick="return: false;">Manuscript Description</a></div>
                    <div class="appEntry" style="display: none"><a href="#" class="closenote">X</a>
                        <h1>Manuscript Description</h1>
                        <p><xsl:for-each select="//tei:msIdentifier/*">
                            <xsl:apply-templates/><xsl:if test="following-sibling::*"><xsl:text>, </xsl:text></xsl:if>
                        </xsl:for-each></p>
                        <xsl:variable name="mspart">
                            <xsl:choose>
                                <xsl:when test="//tei:TEI[@xml:id='ric']"><xsl:copy-of select="tei:msPart/tei:physDesc"></xsl:copy-of></xsl:when>
                                <xsl:otherwise><xsl:copy-of select="tei:physDesc"></xsl:copy-of></xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="mspartpath" select="$mspart"/>
                        <xsl:for-each select="$mspart">
                            <h4>Physical Description</h4>
                            <p><strong>Material</strong>: </p>
                            <xsl:for-each select=".//tei:support/tei:material"><p><xsl:apply-templates/></p></xsl:for-each>
                            <p><strong>Dimensions</strong>: 
                                <xsl:for-each select=".//tei:extent/tei:dimensions">
                                    <xsl:apply-templates select="tei:width"/><xsl:text> mm ×</xsl:text>
                                    <xsl:apply-templates select="tei:height"/><xsl:text> mm</xsl:text>
                                </xsl:for-each></p>
                            <p><xsl:apply-templates select=".//tei:foliation"/></p>
                            <p><xsl:apply-templates select=".//tei:collation"/></p>
                            <p><xsl:apply-templates select=".//tei:supportDesc/tei:condition"/></p>
                            <p><strong>Layout</strong>: <xsl:apply-templates select=".//tei:layoutDesc"/></p>
                            <p>Autograph; scripts: <ul><xsl:for-each select=".//tei:handNote">
                                <li><xsl:apply-templates/> (scope: <xsl:value-of select="scope"/>)</li></xsl:for-each></ul></p>
                            <p><strong>Decorations</strong>:</p>
                            <div style="margin-left:15pt"><xsl:if test=".//tei:decoNote[@type='frontespiece']"><p>Frontispiece: </p>
                                <ul> <xsl:for-each select=".//tei:decoNote[@type='frontespiece']">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='penwork-initials']"><p>Penwork initials: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='penwork-initials']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='drop-capital']"><p>Drop capitals: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='drop-capital']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='headpiece']"><p>Headpieces: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='headpiece']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='tailpiece']"><p>Tailpieces: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='tailpiece']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='cadel']"><p>Cadels: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='cadel']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='cartouche']"><p>Cartouches: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='cartouche']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if>
                                <xsl:if test=".//tei:decoNote[@type='panle']"><p>Panels: </p>
                                    <ul> <xsl:for-each select=".//tei:decoNote[@type='panel']">
                                        <li><xsl:apply-templates/></li>
                                    </xsl:for-each></ul></xsl:if></div>
                            <xsl:if test=".//tei:additions">
                                <p><strong>Additions and Annotations</strong>: <xsl:apply-templates select=".//tei:additions"/></p>
                            </xsl:if>
                            <xsl:if test=".//tei:bindingDesc"><xsl:apply-templates select=".//tei:bindingDesc/tei:p"/></xsl:if>
                            <xsl:if test=".//tei:accMat">
                                <p><strong>Accompanying Material</strong>: <xsl:apply-templates select=".//tei:accMat"/></p>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                    
                </xsl:for-each></span></li>
<li id="editionNav2"><span class="switch_views">
                <a><xsl:attribute name="href"><xsl:value-of select="$siteroot"/>2015/editions/stufaiuolo.<xsl:choose>
                    <xsl:when test="starts-with($stuf_version,'ricc')">riccardiana</xsl:when>
                    <xsl:when test="starts-with($stuf_version,'cam')">valentiniana</xsl:when>
                    </xsl:choose><xsl:choose><xsl:when test="ends-with($stuf_version,'reading')"
                    >_diplomatic</xsl:when><xsl:when test="ends-with($stuf_version,'diplomatic')"
                    >_reading</xsl:when></xsl:choose>.html</xsl:attribute><xsl:choose><xsl:when
                    test="ends-with($stuf_version,'reading')"
                    >Diplomatic Transcription</xsl:when><xsl:when
                    test="ends-with($stuf_version,'diplomatic')"
                    >Reading Text</xsl:when></xsl:choose> <!--of the <xsl:choose> <xsl:when
                    test="starts-with($stuf_version,'ricc')">Riccardiana manuscript</xsl:when>
                    <xsl:when test="starts-with($stuf_version,'cam')">Valentiniana manuscript</xsl:when>
                    </xsl:choose>--> </a>
            </span></li>
                <li id="editionNav3"><span class="interventions_link"><a><xsl:attribute name="href"><xsl:value-of select="$siteroot"/>2015/editions/stufaiuolo.<xsl:choose>
                <xsl:when test="starts-with($stuf_version,'ricc')">riccardiana</xsl:when>
                <xsl:when test="starts-with($stuf_version,'cam')">valentiniana</xsl:when>
            </xsl:choose>_interventions.html</xsl:attribute>Editorial Normalizations<!-- in the <xsl:choose> <xsl:when
                test="starts-with($stuf_version,'ricc')">Riccardiana manuscript</xsl:when>
                <xsl:when test="starts-with($stuf_version,'cam')">Valentiniana manuscript</xsl:when>
            </xsl:choose>--></a></span></li></ul></div></xsl:if>
           
            <xsl:apply-templates />
            <div class="notesList">
                <h2>Notes</h2>
                <xsl:for-each select=".//tei:note[ancestor::tei:text]">
                    <div class="note">
                        <a>
                            <xsl:attribute name="id">note_<xsl:number count="tei:note"
                                from="tei:text" level="any" /></xsl:attribute>
                        </a>
                        <xsl:number count="tei:note" from="tei:text" level="any" />
                        <xsl:text>. </xsl:text>
                        <xsl:choose>
                            <xsl:when test="@sameAs">
                                <xsl:variable name="sameAs" select="substring-after(@sameAs, '#')" />
                                <xsl:variable name="file-note"
                                    select="substring-before(@sameAs, '#')" />
                                <xsl:for-each
                                    select="doc(concat($siteroot,'/2015/editions/',$file-note))//tei:note[@xml:id = $sameAs]">
                                    <xsl:apply-templates />
                                </xsl:for-each>
                                <!--<xsl:for-each select="doc(concat('../',$file-note))//note[@xml:id = $sameAs]">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>-->
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates />
                            </xsl:otherwise>
                        </xsl:choose>
                        <a>
                            <xsl:attribute name="href">#ref_<xsl:number count="tei:note"
                                from="tei:text" level="any" /></xsl:attribute>
                            <img>
                                <xsl:attribute name="src">template_images/goback.png</xsl:attribute>
                                <xsl:attribute name="alt">Go back</xsl:attribute>
                            </img>
                        </a>
                    </div>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:text//tei:note">
        <sup>
            <a href="#" class="tooltip">
                <xsl:attribute name="href">#note_<xsl:number count="tei:note" from="tei:text"
                    level="any" /></xsl:attribute>
                <xsl:attribute name="id">ref_<xsl:number count="tei:note" from="tei:text"
                    level="any" /></xsl:attribute>
                <xsl:number count="tei:note" from="tei:text" level="any" />
                <span>
                    <!--                    <img class="callout" src="callout.gif" />-->
                    <xsl:choose>
                        <xsl:when test="@sameAs">
                            <xsl:variable name="sameAs" select="substring-after(@sameAs, '#')" />
                            <xsl:variable name="file-note" select="substring-before(@sameAs, '#')" />
                            <xsl:for-each
                                select="doc(concat($siteroot,'/2015/editions/',$file-note))//tei:note[@xml:id = $sameAs]">
                                <xsl:apply-templates />
                            </xsl:for-each>
                            <!--<xsl:for-each select="doc(concat('../',$file-note))//note[@xml:id = $sameAs]">
                                <xsl:apply-templates/>
                            </xsl:for-each>-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates />
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </a>
        </sup>
    </xsl:template>
    <!--<xsl:template name="vale">
        <div>
            <a href="valentiniana.html" class="frametoc">Manoscritto V</a>
            <a class="frametoc2" href="camerino-ms.html">Edizione diplomatica</a>
            <a class="frametoc2" href="camerino-in.html">Edizione semi-diplomatica</a>
            <a class="frametoc2" href="camerino-ed.html">Edizione critica</a>
        </div>
        <div>
            <a href="ricca.html" class="frametoc">Manoscritto R</a>
        </div>
    </xsl:template>-->
    <!--<xsl:template name="ricca">
        <div>
            <a href="valentiniana.html" class="frametoc">Manoscritto V</a>
        </div>
        <div>
            <a href="ricca.html" class="frametoc">Manoscritto R</a>
            <a class="frametoc2" href="riccardiana-ms.html">Edizione diplomatica</a>
            <a class="frametoc2" href="riccardiana-in.html">Edizione semi-diplomatica</a>
            <a class="frametoc2" href="riccardiana-ed.html">Edizione critica</a>
        </div>
    </xsl:template>-->
    <!--<xsl:template match="tei:p">
        <xsl:choose>
            <xsl:when test="parent::tei:sp">
                <div style="padding-left:15px">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>-->
    <xsl:template match="tei:sp">
        <div class="sp">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="tei:dim">
        <xsl:apply-templates/><xsl:text> </xsl:text><xsl:value-of select="@unit"/>
    </xsl:template>
    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="//tei:front/tei:div/tei:ab">
        <center>
            <h2>
                <xsl:apply-templates />
            </h2>
        </center>
    </xsl:template>
    <xsl:template match="tei:epigraph[@rend='center']">
        <center>
            <xsl:apply-templates />
        </center>
    </xsl:template>
    
    
    <xsl:template match="tei:hi[@rend='maiuscoletto']">
        <span style="font-variant:sc">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:p[@rend='right']">
        <p style="margin-left:10cm">
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <xsl:template match="tei:signed">
        <span class="signed">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:epigraph">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="tei:ptr"> </xsl:template>
    <xsl:template match="tei:opener">
        <span class="opener">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:closer">
        <span class="closer">
            <xsl:apply-templates />
        </span>
    </xsl:template>


    <!-- <head> variations -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$idno='intro.stufaiuolo'">
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
                    <xsl:when test="parent::tei:table"><h4><xsl:apply-templates/></h4></xsl:when>
                    <xsl:otherwise>
                        <h3>
                            <xsl:apply-templates />
                        </h3>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
          <xsl:when test="ancestor::tei:text/*/tei:div/tei:head">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:when test="ancestor::tei:div/tei:div/tei:head">
                <h3 style="text-transform:uppercase;">
                    <xsl:apply-templates />
                </h3>
            </xsl:when>
            <xsl:when test="parent::tei:body">
                <center>
                    <h2>
                        <xsl:apply-templates />
                    </h2>
                </center>
            </xsl:when>
            <xsl:when test="parent::tei:castList"><dl>
                <dd>
                    <p align="center">
                        <STRONG>
                            <font size="4">
                                <xsl:apply-templates />
                            </font>
                        </STRONG>
                    </p>
                </dd>
            </dl></xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:template match="tei:text/*/tei:div/tei:head">
        <h2>
            <xsl:apply-templates />
        </h2>
    </xsl:template>-->
        <!--<xsl:template match="tei:div/tei:div/tei:head">
        <h3 style="text-transform:uppercase;">
            <xsl:apply-templates />
        </h3>
    </xsl:template>-->
        <!--<xsl:template match="tei:body/tei:head">
        <center>
            <h2>
                <xsl:apply-templates />
            </h2>
        </center>
    </xsl:template>

<xsl:template match="tei:castList/tei:head">
        <dl>
            <dd>
                <p align="center">
                    <STRONG>
                        <font size="4">
                            <xsl:apply-templates />
                        </font>
                    </STRONG>
                </p>
            </dd>
        </dl>
    </xsl:template>

-->
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
