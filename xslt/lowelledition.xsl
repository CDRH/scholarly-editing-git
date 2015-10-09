<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <xsl:include href="base.xsl"/>
    <xsl:param name="lowelledition_version">undeclared</xsl:param>

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
                        <a href="{$siteroot}2015/editions/lowelledition_wit-Courier.html">Edition</a>
                    </li>
                    
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2015/editions/intro.lowelledition.html">Introduction</a>
                    </li>

                    <li id="editionNav4">
                        <a href="{$siteroot}2015/editions/lowelledition.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2015, Volume 36</h5>
    </xsl:template>

    <!-- To draw the page images for each witness -->

    <xsl:template match="//tei:facsimile">
        <xsl:variable name="surfaceGrpID">
            <xsl:for-each select="child::tei:surfaceGrp/attribute::corresp">
                <xsl:value-of select="substring-after(.,'#')"/>
            </xsl:for-each>
        </xsl:variable>

        <span class="lowelledition_witness_thumbs">
            <h4>Page Images for this Witness:</h4>
            <xsl:for-each
                select="child::tei:surfaceGrp[@corresp = $lowelledition_version]/descendant::tei:surface">
                <span class="thumbnail">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>lowelledition/pages/viewsize/</xsl:text>
                            <xsl:value-of select="child::tei:graphic/attribute::url"/>
                        </xsl:attribute>
                        <xsl:attribute name="title">Open &lt;a href="lowelledition/pages/fullsize/<xsl:value-of
                                select="substring-before(child::tei:graphic/attribute::url,'.jpg')"/>.jpg" target="new"&gt;full size image&lt;/a&gt;</xsl:attribute>
                        <img>
                            <xsl:attribute name="src">
                                <xsl:text>lowelledition/pages/thumbs/</xsl:text>
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


    <!-- The witness name is needed for each edition which, like "Mark on the Wall" in the 2014 volume, uses an apparatus entry system to track variations among multiple witnesses -->
    <xsl:template name="witnessName">
        <span class="lowelledition_witnessName">
            <b>Current Witness:&#160;</b>
            <xsl:for-each select="//tei:listWit/tei:witness">
                <xsl:choose>
                    <xsl:when test="./attribute::xml:id=substring($lowelledition_version,2)">
                        <xsl:apply-templates/>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </span>
    </xsl:template>

    <xsl:template match="//tei:text">
        <xsl:variable name="fileIDsubstring">
            <xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='lowelledition'">
                <div class="lowelledition">

                    <xsl:if test="./descendant::tei:app/descendant::tei:rdg">
                        <div class="variantKey"><span class="VariantSymbolExplanation"><span style="color: #007a32">green text</span> = presence of punctuation variance</span><span class="VariantSymbolExplanation"><span style="color: #d12a1b">red text</span> = presence of substantive variance</span><span class="VariantSymbolExplanation"><span style="color: #1896fb">blue text</span> = presence of orthographic variance</span><span class="VariantSymbolExplanation"><span style="color: #ff9300">orange text</span> = presence of formatting alteration</span></div>
                                      </xsl:if>
                    <xsl:apply-templates/>
                  
                    <xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>
                                <xsl:for-each select="//tei:note[@type='editorial' or @type='annotation']">
                                    <xsl:variable name="noteNumber">
                                        <xsl:number count="//tei:note[@type='annotation' or @type='editorial'][contains(ancestor::tei:rdg/attribute::wit, $lowelledition_version) or not(ancestor::tei:rdg)]" level="any"/>
                                    </xsl:variable>
                                    <xsl:if test="contains(ancestor::tei:rdg/attribute::wit, $lowelledition_version) or not(ancestor::tei:rdg)"><li>
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
                                                        >images/goback.png</xsl:attribute>
                                                    <xsl:attribute name="alt">Go back</xsl:attribute>
                                                </img>
                                            </a>
                                        </span>
                                    </li></xsl:if>
                                    
                                </xsl:for-each>
                                
                            </ol>
                        </div>
                    </xsl:if>
                    
                </div>
            </xsl:when>

            <xsl:when test="$fileIDsubstring='intro.lowelledition'">
                <div class="introlowelledition">
                    <xsl:apply-templates/>
                    <xsl:if test="descendant::tei:note">
                        <div class="notesList">
                            <h2>Notes</h2>
                            <ol>
<xsl:for-each select="//tei:text//tei:note">
                                    <xsl:variable name="noteNumber">
                                        <xsl:value-of select="@n"/>
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
        </xsl:choose>

    </xsl:template>





    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main'">
                <h1>
                    <xsl:apply-templates/>
                </h1>
            </xsl:when>
             <xsl:when test="./attribute::type='sub'"><h2><xsl:apply-templates/></h2></xsl:when>
            <xsl:otherwise>
                <h3><xsl:apply-templates/></h3>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:app">
        <xsl:choose>
            <xsl:when test="child::tei:rdg/child::tei:note[@type='authorial']"><xsl:choose><xsl:when test="contains(child::tei:rdg/attribute::wit, $lowelledition_version)"><xsl:apply-templates/></xsl:when></xsl:choose></xsl:when>
            <xsl:otherwise><xsl:for-each select="child::tei:rdg">
            <xsl:variable name="witName">
                <xsl:value-of select="./attribute::wit"/>
            </xsl:variable>
            <xsl:choose>

                <xsl:when test="contains($witName, $lowelledition_version)">

<!--<div class="showNote">
                        <a href="#" onclick="return false;">-->
                            <xsl:choose>
                                <xsl:when test="parent::tei:app/attribute::type='base'">
                                    <!--<div class="showNote">
                                        <a href="#" onclick="return false;">-->
                                            <span class="baseNote" style="color: black">
                                                <xsl:apply-templates />
                                            </span>
                                        <!--</a>
                                    </div>-->
                                </xsl:when>
                                
                                <xsl:when test="parent::tei:app/attribute::type='alteration'">
                                    <div class="showNote">
                                        <a href="#" onclick="return false;">
                                            <span class="alterationNote" style="color: #ff9300">
                                            <xsl:apply-templates />
                                            </span>
                                        </a>
                                    </div>
                                </xsl:when>
                                <xsl:when test="parent::tei:app/attribute::type='substantive'">
                                    <xsl:choose>
                                        <xsl:when test="descendant::tei:note[@type='annotation']">
                                            <div class="substantive_with_annotation">
                                                <span class="substantiveNote">
                                                  <xsl:apply-templates />
                                                </span>
                                            </div><div class="showNote"><a href="#" onclick="return false;" class="substantive_with_annotationLink">See other witnesses for this passage</a></div></xsl:when>
                                        <xsl:otherwise>
                                            <div class="showNote">
                                                <a href="#" onclick="return false;">
                                                  <span class="substantiveNote">
                                                  <xsl:apply-templates />
                                                  </span>
                                                </a>
                                            </div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="parent::tei:app/attribute::type='punctuation'">
                                    <div class="showNote">
                                        <a href="#" onclick="return false;">
                                            <span class="punctuationNote" style="color: #007a32">
                                                <xsl:apply-templates />
                                            </span>
                                        </a>
                                    </div>
                                </xsl:when>
                                <xsl:when test="parent::tei:app/attribute::type='orthographic'">
                                    <div class="showNote">
                                        <a href="#" onclick="return false;">
                                            <span class="orthographicNote" style="color: #1896fb"><xsl:apply-templates />
                                            </span>
                                        </a>
                                    </div>
                                </xsl:when>
                            </xsl:choose>
                        <!--</a>
                    </div>-->

                    

                    <div>
                        <xsl:attribute name="class">appEntry</xsl:attribute>
                        <a href="#" class="closenote">X</a>



                        <div class="appRdg">
                                <xsl:choose>
                                    <xsl:when test="parent::tei:app/attribute::type='substantive'"><h2>Substantive Variance</h2></xsl:when><xsl:when test="parent::tei:app/attribute::type='orthographic'"><h2>Orthographic Variance</h2></xsl:when><xsl:when test="parent::tei:app/attribute::type='punctuation'"><h2>Punctuation Variance</h2></xsl:when><xsl:when test="parent::tei:app/attribute::type='alteration'"><h2>Formatting Alteration</h2></xsl:when>
                                </xsl:choose>
                            <xsl:for-each select="./parent::tei:app/child::tei:rdg">
                                <xsl:variable name="currentWitName">
                                    <xsl:value-of select="substring-after(./attribute::wit,'#')"/>
                                </xsl:variable>
                                <span>
                                    <xsl:attribute name="class">witRdg<xsl:if
                                        test="position()=1 or position()=3 or position()=5 or position()=7"
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
                                    <span class="witness">WITNESS<xsl:if test="contains($currentWitName,' ')">ES</xsl:if>: <xsl:for-each
                                            select="//tei:witness[contains($currentWitName, @xml:id)]">
                                            <span class="witnessResults"><xsl:apply-templates select="."/></span></xsl:for-each></span>
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
        </xsl:for-each></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>




    <!-- Notes and pointers -->
    <xsl:template match="//tei:div[@type='notes']">
        <div class="notesList">
            <h2>Notes</h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
  <xsl:template match="//tei:note">
        <xsl:choose>
            <xsl:when test="starts-with(ancestor::tei:TEI//tei:idno[@type='file'],'intro')">
                <xsl:variable name="noteNumber">
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
                </a>
</xsl:when>
            <xsl:when test="parent::tei:app">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='editorial' or @type='annotation'">
                
                <xsl:variable name="noteNumber">
                    <xsl:number count="//tei:note[@type='annotation' or @type='editorial'][contains(ancestor::tei:rdg/attribute::wit, $lowelledition_version) or not(ancestor::tei:rdg)]" level="any"/>
                </xsl:variable>
                <xsl:if test="contains(ancestor::tei:rdg/attribute::wit, $lowelledition_version) or not(ancestor::tei:rdg)">
                 <a>
                    <xsl:attribute name="href">
                        <xsl:text>#note</xsl:text>
                        <xsl:value-of select="$noteNumber"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:text>ref</xsl:text>
                        <xsl:value-of select="$noteNumber"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">tooltip</xsl:attribute>
                    <!--<span class="noteRef">-->[<xsl:value-of select="$noteNumber"/>]<!--</span>--><span><xsl:apply-templates/></span>
                </a></xsl:if>
            </xsl:when>
            <xsl:when test="@type='authorial'">
                    <xsl:if test="$lowelledition_version='#wit-book'"><span class="AuthorialNoteRef">*</span></xsl:if>
                <span><xsl:attribute name="class">note_authorial_<xsl:value-of select="substring-after($lowelledition_version,'#')"/></xsl:attribute><xsl:if test="$lowelledition_version='#wit-book'">*</xsl:if><xsl:apply-templates/></span>
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
    <!-- Special linebreaks for poetic lines -->
    <!--<xsl:template match="//tei:l//tei:lb"><span class="poetryLinebreak"><br/>&#160;</span></xsl:template>-->

    <!-- signatures and bylines -->
    <xsl:template match="//tei:signed">
        <span class="signed">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<!-- <seg> styling for <rdg> with paragraph breaks in them -->

<xsl:template match="//tei:seg"><span><xsl:attribute name="class"><xsl:value-of select="./attribute::type"/></xsl:attribute><xsl:apply-templates/></span></xsl:template>



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
