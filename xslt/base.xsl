<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teiE="http://www.tei-c.org/ns/Examples">
    <!--<xsl:strip-space elements="*" />-->

    <xsl:param name="utctopsy_notes">undefined</xsl:param>
    <xsl:param name="sevenplanets_abbr">undefined</xsl:param>
    <xsl:param name="avisos_english">undefined</xsl:param>
    <xsl:param name="avisos_modernized">undefined</xsl:param>
    <xsl:param name="cranchjournal_appendices">undefined</xsl:param>
    <xsl:param name="cranchjournal_readingtext">undefined</xsl:param>
    <xsl:param name="stuf_interventions">undefined</xsl:param>
    <xsl:include href="config.xsl"/>
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no"/>
    <xsl:preserve-space elements="tei:*"/>
    <!--<xsl:template name="volCitation"/>
    <xsl:template name="essayNav"/>
    <xsl:template name="editionNav"/>-->

    <!-- added normalize space to, uh, normalize the space. Also moved it to the top level so I can use it throughout -kmd -->
    <xsl:variable name="idno">
        <xsl:value-of select="normalize-space(//tei:idno[@type = 'file'])"/>
    </xsl:variable>
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="x-ua-compatible" content="IE=Edge"/>
                <link>
                    <xsl:attribute name="href"
                        >http://fonts.googleapis.com/css?family=Gentium+Basic:400,700,400italic,700italic&amp;subset=latin,latin-ext'
                        rel='stylesheet' type='text/css</xsl:attribute>
                </link>
                <title>Scholarly Editing: The Annual of the Association for Documentary
                    Editing</title>
                <!--<xsl:if test="contains(//tei:idno[@type='edition'],'stufaiuolo')"><link href="{$siteroot}css/stufaiuolo.css" rel="stylesheet" type="text/css"/></xsl:if>-->
                <link href="{$siteroot}css/style.css" rel="stylesheet" type="text/css"/>
                <link href="{$siteroot}js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"
                    rel="stylesheet" type="text/css"/>


                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"> &#160; </script>
                <script src="{$siteroot}js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js"> &#160; </script>
                <script src="{$siteroot}js/javascript.js"> &#160; </script>

                <link href="{$siteroot}css/style.css" rel="stylesheet" type="text/css"/>
                <xsl:choose>
                    <xsl:when
                        test="
                            $idno = 'dequinqueseptenis.trans' or
                            $idno = 'dequinqueseptenis' or
                            $idno = 'intro.dequinqueseptenis-deorationedominica' or
                            $idno = 'deorationedominica' or
                            $idno = 'deorationedominica.trans'">
                        <link href="{$siteroot}css/dunning.css" rel="stylesheet" type="text/css"/>
                        <script src="{$siteroot}js/dunning.js"> &#160; </script>
                    </xsl:when>
                    <xsl:when test="contains($idno, 'BinyonDestree')">
                        <link href="{$siteroot}css/BinyonDestree.css" rel="stylesheet"
                            type="text/css"/>
                        <!--<script src="{$siteroot}js/BinyonDestree.js"> &#160; </script>-->
                    </xsl:when>
                </xsl:choose>
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
                <!-- Added so the dev environment looks different -kmd -->
                <xsl:if test="$environment = 'development'">
                    <style>
                        body{
                            background-color: #ff9300;
                            border-top: solid 10px red;
                        }</style>
                </xsl:if>
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
                        <xsl:call-template name="volCitation"/>
                    </div>
                    <xsl:apply-templates select="//tei:titleStmt"/>



                    <xsl:choose>
                        <!-- for 2016 dunning edition -kmd -->
                        <xsl:when
                            test="
                                $idno = 'dequinqueseptenis.trans' or
                                $idno = 'dequinqueseptenis' or
                                $idno = 'intro.dequinqueseptenis-deorationedominica' or
                                $idno = 'deorationedominica' or
                                $idno = 'deorationedominica.trans'">
                            <xsl:text>&#160;</xsl:text>
                            <!-- I don't know why this needs to be here but navigation breaks without it?? -KMD -->

                            <div>
                                <!-- apply a class of dunning to cover all of them and a class for the specific page -kmd -->
                                <xsl:attribute name="class">
                                    <xsl:text>dunning </xsl:text>
                                    <xsl:value-of select="translate($idno, '.', '_')"/>
                                </xsl:attribute>

                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>

                        <!-- for 2016 Binyon/Destree edition -kmd -->
                        <xsl:when test="contains($idno, 'BinyonDestree.introduction')">
                            <div class="edition">
                                <div>
                                    <!-- apply a class of dunning to cover all of them and a class for the specific page -kmd -->
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="translate($idno, '.', '_')"/>
                                    </xsl:attribute>

                                    <xsl:apply-templates/>
                                </div>
                            </div>
                        </xsl:when>

                        <xsl:when test="starts-with($idno, 'se.')">
                            <div class="list">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'intro')">
                            <xsl:choose>
                                <xsl:when test="$idno = 'intro.sevenplanets'">
                                    <div class="essay">
                                        <div class="sevenplanetsintro">
                                            <xsl:apply-templates/>
                                        </div>
                                    </div>
                                </xsl:when>
                                <xsl:otherwise>
                                    <div class="essay">
                                        <xsl:apply-templates/>
                                    </div>
                                </xsl:otherwise>
                            </xsl:choose>

                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'about')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'main')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'help')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'essay')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'review')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when test="starts-with($idno, 'juxta')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>
                        <xsl:when
                            test="starts-with($idno, 'hejinian.missing') or starts-with($idno, '2016preface')">
                            <div class="essay">
                                <xsl:apply-templates/>
                            </div>
                        </xsl:when>

                        <xsl:otherwise>
                            <div class="edition">
                                <!--<xsl:if test="descendant::tei:idno[@type='file']='markonthewall'"><xsl:apply-templates select="//tei:facsimile"/></xsl:if>-->
                                <xsl:if test="descendant::tei:sourceDesc//tei:listWit">
                                    <xsl:choose>
                                        <xsl:when
                                            test="descendant::tei:idno[@type = 'edition'] = 'swayzedrama'"/>
                                        <xsl:otherwise>
                                            <xsl:apply-templates
                                                select="//tei:sourceDesc//tei:listWit"/>
                                            <xsl:call-template name="witnessName"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                                <xsl:apply-templates/>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="$idno = 'main.baroness'">
                        <a href="http://v-machine.org/">
                            <img class="pbvm" src="./includes/images/poweredby.gif"
                                alt="powered by the Versioning Machine, version 4.0"/>
                        </a>
                    </xsl:if>
                    
                    <!-- Amanda added this but Andy's templates re handling the notes, so to avoid double notes I am commenting out -KMD -->
                    <!--<xsl:call-template name="NotesList"></xsl:call-template>-->
                    
                    
                    <div class="footer">
                        <span class="creativecommons"><a rel="license"
                                href="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                                <img alt="Creative Commons License" style="border-width:0"
                                    src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png"/>
                            </a><br/>This work is licensed under a <a rel="license"
                                href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative
                                Commons Attribution-NonCommercial-ShareAlike 3.0 Unported
                                License</a>.</span>

                        <span class="adelogo">
                            <a href="http://www.documentaryediting.org">
                                <img src="{$siteroot}images/adelogo.png"
                                    alt="Logo of the Association for Documentary Editing"/>
                            </a>
                        </span>
                        <span class="cdrh">Sponsored by the <a href="http://cdrh.unl.edu">Center for
                                Digital Research in the Humanities at the University of
                                Nebraska-Lincoln</a>.</span>
                        <span class="issn">ISSN 2167-1257</span>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="//tei:fileDesc/tei:titleStmt">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type = 'file']"/>
        </xsl:variable>
        <xsl:variable name="editionIdno">
            <xsl:value-of select="//tei:idno[@type = 'edition']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno, 'essay')">
                <div class="essayHeader">
                    <h1 class="essaysTitle">Essays</h1>
                </div>
                <span class="essayNav">
                    <xsl:call-template name="essayNav"/>
                </span>
            </xsl:when>
            <xsl:when test="starts-with($idno, 'review')">
                <div class="essayHeader">
                    <h1 class="essaysTitle">Reviews</h1>
                </div>
                <span class="essayNav">
                    <xsl:call-template name="essayNav"/>
                </span>
            </xsl:when>
            <xsl:when test="$editionIdno = 'cwnewspaperpoetry'">
                <div class="editionHeader">
                    <h1 class="editionTitle">"Will not these days be by thy poets sung": Poems of
                        the <em>Anglo-African</em> and <em>National Anti-Slavery Standard</em>,
                        1863&#8211;1864</h1>
                    <span class="editor">Edited by Elizabeth Lorang and R. J. Weir</span>
                    <span class="editionNav">
                        <xsl:call-template name="editionNav"/>
                    </span>
                </div>
            </xsl:when>
            
            <xsl:when test="contains($editionIdno,'mullinswhitmanheyde')">
                <div class="editionHeader">
                    <h1 class="editionTitle">The Selected Letters of Hannah Whitman Heyde</h1>
                    <span class="editor">Edited by Maire Mullins</span>
                    <span class="editionNav">
                        <xsl:call-template name="editionNav"/>
                    </span>
                </div>
            </xsl:when>

            <xsl:otherwise>
                <div class="editionHeader">

                    <!-- Karin is adding her titles for Domina and Binyon here because :( -KMD -->
                    <xsl:if
                        test="contains($idno, 'BinyonDestree') or contains($idno, 'deorationedominica') or contains($idno, 'dequinqueseptenis')">
                        <xsl:choose>
                            <xsl:when test="contains($idno, 'BinyonDestree')">
                                <h1 class="editionTitle">A Transnational Literary Network Around
                                    1900: The Correspondence between Laurence Binyon and
                                    Olivier-Georges Destrée</h1>
                                <span class="editor">Edited by Eloise Forestier, Gero Guttzeit, and
                                    Marysa Demoor</span>
                            </xsl:when>
                            <xsl:otherwise>
                                <h1 class="editionTitle">Hugh of St Victor's <em>De quinque
                                        septenis</em> (<em>On the Five Sevens</em>) and its
                                    Versification in Samuel Presbiter's <em>De oratione
                                        dominica</em> (<em>On the Lord's Prayer</em>)</h1>
                                <span class="editor">Edited by Andrew Dunning (University of
                                    Toronto)</span>
                            </xsl:otherwise>
                        </xsl:choose>



                    </xsl:if>


                    <xsl:for-each select="child::tei:title">
                        <xsl:choose>
                            <!-- Remove here in favor of above -kmd -->
                            <xsl:when
                                test="contains($idno, 'BinyonDestree') or contains($idno, 'deorationedominica') or contains($idno, 'dequinqueseptenis')">
                                <!-- Do Nothing -->
                            </xsl:when>
                            <xsl:when test="attribute::type = 'sub'"/>
                            <xsl:otherwise>
                                <h1 class="editionTitle">
                                    <xsl:apply-templates/>
                                </h1>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:for-each select="child::tei:author">
                        <span class="author">by <xsl:apply-templates/></span>
                    </xsl:for-each>
                    <!-- For Karin's edition do nothing here, handled above -kmd  -->
                    <xsl:if
                        test="contains($idno, 'BinyonDestree') or contains($idno, 'deorationedominica') or contains($idno, 'dequinqueseptenis')">
                        <!-- Do nothing -->
                    </xsl:if>

                    <xsl:apply-templates select="child::tei:editor"/>
                    <span class="editionNav">
                        <xsl:choose>
                            <xsl:when
                                test="ancestor::tei:TEI//tei:idno[@type = 'edition'] = 'utctopsy'">
                                <span id="editionNavLong">
                                    <xsl:call-template name="editionNav"/>
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="editionNav"/>
                            </xsl:otherwise>
                        </xsl:choose>


                    </span>
                </div>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <xsl:template match="//tei:titleStmt/child::tei:editor">

        <xsl:choose>
            <xsl:when
                test="contains($idno, 'BinyonDestree') or contains($idno, 'deorationedominica') or contains($idno, 'dequinqueseptenis')">
                <!-- do nothing, because I can't figure out how to make it work with this match rule :( -kmd -->
            </xsl:when>
            <xsl:when test="./following-sibling::tei:editor">
                <span class="editor">Edited by <xsl:value-of select="."/> and <xsl:value-of
                        select="following-sibling::tei:editor"/></span>
            </xsl:when>
            <xsl:when test="./preceding-sibling::tei:editor"/>
            <xsl:otherwise>
                <span class="editor">Edited by <xsl:value-of select="."/></span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- basic paragraph rendering -->
    <xsl:template match="tei:p">

        <xsl:choose>
            <xsl:when test="//tei:idno = 'essay.grayprice'">
                <div class="p">
                    <xsl:apply-templates />
                </div>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'utctopsy'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.utctopsy'">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'juxta.utctopsy'">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when test="//tei:idno[@type = 'edition'] = 'sevenplanets'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.sevenplanets'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when test="//tei:idno[@type = 'edition'] = 'cranchjournal'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.cranchjournal'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:when test=".[@rend = 'text-indent:-2em;']">
                        <div class="p_indent">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'markonthewall'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.markonthewall'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'lowelledition'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.lowelledition'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>

                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'stufaiuolo'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.lowelledition'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:when test="parent::tei:sp">
                        <div class="sp_p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'swayzedrama'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.swayzedrama'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:when test="parent::tei:sp">
                        <div class="sp_p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'avisos'">
                <xsl:variable name="pNumber">
                    <xsl:for-each select=".">
                        <xsl:value-of select="substring(@n, 2)"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.avisos'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="paragraphNav">
                            <span class="paragraphNumber">
                                <xsl:value-of select="$pNumber"/>
                            </span>
                            <xsl:choose>
                                <xsl:when test="$avisos_english = 'yes'">
                                    <a title="see paragraph in the original Spanish"><xsl:attribute
                                            name="href">avisos.html#s<xsl:value-of select="$pNumber"
                                            /></xsl:attribute><xsl:attribute name="class"
                                            >OrigSpanishPara</xsl:attribute><!--&#9776;-->orig
                                            &#182;<xsl:value-of select="$pNumber"/></a>
                                    <a title="see paragraph in modernized Spanish"><xsl:attribute
                                            name="href">avisos_modernized.html#s<xsl:value-of
                                                select="$pNumber"/></xsl:attribute><xsl:attribute
                                            name="class">ModSpanishPara</xsl:attribute>mod
                                            &#182;<xsl:value-of select="$pNumber"/></a>
                                </xsl:when>
                                <xsl:when test="$avisos_modernized = 'yes'">
                                    <a title="see paragraph in the original Spanish"><xsl:attribute
                                            name="href">avisos.html#s<xsl:value-of select="$pNumber"
                                            /></xsl:attribute><xsl:attribute name="class"
                                            >OrigSpanishPara</xsl:attribute>orig &#182;<xsl:value-of
                                            select="$pNumber"/></a>
                                    <a title="see paragraph in English translation"><xsl:attribute
                                            name="href">avisos_english.html#e<xsl:value-of
                                                select="$pNumber"/></xsl:attribute><xsl:attribute
                                            name="class">EnglishPara</xsl:attribute>Engl
                                            &#182;<xsl:value-of select="$pNumber"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <a title="see paragraph in modernized Spanish"><xsl:attribute
                                            name="href">avisos_modernized.html#s<xsl:value-of
                                                select="$pNumber"/></xsl:attribute><xsl:attribute
                                            name="class">ModSpanishPara</xsl:attribute>mod
                                            &#182;<xsl:value-of select="$pNumber"/></a>
                                    <a title="see paragraph in English translation"><xsl:attribute
                                            name="href">avisos_english.html#e<xsl:value-of
                                                select="$pNumber"/></xsl:attribute><xsl:attribute
                                            name="class">EnglishPara</xsl:attribute>Engl
                                            &#182;<xsl:value-of select="$pNumber"/></a>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                        <div class="p">
                            <a>
                                <xsl:attribute name="name" select="@n"/>
                            </a>
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when test="//tei:idno[@type = 'edition'] = 'haley'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'haley.handnotes'">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'haley.typednotes'">
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'cwnewspaperpoetry'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.cwpoems'">
                        <xsl:choose>
                            <xsl:when test="parent::tei:note">
                                <div class="p">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <p>
                                    <xsl:apply-templates/>
                                </p>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="parent::tei:note[@type = 'editorial']">
                        <xsl:choose>
                            <xsl:when test="following-sibling::tei:p">
                                <div class="p">
                                    <xsl:apply-templates/>
                                </div>
                                <div class="blank_line">&#160;</div>
                            </xsl:when>
                            <xsl:otherwise>
                                <div class="p">
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="//tei:idno[@type = 'edition'] = 'youngidea'">
                <xsl:choose>
                    <xsl:when test="//tei:idno[@type = 'file'] = 'intro.youngidea'">
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:when>

                    <xsl:otherwise>
                        <div class="p">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:otherwise>

                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>
    <!-- linebreak rendering -->
    <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="$avisos_modernized = 'yes'"/>
            <xsl:when test="attribute::break = 'no'"/>
            <xsl:otherwise>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- basic <emph> rendering -->
    <xsl:template match="//tei:emph">
        <xsl:choose>
            <xsl:when test="@rend = 'smallcaps' or @rend = 'small caps'">
                <span class="smallcaps">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'italic'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:otherwise>
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- basic <hi> rendering -->
    <xsl:template match="//tei:hi">
        <xsl:variable name="rendvalue">
            <xsl:value-of select="@rend"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="./attribute::rend = 'italics'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'italic'">
                <em>
                    <xsl:apply-templates/>
                </em>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'bold'">
                <strong>
                    <xsl:apply-templates/>
                </strong>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'small-caps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'smallcaps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'small caps'">
                <small>
                    <xsl:value-of select="upper-case(.)"/>
                </small>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'decorated initial'">
                <span class="decoratedinitial">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'highlighting stroke'">
                <span class="highlightingstroke">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'superscript'">
                <span class="superscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'italic superscript'">
                <span class="italicsuperscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'bold superscript'">
                <span class="boldsuperscript">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'bold background(red)'">
                <span class="boldbackgroundred">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="starts-with($rendvalue, 'color')">

                <span>
                    <xsl:attribute name="style">color:#<xsl:value-of
                            select="substring($rendvalue, 7, 6)"/></xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'underline'">
                <u>
                    <xsl:apply-templates/>
                </u>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'underline align(center)'">
                <u>
                    <xsl:apply-templates/>
                </u>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'underline align(right)'">
                <span class="align_right">
                    <u>
                        <xsl:apply-templates/>
                    </u>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'align(right)'">
                <span class="align_right">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'align(center)'">
                <span class="center">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when
                test="./attribute::rend = 'double-underline' or ./attribute::rend = '2-underline'">
                <span class="double-underline">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'persign'">
                <span class="persign">
                    <img src="{$siteroot}images/persign.png" alt="[per sign]" height="10px"/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'longS'">
                <span class="longS">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'bubble'">
                <span class="bubble">(<xsl:apply-templates/>)</span>
            </xsl:when>
            <xsl:when test="./attribute::rend = 'enlarged'">
                <span class="enlarged">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- Figures -->
    <xsl:template match="//tei:figure" priority="1">
        <xsl:variable name="editionName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'edition']"/>
        </xsl:variable>
        <xsl:variable name="fileName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'file']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="attribute::type = 'inline'">
                <img class="inline">
                    <xsl:attribute name="src">
                        <xsl:value-of select="child::tei:graphic/attribute::url"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select="child::tei:figDesc"/>
                    </xsl:attribute>
                </img>
            </xsl:when>
            <xsl:when test="parent::tei:ref[@type = 'figure']"/>
            <xsl:when test="attribute::type = 'enlargeOnClick'">
                <span class="enlargeOnClick">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:choose>
                                <xsl:when test="$editionName = 'sevenplanets'">
                                    <xsl:text>sevenplanets/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="child::tei:graphic/attribute::url"/>
                                </xsl:when>
                                <xsl:when test="$editionName = 'cranchjournal'">
                                    <xsl:text>cranchjournal/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="child::tei:graphic/attribute::url"/>
                                </xsl:when>
                                <xsl:when test="$editionName = 'stufaiuolo'">
                                    <xsl:for-each select="child::tei:graphic">
                                        <xsl:text>stufaiuolo/pages/viewsize/</xsl:text>
                                        <xsl:value-of select="substring(./attribute::url, 7)"/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$editionName = 'hejinian'">
                                    <xsl:text>hejinian/pages/viewsize/</xsl:text>
                                    <xsl:value-of
                                        select="substring(child::tei:graphic/attribute::url, 8)"/>
                                </xsl:when>
                                <xsl:when
                                    test="$fileName = 'essay.calvert' or $fileName = 'essay.porter' or $fileName = 'essay.grayprice' or $fileName = 'essay.alpertabrams'">
                                    <xsl:text>images/viewsize/</xsl:text>
                                    <xsl:value-of
                                        select="substring(child::tei:graphic/attribute::url, 8)"/>
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:text>/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="child::tei:graphic/attribute::url"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <img width="600px">
                            <xsl:attribute name="src">
                                <xsl:choose>
                                    <xsl:when test="$editionName = 'sevenplanets'"
                                            >sevenplanets/<xsl:value-of
                                            select="child::tei:graphic/attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'cranchjournal'"
                                            >cranchjournal/<xsl:value-of
                                            select="child::tei:graphic/attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'hejinian'"
                                            >hejinian/<xsl:value-of
                                            select="child::tei:graphic/attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'stufaiuolo'"
                                            >stufaiuolo/<xsl:value-of
                                            select="child::tei:graphic/attribute::url"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="child::tei:graphic/attribute::url"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>

                            <xsl:attribute name="alt">
                                <xsl:value-of select="child::tei:figDesc"/>
                            </xsl:attribute>
                        </img>
                    </a>
                </span>
                <span class="fig_caption">
                    <xsl:choose>
                        <xsl:when test="descendant::tei:floatingText">
                            <xsl:for-each select="child::tei:head">
                                <h3>[Click on image to enlarge] <xsl:apply-templates/>
                                </h3>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::tei:div">
                                <span class="fig_floatingText_div">
                                    <xsl:for-each select="child::tei:head">
                                        <h3>
                                            <xsl:apply-templates/>
                                        </h3>
                                    </xsl:for-each>
                                    <xsl:for-each select="descendant::tei:p">
                                        <p>
                                            <xsl:apply-templates/>
                                        </p>
                                    </xsl:for-each>
                                </span>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="descendant::tei:head">
                                <h3>[Click on image to enlarge] <xsl:apply-templates/>
                                </h3>
                            </xsl:for-each>
                            <xsl:for-each select="descendant::tei:p">
                                <p>
                                    <xsl:apply-templates/>
                                </p>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>

                </span>


            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="@place = 'margin-left'">figure_left</xsl:when>
                            <xsl:when test="@place = 'margin-right'">figure_right</xsl:when>
                            <xsl:when test="@place = 'center'">figure_center</xsl:when>
                            <xsl:otherwise>figure</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:if test="$fileName = 'cranchjournal'">
                        <h3>
                            <xsl:apply-templates select="child::tei:head"/>
                        </h3>
                    </xsl:if>
                    <xsl:if test="$fileName = 'intro.hejinian'">
                        <xsl:for-each select="child::teiE:egXML">
                            <xsl:call-template name="egXML"/>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:for-each select="child::tei:graphic">
                        <img>
                            <xsl:attribute name="src">
                                <xsl:choose>
                                    <xsl:when test="$editionName = 'sevenplanets'"
                                            >sevenplanets/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'cwnewspaperpoetry'"
                                            >cwnewspaperpoetry/<xsl:value-of
                                            select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'markonthewall'"
                                            >markonthewall/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'cranchjournal'"
                                            >cranchjournal/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'hejinian'"
                                            >hejinian/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'swayzedrama'"
                                            >swayzedrama/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:when test="$editionName = 'stufaiuolo'"
                                            >stufaiuolo/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>

                                    <xsl:when test="$editionName = 'youngidea'"
                                            >youngidea/<xsl:value-of select="./attribute::url"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="./attribute::url"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="$editionName = 'sevenplanets'">
                                    <xsl:attribute name="height">
                                        <xsl:value-of select="./attribute::height"/>
                                    </xsl:attribute>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="child::tei:figDesc"/>
                            </xsl:attribute>
                        </img>
                    </xsl:for-each>
                    <span class="fig_caption">
                        <xsl:for-each select="descendant::tei:head">
                            <xsl:choose>
                                <xsl:when test="$fileName = 'cranchjournal'"/>
                                <xsl:otherwise>
                                    <h3>
                                        <xsl:apply-templates/>
                                    </h3>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <xsl:for-each select="descendant::tei:p">
                            <p>
                                <xsl:apply-templates/>
                            </p>
                        </xsl:for-each>

                    </span>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- for use of <graphic> in a <table> but not in a <figure> element -->

    <xsl:template match="//tei:cell/tei:graphic">
        <xsl:variable name="editionName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'edition']"/>
        </xsl:variable>
        <img>
            <xsl:choose>
                <xsl:when test="$editionName = 'sevenplanets'">
                    <xsl:attribute name="src">sevenplanets/<xsl:value-of select="./attribute::url"/>
                    </xsl:attribute>
                    <xsl:attribute name="height">
                        <xsl:value-of select="./attribute::height"/>
                    </xsl:attribute>

                </xsl:when>

                <xsl:otherwise>
                    <xsl:attribute name="src">
                        <xsl:value-of select="./attribute::url"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </img>

    </xsl:template>

    <!-- for example code meant to be maintained as XML in the display. The choice for the Hejinian intro is, admittedly, very lame, but I struggled to find a better way to do it and did this as a stop-gap measure. It should, of course, be a script not a hack like this. -->
    <xsl:template match="teiE:egXML" name="egXML">
        <pre><code><xsl:choose>
    <xsl:when test="ancestor::tei:TEI//tei:idno[@type = 'file'] = 'intro.hejinian'">&lt;l n="3"&gt;Far
    &lt;app&gt;
        &lt;rdg wit="#t7989-1-1"&gt;above&lt;/rdg&gt;
        &lt;rdg wit="#nocturne_poems"&gt;away&lt;/rdg&gt;
    &lt;/app&gt;
    , stars wheeling in space,&lt;/l&gt;</xsl:when>
</xsl:choose></code></pre>
    </xsl:template>



    <!-- for Tables -->
    <xsl:template match="//tei:table">
        <xsl:for-each select="child::tei:head">
<xsl:choose>
    <xsl:when test="$idno, 'essay'"><h3>
        <xsl:apply-templates/>
    </h3></xsl:when><xsl:otherwise><h2>
                <xsl:apply-templates/>
            </h2></xsl:otherwise>
</xsl:choose>
            
        </xsl:for-each>
        <table>
            <xsl:for-each select="child::tei:row">
                <xsl:variable name="cellNumber">
                    <xsl:value-of select="count(child::tei:cell)"/>
                </xsl:variable>
                <tr>
                    <xsl:attribute name="class">cells_<xsl:value-of select="$cellNumber"
                        /></xsl:attribute>
                    <xsl:for-each select="child::tei:cell">

                        <xsl:choose>
                            <xsl:when test="@role = 'label'">
                                <td>
                                    <b>
                                        <xsl:apply-templates/>
                                    </b>
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:apply-templates/>
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>


    <!-- For Poetry -->
    <xsl:template match="//tei:lg">
        <xsl:choose>
            <xsl:when test="@type = 'poem'">
                <div class="poem">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type = 'cluster'">
                <div class="cluster">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type = 'stanza'">
                <div>
                    <xsl:attribute name="class">stanza<xsl:if test="@rend = 'center'"
                            >_center</xsl:if></xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type = 'chorus'">
                <div class="stanza">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="poem">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:l">
        <xsl:choose>
            <xsl:when
                test="parent::tei:quote/ancestor::tei:note/ancestor::tei:back/ancestor::tei:TEI/descendant::tei:idno[@type = 'edition'] = 'cranchjournal'">
                <xsl:apply-templates/>
                <xsl:if test="following-sibling::tei:l">/&#160;</xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="class">poem_line<xsl:if test="@rend"><xsl:choose><xsl:when
                                    test="@rend = 'align(center)'"
                                        >_center</xsl:when><xsl:otherwise>_<xsl:value-of
                                        select="@rend"
                        /></xsl:otherwise></xsl:choose></xsl:if></xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Blockquotes -->
    <xsl:template match="//tei:q[attribute::rend = 'block']">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <!-- For bylines in documents -->
    <xsl:template match="//tei:byline">
        <span class="byline">
            <xsl:choose>
                <xsl:when test="preceding-sibling::tei:byline">
                    <xsl:choose>
                        <xsl:when test="following-sibling::tei:byline">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>and <xsl:apply-templates/></xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <!-- for front matter, like heads and bylines -->
    <xsl:template match="//tei:front">
        <div class="frontmatter">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- This is for email addresses;  apparently this protects the email addresses from being harvested
by bots, spammers, and other evildoers -->
    <xsl:template match="//tei:milestone[@unit = 'email']">
        <xsl:choose>
            <xsl:when test="@type = 'andyemail'">
                <script type="text/javascript">
                // protected email script by Joe Maller
                // JavaScripts available at http://www.joemaller.com
                // this script is free to use and distribute
                // but please credit me and/or link to my site
                
                emailE =('ajewell@' + 'unlnotes.unl.edu')
                document.write('<a href="mailto:' + emailE + '">' + emailE + '</a>
                ')
                //</script>
            </xsl:when>
            <xsl:when test="@type = 'amandaemail'">
                <script type="text/javascript">
                // protected email script by Joe Maller
                // JavaScripts available at http://www.joemaller.com
                // this script is free to use and distribute
                // but please credit me and/or link to my site
                
                emailE =('agailey2@' + 'unlnotes.unl.edu')
                document.write('<a href="mailto:' + emailE + '">' + emailE + '</a>
                ')
                //</script>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="//tei:ref">

        <xsl:variable name="editionName">
            <xsl:value-of select="//tei:publicationStmt/tei:idno[@type = 'edition']"/>
        </xsl:variable>
        <xsl:choose>
            <!-- <xsl:when test="$editionName='whitmanheydeletters'">
                <xsl:choose>
                    <xsl:when test=""></xsl:when>
                </xsl:choose>
                
            </xsl:when>-->
            <xsl:when test="$editionName = 'utctopsy'">
                <xsl:choose>
                    <xsl:when test="@target">
                        <xsl:choose>
                            <xsl:when test="ancestor::tei:div[@type = 'notes']">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@target"/>
                                        <xsl:choose>
                                            <xsl:when test="@type = 'url'"/>
                                            <xsl:when test="@type = 'html'">.html</xsl:when>
                                            <xsl:when test="@type = 'pdf'">.pdf</xsl:when>
                                            <xsl:when test="@type = 'xml'">.xml</xsl:when>
                                            <xsl:otherwise/>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:if test="@n">
                                        <xsl:attribute name="class">ref<xsl:value-of select="@n"
                                            /></xsl:attribute>
                                    </xsl:if>
                                    <xsl:apply-templates/>
                                </a>
                            </xsl:when>
                            <xsl:when
                                test="./ancestor::tei:TEI/descendant::tei:idno[@type = 'file'] = 'intro.utctopsy'">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@target"/>
                                        <xsl:choose>
                                            <xsl:when test="@type = 'url'"/>
                                            <xsl:when test="@type = 'html'">.html</xsl:when>
                                            <xsl:when test="@type = 'pdf'">.pdf</xsl:when>
                                            <xsl:when test="@type = 'xml'">.xml</xsl:when>
                                            <xsl:otherwise/>
                                        </xsl:choose>
                                    </xsl:attribute>

                                    <xsl:apply-templates/>
                                </a>
                            </xsl:when>
                            <xsl:when
                                test="./ancestor::tei:TEI/descendant::tei:idno[@type = 'file'] = 'juxta.utctopsy'">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@target"/>

                                    </xsl:attribute>

                                    <xsl:apply-templates/>
                                </a>
                            </xsl:when>

                            <xsl:otherwise>



                                <xsl:variable name="refTarget">
                                    <xsl:value-of select="attribute::target"/>
                                </xsl:variable>
                                <xsl:variable name="refContent">
                                    <xsl:for-each select=".">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="fileID">
                                    <xsl:value-of
                                        select="ancestor::tei:TEI/descendant::tei:idno[@type = 'file']"/>

                                </xsl:variable>

                                <xsl:for-each
                                    select="document('../2012/editions/utctopsy/utc_variants.xml')/tei:TEI">
                                    <xsl:for-each select="descendant::tei:item/tei:app">
                                        <xsl:variable name="appID">
                                            <xsl:for-each select="./attribute::loc">
                                                <xsl:value-of select="substring-after(., '#')"/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:variable name="ptrID">
                                            <xsl:for-each
                                                select="./following-sibling::tei:ptr/attribute::target">
                                                <xsl:value-of select="substring-after(., '#')"/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:variable name="rdgWit">
                                            <xsl:for-each select="child::tei:rdg">
                                                <xsl:value-of select="attribute::wit"/>
                                            </xsl:for-each>

                                        </xsl:variable>

                                        <xsl:if test="$appID = $refTarget">

                                            <div class="showNote">
                                                <!-- &#8620; &#9776;-->
                                                <xsl:if test="$utctopsy_notes = 'undefined'">

                                                  <a href="#" onclick="return false;">
                                                  <xsl:copy-of select="$refContent"/>
                                                  </a>

                                                </xsl:if>
                                            </div>
                                            <div>
                                                <xsl:attribute name="class">
                                                  <xsl:choose>
                                                  <xsl:when test="$utctopsy_notes = 'undefined'"
                                                  >appEntry</xsl:when>
                                                  <xsl:when test="$utctopsy_notes = 'show'"
                                                  >appEntryShow</xsl:when>
                                                  </xsl:choose>
                                                </xsl:attribute>
                                                <xsl:choose>
                                                  <xsl:when test="$utctopsy_notes = 'undefined'">
                                                  <a href="#" class="closenote">X</a>
                                                  </xsl:when>
                                                  <xsl:when test="$utctopsy_notes = 'show'"
                                                  ><!--no x needed if all notes are shown--></xsl:when>
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

                            </xsl:otherwise>
                        </xsl:choose>






                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:when>

            <xsl:when test="$editionName = 'youngidea'">
                <xsl:choose>
                    <xsl:when test="@target">
                        <xsl:choose>
                            <xsl:when test="starts-with(@target, 'variants')">
                                <xsl:variable name="refTarget">
                                    <xsl:value-of
                                        select="substring-after(attribute::target, 'variants.youngidea.xml#')"
                                    />
                                </xsl:variable>
                                <xsl:variable name="refContent">
                                    <xsl:for-each select=".">
                                        <xsl:copy-of select="."/>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="fileID">
                                    <xsl:value-of
                                        select="ancestor::tei:TEI/descendant::tei:idno[@type = 'file']"
                                    />
                                </xsl:variable>
                                <xsl:for-each
                                    select="document('../2016/editions/youngidea/variants.youngidea.xml')/tei:TEI">
                                    <xsl:for-each select="descendant::tei:item/tei:app">
                                        <xsl:variable name="appID">
                                            <xsl:for-each select="./attribute::loc">
                                                <xsl:value-of select="substring-after(., '#')"/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:variable name="rdgWit">
                                            <xsl:for-each select="child::tei:rdg">
                                                <xsl:value-of select="attribute::wit"/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:variable name="rdgNote">
                                            <xsl:for-each select="child::tei:rdg">
                                                <xsl:copy-of select="."/>
                                            </xsl:for-each>
                                        </xsl:variable>
                                        <xsl:if test="$appID = $refTarget">
                                            <div class="showNote">
                                                <!-- &#8620; &#9776;-->
                                                <a href="#" onclick="return false;">
                                                  <xsl:value-of select="$refContent"/>
                                                </a>
                                            </div>
                                            <div>
                                                <xsl:attribute name="class">appEntry</xsl:attribute>
                                                <a href="#" class="closenote">X</a>
                                                <xsl:for-each select="$rdgNote">
                                                  <xsl:apply-templates/>
                                                </xsl:for-each>

                                            </div>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@target"/>
                                        <xsl:choose>
                                            <xsl:when test="@type = 'url'"/>
                                            <xsl:when test="@type = 'html'">.html</xsl:when>
                                            <xsl:when test="@type = 'pdf'">.pdf</xsl:when>
                                            <xsl:when test="@type = 'xml'">.xml</xsl:when>
                                            <xsl:otherwise/>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:if test="@n">
                                        <xsl:attribute name="class">ref<xsl:value-of select="@n"
                                            /></xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="@rend = 'new'">
                                        <xsl:attribute name="target">_blank</xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="@xml:id">
                                        <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
                                    </xsl:if>
                                    <xsl:apply-templates/>
                                </a>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>








            <xsl:when test="@type = 'figure'">
                <span class="viewsize">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:choose>
                                <xsl:when test="$editionName = 'baroness'">
                                    <xsl:value-of select="descendant::tei:graphic/attribute::url"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$editionName"/>
                                    <xsl:text>/pages/viewsize/</xsl:text>
                                    <xsl:value-of select="descendant::tei:graphic/attribute::url"/>
                                    <xsl:text>.jpg</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:value-of select="child::tei:figure/child::tei:head"/>
                            <xsl:if test="string(child::tei:figure/child::tei:p)">
                                <xsl:value-of
                                    select="concat('&lt;br &gt;', child::tei:figure/child::tei:p[normalize-space()])"
                                />
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </span>
            </xsl:when>

            <xsl:when test="$editionName = 'stufaiuolo'">
                <xsl:choose>
                    <xsl:when test="@type = 'v_msDesc'">
                        <div class="showNote">
                            <a href="#" onclick="return false;">
                                <xsl:apply-templates/>
                            </a>
                        </div>
                        <div class="appEntry">
                            <a href="#" class="closenote">X</a>
                            <div class="appRdg">
                                <xsl:for-each
                                    select="doc('../2015/editions/stufaiuolo/stufaiuolo.valentiniana.xml')//tei:msDesc">
                                    <h1>Manuscript Description, Valentiniana MS</h1>
                                    <p>
                                        <xsl:for-each select="//tei:msIdentifier/*">
                                            <xsl:apply-templates/>
                                            <xsl:if test="following-sibling::*">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </p>
                                    <xsl:variable name="mspart">
                                        <xsl:choose>
                                            <xsl:when test="//tei:TEI[@xml:id = 'ric']">
                                                <xsl:copy-of select="tei:msPart/tei:physDesc"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="tei:physDesc"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:variable name="mspartpath" select="$mspart"/>
                                    <xsl:for-each select="$mspart">
                                        <h4>Physical Description</h4>
                                        <p><strong>Material</strong>: </p>
                                        <xsl:for-each select=".//tei:support/tei:material">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <p><strong>Dimensions</strong>: <xsl:for-each
                                                select=".//tei:extent/tei:dimensions">
                                                <xsl:apply-templates select="tei:width"/><xsl:text>mm x</xsl:text>
                                                <xsl:apply-templates select="tei:height"
                                                /><xsl:text>mm</xsl:text>
                                            </xsl:for-each></p>
                                        <p>
                                            <xsl:apply-templates select=".//tei:foliation"/>
                                        </p>
                                        <p>
                                            <xsl:apply-templates select=".//tei:collation"/>
                                        </p>
                                        <p>
                                            <xsl:apply-templates
                                                select=".//tei:supportDesc/tei:condition"/>
                                        </p>
                                        <p><strong>Layout</strong>: <xsl:apply-templates
                                                select=".//tei:layoutDesc"/></p>
                                        <p>Autograph; scripts: <ul><xsl:for-each
                                                  select=".//tei:handNote">
                                                  <li><xsl:apply-templates/></li></xsl:for-each></ul></p>
                                        <p><strong>Decorations</strong>:</p>
                                        <div style="margin-left:15pt">
                                            <xsl:if test=".//tei:decoNote[@type = 'frontespiece']">
                                                <p>Frontespiece: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'frontespiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if
                                                test=".//tei:decoNote[@type = 'penwork-initials']">
                                                <p>Penwork initials: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'penwork-initials']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'drop-capital']">
                                                <p>Drop capitals: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'drop-capital']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'headpiece']">
                                                <p>Head pieces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'headpiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'tailpiece']">
                                                <p>Tail pieces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'tailpiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'cadel']">
                                                <p>Cadels: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'cadel']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'cartouche']">
                                                <p>Cartouces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'cartouche']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'panle']">
                                                <p>Panels: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'panel']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                        </div>
                                        <xsl:if test=".//tei:additions">
                                            <p><strong>Additions and annotations</strong>:
                                                  <xsl:apply-templates select=".//tei:additions"
                                                /></p>
                                        </xsl:if>
                                        <xsl:if test=".//tei:bindingDesc">
                                            <xsl:apply-templates select=".//tei:bindingDesc/tei:p"/>
                                        </xsl:if>
                                        <xsl:if test=".//tei:accMat">
                                            <p><strong>Accompaining Material</strong>:
                                                  <xsl:apply-templates select=".//tei:accMat"/></p>
                                        </xsl:if>
                                    </xsl:for-each>


                                </xsl:for-each>

                            </div>
                        </div>

                    </xsl:when>
                    <xsl:when test="@type = 'r_msDesc'">
                        <div class="showNote">
                            <a href="#" onclick="return false;">
                                <xsl:apply-templates/>
                            </a>
                        </div>
                        <div class="appEntry">
                            <a href="#" class="closenote">X</a>
                            <div class="appRdg">
                                <xsl:for-each
                                    select="doc('../2015/editions/stufaiuolo/stufaiuolo.riccardiana.xml')//tei:msDesc">
                                    <h1>Manuscript Description, Riccardiana MS</h1>
                                    <p>
                                        <xsl:for-each select="//tei:msIdentifier/*">
                                            <xsl:apply-templates/>
                                            <xsl:if test="following-sibling::*">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </p>
                                    <xsl:variable name="mspart">
                                        <xsl:choose>
                                            <xsl:when test="//tei:TEI[@xml:id = 'ric']">
                                                <xsl:copy-of select="tei:msPart/tei:physDesc"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy-of select="tei:physDesc"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:variable name="mspartpath" select="$mspart"/>
                                    <xsl:for-each select="$mspart">
                                        <h4>Physical Description</h4>
                                        <p><strong>Material</strong>: </p>
                                        <xsl:for-each select=".//tei:support/tei:material">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <p><strong>Dimensions</strong>: <xsl:for-each
                                                select=".//tei:extent/tei:dimensions">
                                                <xsl:apply-templates select="tei:width"/><xsl:text>mm x</xsl:text>
                                                <xsl:apply-templates select="tei:height"
                                                /><xsl:text>mm</xsl:text>
                                            </xsl:for-each></p>
                                        <p>
                                            <xsl:apply-templates select=".//tei:foliation"/>
                                        </p>
                                        <p>
                                            <xsl:apply-templates select=".//tei:collation"/>
                                        </p>
                                        <p>
                                            <xsl:apply-templates
                                                select=".//tei:supportDesc/tei:condition"/>
                                        </p>
                                        <p><strong>Layout</strong>: <xsl:apply-templates
                                                select=".//tei:layoutDesc"/></p>
                                        <p>Autograph; scripts: <ul><xsl:for-each
                                                  select=".//tei:handNote">
                                                  <li><xsl:apply-templates/></li></xsl:for-each></ul></p>
                                        <p><strong>Decorations</strong>:</p>
                                        <div style="margin-left:15pt">
                                            <xsl:if test=".//tei:decoNote[@type = 'frontespiece']">
                                                <p>Frontespiece: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'frontespiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if
                                                test=".//tei:decoNote[@type = 'penwork-initials']">
                                                <p>Penwork initials: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'penwork-initials']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'drop-capital']">
                                                <p>Drop capitals: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'drop-capital']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'headpiece']">
                                                <p>Head pieces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'headpiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'tailpiece']">
                                                <p>Tail pieces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'tailpiece']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'cadel']">
                                                <p>Cadels: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'cadel']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'cartouche']">
                                                <p>Cartouces: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'cartouche']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                            <xsl:if test=".//tei:decoNote[@type = 'panle']">
                                                <p>Panels: </p>
                                                <ul>
                                                  <xsl:for-each
                                                  select=".//tei:decoNote[@type = 'panel']">
                                                  <li>
                                                  <xsl:apply-templates/>
                                                  </li>
                                                  </xsl:for-each>
                                                </ul>
                                            </xsl:if>
                                        </div>
                                        <xsl:if test=".//tei:additions">
                                            <p><strong>Additions and annotations</strong>:
                                                  <xsl:apply-templates select=".//tei:additions"
                                                /></p>
                                        </xsl:if>
                                        <xsl:if test=".//tei:bindingDesc">
                                            <xsl:apply-templates select=".//tei:bindingDesc/tei:p"/>
                                        </xsl:if>
                                        <xsl:if test=".//tei:accMat">
                                            <p><strong>Accompaining Material</strong>:
                                                  <xsl:apply-templates select=".//tei:accMat"/></p>
                                        </xsl:if>
                                    </xsl:for-each>


                                </xsl:for-each>

                            </div>
                        </div>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$editionName = 'lowelledition'">
                <xsl:choose>
                    <xsl:when test="parent::tei:note[@type = 'annotation']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>

                <a>
                    <xsl:attribute name="href">
                        <xsl:if test="@type = 'email'">mailto:</xsl:if>
                        <xsl:if test="$editionName = 'cwnewspaperpoetry'">
                            <xsl:if test="contains(@target, 'pp')"
                                >cwnewspaperpoetry/pages/issues/fullsize/</xsl:if>
                        </xsl:if>
                        <xsl:if test="@type != 'url'">
                            <xsl:choose>
                                <xsl:when test="@type = 'email'"/>
                                <xsl:otherwise>
                                    <xsl:value-of select="$siteroot"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:value-of select="@target"/>
                        <xsl:choose>
                            <xsl:when test="$editionName = 'cwnewspaperpoetry'">
                                <xsl:choose>
                                    <xsl:when test="contains(@target, 'pp')">.jpg</xsl:when>
                                    <xsl:when test="@type = 'url'"/>
                                    <xsl:otherwise>.html</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="@type = 'url'"/>
                            <xsl:when test="@type = 'html'">.html</xsl:when>
                            <xsl:when test="@type = 'pdf'">.pdf</xsl:when>
                            <xsl:when test="@type = 'xml'">.xml</xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:if test="@n">
                        <xsl:attribute name="class">ref<xsl:value-of select="@n"/></xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </a>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>




    <!-- to get the witness list in <sourceDesc> into a list of options-->
    <xsl:template match="//tei:sourceDesc//tei:listWit">
        <ul class="listWit">
            <li>
                <span class="listWitHead">Select a Witness</span>
                <div>
                    <ul>

                        <xsl:for-each select="./child::tei:witness">
                            <li>
                                <a>
                                    <xsl:attribute name="href"><xsl:value-of select="$siteroot"
                                                /><xsl:choose><xsl:when
                                                test="ancestor::tei:TEI//tei:idno[@type = 'edition'] = 'sunsetwings'"
                                                >2013</xsl:when><xsl:when
                                                test="ancestor::tei:TEI//tei:idno[@type = 'edition'] = 'markonthewall'"
                                                >2014</xsl:when><xsl:when
                                                test="ancestor::tei:TEI//tei:idno[@type = 'edition'] = 'lowelledition'"
                                                >2015</xsl:when></xsl:choose>/editions/<xsl:value-of
                                            select="//tei:idno[@type = 'edition']"/>_<xsl:value-of
                                            select="@xml:id"/>.html</xsl:attribute>
                                    <xsl:if
                                        test="ancestor::tei:TEI//tei:idno[@type = 'edition'] = 'sunsetwings'"
                                            ><xsl:value-of select="@xml:id"/>.&#160;</xsl:if>
                                    <xsl:apply-templates/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </li>
        </ul>

    </xsl:template>

    <!-- HWH -->
    <xsl:template name="NotesList">
        <div class="notesList">
            <h2>Notes</h2>
            <ul>
                <xsl:for-each select="//tei:note">
                    <li>
                        <xsl:choose>
                            <xsl:when test="@type = 'editorial'">
                                <xsl:variable name="noteNumber">
                                    <xsl:number count="//tei:note[@type = 'editorial']" level="any"
                                    />
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
                                    <span class="noteRef">[<xsl:value-of select="$noteNumber"
                                        />]</span>
                                </a>
                            </xsl:when>

                            <xsl:otherwise/>


                        </xsl:choose>
                        <xsl:apply-templates/>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>



</xsl:stylesheet>
