<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
    <xsl:param name="stuf_version">undefined</xsl:param>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <xsl:include href="config.xsl"/>
    <xsl:template match="TEI">
        
        <html><head>
            <link><xsl:attribute name="href">http://fonts.googleapis.com/css?family=Gentium+Basic:400,700,400italic,700italic&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css</xsl:attribute></link> 
            <title>Scholarly Editing: The Annual of the Association for Documentary
                Editing</title>
            <!--<xsl:if test="contains(//idno[@type='edition'],'stufaiuolo')"><link href="{$siteroot}css/stufaiuolo.css" rel="stylesheet" type="text/css"/></xsl:if>-->
            <link href="{$siteroot}css/style.css" rel="stylesheet" type="text/css"/>
            <link href="{$siteroot}js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"
                rel="stylesheet" type="text/css"/>
            
            
            <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
            <script src="{$siteroot}js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js"> &#160; </script>
            <script src="{$siteroot}js/javascript.js"> &#160; </script>
            <script type="text/javascript">
                
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-29415214-1']);
                _gaq.push(['_trackPageview']);
                
                (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
                
            </script>
        </head>
            

            
                <body>
                    <div id="content">
                        <div class="nav">
                            <ul>
                                <li id="nav1">
                                    <a href="{$siteroot}se.index.issues.html">Issues</a>
                                </li>
                                <li id="nav2">
                                    <a href="{$siteroot}se.index.editions.html">Editions</a>
                                </li>
                                <li id="nav3">
                                    <a href="{$siteroot}se.index.essays.html">Essays</a>
                                </li>
                                <li id="nav4">
                                    <a href="{$siteroot}se.index.reviews.html">Reviews</a>
                                </li>
                                <li id="about">
                                    <a href="{$siteroot}se.about.html">About</a>
                                </li>
                            </ul>
                        </div>
                        <div class="masthead">
                            <h1>
                                <a href="{$siteroot}">
                                    <span>Scholarly Editing</span>
                                </a>
                            </h1>
                            <h4>The Annual of the Association for Documentary Editing</h4>
                            <h5>2015, Volume 36</h5>
                        </div>
                        <xsl:apply-templates select="//titleStmt"/>
                        
                        <div class="stufaiuolo">
                            <xsl:variable name="idno"><xsl:value-of select="//idno[@type='file']"/></xsl:variable>
                             
                            
                            <span class="back_to_ms">
                                <a><xsl:attribute name="href"><xsl:value-of select="$siteroot"/>2015/editions/stufaiuolo.<xsl:choose><xsl:when test="$idno='stufaiuolo.riccardiana'">riccardiana_reading</xsl:when><xsl:when test="$idno='stufaiuolo.valentiniana'">valentiniana_reading</xsl:when></xsl:choose>.html</xsl:attribute>Back to <xsl:choose><xsl:when test="$idno='stufaiuolo.riccardiana'">Riccardiana</xsl:when><xsl:when test="$idno='stufaiuolo.valentiniana'">Valentiniana</xsl:when></xsl:choose> manuscript</a>
                            </span>
<h1 class="main2">Lo Stufaiuolo: Normalizations <xsl:value-of
                                select="concat(//msDesc/msIdentifier/repository, ' ', //msDesc/msIdentifier/idno)"
                            /></h1>

                    
                        
                        <ul id="toc"><h3>Normalizations by types </h3>
                            <li>Word Separation: <a href="#w-separation"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'w-separation')]])"
                                    /></a> interventions</li>
                            <li>Latinisms: <a href="#lat"><xsl:value-of
                                        select="count(//choice[reg[@type ='lat']])"/></a>
                                interventions</li>
                            <li>Etymological and pseudo-etymological H: <a href="#lat-h"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'lat-h')]])"
                                    /></a> interventions</li>
                            <li>Added Accent: <a href="#accent-add"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'accent-add')]])"
                                    /></a> interventions</li>
                            <li>Deleted Accent: <a href="#accent-del"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'accent-del')]])"
                                    /></a> interventions</li>
                            <li>Accent Direction: <a href="#dir-acc"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'dir-acc')]])"
                                    /></a> interventions</li>
                            <li>Added apostrophe: <a href="#apo-add"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'apo-add')]])"
                                    /></a> interventions</li>
                            <li>Deleted Apostrophe: <a href="#apo-del"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'apo-del')]])"
                                    /></a> interventions</li>
                            <li>Expunction of diacritic -i-: <a href="#apo-del"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'diacritic-i')]])"
                                    /></a> interventions</li>
                            <li>Normalization of np-nb > mp-mb: <a href="#mp-mb"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'mp-mb')]])"
                                    /></a> interventions</li>
                            <li>Normalization of other graphematic features: <a href="#mp-mb"
                                        ><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'graphematic')]])"
                                    /></a> interventions</li>
                            <li>Normalization of other spelling features: <a href="#mp-mb"
                                        ><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'spelling')]])"
                                    /></a> interventions</li>
                            <li>Upper to Lower case: <a href="#mp-mb"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'U2L-reg')]])"
                                    /></a> interventions</li>
                            <li>Upper to Lower case due to change of punctuation: <a href="#mp-mb"
                                        ><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'U2L-pc')]])"
                                    /></a> interventions</li>
                            <li>Lower to Upper case: <a href="#mp-mb"><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'l2U-reg')]])"
                                    /></a> interventions</li>
                            <li>Lower to Upper case due to change of punctuation: <a href="#mp-mb"
                                        ><xsl:value-of
                                        select="count(//choice[reg[contains(@type, 'l2U-pc')]])"
                                    /></a> interventions</li>

                        </ul>

                        <ul id="toc">
                            <h3>Paragraphematic system</h3>
                            <li>Editorial punctuation: <a href="#pc-ep"><xsl:value-of
                                        select="count(//pc[@resp='#ep'])"/></a> interventions</li>
                            <li>Authorial punctuation not retained by the editor: <a href="#pc-doni"
                                        ><xsl:value-of select="count(//pc[@resp='#doni'])"/></a>
                                interventions</li>
                            <li>Authorial punctuation retained by the editor: <a href="#pc-doni-ep"
                                        ><xsl:value-of
                                        select="count(//pc[contains(@resp,'#ep' ) and contains(@resp, '#doni')])"
                                    /></a> occurences</li>

                            <li>Soft-hyphen in between words: <a href="#soft-hyphen"><xsl:value-of
                                        select="count(//lb[@rend='h3'])"/></a> occurences</li>
                            <li>Soft-equal in between words: <a href="#soft-equal"><xsl:value-of
                                        select="count(//lb[@rend='h4'])"/></a> occurences</li>
                        </ul>

                        <xsl:variable name="punct-don" select="count(//pc[@resp='#doni'])"/>
                        <xsl:variable name="pinct-ep" select="count(//pc[@resp='#ep'])"/>



                        <span class="norm_total">Total interventions on orthography and spelling: <strong><xsl:value-of
                                    select="count(//choice[reg])"/></strong>; Interventions on
                            punctuation <strong><xsl:value-of select="$punct-don + $pinct-ep"
                                /></strong>
                        </span>


                        <ul class="lista" id="w-separation">
                            <h4>Word Separation <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'w-separation')]])"
                                /></h4>
                            <xsl:for-each-group
                                select="//choice[reg[contains(@type, 'w-separation')]]"
                                group-by="lower-case(reg[contains(@type, 'w-separation')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>&#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="lat">
                            <h4>Latinisms <xsl:value-of select="count(//choice[reg[@type ='lat']])"
                                /></h4>
                            <xsl:for-each-group select="//choice[reg[@type='lat']]"
                                group-by="lower-case(reg[@type='lat'])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="lat-h">
                            <h4>Pseudo-etymological "H": <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'lat-h')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'lat-h')]]"
                                group-by="lower-case(reg[contains(@type, 'lat-h')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="accent-add">
                            <h4>Accent added: <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'accent-add')]])"
                                /></h4>
                            <xsl:for-each-group
                                select="//choice[reg[contains(@type, 'accent-add')]]"
                                group-by="lower-case(reg[contains(@type, 'accent-add')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="accent-del">
                            <h4>Accent deleted: <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'accent-del')]])"
                                /></h4>
                            <xsl:for-each-group
                                select="//choice[reg[contains(@type, 'accent-del')]]"
                                group-by="lower-case(reg[contains(@type, 'accent-del')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>

                        <ul class="lista" id="dir-acc">
                            <h4>Accent direction: <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'dir-acc')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'dir-acc')]]"
                                group-by="lower-case(reg[contains(@type, 'dir-acc')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>

                        <ul class="lista" id="apo-add">
                            <h4>Apostrophe added: <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'apo-add')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'apo-add')]]"
                                group-by="lower-case(reg[contains(@type, 'apo-add')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="apo-del">
                            <h4>Apostrophe deleted : <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'apo-del')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'apo-del')]]"
                                group-by="lower-case(reg[contains(@type, 'apo-del')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="apo-del">
                            <h4>Expunction of diacritic -i- <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'diacritic-i')]])"
                                /></h4>
                            <xsl:for-each-group
                                select="//choice[reg[contains(@type, 'diacritic-i')]]"
                                group-by="lower-case(reg[contains(@type, 'diacritic-i')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="mp-mb">
                            <h4>Normalization of np-nb > mp-mb <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'mp-mb')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'mp-mb')]]"
                                group-by="lower-case(reg[contains(@type, 'mp-mb')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="mp-mb">
                            <h4>Normalization of other grapheamtic features <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'graphematic')]])"
                                /></h4>
                            <xsl:for-each-group
                                select="//choice[reg[contains(@type, 'graphematic')]]"
                                group-by="lower-case(reg[contains(@type, 'graphematic')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="mp-mb">
                            <h4>Normalization of other spelling <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'spelling')]])"
                                /></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'spelling')]]"
                                group-by="lower-case(reg[contains(@type, 'spelling')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="lower-case(orig)"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="U2L-reg">
                            <h4>Upper to lower case <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'U2L-reg')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'U2L-reg')]]"
                                group-by="lower-case(reg[contains(@type, 'U2L-reg')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="orig"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>

                        <ul class="lista" id="U2L-pc">
                            <h4>Upper to lower case due to a change of punctuation <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'U2L-pc')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'U2L-pc')]]"
                                group-by="lower-case(reg[contains(@type, 'U2L-pc')])">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="orig"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="l2U-reg">
                            <h4>Lower to Upper case <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'l2U-reg')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'l2U-reg')]]"
                                group-by="reg[contains(@type, 'l2U-reg')]">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="orig"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="l2U-pc">
                            <h4>Lower to Upper case due to a change of punctuation <xsl:value-of
                                    select="count(//choice[reg[contains(@type, 'l2U-pc')]])"/></h4>
                            <xsl:for-each-group select="//choice[reg[contains(@type, 'l2U-pc')]]"
                                group-by="reg[contains(@type, 'l2U-pc')]">
                                <xsl:sort select="count(current-group())" order="descending"/>
                                <xsl:sort select="lower-case(orig)" order="ascending"/>
                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of
                                            select="orig"/> &gt; <xsl:value-of
                                            select="normalize-space(current-grouping-key())"
                                        /></span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>

                        <ul class="lista" id="pc-ep">
                            <h4>Editorial punctuation: <xsl:value-of
                                    select="count(//pc[@resp='#ep'])"/></h4>

                            <xsl:for-each-group select="//pc[@resp='#ep']" group-by=".">
                                <xsl:sort select="count(current-group())" order="descending"/>

                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:value-of select="."/>
                                    </span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="pc-doni">
                            <h4>Authorial punctuation not retained by the editor: <xsl:value-of
                                    select="count(//pc[@resp='#doni'])"/></h4>

                            <xsl:for-each-group select="//pc[@resp='#doni']" group-by="text(), g/@ref">
                                <xsl:sort select="count(current-group())" order="descending"/>

                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:apply-templates/>
                                    </span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                           
                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="pc-doni-ep">
                            <h4>Authorial punctuation retained by the editor: <xsl:value-of
                                    select="count(//pc[contains(@resp,'#ep' ) and contains(@resp, '#doni')])"
                                /></h4>

                            <xsl:for-each-group
                                select="//pc[contains(@resp,'#ep' ) and contains(@resp, '#doni')]"
                                group-by=".">
                                <xsl:sort select="count(current-group())" order="descending"/>

                                <li class="occo">
                                    <span class="tipo">
                                        <xsl:number value="position()"/>. <xsl:apply-templates/>
                                    </span>
                                    &#160;
                                    <span class="num">
                                        <xsl:value-of select="count(current-group())"/>
                                    </span>
                                </li>
                            </xsl:for-each-group>
                            <a href="#toc">Back</a>
                        </ul>


                        <ul class="lista" id="soft-hyphen">
                            <h4>Soft-hyphen in between words <xsl:value-of
                                    select="count(//lb[@rend='h3'])"/></h4>
                            <xsl:for-each select="//lb[@rend eq 'h3']">
                                <li><xsl:number value="position()"/>. <xsl:variable
                                        name="preceding-text-strings" as="xs:string*">
                                        <xsl:for-each select="preceding-sibling::node()">
                                            <xsl:value-of select="string(.)"/>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:variable name="preceding-text"
                                        select="normalize-space(string-join($preceding-text-strings, ''))"/>
                                    <xsl:variable name="preceding-word"
                                        select="replace(tokenize($preceding-text, '\s')[last()], '\W*(\w.*\w)\W*','$1')"/>
                                    <xsl:variable name="following-text-strings" as="xs:string*">
                                        <xsl:for-each select="following-sibling::node()">
                                            <xsl:value-of select="string(.)"/>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:variable name="following-text"
                                        select="normalize-space(string-join($following-text-strings, ''))"/>
                                    <xsl:variable name="following-word"
                                        select="replace(tokenize($following-text, '\s')[1], '\W*(\w.*\w)\W*','$1')"/>
                                    <xsl:value-of select="$preceding-word"/> - <xsl:value-of
                                        select="$following-word"/>
                                </li>
                            </xsl:for-each>

                            <a href="#toc">Back</a>
                        </ul>
                        <ul class="lista" id="soft-equal">
                            <h4>Soft-Equal in between words <xsl:value-of
                                    select="count(//lb[@rend='h4'])"/></h4>
                            <xsl:for-each select="//lb[@rend eq 'h4']">
                                <li><xsl:number value="position()"/>. <xsl:variable
                                        name="preceding-text-strings" as="xs:string*">
                                        <xsl:for-each select="preceding-sibling::node()">
                                            <xsl:value-of select="string(.)"/>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:variable name="preceding-text"
                                        select="normalize-space(string-join($preceding-text-strings, ''))"/>
                                    <xsl:variable name="preceding-word"
                                        select="replace(tokenize($preceding-text, '\s')[last()], '\W*(\w.*\w)\W*','$1')"/>
                                    <xsl:variable name="following-text-strings" as="xs:string*">
                                        <xsl:for-each select="following-sibling::node()">
                                            <xsl:value-of select="string(.)"/>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:variable name="following-text"
                                        select="normalize-space(string-join($following-text-strings, ''))"/>
                                    <xsl:variable name="following-word"
                                        select="replace(tokenize($following-text, '\s')[1], '\W*(\w.*\w)\W*','$1')"/>
                                    <xsl:value-of select="$preceding-word"/> = <xsl:value-of
                                        select="$following-word"/>
                                </li>
                            </xsl:for-each>

                            <a href="#toc">Back</a>
                        </ul>

                       </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="//fileDesc/titleStmt">
        <xsl:variable name="idno">
            <xsl:value-of select="//idno[@type='file']"/>
        </xsl:variable>
        <xsl:variable name="editionIdno"><xsl:value-of select="//idno[@type='edition']"/></xsl:variable>
        <div class="editionHeader">
                <xsl:for-each select="child::title">
                    <xsl:choose>
                        <xsl:when test="attribute::type='sub'"/>
                        <xsl:otherwise>
                            <h1 class="editionTitle">
                                <xsl:apply-templates/>
                            </h1>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="child::author">
                    <span class="author">by <xsl:apply-templates/></span>
                </xsl:for-each>
                <xsl:apply-templates select="child::editor"/>
                <span class="editionNav">
                            <xsl:call-template name="editionNav"/>
                </span>
            </div>
        
    </xsl:template>
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//idno" />
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
                        <a href="{$siteroot}2015/editions/stufaiuolo_XML.zip">Edition XML</a>
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
                        <a href="{$siteroot}2015/editions/stufaiuolo_XML.zip">Edition XML</a>
                    </li>
                    <li id="editionNav4">
                        <a href="http://juxtacommons.org/shares/ehF60q"
                            >Manuscript comparison in Juxta</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//titleStmt/child::editor">
        <xsl:choose>
            <xsl:when test="./following-sibling::editor">
                <span class="editor">Edited by <xsl:value-of select="."/> and <xsl:value-of
                    select="following-sibling::editor"/></span>
            </xsl:when>
            <xsl:when test="./preceding-sibling::editor"/>
            <xsl:otherwise>
                <span class="editor">Edited by <xsl:value-of select="."/></span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="g">
        <xsl:choose>
            <xsl:when test="@ref='#qm'">
                <xsl:text>.~</xsl:text>
            </xsl:when>
            <xsl:when test="@ref='#par'">
                <xsl:text>:~</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
