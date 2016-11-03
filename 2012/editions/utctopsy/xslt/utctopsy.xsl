<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
<xsl:include href="../../../../legacy/template_xslt/base.xsl"/>
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:template match="//tei:teiHeader"/>
<xsl:template name="essayNav"/>
    <xsl:template name="witnessName"> </xsl:template>

    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']"/>
        </xsl:variable>
        
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">

                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='intro.utctopsy'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/intro.utctopsy.html"
                            >Introduction</a>
                        </span>

                        
                    </li>
                    <li id="editionNav2" class="heading">Witnesses:</li>
                    <li id="editionNav3" class="postHeading">
                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='Era'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/Era.html">Era
                                (6 Nov. 1851)</a>
                        </span>
                    </li>
                    <li id="editionNav4">
                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='J2V'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/J2V.html">Jewett First
                                (1852)</a>
                        </span>
                    </li>
                    <li id="editionNav5">
                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='JPB'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/JPB.html">Jewett Million
                                (1852/3)</a>
                        </span>
                    </li>
                    <li id="editionNav6">
                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='JIL'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/JIL.html">Jewett Illustrated
                                (1853)</a>
                        </span>
                    </li>
                    <li id="editionNav7">
                        <span>
                            <xsl:attribute name="class">
                                <xsl:if test="$idno='HO'">currentPage</xsl:if>
                            </xsl:attribute>
                            <a href="{$siteroot}2012/editions/utctopsy/HO.html">Osgood (1879)</a>
                        </span>
                    </li>
                    
                </ul>
<xsl:if test="$idno!='juxta.utctopsy'"><a href="{$siteroot}2012/editions/utctopsy/juxta.utctopsy.html"><div class="xmljuxta">download XML and Juxta files</div></a></xsl:if>
                
<xsl:choose>

<xsl:when test="starts-with($idno,'intro')"></xsl:when>
    <xsl:when test="starts-with($idno,'juxta')"></xsl:when>
<xsl:otherwise><xsl:choose>
                    <xsl:when test="$utctopsy_notes='undefined'">
                        <a href="{$siteroot}2012/editions/utctopsy/{$idno}_notes.html">
                            <div class="notesLink">show all notes</div>
                        </a>
                    </xsl:when>
                    <xsl:when test="$utctopsy_notes='show'">
                        <a href="{$siteroot}2012/editions/utctopsy/{$idno}.html">
                            <div class="notesLink">collapse notes</div>
                        </a>
                    </xsl:when>
                </xsl:choose></xsl:otherwise></xsl:choose>
       
        <!-- <listWit>
            <witness xml:id="era">National Era</witness>
            <witness xml:id="j2v">John P. Jewett First Edition, 2 Volumes (1852)</witness>
            <witness xml:id="jpb">John P. Jewett Paperback &#8220;Edition for the
            Million&#8221; (1852/1853)</witness>
            <witness xml:id="jil">John P. Jewett Illustrated Edition (1853)</witness>
            <witness xml:id="ho">Houghton Osgood New Edition (1879)</witness>
            </listWit> -->
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2012, Volume 33</h5>
    </xsl:template>

    <!-- to get a special div for styling -->
    <xsl:template match="//tei:body">
        <xsl:variable name="fileIDsubstring"><xsl:value-of select="ancestor::tei:TEI//tei:idno[@type='file']/substring(.,7)"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$fileIDsubstring!='utctopsy'">
                <div class="utctopsy">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>



    </xsl:template>


    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="@type='copyright'">
                <p class="center">
                    <xsl:apply-templates/>
                </p>
            </xsl:when>
            <xsl:when test="@type='chaptitle'">
                <h5>
                    <xsl:apply-templates/>
                </h5>
            </xsl:when>
            <xsl:when test="@type='chaptitle_chapnumb'">
                <h5>
                    <xsl:apply-templates/>
                </h5>
            </xsl:when>
            <xsl:when test="@type='chapnumb'">
                <h6>
                    <xsl:apply-templates/>
                </h6>
            </xsl:when>
            <xsl:when test="@type='title'">
                <h4>
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:when test="@type='subtitle'">
                <h5>
                    <xsl:apply-templates/>
                </h5>
            </xsl:when>
            <xsl:when test="@type='author'">
                <h6>
                    <xsl:apply-templates/>
                </h6>
            </xsl:when>
            <xsl:when test="@type='divider'">
                <h6>
                    <xsl:apply-templates/>
                </h6>
            </xsl:when>
            <xsl:when test="./attribute::type='main'">
                <h1>
                    <xsl:apply-templates/>
                </h1>
            </xsl:when>
            <xsl:when test="./attribute::type='sub'">
                <h2>
                    <xsl:apply-templates/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>

    <!-- milestone -->
    <xsl:template match="//tei:milestone">
        <xsl:choose>
            <xsl:when test="attribute::type='emdashemdash'">
                <span class="center">&#8212;&#8212;</span>
            </xsl:when>
            <xsl:when test="attribute::unit='column'">
               <!-- <xsl:choose>
                    <xsl:when test="@n='b'">-->
                        <span class="columnBreak">[column <xsl:value-of select="./attribute::n"/>]</span>
                  <!--  </xsl:when>
                </xsl:choose>-->

            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- <opener> and <closer> -->
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
    <!-- makes the <orig> or <sic> show up in a <choice> (rather than the regularized forms) -->
    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="child::tei:orig">
                <xsl:for-each select="child::tei:orig">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="child::tei:sic">
                <xsl:for-each select="child::tei:sic">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- an attempt to connect the transcriptions with the variants and notes -->
    <!-- This brings up the app entry at the point in the transcription where the <anchor> @xml:id matches
the value of @to on <app> in utc_variants.xml -->
    <!--<xsl:template match="//tei:anchor">
        <xsl:variable name="anchorID">
            <xsl:value-of select="attribute::xml:id"/>
        </xsl:variable>

    <!-\-<xsl:if test="$anchorID = document('../2012/editions/utctopsy/utc_variants.xml')//tei:app/substring-after(./attribute::from,'#')"><xsl:text disable-output-escaping="yes"><![CDATA[<span class="variantText">]]></xsl:text></xsl:if>
    <xsl:if test="$anchorID = document('../2012/editions/utctopsy/utc_variants.xml')//tei:app/substring-after(./attribute::to,'#')"><xsl:text disable-output-escaping="yes"><![CDATA[</span>]]></xsl:text></xsl:if>-\->

        
        
        <!-\- An attempt to grab content between anchors -\->
        <!-\-<xsl:variable name="anchorSpan"><span class="anchorSpan"><xsl:value-of select="substring-before(.,preceding-sibling::tei:anchor[1])"/></span></xsl:variable>-\->

        <!-\- may need to change the URI below once this is on the server, but I think the directory
structure is likely to be the same -\->
        <xsl:for-each select="document('../2012/editions/utctopsy/utc_variants.xml')/tei:TEI">
            <xsl:for-each select="descendant::tei:item/tei:app">
                <xsl:variable name="ptrID">
                    <xsl:for-each select="./following-sibling::tei:ptr/attribute::target">
                        <xsl:value-of select="substring-after(.,'#')"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="appIDfrom">
                    <xsl:value-of select="substring-after(./attribute::from,'#')"/>
                </xsl:variable>
                <xsl:variable name="appIDto">
                    <xsl:value-of select="substring-after(./attribute::to,'#')"/>
                </xsl:variable>
                <xsl:if test="$appIDto = $anchorID">

                    <div class="showNote">
                        <!-\- &#8620; &#9776;-\->
                        <xsl:if test="$utctopsy_notes='undefined'">
                            
                            [<a href="#" onclick="return false;"><span class="noteRefImage">note</span></a>]
                            
                        </xsl:if>
                    </div>
                    <div>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="$utctopsy_notes='undefined'">appEntry</xsl:when>
                                <xsl:when test="$utctopsy_notes='show'">appEntryShow</xsl:when>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$utctopsy_notes='undefined'"><a href="#" class="closenote">X</a></xsl:when>
                            <xsl:when test="$utctopsy_notes='show'"><!-\-no x needed if all notes are shown-\-></xsl:when>
                        </xsl:choose>
                        <xsl:apply-templates select="."/>
                        <xsl:for-each select="//tei:note[@xml:id = $ptrID]">
                            <div class="rdgNote">
                                <h4>Note</h4>
                                <xsl:apply-templates/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>-->
    <xsl:template match="//tei:app">
        <xsl:for-each select="child::tei:rdg">
            <xsl:variable name="witnessID">
                <xsl:value-of select="substring-after(./attribute::wit,'#')"/>
            </xsl:variable>
            <div class="appRdg">
                <xsl:apply-templates/>
                <span class="witness">witness: <xsl:for-each
                        select="//tei:witness[@xml:id = $witnessID]">
                        <xsl:value-of select="."/>
                    </xsl:for-each></span>
            </div>
            <!--<xsl:for-each select="//tei:note[@xml:id = $ptrID]"><div class="rdgNote"><xsl:apply-templates/></div></xsl:for-each>-->
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="//tei:note//tei:title">
        <h5>
            <xsl:apply-templates/>
        </h5>
    </xsl:template>
    <!--<xsl:template match="//tei:note//tei:ptr">
        <a><xsl:attribute name="href">note#<xsl:value-of
                    select="substring-after(attribute::target,'#')"/></xsl:attribute>note
                <xsl:value-of select="substring-after(attribute::target,'#')"/></a>
    </xsl:template>-->
    <xsl:template match="//tei:fw">
        <div class="formework">
            <xsl:choose>
                <xsl:when test="@type='sig'">
                    <span class="fw_sig">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@type='header'">
                    <span class="fw_header">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@type='footer'">
                    <span class="fw_footer">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@type='divider'">
                    <span class="fw_divider">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
            </xsl:choose>
        </div>
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
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI//tei:idno[@type='file']!='intro.utctopsy'"
                        ><xsl:attribute name="href">note#<xsl:value-of
                            select="substring-after(attribute::target,'#')"/></xsl:attribute>note
                        <xsl:value-of select="substring-after(attribute::target,'#')"/></xsl:when>
                <xsl:otherwise>

                    <xsl:attribute name="href"><xsl:value-of select="attribute::target"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="attribute::xml:id"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when
                            test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                            <span class="noteRefIntro">[<xsl:value-of
                                    select="substring-after(attribute::target,'#note')"/>]</span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="noteRef">[<xsl:value-of
                                    select="substring-after(attribute::target,'#note')"/>]</span>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>


        </a>
    </xsl:template>
    <xsl:template match="//tei:note">
<xsl:choose>

<xsl:when test="@resp='editor'"><span class="inTextEditorialNote">[<xsl:apply-templates/>]</span></xsl:when>
<xsl:otherwise><div class="note">
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
        </div></xsl:otherwise>

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
    <xsl:template match="//tei:item/child::tei:label">
        <span class="list-label">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- pagebreaks -->
    <xsl:template match="//tei:pb">
        <span class="pagebreak">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>pages/thumbs/</xsl:text>
                            <xsl:value-of select="@facs"/>
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/viewsize/</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Page </xsl:text>
                    <xsl:value-of select="@n"/>
                </a>
            </span>
            <br/>
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>pages/fullsize/</xsl:text>
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

<!--<xsl:template match="//tei:ref">
 
        <xsl:variable name="refTarget">
            <xsl:value-of select="attribute::target"/>
        </xsl:variable>
<xsl:variable name="refContent"><xsl:for-each select="."><xsl:apply-templates/></xsl:for-each></xsl:variable>
<xsl:variable name="fileID">
    <xsl:value-of select="ancestor::tei:TEI/descendant::tei:idno[@type='file']"/>

</xsl:variable>
        
        <xsl:for-each select="document('../2012/editions/utctopsy/utc_variants.xml')/tei:TEI">
            <xsl:for-each select="descendant::tei:item/tei:app">
                <xsl:variable name="appID">
                    <xsl:for-each select="./attribute::loc">
                        <xsl:value-of select="substring-after(.,'#')"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="ptrID">
                    <xsl:for-each select="./following-sibling::tei:ptr/attribute::target">
                        <xsl:value-of select="substring-after(.,'#')"/>
                    </xsl:for-each>
                </xsl:variable>
<xsl:variable name="rdgWit">
<xsl:for-each select="child::tei:rdg"><xsl:value-of select="attribute::wit"/></xsl:for-each>

</xsl:variable>
              
                <xsl:if test="$appID = $refTarget">
                    
                    <div class="showNote">
                        <!-\- &#8620; &#9776;-\->
                        <xsl:if test="$utctopsy_notes='undefined'">
                            
                            <a href="#" onclick="return false;"><xsl:value-of select="$refContent"/></a>
                            
                        </xsl:if>
                    </div>
                    <div>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="$utctopsy_notes='undefined'">appEntry</xsl:when>
                                <xsl:when test="$utctopsy_notes='show'">appEntryShow</xsl:when>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="$utctopsy_notes='undefined'"><a href="#" class="closenote">X</a></xsl:when>
                            <xsl:when test="$utctopsy_notes='show'"><!-\-no x needed if all notes are shown-\-></xsl:when>
                        </xsl:choose>
                        <xsl:apply-templates select="."/>
                        <xsl:for-each select="//tei:note[@xml:id = $ptrID]">
                            <div class="rdgNote">
                                <h4>Note</h4>
                                <xsl:apply-templates/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    

</xsl:template>-->


</xsl:stylesheet>
