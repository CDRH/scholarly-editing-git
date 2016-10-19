<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
    <xsl:template match="TEI">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//titleStmt/title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="stufaiolo.css"/>
            </head>
            <body>
                <div class="wrapper">
                    <!--<div class="intesta">
                        <h2 class="main2">Lo Stufaiuolo del Doni - edizione digitale</h2>
                    </div>
                    <div class="img">
                        <div>
                            <a href="home.html" class="frametoc">Home</a>
                        </div>
                        <xsl:call-template name="vale"/>
                        <!-\-<xsl:call-template name="ricca"/>-\->
                        <div>
                            <a href="confronta.html" class="frametoc">Confronta Versioni</a>
                        </div>
                        <div>
                            <a href="interventi.html" class="frametoc">Criteri editoriali</a>
                        </div>
                    </div>-->
                    <div class="main">
                        <div class="plain">
                            <xsl:apply-templates select="text"/>
                        </div>
                    </div>
                    <div class="notes">
                        <div class="plain">
                            <h3>Notes</h3>
                            <xsl:for-each select=".//note[ancestor::text]">
                                <p>
                                    <a>
                                        <xsl:attribute name="id">note_<xsl:number count="note"
                                                from="text" level="any"/></xsl:attribute>
                                        <xsl:number count="note" from="text" level="any"/>
                                    </a>
                                    <xsl:text>. </xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="@sameAs">
                                            <xsl:variable name="sameAs" select="substring-after(@sameAs, '#')"/>
                                            <xsl:variable name="file-note" select="substring-before(@sameAs, '#')"/>
                                            <xsl:for-each select="doc($file-note)//note[@xml:id = $sameAs]">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>
                                            <!--<xsl:for-each select="doc(concat('../',$file-note))//note[@xml:id = $sameAs]">
                                                <xsl:apply-templates/>
                                            </xsl:for-each>-->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <a><xsl:attribute name="href">#ref_<xsl:number count="note"
                                                from="text" level="any"/></xsl:attribute>[Back to
                                        text]</a>
                                </p>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </body>

        </html>
    </xsl:template>

    <xsl:template match="text//note">

        <sup>
            <a href="#" class="tooltip">
                <xsl:attribute name="href">#note_<xsl:number count="note" from="text" level="any"
                    /></xsl:attribute>
                <xsl:attribute name="id">ref_<xsl:number count="note" from="text" level="any"
                    /></xsl:attribute>
                <xsl:number count="note" from="text" level="any"/>
                <span>
                    <img class="callout" src="callout.gif" />
                    <xsl:choose>
                        <xsl:when test="@sameAs">
                            <xsl:variable name="sameAs" select="substring-after(@sameAs, '#')"/>
                            <xsl:variable name="file-note" select="substring-before(@sameAs, '#')"/>
                            <xsl:for-each select="doc($file-note)//note[@xml:id = $sameAs]">
                                <xsl:apply-templates/>
                            </xsl:for-each><!--<xsl:for-each select="doc(concat('../',$file-note))//note[@xml:id = $sameAs]">
                                <xsl:apply-templates/>
                            </xsl:for-each>-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </a>
        </sup>
    </xsl:template>
    <xsl:template name="vale">
        <div>
            <a href="valentiniana.html" class="frametoc">Manoscritto V</a>
            <a class="frametoc2" href="camerino-ms.html">Edizione diplomatica</a>
            <a class="frametoc2" href="camerino-in.html">Edizione semi-diplomatica</a>
            <a class="frametoc2" href="camerino-ed.html">Edizione critica</a>
        </div>
        <div>
            <a href="ricca.html" class="frametoc">Manoscritto R</a>
        </div>
    </xsl:template>

    <xsl:template name="ricca">
        <div>
            <a href="valentiniana.html" class="frametoc">Manoscritto V</a>
        </div>
        <div>
            <a href="ricca.html" class="frametoc">Manoscritto R</a>
            <a class="frametoc2" href="riccardiana-ms.html">Edizione diplomatica</a>
            <a class="frametoc2" href="riccardiana-in.html">Edizione semi-diplomatica</a>
            <a class="frametoc2" href="riccardiana-ed.html">Edizione critica</a>
        </div>
    </xsl:template>


    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="parent::sp">
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


    </xsl:template>

    <xsl:template match="sp">
        <div class="sp">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="text/*/div/head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="div/div/head">
        <h3 style="text-transform:uppercase;">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

    <xsl:template match="//front/div/ab">
        <center>
            <h2>
                <xsl:apply-templates/>
            </h2>
        </center>
    </xsl:template>

    <xsl:template match="epigraph[@rend='center']">
        <center>
            <xsl:apply-templates/>
        </center>
    </xsl:template>

    <xsl:template match="body/head">
        <center>
            <h2>
                <xsl:apply-templates/>
            </h2>
        </center>
    </xsl:template>


    <xsl:template match="castList/head">
        <dl>
            <dd>
                <p align="center">
                    <STRONG>
                        <font size="4">
                            <xsl:apply-templates/>
                        </font>
                    </STRONG>
                </p>
            </dd>
        </dl>
    </xsl:template>


    <xsl:template match="hi[@rend='maiuscoletto']">
        <span style="font-variant:sc">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="p[@rend='right']">
        <p style="margin-left:10cm">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="signed[@rend='right']">
        <span style="width:20em"/>
        <xsl:apply-templates/>
    </xsl:template>



    <xsl:template match="epigraph">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ptr"> </xsl:template>
    <xsl:template match="opener">
        <div align="center">
            <xsl:apply-templates/>
        </div>

    </xsl:template>

</xsl:stylesheet>
