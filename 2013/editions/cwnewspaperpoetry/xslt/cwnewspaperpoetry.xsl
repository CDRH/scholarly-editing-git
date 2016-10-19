<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xhtml" indent="no" encoding="iso-8859-1" omit-xml-declaration="no" />
    <!--<xsl:include href="base_no_nav.xsl"/>-->
    <xsl:include href="../../../../template_xslt/base.xsl" />
    <xsl:param name="sortValue">undefined</xsl:param>
    <xsl:template match="//tei:teiHeader" />
    <xsl:template name="essayNav" />
    <xsl:template name="witnessName"> </xsl:template>
    <!-- edition navigation (required for each edition) -->
    <xsl:template name="editionNav">
        <xsl:variable name="idno">
            <xsl:value-of select="//tei:idno[@type='file']" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with($idno,'intro.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/index.cwnewspaperpoetry.html">Poem Index</a>
                    </li>
                </ul>
            </xsl:when>
            <xsl:when test="starts-with($idno,'index.')">
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/intro.cwnewspaperpoetry.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2013/editions/intro.cwnewspaperpoetry.html#usingThisEdition"
                            >Using This Edition</a>
                    </li>
                    
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <li id="editionNavPre">Go to:</li>
                    <li id="editionNav1">
                        <a href="{$siteroot}2013/editions/intro.cwnewspaperpoetry.html"
                            >Introduction</a>
                    </li>
                    <li id="editionNav2">
                        <a href="{$siteroot}2013/editions/index.cwnewspaperpoetry.html">Poem Index</a>
                    </li>
                    <li id="editionNav3">
                        <a href="{$siteroot}2013/editions/{$idno}.xml">Edition XML</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- volume citation (required for each essay, review, and edition) -->
    <xsl:template name="volCitation">
        <h5>2013, Volume 34</h5>
    </xsl:template>
    <!-- to create a special div type and to push notes to the backmatter -->
    <xsl:template match="//tei:body">
        <xsl:choose>
            <xsl:when test="ancestor::tei:floatingText">
                <blockquote>
                    <xsl:apply-templates />
                </blockquote>
            </xsl:when>
            <xsl:otherwise>
                <div class="cwnewspaperpoetry">
                    <div class="cwpoetry_biblNav">
                        <xsl:for-each select="//tei:facsimile">
                            <span class="complete_issue">
                                <span class="issue_thumbs">
                                    <table><tr><xsl:for-each select="child::tei:surface">
                                        <td><a>
                                            <xsl:attribute name="href">
                                                <xsl:text>cwnewspaperpoetry/pages/issues/fullsize/</xsl:text>
                                                <xsl:value-of
                                                  select="child::tei:graphic/attribute::url" />
                                            </xsl:attribute>
                                            <img>
                                                <xsl:attribute name="src">
                                                  <xsl:text>cwnewspaperpoetry/pages/issues/thumbs/</xsl:text><xsl:value-of
                                                  select="substring-before(child::tei:graphic/attribute::url,'.jpg')"
                                                   /><xsl:text>_thumb.jpg</xsl:text>
                                                </xsl:attribute>
                                            </img>
                                          </a></td>
                                    </xsl:for-each></tr><tr><xsl:for-each select="//tei:facsimile/tei:surface"><td><span class="thumbCaption"><a>
                                        <xsl:attribute name="href">
                                            <xsl:text>cwnewspaperpoetry/pages/issues/fullsize/</xsl:text>
                                            <xsl:value-of
                                                select="child::tei:graphic/attribute::url" />
                                        </xsl:attribute><xsl:text>page </xsl:text><xsl:value-of select="substring(attribute::xml:id,3)"/></a></span></td></xsl:for-each></tr></table>
                                </span>
                                <span class="issue_bibl">
                                    <b>Complete Issue:&#160;</b>
                                    <xsl:for-each
                                        select="//tei:sourceDesc/tei:biblStruct[@xml:id='poem']">
                                        <xsl:for-each
                                        select="child::tei:monogr/tei:title"
                                        ><em><xsl:apply-templates /></em></xsl:for-each>&#160;<xsl:for-each
                                        select="descendant::tei:date"
                                        >(<xsl:apply-templates />)</xsl:for-each> </xsl:for-each>
                                </span>
                            </span>
                        </xsl:for-each>
                        <xsl:if test="//tei:publicationStmt//tei:idno[@type='file']!='index.cwnewspaperpoetry'"><xsl:if test="//tei:publicationStmt//tei:idno[@type='file']!='intro.cwnewspaperpoetry'"><span class="current_poem">
                            <xsl:for-each select="//tei:sourceDesc/tei:biblStruct[@xml:id='poem']">
                                <span class="current_poem_bibl"><!--<xsl:for-each select=".//tei:author"
                                    ><xsl:apply-templates /></xsl:for-each>--><xsl:for-each select=".//tei:author"> <xsl:variable
                                        name="refValue"><xsl:value-of
                                        select="substring-after(attribute::ref,'#')"
                                         /></xsl:variable> <span><xsl:attribute name="class">index_author</xsl:attribute><xsl:attribute name="title"
                                        ><xsl:for-each
                                        select="//tei:creation/tei:persName[@xml:id = $refValue]"
                                        ><xsl:value-of select="." /></xsl:for-each> </xsl:attribute>
                                        <xsl:apply-templates /></span>,&#160;</xsl:for-each><xsl:for-each
                                    select="child::tei:analytic/tei:title[@level='a']"
                                            ><xsl:choose><xsl:when test="starts-with(.,'&quot;')">
                                                <xsl:variable name="removeQuoteMark1">
                                                    <xsl:value-of select="substring-after(.,'&quot;')"
                                                    />
                                                </xsl:variable>
                                                <xsl:variable name="removeQuoteMarks">
                                                    <xsl:value-of
                                                        select="substring-before($removeQuoteMark1,'&quot;')"
                                                    />
                                                </xsl:variable>
                                                "'<xsl:value-of select="$removeQuoteMarks" />'"
                                            </xsl:when><xsl:otherwise>"<xsl:apply-templates />"</xsl:otherwise></xsl:choose></xsl:for-each>&#160;<xsl:for-each
                                    select="child::tei:monogr/tei:title"
                                    ><em><xsl:apply-templates /></em></xsl:for-each>&#160;<xsl:for-each
                                    select="descendant::tei:date"
                                    >(<xsl:apply-templates />):&#160;</xsl:for-each> <xsl:for-each
                                    select="descendant::tei:biblScope[@type='pp']"
                                    ><xsl:apply-templates /></xsl:for-each></span>
                            </xsl:for-each>
                            <xsl:call-template name="cwpoempageimage" />
                        </span></xsl:if></xsl:if>
                    </div>
                    
                  

                   
                    <xsl:apply-templates />
                    <xsl:if test="descendant::tei:note"><div class="notesList">
                        <h2>Notes</h2>
                        <xsl:if test="descendant::tei:supplied"><ol class="starred"><li><span class="supplied_note"><b>Note on the text:</b> The text in red, which is obscured in the newspaper printing represented here, is supplied by <xsl:value-of select="//tei:biblStruct[@xml:id='supplied']//tei:author"/>
                                <xsl:choose>
                                    <xsl:when
                                        test="ends-with(//tei:biblStruct[@xml:id='supplied']//tei:author, '.')" />
                                    <xsl:otherwise>,</xsl:otherwise>
                                </xsl:choose>&#160;<xsl:if test="//tei:biblStruct[@xml:id='supplied']/tei:analytic/tei:title[@level='a']">"<xsl:value-of select="//tei:biblStruct[@xml:id='supplied']//tei:title[@level='a']"/>,"&#160;</xsl:if><xsl:if test="//tei:biblStruct[@xml:id='supplied']//tei:title[@level='m']"><em><xsl:value-of select="//tei:biblStruct[@xml:id='supplied']//tei:title[@level='m']"/></em></xsl:if><xsl:if test="//tei:biblStruct[@xml:id='supplied']//tei:title[@level='j']"><em><xsl:value-of select="//tei:biblStruct[@xml:id='supplied']//tei:title[@level='j']"/></em>,</xsl:if>&#160;
                                <xsl:choose>
                                    <xsl:when
                                        test="//tei:biblStruct[@xml:id='supplied']//tei:imprint/tei:pubPlace"
                                        >(<xsl:value-of
                                            select="//tei:biblStruct[@xml:id='supplied']//tei:imprint/tei:pubPlace"
                                        />:&#160;<xsl:value-of
                                            select="//tei:biblStruct[@xml:id='supplied']//tei:imprint/tei:publisher"
                                        />, <xsl:value-of
                                            select="//tei:biblStruct[@xml:id='supplied']//tei:imprint/tei:date"
                                        />),&#160;<xsl:if test="//tei:biblStruct[@xml:id='supplied']//tei:biblScope[@type='volume']">&#160;<xsl:value-of select="//tei:biblStruct[@xml:id='supplied']//tei:biblScope[@type='volume']"/>:</xsl:if><xsl:value-of
                                            select="//tei:biblStruct[@xml:id='supplied']//tei:biblScope[@type='pp']"
                                        /></xsl:when>
                                    <xsl:otherwise><xsl:value-of
                                        select="//tei:biblStruct[@xml:id='supplied']//tei:date"
                                    />,&#160;<xsl:value-of
                                        select="//tei:biblStruct[@xml:id='supplied']//tei:biblScope[@type='pp']"
                                    /></xsl:otherwise>
                                </xsl:choose>.</span></li></ol></xsl:if>
<ol>

                            

<xsl:for-each select="//tei:note[@type='editorial']">
                            <xsl:variable name="noteNumber">
                                <xsl:number count="//tei:note[@type='editorial']" level="any" />
                            </xsl:variable>
                            <li><span class="note_editorial"><a> <xsl:attribute name="name"
                                ><xsl:text>note</xsl:text><xsl:value-of select="$noteNumber" />
                            </xsl:attribute> </a><xsl:apply-templates /><a> <xsl:attribute name="href"
                                ><xsl:text>#ref</xsl:text><xsl:value-of select="$noteNumber"
                                /></xsl:attribute> <img> <xsl:attribute name="src"
                                    >images/goback.png</xsl:attribute> <xsl:attribute name="alt"
                                        >Go back</xsl:attribute> </img> </a></span></li>
                           
                        </xsl:for-each></ol>
                    </div></xsl:if>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<xsl:template match="//tei:body//tei:div"><div class="prose_section"><xsl:if test="./attribute::xml:id"><a><xsl:attribute name="name"><xsl:value-of select="./attribute::xml:id"/></xsl:attribute></a></xsl:if><xsl:apply-templates/></div></xsl:template>

<xsl:template match="//tei:body//tei:div1"><div class="poem_section"><xsl:apply-templates/></div></xsl:template>

    <!-- Special <head> @types -->
    <xsl:template match="//tei:text//tei:head">
        <xsl:choose>
            <xsl:when test="./attribute::type='main-authorial'">
                <xsl:choose>
                    <xsl:when test="parent::tei:lg[@type='cluster']">
                        <xsl:choose>
                            <xsl:when test="@rend='underline'">
                                <h1>
                                    <u>
                                        <xsl:apply-templates />
                                    </u>
                                </h1>
                            </xsl:when>
                            <xsl:otherwise>
                                <h1>
                                    <xsl:apply-templates />
                                </h1>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="parent::tei:lg[@type='poem']">
                        <h2>
                            <xsl:apply-templates />
                        </h2>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="./attribute::type='main'">
                <xsl:choose><xsl:when test="parent::tei:div"><h2>
                    <xsl:apply-templates />
                </h2></xsl:when><xsl:when test="parent::tei:body"><span class="body_head"><h1><xsl:apply-templates/></h1></span></xsl:when><xsl:otherwise><h1>
                    <xsl:apply-templates />
                </h1></xsl:otherwise></xsl:choose>
                
            </xsl:when>
            <xsl:when test="./attribute::type='small-main'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            <xsl:when test="./attribute::type='sub'">
                <h2>
                    <xsl:apply-templates />
                </h2>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!-- poem page images -->
    <xsl:template name="cwpoempageimage">
        <span class="cwpoempageimage">
            <span class="thumbnail">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>cwnewspaperpoetry/pages/poems/viewsize/</xsl:text>
                        <xsl:value-of
                            select="substring-before(//tei:facsimile//tei:zone/tei:graphic/attribute::url,'_cropped.jpg')"
                        /><xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <img>
                        <xsl:attribute name="src">
                            <xsl:text>cwnewspaperpoetry/pages/poems/thumbs/</xsl:text>
                            <xsl:value-of
                                select="substring-before(//tei:facsimile//tei:zone/tei:graphic/attribute::url,'_cropped.jpg')"
                            />
                            <xsl:text>_thumb.jpg</xsl:text>
                        </xsl:attribute>
                    </img>
                </a>
            </span>
            <span class="viewsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>cwnewspaperpoetry/pages/poems/viewsize/</xsl:text>
                        <xsl:value-of
                            select="substring-before(//tei:facsimile//tei:zone/tei:graphic/attribute::url,'_cropped.jpg')"
                        />
                        <xsl:text>.jpg</xsl:text>
                    </xsl:attribute>
                    <xsl:text>View Poem Image</xsl:text>
                </a>
            </span>
            <br />
            <span class="fullsize">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>cwnewspaperpoetry/pages/poems/fullsize/</xsl:text>
                        <xsl:value-of
                            select="substring-before(//tei:facsimile//tei:zone/tei:graphic/attribute::url,'_cropped.jpg')"
                        />
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
    <!-- milestone -->
<xsl:template match="//tei:milestone">
<xsl:choose>
    <xsl:when test="@rend='short-bar'"><span class="horizontal_bar">&#160;&#160;&#160;&#160;&#160;</span></xsl:when>
    <xsl:when test="@rend='asterisks'"><span class="asterisks">*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;*</span></xsl:when>
</xsl:choose>

</xsl:template>


    <!-- <opener> and <closer> -->
    <xsl:template match="//tei:opener">
        <span class="opener">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:closer">
        <span class="closer">
            <xsl:apply-templates />
        </span>
    </xsl:template>
  
    
    <xsl:template match="//tei:ptr">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="attribute::target" />
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="attribute::xml:id" />
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ancestor::tei:TEI/descendant::tei:idno[starts-with(.,'intro')]">
                    <span class="noteRefIntro">
                [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />]
            </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="noteRef">
                        <!-- <a>
                    <xsl:attribute name="name"> <xsl:value-of select="@xml:id" /></xsl:attribute>
                </a>-->
                [<xsl:value-of
                        select="substring-after(attribute::target,'#note')" />]
            </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>

    <xsl:template match="//tei:note[@type='newspaper-editorial']">
        <span>
            <xsl:attribute name="class">note_newspaper-editorial<xsl:if test="@rend">_<xsl:value-of
                select="@rend" /></xsl:if><xsl:if test="preceding-sibling::tei:lg">_end</xsl:if></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="//tei:note[@type='authorial']">
        <span>
            <xsl:attribute name="class">note_newspaper-authorial<xsl:if test="@rend">_<xsl:value-of
                select="@rend" /></xsl:if></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="//tei:note[@type='editorial']">
        <xsl:variable name="noteNumber"><xsl:number count="//tei:note[@type='editorial']" level="any"/></xsl:variable>
<a>
        <xsl:attribute name="href">
            <xsl:text>#note</xsl:text><xsl:value-of select="$noteNumber" />
        </xsl:attribute>
        <xsl:attribute name="name">
            <xsl:text>ref</xsl:text><xsl:value-of select="$noteNumber" />
        </xsl:attribute>
    <span class="noteRef">[<xsl:value-of select="$noteNumber"/>]</span>
    </a></xsl:template>

  


    <!-- Special linebreaks for poetic lines -->
    <xsl:template match="//tei:l//tei:lb"><br />&#160;&#160;&#160;&#160;&#160;</xsl:template>
    <!-- deletions and additions in the manuscript (I did not do anything with the <subst> stuff at this
point because I thought the styling could be accomplished for this file through this relatively
simple approach -->
    <xsl:template match="//tei:del">
        <span>
            <xsl:attribute name="class">del_<xsl:value-of select="@type" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:add">
        <xsl:if test="@type='insertion'">
            <span class="insertionMark">^</span>
        </xsl:if>
        <span>
            <xsl:attribute name="class">add_<xsl:value-of select="@place" /></xsl:attribute>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="//tei:gap">
        <span class="gap">[<xsl:value-of select="@extent"/><xsl:text> </xsl:text><xsl:value-of select="@reason"/>]</span>
    </xsl:template>

    <xsl:template match="//tei:unclear">
        <span><xsl:attribute name="class">unclear_<xsl:value-of select="@cert"/></xsl:attribute><xsl:apply-templates/></span>
    </xsl:template>

    <!-- To get quoted poetic lines to show up in the introduction -->
    <xsl:template match="//tei:quote">
        <blockquote>
            <xsl:apply-templates />
        </blockquote>
    </xsl:template>


<!-- title levels -->

<xsl:template match="//tei:body//tei:title"><xsl:choose>
    <xsl:when test="attribute::level='j'"><em><xsl:apply-templates/></em></xsl:when>
    <xsl:when test="attribute::level='m'"><em><xsl:apply-templates/></em></xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose></xsl:template>


    <!-- simple lists -->
    <xsl:template match="//tei:list">
        <xsl:choose>
            <xsl:when test="//tei:publicationStmt//tei:idno[@type='file']='index.cwnewspaperpoetry' ">
                
                
                    <span class="indexsort">
                        <a><xsl:attribute name="href">index.cwnewspaperpoetry_date.html</xsl:attribute>&#8658;&#160;&#160;Sort list by publication
                    date</a>
                        <br />
                        <a><xsl:attribute name="href">index.cwnewspaperpoetry_title.html</xsl:attribute>&#8658;&#160;&#160;Sort list alphabetically by title</a>
                        <br />
                        <a><xsl:attribute name="href">index.cwnewspaperpoetry_author.html</xsl:attribute>&#8658;&#160;&#160;Sort list alphabetically by author</a>
                        <br />
                        <a><xsl:attribute name="href">index.cwnewspaperpoetry_attribution.html</xsl:attribute>&#8658;&#160;&#160;Sort list alphabetically by attribution</a>
                        <br />
                        <a><xsl:attribute name="href">index.cwnewspaperpoetry_newspaper.html</xsl:attribute>&#8658;&#160;&#160;Sort list alphabetically by newspaper</a>
                    </span>
                    <xsl:choose>
                        <xsl:when test="$sortValue='title'">
                            <h4>Items sorted alphabetically by
                            title</h4>
                        </xsl:when>
                        <xsl:when test="$sortValue='date'">
                            <h4>Items sorted by publication date</h4>
                        </xsl:when>
                        <xsl:when test="$sortValue='author'">
                            <h4>Items sorted alphabetically by author</h4>
                        </xsl:when>
                        <xsl:when test="$sortValue='attribution'">
                            <h4>Items sorted alphabetically by attribution</h4>
                        </xsl:when>
                        <xsl:when test="$sortValue='newspaper'">
                            <h4>Items sorted by newspaper in which they were published, then by publication date</h4>
                        </xsl:when>
                        <xsl:otherwise> </xsl:otherwise>
                    </xsl:choose>
                
                
                <xsl:for-each select="child::tei:head">
                    <h1><xsl:apply-templates /></h1>
                </xsl:for-each><ol>
                    <xsl:choose>
                        <xsl:when test="$sortValue='title'">
                            <xsl:for-each select="child::tei:item">
                                <xsl:sort select="descendant::tei:title[@level='a']/attribute::key" order="ascending"/>
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$sortValue='author'">
                            <xsl:for-each select="child::tei:item">
                                <xsl:sort select="descendant::tei:author/attribute::key" order="ascending" />
                                <xsl:sort select="descendant::tei:date/attribute::when" order="ascending"/>
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$sortValue='attribution'">
                            <xsl:for-each select="child::tei:item">
                                <xsl:sort select="descendant::tei:author" order="ascending" />
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$sortValue='date'">
                            <xsl:for-each select="child::tei:item">
                                <xsl:sort select="descendant::tei:date/attribute::when" order="ascending" />
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$sortValue='newspaper'">
                    <xsl:variable name="newspaper_title"><xsl:value-of select="child::tei:item/descendant::tei:title[@level!='a']"/></xsl:variable>
                            <xsl:for-each select="child::tei:item">
                             <xsl:sort select="$newspaper_title" order="ascending" />
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$sortValue='undefined'">
                            <xsl:for-each select="child::tei:item">
                                <xsl:sort select="descendant::tei:date/attribute::when" order="ascending" />
                                <li>
                                    <xsl:apply-templates />
                                </li>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                </ol>
            </xsl:when>

<xsl:otherwise><xsl:choose><xsl:when test="@type='simple'">
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
    <xsl:when test="@type='bulleted'">
        <ol class="bulleted">
            <xsl:apply-templates/>
        </ol>
    </xsl:when>

            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise></xsl:choose></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

<xsl:template match="//tei:body//tei:dateline"><span><xsl:attribute name="class">cwpoetry_dateline<xsl:if test="./attribute::rend='center'">_center</xsl:if></xsl:attribute><xsl:apply-templates/></span></xsl:template>


    <xsl:template match="//tei:bibl/tei:author"><span><xsl:attribute name="class">index_author<xsl:if test="$sortValue='author'">_sorted</xsl:if></xsl:attribute><xsl:attribute name="title"><xsl:value-of select="@key"/></xsl:attribute><xsl:apply-templates/><xsl:if test="$sortValue='author'">&#160;[<xsl:value-of select="@key"/>]</xsl:if></span></xsl:template>

<xsl:template match="//tei:supplied"><span class="supplied"><xsl:apply-templates/></span></xsl:template>


<xsl:template match="//tei:choice">
        <xsl:choose>
            <xsl:when test="child::tei:orig">
                <xsl:choose>
                    <xsl:when test="child::tei:reg[@type='dialect']">
                        <xsl:for-each select="child::tei:orig">
                            <xsl:apply-templates />
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <span><xsl:attribute name="class">choice<xsl:if test="contains(.,'-')">_endLineHyphen</xsl:if></xsl:attribute>
                            <xsl:attribute name="title">
                                <xsl:value-of select="child::tei:reg" />
                            </xsl:attribute>
                            <xsl:for-each select="child::tei:orig">
                                <xsl:apply-templates />
                            </xsl:for-each>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="child::tei:sic">
                <xsl:choose><xsl:when test="ancestor::tei:author/parent::tei:analytic"><xsl:value-of select="child::tei:corr" /></xsl:when><xsl:otherwise><span class="choice">
                    <xsl:attribute name="title">
                        <xsl:value-of select="child::tei:corr" />
                    </xsl:attribute>
                    <xsl:for-each select="child::tei:sic">
                        <xsl:apply-templates />
                    </xsl:for-each>
                </span></xsl:otherwise></xsl:choose>
            </xsl:when>
        </xsl:choose></xsl:template>


<xsl:template match="//tei:sic"><span class="choice"><xsl:attribute name="title"><xsl:value-of select="child::tei:corr"/></xsl:attribute><xsl:for-each select="child::tei:orig"><xsl:apply-templates/></xsl:for-each></span>
</xsl:template>


<xsl:template match="//tei:name[@type='ship']"><em><xsl:apply-templates/></em></xsl:template>

<xsl:template match="//tei:salute[@rend='italic']">
<xsl:choose>
    <xsl:when test="parent::tei:opener/parent::tei:div1/parent::tei:body"><span class="head_salute"><em><xsl:apply-templates/></em></span></xsl:when>
    <xsl:otherwise><em><xsl:apply-templates/></em></xsl:otherwise>
</xsl:choose>
    </xsl:template>


    <xsl:template match="//tei:epigraph">
        <xsl:choose>
            <xsl:when test="attribute::rend='center'">
                <span class="epigraph_center">
                    <xsl:apply-templates />
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="epigraph">
                    <xsl:apply-templates />
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
