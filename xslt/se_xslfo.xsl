<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei fo" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:strip-space elements="tei:ref" />
    <xsl:variable name="bylineCount">
        <xsl:value-of select="count(//tei:front/descendant::tei:byline)" />
    </xsl:variable>
    <xsl:variable name="idno">
        <xsl:value-of select="//descendant::tei:idno[@type='file']" />
    </xsl:variable>
    <xsl:template match="tei:TEI">
        <xsl:variable name="figure">
            <xsl:if test="./descendant::tei:figure">
                <fo:block text-align="center" font-family="AGaramondPro-Regular" font-size="15pt"
                    break-before="page">Figures</fo:block>
            </xsl:if>
            <xsl:for-each select="//tei:figure">
                <xsl:variable name="fileID">
                    <xsl:value-of select="./ancestor::tei:TEI/descendant::tei:idno" />
                </xsl:variable>
                <xsl:variable name="graphicID">
                    <xsl:value-of select="./descendant::tei:graphic/attribute::url" />
                </xsl:variable>
                <!-- this gets Exhibit info showing up in Broude's piece -->
                <xsl:if test="./parent::tei:div[@type='exhibit']">
                    <fo:block font-size="12pt" text-align="center" padding-top="10pt"
                        font-family="AGaramondPro-Regular">
                        <xsl:for-each
                            select="./parent::tei:div[@type='exhibit']/descendant::tei:head[@type='main']">
                            <xsl:apply-templates />
                        </xsl:for-each>
                    </fo:block>
                    <fo:block font-size="10pt" text-align="center" padding-top="10pt"
                        font-family="AGaramondPro-Regular">
                        <xsl:for-each
                            select="./parent::div[@type='exhibit']/descendant::tei:head[@type='sub']">
                            <xsl:apply-templates />
                        </xsl:for-each>
                    </fo:block>
                </xsl:if>
                <fo:block text-align="center" break-after="page">
                    <xsl:attribute name="padding-top">
                        <xsl:choose>
                            <xsl:when test="./parent::tei:div[@type='exhibit']">.5pc</xsl:when>
                            <xsl:otherwise>2pc</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <fo:external-graphic content-height="32pc" content-width="26pc"
                        scaling="uniform" padding="0" margin="0">
                        <xsl:attribute name="src"
                            >url(/Users/ajewell/Documents/scholarly-editing-git/2016/essays/<xsl:value-of
                            select="$graphicID" />)</xsl:attribute>
                    </fo:external-graphic>
                    <xsl:choose>
                    <xsl:when test="descendant::tei:floatingText">
                        <xsl:for-each select="child::tei:head"><fo:block font-size="8pt" text-align="justify" padding-top="10pt"
                            font-family="AGaramondPro-Regular"><xsl:apply-templates/></fo:block></xsl:for-each>
                        <xsl:for-each select="descendant::tei:div">
                            <xsl:for-each select="child::tei:head"><fo:block font-size="8pt" text-align="justify" padding-top="10pt"
                                font-family="AGaramondPro-Regular"><xsl:apply-templates/></fo:block></xsl:for-each>
                            <xsl:for-each select="child::tei:p"><fo:block font-size="6pt" text-align="justify" padding-top="10pt"
                                padding-left="2cm" padding-right="2cm" font-family="AGaramondPro-Regular"><xsl:apply-templates /></fo:block></xsl:for-each>

</xsl:for-each>


</xsl:when>

<xsl:otherwise><fo:block font-size="8pt" text-align="justify" padding-top="10pt"
                        font-family="AGaramondPro-Regular">
                        <xsl:for-each select="./descendant::tei:head">
                            <xsl:apply-templates />
                        </xsl:for-each>
                    </fo:block>
                    <xsl:for-each select="./descendant::tei:p"><fo:block font-size="6pt" text-align="justify" padding-top="10pt"
                        padding-left="2cm" padding-right="2cm" font-family="AGaramondPro-Regular"><xsl:apply-templates /></fo:block></xsl:for-each></xsl:otherwise></xsl:choose>
                </fo:block>
            </xsl:for-each>
        </xsl:variable>
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="first-page" page-width="6in" page-height="9in">
                    <fo:region-body margin-top="5pc" margin-left="5pc" margin-right="5pc"
                        margin-bottom="6pc" />
                    <fo:region-before extent="5pc" region-name="first-page" />
                    <fo:region-after extent="6pc" />
                </fo:simple-page-master>
                <fo:simple-page-master master-name="odd-page" page-width="6in" page-height="9in">
                    <fo:region-body margin-top="5pc" margin-left="5pc" margin-right="5pc"
                        margin-bottom="6pc" />
                    <fo:region-before extent="5pc" region-name="odd-page" margin-left="5pc"
                        margin-right="5pc" />
                    <fo:region-after extent="6pc" />
                </fo:simple-page-master>
                <fo:simple-page-master master-name="even-page" page-width="6in" page-height="9in">
                    <fo:region-body margin-top="5pc" margin-left="5pc" margin-right="5pc"
                        margin-bottom="6pc" />
                    <fo:region-before extent="5pc" region-name="even-page" margin-left="5pc"
                        margin-right="5pc" />
                    <fo:region-after extent="6pc" />
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="my-sequence">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference page-position="first"
                            master-reference="first-page" />
                        <fo:conditional-page-master-reference odd-or-even="odd"
                            master-reference="odd-page" />
                        <fo:conditional-page-master-reference odd-or-even="even"
                            master-reference="even-page" />
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="my-sequence">
                <fo:static-content flow-name="first-page">
                    <fo:block font-size="8pt" font-family="AGaramondPro-Regular" padding="0pc"
                        margin-left="5pc" margin-right="5pc" margin-top="2.5pc">
                        <fo:block font-size="10pt" font-family="GoudyBookletter1911Regular"
                            text-align="left" padding-bottom="0cm" font-style="normal">
                            <fo:inline font-style="italic" font-family="AGaramondPro-Italic"
                                >Scholarly Editing: The Annual of the Association for Documentary Editing
                                        </fo:inline>
                        </fo:block>
                        <fo:block font-size="9pt" font-family="GoudyBookletter1911Regular"
                            text-align="left" padding-bottom="0cm" font-style="normal"
                            >Volume&#160;<xsl:value-of
                            select="//tei:seriesStmt/descendant::tei:idno[@type='vol']"
                             />, <xsl:value-of select="//tei:publicationStmt//tei:date"
                             />&#160;|&#160;http://www.scholarlyediting.org/<xsl:value-of
                            select="//tei:publicationStmt//tei:date" />/essays/<xsl:value-of
                            select="//tei:fileDesc//tei:publicationStmt/tei:idno"
                             />.html
</fo:block>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="odd-page">
                    <!-- header-width is the width of the full header in picas -->
                    <xsl:variable name="header-width" select="26" />
                    <xsl:variable name="header-field-width">
                        <xsl:value-of select="$header-width * 0.3333" />
                        <xsl:text>pc</xsl:text>
                    </xsl:variable>
                    <fo:list-block font-size="8pt" provisional-label-separation="0pt"
                        font-family="AGaramondPro-Regular" padding="0pc" margin-left="5pc"
                        margin-right="5pc" margin-top="2.5pc">
                        <xsl:attribute name="provisional-distance-between-starts">
                            <xsl:value-of select="$header-field-width" />
                        </xsl:attribute>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block text-align="left">
                                    <fo:page-number font-size="8pt" />
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:list-block provisional-label-separation="0pt">
                                    <xsl:attribute name="provisional-distance-between-starts">
                                        <xsl:value-of select="$header-field-width" />
                                    </xsl:attribute>
                                    <fo:list-item>
                                        <fo:list-item-label end-indent="label-end()">
                                            <!-- <fo:block text-align="center">
                                               <fo:inline font-style="italic" font-family="AGaramondPro-Italic">Scholarly Editing</fo:inline>, Vol.&#160;<xsl:value-of
                                                  select=".//tei:seriesStmt/descendant::tei:idno[@type='vol']"
                                                   />, <xsl:value-of
                                                  select=".//tei:publicationStmt//tei:date" />
                                            </fo:block>--> </fo:list-item-label>
                                        <fo:list-item-body start-indent="body-start()">
                                            <fo:block text-align="right"> <fo:inline
                                                font-style="italic"
                                                font-family="AGaramondPro-Italic"
                                                >Scholarly Editing</fo:inline>&#160;<xsl:value-of
                                                select=".//tei:seriesStmt/descendant::tei:idno[@type='vol']"
                                                 /> (<xsl:value-of
                                                select=".//tei:publicationStmt//tei:date"
                                                 />)</fo:block>
                                        </fo:list-item-body>
                                    </fo:list-item>
                                </fo:list-block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                    <!--<fo:block text-align-last="justify" margin-left="5pc" margin-right="5pc"
                        padding-top="-.5pc">
                        <fo:leader leader-pattern="rule" rule-thickness=".5pt" />
                    </fo:block>-->
                </fo:static-content>
                <fo:static-content flow-name="even-page">
                    <!-- header-width is the width of the full header in picas -->
                    <xsl:variable name="header-width" select="26" />
                    <xsl:variable name="header-field-width">
                        <xsl:value-of select="$header-width * 0.5" />
                        <xsl:text>pc</xsl:text>
                    </xsl:variable>
                    <fo:list-block font-size="8pt" provisional-label-separation="0pt"
                        font-family="AGaramondPro-Regular" padding="0pc" margin-left="5pc"
                        margin-right="5pc" margin-top="2.5pc">
                        <xsl:attribute name="provisional-distance-between-starts">
                            <xsl:value-of select="$header-field-width" />
                        </xsl:attribute>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block text-align="left">
                                    <xsl:choose>
                                        <xsl:when test="starts-with($idno,'review')">
                                            <xsl:choose>
                                                <xsl:when
                                                  test="starts-with($idno,'review.recenteditions')"
                                                  ><xsl:text>Recent Editions</xsl:text></xsl:when>
                                                <xsl:otherwise><xsl:text>Review</xsl:text></xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                    "<xsl:value-of
                                            select="//tei:titleStmt/descendant::tei:title[@type='main']"
                                             />"</xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:list-block provisional-label-separation="0pt">
                                    <xsl:attribute name="provisional-distance-between-starts">
                                        <xsl:value-of select="$header-field-width" />
                                    </xsl:attribute>
                                    <fo:list-item>
                                        <fo:list-item-label end-indent="label-end()">
                                            <!--<fo:block text-align="center">
                                                "<xsl:value-of
                                                  select="//tei:titleStmt/descendant::tei:title[@type='main']"
                                                 />"
                                            </fo:block>--> </fo:list-item-label>
                                        <fo:list-item-body start-indent="body-start()">
                                            <fo:block text-align="right">
                                                <fo:page-number font-size="8pt" />
                                            </fo:block>
                                        </fo:list-item-body>
                                    </fo:list-item>
                                </fo:list-block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                    <!--<fo:block text-align-last="justify" margin-left="5pc" margin-right="5pc"
                        padding-top="-.5pc">
                        <fo:leader leader-pattern="rule" rule-thickness=".5pt" />
                    </fo:block>-->
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <xsl:apply-templates select="//tei:notesStmt" />
                        <xsl:apply-templates select="//tei:text" />
                        <!--<xsl:apply-templates select="//tei:sourceDesc" />-->
                        <xsl:copy-of select="$figure" />
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="//tei:teiHeader" />
    <xsl:template match="//tei:lb">
        <xsl:text> </xsl:text>
    </xsl:template>
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="attribute::type='main'">
                <xsl:choose>
                    <xsl:when test="parent::tei:front | parent::tei:body">
                        <xsl:choose>
                            <xsl:when test="starts-with($idno,'review')">
                                <xsl:choose>
                                    <xsl:when test="starts-with($idno,'review.recenteditions')">
                                        <fo:block font-size="20pt" text-align="left"
                                            padding-top="3pc" wrap-option="wrap"
                                            font-family="GoudyBookletter1911Regular">
                                            <xsl:apply-templates />
                                        </fo:block>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose><xsl:when test="preceding-sibling::tei:head[@type='main']"><fo:block font-size="12pt" text-align="left"
                                            padding-top="0pc" wrap-option="wrap"
                                            font-family="GoudyBookletter1911Regular"
                                            padding-bottom="1pc">
                                            <xsl:apply-templates />
                                        </fo:block></xsl:when><xsl:otherwise><fo:block font-size="12pt" text-align="left"
                                            padding-top="3pc" wrap-option="wrap"
                                            font-family="GoudyBookletter1911Regular"
                                            padding-bottom="1pc">
                                            <xsl:apply-templates />
                                        </fo:block></xsl:otherwise></xsl:choose>
                                        
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:block font-size="20pt" text-align="left" padding-top="3pc"
                                    wrap-option="wrap" font-family="GoudyBookletter1911Regular">
                                    <xsl:apply-templates />
                                </fo:block>
                                <xsl:if test="following-sibling::tei:head[@type='sub']">
                                    <xsl:variable name="subheads">
                                        <xsl:for-each
                                            select="following-sibling::tei:head[@type='sub']">
                                            <fo:inline>
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="./following-sibling::tei:head[@type='sub']"
                                                  ><xsl:apply-templates />&#160;&#8226;&#160;</xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:apply-templates />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:inline>
                                        </xsl:for-each>
                                    </xsl:variable>
                                    <fo:block font-size="16pt" text-align="left" padding-top="0pc"
                                        margin-bottom="10pt" wrap-option="wrap"
                                        font-family="GoudyBookletter1911Regular">
                                        <xsl:copy-of select="$subheads" />
                                    </fo:block>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="parent::tei:div[@type='section']">
                        <fo:block font-size="12pt" text-align="left" padding-top="1pc"
                            padding-bottom="1pc" font-family="GoudyBookletter1911Regular">
                            <xsl:apply-templates />
                        </fo:block>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:text">
        <fo:block font-family="AGaramondPro-Regular" break-before="page">
            <xsl:if test="./ancestor::tei:TEI/descendant::tei:notesStmt/tei:note[@type='editorial']">
                <xsl:for-each select="//tei:notesStmt/tei:note[@type='editorial']">
                    <fo:block border-color="black" border-style="solid" border-width="1px"
                        padding="10px" font-size="8pt" font-family="AGaramondPro-Regular">
                        <fo:block font-family="AGaramondPro-Bold"
                            >Editorial
                            Note</fo:block>
                        <xsl:for-each select="./child::tei:p">
                            <fo:block text-indent=".2in">
                                <xsl:apply-templates />
                            </fo:block>
                        </xsl:for-each>
                    </fo:block>
                </xsl:for-each>
            </xsl:if>
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="//tei:p">
        <xsl:choose>
            <xsl:when test="ancestor::tei:body">
                <xsl:choose>
                    <xsl:when test="ancestor::tei:figure" />
                    <xsl:when test="parent::tei:q[@rend='block']">
                        <fo:block text-indent="0in" line-height="1.5" text-align="justify"
                            font-size="10pt">
                            <xsl:apply-templates />
                        </fo:block>
                    </xsl:when>
                    <xsl:when test="starts-with($idno,'review.recenteditions')">
                        <fo:block text-indent="0in" line-height="1.5" text-align="justify"
                            font-size="10pt">
                            <xsl:apply-templates />
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block text-indent=".25in" line-height="1.5" text-align="justify"
                            font-size="10pt">
                            <xsl:apply-templates />
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="ancestor::tei:div[@type='note']">
                <fo:block font-size="9pt" text-align="left" padding-top="5pt" start-indent="15pt"
                    font-family="AGaramondPro-Regular">
                    <xsl:apply-templates />
                </fo:block>
            </xsl:when>
            <xsl:when test="ancestor::tei:note">
                <fo:block font-size="9pt" text-align="left" padding-top="10pt" start-indent="15pt"
                    font-family="AGaramondPro-Regular">
                    <xsl:apply-templates />
                </fo:block>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:back/tei:closer/tei:signed">
        <fo:block text-align="right" padding-top="5mm">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="//tei:body/tei:signed">
        <xsl:variable name="signatureCount"><xsl:value-of select="count(child::tei:name)"/></xsl:variable>

        <xsl:choose><xsl:when test="$signatureCount>1">
            <xsl:for-each select="child::tei:name[1]"><fo:block text-align="right" padding-top="5mm" font-size="10pt">
                <xsl:apply-templates />
            </fo:block></xsl:for-each>
            <xsl:for-each select="child::tei:affiliation[1]"><fo:block text-align="right" padding-top="0mm" font-size="10pt">
                <xsl:apply-templates />
            </fo:block></xsl:for-each>
            <fo:block padding-top="2mm">
                <xsl:for-each select="child::tei:name[2]"><fo:block text-align="right" padding-top="5mm" font-size="10pt">
                    <xsl:apply-templates />
                </fo:block></xsl:for-each>
                <xsl:for-each select="child::tei:affiliation[2]"><fo:block text-align="right" padding-top="0mm" font-size="10pt">
                    <xsl:apply-templates />
                </fo:block></xsl:for-each>
            </fo:block>


        </xsl:when>
<xsl:otherwise>
        <xsl:for-each select="child::tei:name">
            <fo:block text-align="right" padding-top="5mm" font-size="10pt">
                <xsl:apply-templates />
            </fo:block>
        </xsl:for-each>
        <xsl:for-each select="child::tei:affiliation">
            <fo:block text-align="right" padding-top="0mm" font-size="10pt">
                <xsl:apply-templates />
            </fo:block>
        </xsl:for-each></xsl:otherwise></xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:*[@rend='italic']">
        <fo:inline font-style="italic" font-family="AGaramondPro-Italic">
            <xsl:apply-templates />
        </fo:inline>
    </xsl:template>
    <xsl:template match="//tei:*[@rend='underline']">
        <fo:inline text-decoration="underline" font-family="AGaramondPro-Regular">
            <xsl:apply-templates />
        </fo:inline>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='persign']">
        <fo:external-graphic content-height="8px" content-width="8px"
            scaling="uniform" padding="0" margin="0">
            <xsl:attribute name="src"
                >url(http://www.scholarlyediting.org/images/persign.png)</xsl:attribute>
        </fo:external-graphic>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='longS']">
        <fo:external-graphic content-height="10px" content-width="8px"
            scaling="uniform" padding="0" margin="0">
            <xsl:attribute name="src"
                >url(http://www.scholarlyediting.org/images/longS.png)</xsl:attribute>
        </fo:external-graphic>
    </xsl:template>
    <xsl:template match="//tei:hi[@rend='superscript']"><fo:inline font-size="6pt" vertical-align="super"><xsl:apply-templates/></fo:inline></xsl:template>
    <!--<xsl:template match="//tei:hi[@rend='longS']">
        <fo:inline>[long-S]</fo:inline>
    </xsl:template>-->
    <xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="./descendant::tei:sic">
                <xsl:value-of select="./descendant::tei:sic" />
            </xsl:when>
            <xsl:when test="./descendant::tei:orig">
                <xsl:value-of select="./descendant::tei:reg" />
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:front">
        <fo:block margin-bottom="30pt">
            <xsl:variable name="bylineContent">
                <xsl:for-each select="./descendant::tei:byline">
                    <fo:inline>
                        <xsl:choose>
                            <xsl:when test="following-sibling::tei:byline">
                                <xsl:apply-templates />
                                <xsl:if test="$bylineCount!=2">,&#160;</xsl:if>
                            </xsl:when>
                            <xsl:when test="preceding-sibling::tei:byline">
                                <xsl:choose>
                                    <xsl:when test="following-sibling::tei:byline"
                                        ><xsl:apply-templates />,&#160;</xsl:when>
                                    <xsl:otherwise>&#160;and&#160;<xsl:apply-templates /></xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates />
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:inline>
                </xsl:for-each>
            </xsl:variable>
            <xsl:apply-templates select="./descendant::tei:head" />
            <fo:block font-size="12pt" text-align="right" padding-bottom="14pt"
                font-family="GoudyBookletter1911Regular">
                <xsl:value-of select="$bylineContent" />
            </fo:block>
            <xsl:apply-templates select="./descendant::tei:epigraph" />
        </fo:block>
    </xsl:template>
    <xsl:template match="//tei:note">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="//tei:div[@type='section']">
        <xsl:choose>
            <xsl:when test="attribute::n">
                <xsl:choose>
                    <xsl:when test="child::tei:head">
                        <fo:block font-size="12pt" text-align="center" padding-bottom="0pt"
                            padding-top="24pt">
                            <xsl:value-of select="attribute::n" />
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block font-size="12pt" text-align="center" padding-bottom="7pt"
                            padding-top="24pt">
                            <xsl:copy-of select="attribute::n" />
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates />
            </xsl:when>
            <xsl:otherwise>
                <fo:block padding-top="14pt">
                    <xsl:apply-templates />
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:epigraph">
        <xsl:for-each select="descendant::tei:quote">
            <fo:block margin-top="7pt" margin-bottom="7pt" margin-left="10pt" text-indent="0"
                font-size="8pt">
                <xsl:apply-templates />
            </fo:block>
        </xsl:for-each>
        <xsl:for-each select="descendant::tei:bibl">
            <fo:block text-align="right" margin-right="50pt" font-size="8pt" margin-bottom="15pt">
                <xsl:apply-templates />
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="//tei:q">
        <xsl:choose>
            <xsl:when test="descendant::tei:l">
                <xsl:choose>
                    <xsl:when test="ancestor::div[@type='note']">
                        <xsl:apply-templates />
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block margin-top="7pt" margin-bottom="7pt" margin-left="0in">
                            <xsl:for-each select="descendant::tei:l">
                                <fo:block>
                                    <xsl:apply-templates />
                                </fo:block>
                            </xsl:for-each>
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="attribute::rend='block'">
                <fo:block margin-top="7pt" margin-bottom="7pt" margin-left="20pt"
                    margin-right="20pt" text-indent="0" font-size="10pt">
                    <xsl:apply-templates />
                </fo:block>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:lg">
        <xsl:choose>
            <xsl:when test="descendant::tei:l">
                <fo:block margin-top="7pt" margin-bottom="7pt" margin-left="10pt" text-indent="0"
                    font-size="8pt">
                    <xsl:for-each select="descendant::tei:l">
                        <xsl:choose><xsl:when test="@rend='indented1'"><fo:block text-indent="10pt">
                            <xsl:apply-templates />
                        </fo:block></xsl:when>
                            <xsl:when test="@rend='italic'"><fo:block font-style="italic" font-family="AGaramondPro-Italic">
                                <xsl:apply-templates />
                            </fo:block></xsl:when>
<xsl:otherwise><fo:block>
                            <xsl:apply-templates />
                        </fo:block></xsl:otherwise></xsl:choose>
                        
                    </xsl:for-each>
                </fo:block>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:ptr">
        <xsl:variable name="refNumber">
            <xsl:for-each select=".">
                <xsl:value-of select="attribute::n" />
            </xsl:for-each>
        </xsl:variable>
        <fo:inline font-size="6pt" vertical-align="super">
            <xsl:choose>
                <xsl:when test="$refNumber='pre'">&#42;</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$refNumber" />
                </xsl:otherwise>
            </xsl:choose>
        </fo:inline>
    </xsl:template>
    <xsl:template match="//tei:figDesc" />
    <xsl:template match="//tei:pb" />
    <xsl:template match="//tei:back/tei:div[@type='notes']">
        <fo:block text-align="center" font-family="AGaramondPro-Regular" font-size="15pt"
            margin-top="50pt">Notes</fo:block><!-- insert this to the previous fo:block when the Notes heading is stuck at the bottom: break-before="page" -->
        <fo:list-block>
            <xsl:for-each select="descendant::tei:note">
                <fo:list-item>
                    <fo:list-item-label>
                        <fo:block font-size="9pt" text-align="left" padding-top="10pt"
                            font-family="AGaramondPro-Regular">
                            <xsl:choose>
                                <xsl:when test="attribute::xml:id='note_pre'" />
                                <xsl:otherwise><xsl:value-of
                                    select="substring-after(attribute::xml:id, 'note')"
                                     />.</xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body>
                        <fo:block font-size="9pt" text-align="left" padding-top="10pt"
                            start-indent="15pt" font-family="AGaramondPro-Regular">
                            <xsl:apply-templates />
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>
    <xsl:template match="//tei:list">
        <xsl:choose>
            <xsl:when test="@type='simple'">
                <fo:list-block>
                    <xsl:apply-templates />
                </fo:list-block>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <fo:list-block>
                    <xsl:apply-templates />
                </fo:list-block>
            </xsl:when>
            <xsl:when test="@type='bulleted'">
                <fo:list-block>
                    <xsl:apply-templates />
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates />
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:item">
        <xsl:choose><xsl:when test="parent::tei:list[@type='ordered']">

            <fo:list-item>
                <fo:list-item-label>
                    <fo:block font-size="10pt" text-align="left" padding-top="5pt"
                        font-family="AGaramondPro-Regular">
                        <xsl:number value="count(preceding-sibling::tei:item)+1" format="1"/>.
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:block font-size="10pt" text-align="left" padding-top="5pt" padding-bottom="5pt"
                        start-indent="35pt" font-family="AGaramondPro-Regular" text-indent="0in">
                        <xsl:apply-templates />
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>

</xsl:when><xsl:otherwise><fo:list-item>
            <xsl:if test="starts-with($idno,'review.recenteditions')">
                <xsl:attribute name="margin-top">20pt</xsl:attribute>
            </xsl:if>
            <fo:list-item-label></fo:list-item-label>
            <fo:list-item-body>
<fo:block>
                <xsl:attribute name="text-align">left</xsl:attribute>
                <xsl:attribute name="padding-top">10pt</xsl:attribute>
                <xsl:attribute name="font-family">AGaramondPro-Regular</xsl:attribute>
                <xsl:attribute name="start-indent">
                    <xsl:choose>
                        <xsl:when test="starts-with($idno,'review.recenteditions')">0pt</xsl:when>
                        <xsl:otherwise>15pt</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
    <!--<xsl:if test="parent::tei:list[@type='ordered']"><xsl:number value="count(preceding-sibling::tei:item)+1" format="1"/>.&#160;&#160;</xsl:if>-->
                <xsl:if test="parent::tei:list[@type='bulleted']">&#8226;&#160;</xsl:if>
                <xsl:apply-templates /></fo:block>
            </fo:list-item-body>
        </fo:list-item></xsl:otherwise></xsl:choose>
        
    </xsl:template>


    <xsl:template match="//tei:table">
        <xsl:for-each select="./child::tei:head"><fo:block font-size="10pt" text-align="left" padding-bottom="14pt"  padding-top="14pt"
                    font-family="GoudyBookletter1911Regular"><xsl:apply-templates/></fo:block></xsl:for-each>
        <fo:table table-layout="fixed" width="100%" margin-bottom="25pt">
            <fo:table-body>
                <xsl:for-each select="./child::tei:row">
                    <xsl:choose><xsl:when test="@role='label'"><fo:table-row>
                        <xsl:for-each select="./child::tei:cell">
                            <fo:table-cell>
                                <fo:block font-size="7pt" font-family="AGaramondPro-Bold">
                                    <xsl:apply-templates />
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                    </fo:table-row></xsl:when><xsl:otherwise><fo:table-row>
                        <xsl:for-each select="./child::tei:cell">
                            <fo:table-cell>
                                <fo:block font-size="7pt">
                                    <xsl:apply-templates />
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                    </fo:table-row></xsl:otherwise></xsl:choose>
                    
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template match="//tei:text//tei:note[@type='editorial']">
        <fo:block text-align="center" font-size="8pt">[<xsl:apply-templates />]</fo:block>
    </xsl:template>
<xsl:template match="//tei:del[@type='strikethrough']"><fo:inline text-decoration="line-through"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="//tei:add[@rend='caret']"><fo:inline vertical-align="-4pt" line-height="0" font-size="6pt">^</fo:inline><xsl:apply-templates/><fo:inline vertical-align="-4pt" line-height="0" font-size="6pt">^</fo:inline></xsl:template>
</xsl:stylesheet>
