<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../template_xslt/base.xsl" />
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
                        <a href="{$siteroot}2013/editions/sevenplanets.html">Edition</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2013/editions/plaintext.sevenplanets.rtf">Download Text (RTF)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/glossary.sevenplanets.html">Linguistic Glossary</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2013/editions/sevenplanets.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="starts-with($idno,'glossary.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/intro.sevenplanets.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2013/editions/sevenplanets.html">Edition</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/plaintext.sevenplanets.rtf">Download Text (RTF)</a>
                    </li>
                    
                    <li id="editionNav4">
                        <a href="{$siteroot}2013/editions/sevenplanets.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/intro.sevenplanets.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2013/editions/plaintext.sevenplanets.rtf">Download Text (RTF)</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/glossary.sevenplanets.html">Linguistic Glossary</a>
                    </li>
                    <li id="editionNav4">
                        <a href="{$siteroot}2013/editions/sevenplanets.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
<xsl:choose>
    <xsl:when test="starts-with($idno,'intro.')"></xsl:when>
    <xsl:when test="starts-with($idno,'glossary.')"></xsl:when>
        <xsl:otherwise><xsl:choose>
            <xsl:when test="$sevenplanets_abbr='undefined'">
                <a class="abbrExpanLink" href="{$siteroot}2013/editions/sevenplanets_abbrexpan.html">
                    <div class="abbrExpanLink">expand all abbreviations</div>
                </a>
            </xsl:when>
            <xsl:when test="$sevenplanets_abbr='expand'">
                <a class="abbrExpanLink" href="{$siteroot}2013/editions/sevenplanets.html">
                    <div class="abbrExpanLink">compress all abbreviations</div>
                </a>
            </xsl:when>
        </xsl:choose></xsl:otherwise></xsl:choose>

    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2013, Volume 34</h5>
    </xsl:template>

<!-- To have a special div for distinctive body styling -->

    <xsl:template match="//tei:body">
        <xsl:variable name="fileIDsubstring"><xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring='sevenplanets'">
                <div class="sevenplanets">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
        
        
    </xsl:template>

    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            
            <xsl:when test="./parent::tei:div/parent::tei:div">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:when test="./parent::tei:div/parent::tei:body">
                <h1>
                    <xsl:apply-templates />
                </h1>
            </xsl:when>
            <!--<xsl:when test="./attribute::type='sub'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>-->
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    
    <!-- pagebreaks -->



    <xsl:template match="//tei:pb">
        
        <xsl:choose><xsl:when test="attribute::type='verso'"><span class="pagebreak">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>sevenplanets/pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                    <xsl:text>View pages </xsl:text><xsl:value-of select="substring(@facs,8,11)" />
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>sevenplanets/pages/fullsize/</xsl:text>
                        <xsl:value-of select="@facs" />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:text>_blank</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Full size in new window</xsl:text>
                </a>
            </span>
        </span></xsl:when>
            <xsl:when test="attribute::type='recto'"><xsl:choose><xsl:when test="attribute::n='f122r'"><span class="pagebreak">
                <span class="thumbnail">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                        <img>
                            <xsl:attribute name="src">
                                <xsl:text>sevenplanets/pages/thumbs/</xsl:text>
                                <xsl:value-of select="@facs" />
                                <xsl:text>_thumb.jpg</xsl:text>
                            </xsl:attribute>
                        </img>
                    </a>
                </span>
                <span class="viewsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                        <xsl:text>View pages </xsl:text><xsl:value-of select="substring(@facs,8,11)" />
                    </a>
                </span>
                <br />
                <span class="fullsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>sevenplanets/pages/fullsize/</xsl:text>
                            <xsl:value-of select="@facs" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:text>_blank</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Full size in new window</xsl:text>
                    </a>
                </span>
            </span></xsl:when></xsl:choose></xsl:when>

</xsl:choose>
        <span class="pageid"><xsl:text>[page id: </xsl:text><!--<a>
            <xsl:attribute name="href">
                <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                <xsl:value-of select="@facs" />
                <xsl:text>.jpg</xsl:text>
            </xsl:attribute>-->
            <xsl:value-of select="@n" /><!--</a>-->]</span>
    </xsl:template>




<!-- This template makes the <w> preceding the <ptr> a link that calls up a matching <entry> -->

<xsl:template match="//tei:w">
    <xsl:choose><xsl:when test="following-sibling::*[1][self::tei:ptr]">
<xsl:variable name="wContent">
    <xsl:for-each select="."><xsl:choose><xsl:when test="descendant::tei:pb"><xsl:value-of select="substring(.,1,5)"/><span class="pageid_special">[page id: 
        <span class="pageid_number"><xsl:value-of select="descendant::tei:orig/tei:pb/attribute::n" /></span>]</span><!--<xsl:apply-templates select="child::tei:pb"/>--><xsl:value-of select="substring(.,6,10)"/></xsl:when><xsl:otherwise><xsl:apply-templates/>&#160;</xsl:otherwise></xsl:choose></xsl:for-each>
        </xsl:variable>

    <xsl:for-each select="./following-sibling::tei:ptr[position()=1]">
        
        <xsl:variable name="ptrTarget">
            <xsl:for-each select="./attribute::target">
                <xsl:value-of select="substring-after(.,'#')"/>
            </xsl:for-each>
        </xsl:variable>
       
        
        
        <xsl:for-each select="//tei:superEntry[@type='glossary']">
            <xsl:for-each select="descendant::tei:entry">
                <xsl:variable name="entryID">
                    <xsl:for-each select="./attribute::xml:id">
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </xsl:variable>
                
                
                
                <xsl:if test="$entryID = $ptrTarget">
                    
                    <div class="showNote">
                        <!-- &#8620; &#9776;-->
                        
                        
                        <a href="#" onclick="return false;" class="gloss"><xsl:copy-of select="$wContent"/></a>
                        
                        
                    </div>
                    <div>
                        <xsl:attribute name="class">appEntry</xsl:attribute>
                        <a href="#" class="closenote">X</a>
                        
                        <xsl:for-each select="//.[@xml:id = $ptrTarget]">
                            <div class="rdgNote">
                                <h4>Gloss</h4>
                                <xsl:apply-templates select="//tei:entry[@xml:id = $ptrTarget]"/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
        
    </xsl:for-each><xsl:if test="descendant::tei:orig/tei:pb"><span class="pagebreak_special">
        <span class="thumbnail">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                    <xsl:value-of select="descendant::tei:orig/tei:pb/attribute::facs" />
                    <xsl:text>.jpg</xsl:text>
                </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                <img>
                    <xsl:attribute name="src">
                        <xsl:text>sevenplanets/pages/thumbs/</xsl:text>
                        <xsl:value-of select="descendant::tei:orig/tei:pb/attribute::facs" />
                        <xsl:text>_thumb.jpg</xsl:text>
                    </xsl:attribute>
                </img>
            </a>
        </span>
        <span class="viewsize">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                    <xsl:value-of select="descendant::tei:orig/tei:pb/attribute::facs" />
                    <xsl:text>.jpg</xsl:text>
                </xsl:attribute><xsl:attribute name="title">The manuscript images are displayed with the kind permission of the Master and the Fellows at the Trinity College Library</xsl:attribute>
                <xsl:text>View pages </xsl:text><xsl:value-of select="substring(descendant::tei:orig/tei:pb/attribute::facs,8,11)" />
            </a>
        </span>
        <span class="fullsize">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>sevenplanets/pages/fullsize/</xsl:text>
                    <xsl:value-of select="descendant::tei:orig/tei:pb/attribute::facs" />
                    <xsl:text>.jpg</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="target">
                    <xsl:text>_blank</xsl:text>
                </xsl:attribute>
                <xsl:text>Full size in new window</xsl:text>
            </a>
        </span>
    </span></xsl:if>


</xsl:when>
    <xsl:otherwise><xsl:apply-templates/>&#160;</xsl:otherwise>
</xsl:choose>

</xsl:template>

<!-- styles the glossary entries linked to the text -->
<xsl:template match="//tei:entry">
<span class="glossEntry">
<xsl:for-each select="./child::tei:form">
    <span class="glossEntryHead"><xsl:if test=".//child::tei:orth[.!='']"><xsl:value-of select="./child::tei:orth"/></xsl:if><xsl:if test="./child::tei:orth and ./child::tei:oVar"><xsl:if test=".//child::tei:orth[.!='']"><xsl:if test=".//child::tei:oVar[.!='']"> | </xsl:if></xsl:if></xsl:if><xsl:if test=".//child::tei:oVar[.!='']"><xsl:value-of select="./child::tei:oVar"/></xsl:if><xsl:if test=".//child::tei:pos[.!='']">, <em><xsl:value-of select="./child::tei:pos"/></em></xsl:if></span>
</xsl:for-each>
<xsl:for-each select="./child::tei:sense">
    <span class="glossDefinition"><b>Definition:</b>&#160;<xsl:for-each select="./child::tei:def"><xsl:apply-templates/></xsl:for-each></span>
    <xsl:if test=".//child::tei:etym[.!='']"><span class="glossEtym"><b>Etymology:</b>&#160;<xsl:for-each select="./child::tei:etym"><xsl:apply-templates/></xsl:for-each></span></xsl:if>
</xsl:for-each>

</span>

</xsl:template>



   
    

    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="child::tei:abbr">
                <xsl:for-each select="child::tei:abbr">
                    <xsl:choose>
                        <xsl:when test="$sevenplanets_abbr='expand'">
                            <span class="abbr">
                                <xsl:attribute name="title">
                                    <xsl:value-of select="." />
                                </xsl:attribute>
                               
                                <xsl:choose>
                                  
                                    <xsl:when test="following-sibling::tei:expan">
                                        <xsl:choose>
                                            <xsl:when
                                                test="following-sibling::tei:expan/child::tei:ex">
                                                <xsl:apply-templates
                                                  select="following-sibling::tei:expan" />
                                            </xsl:when>
                                            <xsl:when
                                                test="following-sibling::tei:expan[@cert='unknown']">
                                                <span class="unknownAbbr" style="color:gray">
                                                  <i>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:expan" />
                                                  </i>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <i>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:expan" />
                                                </i>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="abbr">
                                <xsl:attribute name="title">
                                    <xsl:value-of select="following-sibling::tei:expan" />
                                </xsl:attribute>
                                <span class="abbr_short"><xsl:apply-templates select="." /></span>
                                <span class="abbr_long"><!--<xsl:apply-templates select="following-sibling::tei:expan" />--><xsl:for-each select="following-sibling::tei:expan">
                                    <xsl:choose>
                                        <xsl:when
                                            test="./child::tei:ex">
                                            <xsl:apply-templates
                                                select="." />
                                        </xsl:when>
                                        <xsl:when
                                            test=".[@cert='unknown']">
                                            <span class="unknownAbbr" style="color:gray">
                                                <i>
                                                    <xsl:apply-templates
                                                        select="." />
                                                </i>
                                            </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <i>
                                                <xsl:apply-templates
                                                    select="." />
                                            </i>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each></span>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="child::tei:orig">
                <xsl:for-each select="child::tei:orig">
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>



<xsl:template match="//tei:expan/child::tei:ex">
<xsl:choose>
    <xsl:when test="attribute::cert='unknown'"><span style="color:gray"><i><xsl:apply-templates/></i></span></xsl:when>
    <xsl:otherwise><i><xsl:apply-templates/></i></xsl:otherwise>
</xsl:choose>

</xsl:template>

    
    <xsl:template match="//tei:superEntry"></xsl:template>

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
            <xsl:choose><xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]"><span class="noteRefIntro">[<xsl:value-of
                    select="substring-after(attribute::target,'#note')" />]
            </span></xsl:when></xsl:choose>
        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
<xsl:choose>
    <xsl:when test="parent::tei:div[@type='notes']"><div class="note">
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
        </div></xsl:when>

  <!--  authorial notes in the original  -->
        <xsl:otherwise><xsl:choose>
<xsl:when test="./attribute::place='foot'"><span class="footnote"><xsl:apply-templates/></span></xsl:when>
<xsl:when test="./attribute::place='left margin'"><span class="leftmarginnote"><xsl:apply-templates/></span></xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose></xsl:otherwise>

</xsl:choose>
        
    </xsl:template>
    
  
    
        

    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:apply-templates/>
                </ol>
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
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

<!--For deletions and additions in ms -->
    <xsl:template match="//tei:del">
        <span class="del_overstrike"><xsl:apply-templates /></span>
    </xsl:template>
    <xsl:template match="//tei:add">
        <span class="add_supralinear"><xsl:apply-templates /></span>
    </xsl:template>
</xsl:stylesheet>
