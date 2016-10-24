<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <xsl:include href="../../../../legacy/template_xslt/base.xsl"/>
    <xsl:param name="markonthewall_version">undefined</xsl:param>

    <xsl:template match="//tei:teiHeader"/>
    <xsl:template name="essayNav"/>
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
                        <a href="{$siteroot}2014/editions/markonthewall_ho17.html">Edition</a>
                    </li>
                    <!--<li id="editionNav2">
                        <a href="http://juxtacommons.org/shares/WHf02o" target="new">Compare Versions</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/map.markonthewall.html" target="new">Map</a>
                    </li>-->
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2014/editions/intro.markonthewall.html">Introduction</a>
                    </li>

                    <li id="editionNav4">
                        <a href="{$siteroot}2014/editions/markonthewall.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2014, Volume 35</h5>
    </xsl:template>

    <!-- To draw the page images for each witness -->

    <xsl:template match="//tei:facsimile">
        <xsl:variable name="surfaceGrpID">
            <xsl:for-each select="child::tei:surfaceGrp/attribute::corresp">
                <xsl:value-of select="substring-after(.,'#')"/>
            </xsl:for-each>
        </xsl:variable>

        <span class="markonthewall_witness_thumbs">
            <h4>Page Images for this Witness:</h4>
            <xsl:for-each
                select="child::tei:surfaceGrp[@corresp = $markonthewall_version]/descendant::tei:surface">
                <span class="thumbnail">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>markonthewall/pages/viewsize/</xsl:text>
                            <xsl:value-of select="child::tei:graphic/attribute::url"/>
                        </xsl:attribute>
                        <img>
                            <xsl:attribute name="src">
                                <xsl:text>markonthewall/pages/thumbs/</xsl:text>
                                <xsl:value-of
                                    select="substring-before(child::tei:graphic/attribute::url,'.jpg')"/>
                                <xsl:text>_thumb.jpg</xsl:text>
                            </xsl:attribute>
                        </img>
                    </a>
                </span>
            </xsl:for-each>
        </span>


    </xsl:template>


    <!-- The witness name is needed for each edition which, like "Mark on the Wall," uses an apparatus entry system to track variations among multiple witnesses -->
    <xsl:template name="witnessName">
        <span class="markonthewall_witnessName">
            <b>Current Witness:&#160;</b>
            <xsl:for-each select="//tei:listWit/tei:witness">
                <xsl:choose>
                    <xsl:when test="./attribute::xml:id=substring($markonthewall_version,2)">
                        <xsl:apply-templates/>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </span>
        <!--<xsl:call-template name="markonthewallpageimage"/>-->
    </xsl:template>

    <xsl:template match="//tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='markonthewall'">
                <div class="markonthewall">

                    <xsl:if test="./descendant::tei:app/descendant::tei:rdg">
                        <span class="VariantSymbolExplanation"><span style="color: #007a32">green text</span> = presence of grammatical or stylistic alteration</span><span class="VariantSymbolExplanation"><span style="color: #d12a1b">red text</span> = presence of variance and annotated note</span>
                    </xsl:if>
                    <xsl:apply-templates/>
                    <!--Gabi editing-->
                    <xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>
                                <xsl:for-each select="//tei:note[@type='editorial']">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:note[@type='editorial']"
                                            level="any"/>
                                    </xsl:variable>
                                    <li>
                                        <span class="note_editorial">
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
                                                        >template_images/goback.png</xsl:attribute>
                                                    <xsl:attribute name="alt">Go back</xsl:attribute>
                                                </img>
                                            </a>
                                        </span>
                                    </li>
                                    
                                </xsl:for-each>
                            </ol>
                        </div>
                    </xsl:if>
                    <!--done-->
                </div>
            </xsl:when>

            <xsl:when test="$fileIDsubstring='intro.markonthewall'">
                <div class="intromarkonthewall">
                    <xsl:apply-templates/>
                    <xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>



                                <xsl:for-each select="//tei:note[@type='editorial']">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:note[@type='editorial']"
                                            level="any"/>
                                    </xsl:variable>
                                    <li>
                                        <span class="note_editorial">
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
                                                  >template_images/goback.png</xsl:attribute>
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
        </xsl:choose>

    </xsl:template>





    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main'">
<xsl:choose><xsl:when test="parent::tei:div"><h2><xsl:apply-templates/></h2></xsl:when><xsl:otherwise>
                <h1>
                    <xsl:apply-templates/>
                </h1></xsl:otherwise></xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:app">
        <xsl:for-each select="child::tei:rdg">
            <xsl:variable name="witName">
                <xsl:value-of select="./attribute::wit"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="contains($witName, $markonthewall_version)">

<div class="showNote">
                        <a href="#" onclick="return false;">
                            <xsl:choose>
                                <xsl:when test="contains(.,'&#160;')">
                                    <span class="emptyVariantSymbol">
                                        <img src="{$siteroot}/template_images/sep.png"
                                            alt="symbol indicating variant note"/>
                                    </span>
                                </xsl:when>
                                <xsl:when test="parent::tei:app/child::tei:note[@type='annotation']"><span class="annotatedNote"><xsl:apply-templates select="."/></span></xsl:when>
                                
                                <xsl:otherwise>
                                    <span class="variantNote" style="color: #007a32"><xsl:apply-templates/></span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </div>

                    

                    <div>
                        <xsl:attribute name="class">appEntry</xsl:attribute>
                        <a href="#" class="closenote">X</a>



                        <div class="appRdg">
                            <xsl:for-each select="./parent::tei:app/child::tei:rdg">
                                <xsl:variable name="currentWitName">
                                    <xsl:value-of select="./attribute::wit"/>
                                </xsl:variable>
                                <span>
                                    <xsl:attribute name="class">witRdg<xsl:if
                                            test="position()=1 or position()=3 or position()=5"
                                            >odd</xsl:if></xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="contains(.,'&#160;')">
                                            <span class="emptyVariant">[no text in this
                                                witness]</span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <span class="witness">WITNESS: <xsl:for-each
                                            select="//tei:witness[@xml:id = substring-after($currentWitName,'#')]">
                                            <xsl:value-of select="."/></xsl:for-each></span>
                                </span>
                            </xsl:for-each>
                            <xsl:if test="following-sibling::tei:note">
                                <div class="rdgNote">
                                    <h4>Note</h4>
                                    <xsl:apply-templates select="following-sibling::tei:note"/>
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>




    <!-- Notes and pointers -->
    <xsl:template match="//tei:div[@type='notes']">
        <div class="notesList">
            <h2>Notes</h2>
            <xsl:apply-templates/>
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
                    <span class="noteRefIntro">[<xsl:value-of
                            select="substring-after(attribute::target,'#note')"/>]</span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef">
                        <!-- <a>
                    <xsl:attribute name="name"> <xsl:value-of select="@xml:id" /></xsl:attribute>
                </a>-->
                            [<xsl:value-of select="substring-after(attribute::target,'#note')"/>]
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="parent::tei:app">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='editorial'">
                <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:note[@type='editorial']" level="any"/>
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
                            <xsl:attribute name="src">template_images/goback.png</xsl:attribute>
                            <xsl:attribute name="alt">Go back</xsl:attribute>
                        </img>
                    </a>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Special linebreaks for poetic lines -->
    <xsl:template match="//tei:l//tei:lb"><br/>&#160;&#160;&#160;&#160;&#160;</xsl:template>

    <!-- signatures and bylines -->
    <xsl:template match="//tei:signed">
        <span class="signed">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<!-- <seg> styling for <rdg> with paragraph breaks in them -->

<xsl:template match="//tei:seg"><span><xsl:attribute name="class"><xsl:value-of select="./attribute::type"/></xsl:attribute><xsl:apply-templates/></span></xsl:template>




    <!-- page images -->
    <!--<xsl:template name="markonthewallpageimage">
                <span class="markonthewallpageimage">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>markonthewall/pages/viewsize/</xsl:text>
                        <xsl:value-of select="substring($markonthewall_version,2)" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>markonthewall/pages/thumbs/</xsl:text>
                            <xsl:value-of select="substring($markonthewall_version,2)" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>markonthewall/pages/viewsize/</xsl:text>
                        <xsl:value-of select="substring($markonthewall_version,2)" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Page</xsl:text>
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>markonthewall/pages/fullsize/</xsl:text>
                        <xsl:value-of select="substring($markonthewall_version,2)" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
        </span>
    </xsl:template>-->

</xsl:stylesheet>
