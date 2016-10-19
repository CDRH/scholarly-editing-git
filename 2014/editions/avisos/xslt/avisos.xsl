<?xml version="1.0" encoding="UTF-8"?>
<!--Another big question is how to deal with all of the different types of notes 
    (authorial, editorial, translation) The introduction only has authorial notes, 
    and those are bing put in a notelist. Currently this only puts editorial notes
    in the notelist for the edition though.-->
<!--Another question is whether or not the English and Spanish versions should appear on the same page 
    or on seperate pages. Professor McCarl has indicated that he wants them side by side, which makes sense, 
    but I feel like with the hide/show button on the Spanish, and not on the English, it might be confusing
    to have them next to eachother? The other problem is that the translation might not line up well with the
    Spanish version. The <p> elements do have @corresp but just from a spacing perspective I'm not sure how the
    English and Spanish corresponding sections would line up on the page.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <!--this should be calling base-->   
    <xsl:include href="../../../../template_xslt/base.xsl"/>
    <xsl:template match="//tei:teiHeader"/>
    <xsl:template name="essayNav"/>
    <xsl:template name="witnessName"/>

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
                        <a href="{$siteroot}2014/editions/avisos.html">Edition (in original Spanish)</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/avisos_modernized.html">Edition (in modernized Spanish)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/avisos_english.html">English Translation</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="$avisos_english='yes'">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/intro.avisos.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/avisos.html">Edition (in original Spanish)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/avisos_modernized.html">Edition (in modernized Spanish)</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2014/editions/avisos.xml">Edition XML</a>
                    </li>
                </ul>

</xsl:when>
            <xsl:when test="$avisos_modernized='yes'">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/intro.avisos.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/avisos.html">Edition (in original Spanish)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/avisos_english.html">English Translation</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2014/editions/avisos.xml">Edition XML</a>
                    </li>
                </ul>
                
            </xsl:when>
            
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/intro.avisos.html">Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2014/editions/avisos_modernized.html">Edition (in modernized Spanish)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2014/editions/avisos_english.html">English Translation</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2014/editions/avisos.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')"/>
            <xsl:when test="$avisos_english='yes'"/>
            <xsl:when test="$avisos_modernized='yes'"><a class="modernizedLink" href="{$siteroot}2014/editions/avisos.html">
                <div class="modernizedLink">Highlight text that has been modernized</div></a>
                <a class="modernizedKey"><div class="modernizedKey"><span class="text">Hover over the text to see original Spanish form</span><ul class="keyList"><li><span  style="background-color: #ff9900;">&#160;&#160;&#160;</span> = expanded abbreviation</li>
                    <li><span style="background-color: #cc0000;">&#160;&#160;&#160;</span> = regularized spelling</li>
                    <li><span style="background-color: #66cc66;">&#160;&#160;&#160;</span> = corrected text</li>
                    <li><span style="color: #1896fb;">blue text</span> = supplied by editor</li></ul></div></a></xsl:when>
            </xsl:choose>
    </xsl:template>
    <!--volume citation-->
    <xsl:template name="volCitation">
        <h5>2014, Volume 35</h5>
    </xsl:template>
    <xsl:template match="//tei:TEI/tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="parent::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='avisos'">
                <!--unique div identifier-->
                <div class="avisos">
                    <xsl:choose>
                        <xsl:when test="$avisos_english='yes'">
                            <div lang="english" class="avisos_english">
                                <h1>English Translation</h1>
                                <!--<span class="symbolExplanation">[Click on the <span style="color:#d12a1b;">&#8620;</span> before each paragraph to reveal the original Spanish text of the paragraph]</span>-->
                                <xsl:apply-templates select=".//tei:text[@xml:id='englishtranslation']"/>
                            </div>
                            <!--english notes -->
                            <xsl:if test="//tei:text[2]/descendant::tei:note">
                                <div class="notesList" id="english">
                                    <h2>Notes</h2>
                                    <ol>
                                        <xsl:for-each select="//tei:text[2]//tei:note[@type = 'editorial']">
                                            <xsl:variable name="noteNumber">
                                                <xsl:number
                                                    count="//tei:text[2]//tei:note[@type = 'editorial']"
                                                    level="any"/>
                                            </xsl:variable>
                                            <li>
                                                <span class="note_authorial">
                                                    <a>
                                                        <xsl:attribute name="name">
                                                            <xsl:text>note</xsl:text>
                                                            <xsl:value-of select="$noteNumber"/>
                                                        </xsl:attribute>
                                                    </a>
                                                    <xsl:apply-templates/>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:text>#ref</xsl:text>
                                                            <xsl:value-of select="$noteNumber"/>
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
                                    <h2>Translation Notes</h2>
                                    <ol class="upper-latin">
                                        <xsl:for-each select="//tei:text[2]//tei:note[@type = 'translational']">
                                            <xsl:variable name="translationalNoteNumber">
                                                <xsl:number
                                                    count="//tei:text[2]//tei:note[@type = 'translational']"
                                                    level="any" format="A"/>
                                            </xsl:variable>
                                            <li>
                                                <span class="note_authorial">
                                                    <a>
                                                        <xsl:attribute name="name">
                                                            <xsl:text>note</xsl:text>
                                                            <xsl:value-of select="$translationalNoteNumber"/>
                                                        </xsl:attribute>
                                                    </a>
                                                    <xsl:apply-templates/>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:text>#ref</xsl:text>
                                                            <xsl:value-of select="$translationalNoteNumber"/>
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
                            </xsl:if></xsl:when>
                        <xsl:otherwise>
                            <div><xsl:attribute name="lang">spanish</xsl:attribute><xsl:attribute name="class">avisos_spanish<xsl:if test="$avisos_modernized='yes'">_modernized</xsl:if></xsl:attribute><xsl:if test="$avisos_modernized='yes'"><h1>Modernized and annotated Spanish text</h1>
                            </xsl:if>
                                <xsl:apply-templates select=".//tei:text[@xml:id='spanish']"/>
                            </div>
                            <!--spanish notes -->
                            <xsl:choose><xsl:when test="$avisos_modernized='yes'"><xsl:if test="//tei:text[following-sibling::tei:text]/descendant::tei:note">
                                <div class="notesList" id="spanish">
                                    <h2>Notes</h2>
                                    <ol>
                                        <xsl:for-each
                                            select="//tei:text[following-sibling::tei:text]//tei:note[@type = 'editorial']">
                                            <xsl:variable name="noteNumber">
                                                <xsl:number
                                                    count="//tei:text[following-sibling::tei:text]//tei:note[@type = 'editorial']"
                                                    level="any"/>
                                            </xsl:variable>
                                            <li>
                                                <span class="note_authorial">
                                                    <a>
                                                        <xsl:attribute name="name">
                                                            <xsl:text>note</xsl:text>
                                                            <xsl:value-of select="$noteNumber"/>
                                                        </xsl:attribute>
                                                    </a>
                                                    <xsl:apply-templates/>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:text>#ref</xsl:text>
                                                            <xsl:value-of select="$noteNumber"/>
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
                            </xsl:if></xsl:when></xsl:choose></xsl:otherwise>
                    </xsl:choose>
                 
                </div>
            </xsl:when>
            <xsl:when test="$fileIDsubstring='intro.avisos'">
                <div class="introavisos">
                    <xsl:apply-templates/>
                    <!--intro avisos notes-->
                    <xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>
                                <xsl:for-each select="//tei:note[@type ='authorial']">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:note[@type ='authorial']"
                                            level="any"/>
                                    </xsl:variable>
                                    <li>
                                        <span class="note_authorial">
                                            <a>
                                                <xsl:attribute name="name">
                                                  <xsl:text>note</xsl:text>
                                                  <xsl:value-of select="$noteNumber"/>
                                                </xsl:attribute>
                                            </a>
                                            <xsl:apply-templates/>
                                            <a>
                                                <xsl:attribute name="href">
                                                  <xsl:text>#ref</xsl:text>
                                                  <xsl:value-of select="$noteNumber"/>
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
                    </xsl:if>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--head-->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose><xsl:when test="parent::tei:div"><h2><xsl:apply-templates/></h2></xsl:when><xsl:otherwise><h1>
            <xsl:apply-templates/>
        </h1></xsl:otherwise></xsl:choose>
    </xsl:template>
    <!--page breaks-->
    <xsl:template match="//tei:pb">
        <xsl:choose><xsl:when test="$avisos_modernized='yes'"></xsl:when><xsl:otherwise><span class="pagebreak">
            <span class="pageid">[fol.<xsl:value-of select="./@n" />]</span><!--folio numbers-->
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>avisos/pages/viewsize/</xsl:text>
                        <xsl:text>avisos_</xsl:text>
                        <xsl:value-of select="@n"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>avisos/pages/thumbs/</xsl:text>
                            <xsl:text>avisos_</xsl:text>
                            <xsl:value-of select="@n"/>
                            <xsl:text>_thumbs.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>avisos/pages/viewsize/</xsl:text>
                        <xsl:text>avisos_</xsl:text>
                        <xsl:value-of select="@n"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Page</xsl:text>
                </a>
            </span>
            <br/>
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>avisos/pages/fullsize/</xsl:text>
                        <xsl:text>avisos_</xsl:text>
                        <xsl:value-of select="@n"/>
                        <xsl:text>.JPG</xsl:text><!--not sure why this is getting capitolized in the image filenames once they hit the server-->
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
        </span></xsl:otherwise></xsl:choose>
    </xsl:template>
    <!--avisos spanish note pointers-->
    <xsl:template
        match="//tei:text//tei:text[following-sibling::tei:text]//tei:note[@type = 'editorial']">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:if test="$avisos_modernized='yes'"><xsl:choose>
            <xsl:when test="$fileIDsubstring='avisos'">
                <xsl:variable name="noteNumber">
                    <!--This isn't the way it is in the XSLT for other editions, but I had a hard time getting it to work the other way; it was probably just me though.-->
                    <xsl:number value="count(.//preceding::tei:note[@type = 'editorial']) + 1"/>
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
                </a>
            </xsl:when>
            <xsl:otherwise>
                <div class="note">
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
                </div>
            </xsl:otherwise>
        </xsl:choose></xsl:if>
    </xsl:template>
    <!--avisos english note pointers-->
    <xsl:template match="//tei:text//tei:text[2]//tei:note[@type = 'editorial']">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='avisos'">
                <xsl:variable name="noteNumber">
                    <!--This isn't the way it is in the XSLT for other editions, but I had a hard time getting it to work the other way; it was probably just me though.-->
                    <xsl:number
                        value="count(preceding::tei:note[@type = 'editorial'][ancestor::tei:text[preceding-sibling::tei:text]]) + 1"/>
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
                </a>
            </xsl:when>
            <xsl:otherwise>
                <div class="note">
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
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
<!--avisos English translational notes pointers-->
    <xsl:template match="//tei:text//tei:text[2]//tei:note[@type = 'translational']">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='avisos'">
                <xsl:variable name="translationalNoteNumber">
                    <!--This isn't the way it is in the XSLT for other editions, but I had a hard time getting it to work the other way; it was probably just me though.-->
                    <xsl:number
                        value="count(preceding::tei:note[@type = 'translational'][ancestor::tei:text[preceding-sibling::tei:text]]) + 1" format="A"/>
                </xsl:variable>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>#note</xsl:text>
                        <xsl:value-of select="$translationalNoteNumber"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:text>ref</xsl:text>
                        <xsl:value-of select="$translationalNoteNumber"/>
                    </xsl:attribute>
                    <span class="noteRef">[<xsl:value-of select="$translationalNoteNumber"/>]</span>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <div class="note">
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
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <!--avisos intro note pointers-->
    <xsl:template match="//tei:text//tei:note[@type = 'authorial']">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='intro.avisos'">
                <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:note[@type='authorial']" level="any"/>
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
                </a>
            </xsl:when>
            <xsl:when test="$fileIDsubstring='avisos'">
                <xsl:choose><xsl:when test="$avisos_modernized='yes'"></xsl:when><xsl:otherwise><xsl:for-each select="."><span><xsl:attribute name="class">add_<xsl:value-of select="@place"/></xsl:attribute><xsl:apply-templates/></span></xsl:for-each></xsl:otherwise></xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!--choice-->
    <!--original and regularized-->
    
    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="$avisos_modernized='yes'">
                <xsl:choose>
                    <xsl:when test="child::tei:orig">
                        <span class="avisos_origReg">
                            <xsl:attribute name="title">
                                <xsl:value-of select="descendant::tei:orig"
                                />
                            </xsl:attribute>
                            <xsl:for-each select="descendant::tei:orig">
                                <span class="avisos_orig">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::tei:reg">
                                <span class="avisos_reg">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="child::tei:abbr">
                        <span class="avisos_abbrExpan">
                            <xsl:attribute name="title">
                                <xsl:value-of select="descendant::tei:abbr"
                                 />
                            </xsl:attribute>
                            <xsl:for-each select="descendant::tei:abbr">
                                <span class="avisos_abbr">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::tei:expan">
                                <span class="avisos_expan">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                    <xsl:when test="child::tei:sic">
                        <span class="avisos_sicCorr">
                            <xsl:attribute name="title">
                                <xsl:value-of select="descendant::tei:sic"
                                />
                            </xsl:attribute>
                            <xsl:for-each select="descendant::tei:sic">
                                <span class="avisos_sic">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::tei:corr">
                                <span class="avisos_corr">
                                    <xsl:apply-templates />
                                </span>
                            </xsl:for-each>
                        </span>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="child::tei:orig">
                    <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="child::tei:reg" />
                <xsl:for-each select="child::tei:abbr">
                    <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="child::tei:expan" />
                <xsl:for-each select="child::tei:sic">
                    <xsl:apply-templates />
                </xsl:for-each>
                <xsl:for-each select="child::tei:corr" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--unlcear and gap tags-->
    <xsl:template match="//tei:gap">
        <span class="gap"><xsl:text>[. . .]</xsl:text></span><!--added-->
    </xsl:template>
    
    <xsl:template match="//tei:unclear">
       <!--do we need to differentiate between the different reasons for unclearness?-->
                <span class="unclear_high">
                    <xsl:apply-templates/>
                </span>
    </xsl:template>
    <!--end uclear and gap tags-->
    <!--supplied text-->
    
    <!--end supplied text-->
   
<xsl:template match="//tei:foreign"><i><xsl:apply-templates/></i></xsl:template>
    <xsl:template match="//tei:body//tei:title[@level='m']"><i><xsl:apply-templates/></i></xsl:template>
    <xsl:template match="//tei:body//tei:title[@level='a']">"<xsl:apply-templates/>"</xsl:template>
    
    <!--new stuff-->
    <!--quotes around title in intro-->
    <xsl:template match="//tei:title[@level = 'u']">
        <xsl:text>"</xsl:text><xsl:apply-templates/><xsl:text>"</xsl:text>
    </xsl:template>
    <!--get rid of deleted text-->
    <xsl:template match="//tei:del">
        <xsl:choose>
            <xsl:when test="$avisos_modernized='yes'">
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test=".[@type = 'strikeout']"><span class="del_strikethrough"><xsl:apply-templates/></span></xsl:when>
                    <xsl:when test=".[@rend = 'overwritten']"><span class="del_overwrite"><xsl:apply-templates/></span></xsl:when>
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--mentioned elements-->
    <xsl:template match="//tei:mentioned">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    <!--carets-->
    <!--I'm not entirely sure how to handle this, I don't know how he wants no_caret adds displayed? Should they just be displayed above the line without a caret?-->
    <xsl:template match="//tei:add">
        <xsl:choose>
            <xsl:when test="$avisos_modernized='yes'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@type='caret'">
                    <span class="insertionMark">^</span>
                </xsl:if>
                <span>
                    <xsl:attribute name="class">add_above</xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:supplied"><xsl:choose>
        <xsl:when test="$avisos_modernized='yes'"><xsl:choose><xsl:when test="@reason='editorial_choice'"><span class="avisos_supplied_editorial_choice"><xsl:apply-templates/></span></xsl:when><xsl:otherwise><xsl:apply-templates/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><span class="avisos_supplied"><xsl:apply-templates/></span></xsl:otherwise>
    </xsl:choose>
        
</xsl:template>

</xsl:stylesheet>