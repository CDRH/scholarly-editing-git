<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- Object View Component Stylesheet                                       -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!--
    Templates for all of the TEI elements
-->
<xsl:stylesheet version="2.0" 
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:tei="http://www.tei-c.org/ns/1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="chunk.id"/>
    <xsl:param name="doc.view">print</xsl:param>
    <xsl:param name="id"/>
    <xsl:param name="from"/>
    <xsl:param name="fig.path"/>
    <xsl:param name="doc.file"/>
    <xsl:param name="docId"/>
    <xsl:param name="ID"/>

 <!-- ELEMENT: ab -->
 <xsl:template exclude-result-prefixes="#all" match="tei:ab[@type]">
  <xsl:choose>
   <xsl:when test="@type='doc'">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='illgrp'">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='pt'">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: add -->
 <xsl:template exclude-result-prefixes="#all" match="tei:add[@type]">
  <xsl:choose>
   <xsl:when test="@type='formfill'">
    <span class="formfill">
     <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
    </span>
   </xsl:when>
   <xsl:when test="@type='beginSpan'">
    <xsl:text> </xsl:text>
    <span class="carat">^</span>
    <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
   </xsl:when>
   <xsl:when test="@type='endSpan'">
    <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
    <span class="carat">^</span>
    <xsl:text> </xsl:text>
   </xsl:when>
   <xsl:when test="@type='noCaret'">
    <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
   </xsl:when>
   <xsl:otherwise>
    <span class="carat">^</span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

<xsl:template exclude-result-prefixes="#all" match="tei:add[not(@type)]">
 <span class="carat">^</span>
    <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
 <span class="carat">^</span>
</xsl:template>
 <!-- ELEMENT: addressee -->
 <xsl:template exclude-result-prefixes="#all" match="tei:addressee">
  <xsl:choose>
   <xsl:when test="@rend='inline'">
    <span class="inline">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@rend='left'">
    <span class="left">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@rend='noindent'">
    <span class="noindent">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@rend">
    <span style="{@rend}">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: anchor -->
 <xsl:template exclude-result-prefixes="#all" match="tei:anchor" mode="old">
  <xsl:variable name="id" select="@xml:id"/>
  <xsl:choose>
   <!-- no display for these -->
   <xsl:when test="$doc.view='print'"/>
   <xsl:when test="following::tei:app[@from=$id][@type='copy']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='multiple']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='repeated']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='wit']"/>
   <!-- becasue we start the element here and end it in another template, we need to use CDATA sections to create the markup -->
   <xsl:when test="following::tei:app[@from=$id]">
    <xsl:text disable-output-escaping="yes"><![CDATA[<a href="#" class="apparatus" id="text_note]]></xsl:text>
    <xsl:value-of select="$id"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[" onmouseover="hiliteNote('note]]></xsl:text>
    <xsl:value-of select="$id"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[');" onmouseout="unliteNote('note]]></xsl:text>
    <xsl:value-of select="$id"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[');" onclick="selectNote('note]]></xsl:text>
    <xsl:value-of select="$id"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[');">]]></xsl:text>
   </xsl:when>
   <xsl:otherwise/>
  </xsl:choose>
 </xsl:template>

 <xsl:template exclude-result-prefixes="#all" match="tei:anchor">
  <xsl:variable name="id" select="@xml:id"/>
  <xsl:choose>
   <!-- no display for these -->
   <xsl:when test="$doc.view='print'"/>
   <xsl:when test="following::tei:app[@from=$id][@type='copy']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='multiple']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='repeated']"/>
   <xsl:when test="following::tei:app[@from=$id][@type='wit']"/>
   <xsl:when test="following::tei:app[@from=$id]">
    <a class="apparatus" href="#" id="text_note{$id}" onclick="selectNote('note{$id}');" onmouseout="unliteNote('note{$id}');"
     onmouseover="hiliteNote('note{$id}');">[</a>
   </xsl:when>
   <xsl:otherwise/>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: app -->
 <xsl:template exclude-result-prefixes="#all" match="tei:app" mode="old">
  <xsl:variable name="from" select="@from"/>
  <xsl:choose>
   <!-- no display for these -->
   <xsl:when test="$doc.view='print'"/>
   <xsl:when test="@type='copy'"/>
   <xsl:when test="@type='multiple'"/>
   <xsl:when test="@type='repeated'"/>
   <xsl:when test="@type='wit'"/>
   <xsl:when test="preceding::tei:anchor[@xml:id=$from]">
    <xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
   </xsl:when>
   <xsl:otherwise/>
  </xsl:choose>
 </xsl:template>

 <xsl:template exclude-result-prefixes="#all" match="tei:app">
  <xsl:variable name="id" select="@from"/>
  <xsl:choose>
   <!-- no display for these -->
   <xsl:when test="$doc.view='print'"/>
   <xsl:when test="@type='copy'"/>
   <xsl:when test="@type='multiple'"/>
   <xsl:when test="@type='repeated'"/>
   <xsl:when test="@type='wit'"/>
   <xsl:when test="preceding::tei:anchor[@xml:id=$id]">
    <a class="apparatus" href="#" id="text_note{$id}" onclick="selectNote('note{$id}');" onmouseout="unliteNote('note{$id}');"
     onmouseover="hiliteNote('note{$id}');">]</a>
   </xsl:when>
   <xsl:otherwise/>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: closer -->
 <xsl:template exclude-result-prefixes="#all" match="tei:closer">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: corr -->
 <xsl:template exclude-result-prefixes="#all" match="tei:corr">
  <span class="normal">
   <xsl:text>&#x005b;</xsl:text>
  </span>
  <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
  <span class="normal">
   <xsl:text>&#x005d;</xsl:text>
  </span>
 </xsl:template>

 <!-- ELEMENT: date -->
 <xsl:template exclude-result-prefixes="#all" match="tei:date">
  <xsl:choose>
   <xsl:when test="parent::tei:head[@type='metadata']">
    <xsl:choose>
     <xsl:when test="preceding-sibling::tei:date">
      <xsl:apply-templates/>
     </xsl:when>
     <xsl:otherwise>
      <br/><!-- ask nikki if she can help me figure out why this is duplicating -kmd -->
      <xsl:apply-templates/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: dateRange 
 <xsl:template exclude-result-prefixes="#all" match="tei:dateRange">
  <xsl:choose>
   <xsl:when test="parent::head[@type='metadata']">
    <br/>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template> -->

 <!-- ELEMENT: dateline -->
 <xsl:template exclude-result-prefixes="#all" match="tei:dateline">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: div1 -->
 <!-- to hide in primary frame -->
 <xsl:template match="tei:div1[@type='commentary']"/>

 <xsl:template exclude-result-prefixes="#all" match="tei:div1">
  <a name="{@xml:id}"/>
  <xsl:if test="$chunk.id=@xml:id">
   <a name="X"/>
  </xsl:if>
  <xsl:choose>
    <!-- Commented out this rule becaue it was putting the entire sun article in a table. -KMD -->
   <!--<xsl:when test="@type='clipping'">
    <p class="center">
     <table class="clipping">
      <tr>
       <td>
        <xsl:apply-templates/>
       </td>
      </tr>
     </table>
    </p>
   </xsl:when>-->
   <xsl:when test="@type='enclosure'">
    <br/>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='form'">
    <table class="form">
     <tr>
      <td>
<!-- revisit this? 
       <span class="print"> -->
<span class="normal">
        <xsl:apply-templates/>
       </span>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@type='post-transmission'">
    <p class="noindent">
     <div class="envline">
      <img>
       <xsl:attribute name="src">icons/ts_envlop.gif</xsl:attribute>
       <xsl:attribute name="alt">alt</xsl:attribute>
      </img>
      <span class="ts_single_deletion"><img src="icons/ts_single_deletion.gif"/></span>
     </div>
    </p>
    <p class="noindent">
     <xsl:apply-templates/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: div2 -->
 <xsl:template exclude-result-prefixes="#all" match="tei:div2">
  <a name="{@xml:id}"/>
  <xsl:if test="$chunk.id=@xml:id">
   <a name="X"/>
  </xsl:if>
  <xsl:choose>
   <xsl:when test="@type='clipping'">
    <table class="clipping">
     <tr>
      <td>
       <xsl:apply-templates/>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@type='copytext'"> </xsl:when>
   <xsl:when test="@type='form'">
    <table class="form">
     <tr>
      <td>
       <span class="print">
        <xsl:apply-templates/>
       </span>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@type='pub'">
    <xsl:text> &#x220e; </xsl:text>
    <i>Previous publication:</i>
    <xsl:text>&#x2002;</xsl:text>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='provenance'">
    <xsl:text> &#x220e; </xsl:text>
    <i>Provenance:</i>
    <xsl:text>&#x2002;</xsl:text>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='appletter'">
    <xsl:choose>
     <xsl:when test="//witList">
      <xsl:text> &#x220e; </xsl:text>
      <i>Emendations, adopted readings, and textual notes:</i>
      <xsl:text>&#x2002;</xsl:text>
      <xsl:apply-templates/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:text> &#x220e; </xsl:text>
      <i>Emendations and textual notes:</i>
      <xsl:text>&#x2002;</xsl:text>
      <xsl:apply-templates/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: div3 -->
 <xsl:template exclude-result-prefixes="#all" match="tei:div3">
  <a name="{@xml:id}"/>
  <xsl:if test="$chunk.id=@xml:id">
   <a name="X"/>
  </xsl:if>
  <xsl:choose>
   <xsl:when test="@type='clipping'">
    <table class="clipping">
     <tr>
      <td>
       <xsl:apply-templates/>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@type='form'">
    <table class="form">
     <tr>
      <td>
       <span class="print">
        <xsl:apply-templates/>
       </span>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@type='postmark'">
    <xsl:text> [</xsl:text>
    <span class="italic">
     <xsl:text>postmarked:</xsl:text>
    </span>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:when test="@type='returnAddress'">
    <xsl:text> [</xsl:text>
    <span class="italic">
     <xsl:text>return address:</xsl:text>
    </span>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: figText -->
 <xsl:template exclude-result-prefixes="#all" match="tei:figText">
  <xsl:choose>
   <xsl:when test="ancestor::tei:seg[@type='monogram']">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <p class="caption">
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: figure -->
 <xsl:template exclude-result-prefixes="#all" match="tei:figure">
  <xsl:choose>
   <xsl:when test="parent::tei:seg[@type='monogram']">
    <xsl:apply-templates/>
   </xsl:when>
   <!-- print view -->
   <xsl:when test="$doc.view='print'">
    <xsl:choose>
     <!-- block image -->
     <xsl:when test="@rend='block'">
      <div class="img-center">
       <img alt="figure" class="select-text" width="275">
        <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
        <xsl:attribute name="id">
         <xsl:value-of select="concat('note-',@entity)"/>
        </xsl:attribute>
       </img>
      </div>
      <xsl:apply-templates/>
     </xsl:when>
     <!-- inline image -->
     <xsl:when test="@rend='inline'">
      <xsl:choose>
       <!-- figure in a list -->
       <xsl:when test="ancestor::tei:list">
        <img alt="figure" class="inline">
         <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
         <xsl:attribute name="id">
          <xsl:value-of select="concat('note-',@entity)"/>
         </xsl:attribute>
        </img>
        <xsl:apply-templates/>
       </xsl:when>
       <xsl:otherwise>
        <img alt="figure" class="select-text" style="max-width:275px;">
         <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
         <xsl:attribute name="id">
          <xsl:value-of select="concat('note-',@entity)"/>
         </xsl:attribute>
        </img>
        <xsl:apply-templates/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:when>
     <!-- center, no highslide, for tp imprint -->
     <xsl:when test="@rend='center' and parent::tei:p[@rend='imprint']">
      <div class="imprint">
       <img class="logo">
        <xsl:attribute name="name">#<xsl:value-of select="@entity"/></xsl:attribute>
        <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
        <xsl:attribute name="alt">UC Press imprint</xsl:attribute>
       </img>
      </div>
     </xsl:when>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <!-- block image -->
     <xsl:when test="@rend='block'">
      <a name="{@entity}"/>
      <div class="img-center">
       <a class="highslide">
        <xsl:attribute name="href"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
        <img alt="figure" class="select-text" style="max-width: 210px;">
         <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
         <xsl:attribute name="id">
          <xsl:value-of select="concat('note-',@entity)"/>
         </xsl:attribute>
        </img>
       </a>
      </div>
      <xsl:apply-templates/>
     </xsl:when>
     <!-- inline image -->
     <xsl:when test="@rend='inline'">
      <xsl:choose>
       <!-- figure in a list -->
       <xsl:when test="ancestor::tei:list">
        <a name="{@entity}"/>
        <img alt="figure" class="inline">
         <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
         <xsl:attribute name="id">
          <xsl:value-of select="concat('note-',@entity)"/>
         </xsl:attribute>
        </img>
        <xsl:apply-templates/>
       </xsl:when>
       <xsl:otherwise>
        <a name="{@entity}"/>
        <!--                                <a class="highslide">
                                    <xsl:attribute name="href"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>-->
        <img alt="figure" class="select-text" style="max-width: 210px;">
         <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
         <xsl:attribute name="id">
          <xsl:value-of select="concat('note-',@entity)"/>
         </xsl:attribute>
        </img>
        <!--                                </a>-->
        <xsl:apply-templates/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:when>
     <!-- center, no highslide, for tp imprint -->
     <xsl:when test="@rend='center' and parent::tei:p[@rend='imprint']">
      <div class="imprint">
       <img class="logo">
        <xsl:attribute name="name">#<xsl:value-of select="@entity"/></xsl:attribute>
        <xsl:attribute name="src"><xsl:value-of select="$fig.path"/><xsl:value-of select="@entity"/>.jpg</xsl:attribute>
        <xsl:attribute name="alt">UC Press imprint</xsl:attribute>
       </img>
      </div>
     </xsl:when>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: head -->
 <xsl:template exclude-result-prefixes="#all" match="tei:head">
  <xsl:variable name="id" select="/TEI/@xml:id"/>
  <xsl:choose>
   <xsl:when test="@type='metadata' and not($doc.view='print')">
    <div class="editorialheading">
     <!-- The 'asterix' behavior in utils.js fires when the user hovers over or clicks this link -->
    <!-- <a class="asterix" href="javascript://" id="citation-top">
      <img alt="Add to My Citations" class="asterix" src="icons/cite.gif"/>
     </a>--><!-- kmd -->
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:when test="$doc.view='print'">
    <div class="centerhead">
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:when test="@rend='tpTitle'">
    <div class="tpTitle">
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:otherwise>
    <p class="centerhead">
     <!-- The 'asterix' behavior in utils.js fires when the user hovers over or clicks this link -->
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
  <!-- This div is initially hidden, but gets popped up by the 'asterix' behavior in utils.js when the
            user hovers over the link.
        -->
  <div class="citation" id="citblock-top">
   <xsl:call-template name="fillCitBlock">
    <xsl:with-param name="id" select="$id"/>
   </xsl:call-template>
  </div>
 </xsl:template>

 <!-- ELEMENT: letterhead -->
 <xsl:template exclude-result-prefixes="#all" match="tei:letterhead">
  <div class="letterhead">
   <xsl:choose>
    <xsl:when test="@rend">
     <p>
      <xsl:call-template name="align"/>
     </p>
    </xsl:when>
    <xsl:otherwise>
     <p class="noindent">
      <xsl:apply-templates/>
     </p>
    </xsl:otherwise>
   </xsl:choose>
  </div>
 </xsl:template>

 <!-- ELEMENT: note -->
 <xsl:template exclude-result-prefixes="#all" match="tei:note">
  <xsl:choose>
   <xsl:when test="@type='an'">
    <xsl:choose>
     <xsl:when test="preceding-sibling::tei:figure">
      <p class="inline">
       <span class="superscript">
        <xsl:value-of select="@n"/>
       </span>
      </p>
     </xsl:when>
     <xsl:otherwise>
      <a class="superscript alteration" id="text_note{@n}" onclick="selectNote('note{@n}');" onmouseout="unliteNote('note{@n}');"
       onmouseover="hiliteNote('note{@n}');">
       <xsl:value-of select="@n"/>
      </a>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <!-- ticket #160 -->
   <!-- authorial note -->
   <xsl:when test="@type='au' and not(@place='foot')">
    <span class="normal">
     <xsl:text> [</xsl:text>
     <span class="italic">
      <xsl:value-of select="@n"/>
      <xsl:text> </xsl:text>
     </span>
     <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
     <xsl:text>] </xsl:text>
    </span>
   </xsl:when>
   <!-- editorial note -->
   <xsl:when test="@type='ed'">
    <xsl:choose>
     <xsl:when test="parent::tei:div3[@type='postmark']">
      <span class="normal">
       <xsl:text> [</xsl:text>
       <i>
        <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
       </i>
       <xsl:text>] </xsl:text>
      </span>
     </xsl:when>
     <xsl:when test="following-sibling::tei:ab[@type='pt']">
      <span class="normal">
       <xsl:text> [</xsl:text>
       <i>
        <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
       </i>
       <xsl:text>] </xsl:text>
      </span>
     </xsl:when>
     <xsl:otherwise>
      <span class="normal">
       <xsl:text>[</xsl:text>
       <i>
        <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
       </i>
       <xsl:text>]</xsl:text>
      </span>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <!-- ? note -->
   <xsl:when test="@type='pt'">
    <xsl:text> [</xsl:text>
    <span class="italic">
     <xsl:value-of select="@n"/>
    </span>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
   </xsl:when>
   <xsl:when test="@type='cp'"> </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: opener -->
 <xsl:template exclude-result-prefixes="#all" match="tei:opener">
  <p>
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <!-- ELEMENT: p -->
 <xsl:template exclude-result-prefixes="#all" match="tei:p">
  <xsl:choose>
   <xsl:when test="parent::tei:div2[@type='pub'] | parent::tei:div2[@type='provenance'] | parent::tei:div2[@type='appletter']">
    <xsl:apply-templates/>
    <br/>
   </xsl:when>
   <xsl:when test="parent::tei:note[@type='an']">
    <xsl:choose>
     <xsl:when test="preceding-sibling::tei:p">
      <p>
       <xsl:call-template name="align"/>
      </p>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

<!-- ELEMENT: pb -->
    <xsl:template match="tei:pb" exclude-result-prefixes="#all">
      <xsl:variable name="id" select="@n"/>
      <xsl:choose>
	<xsl:when test="$doc.view!='facsimile'"/>
	<xsl:otherwise>
      <a href="#" class="mslink" id="page-{$id}" onclick="selectNote('note-{$id}');"><xsl:text> [MS page </xsl:text><xsl:value-of select="@n"/><xsl:text>] </xsl:text></a>
      </xsl:otherwise>
	</xsl:choose>
    </xsl:template>

 <!-- ELEMENT: ps -->
 <xsl:template exclude-result-prefixes="#all" match="tei:ps">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: salute -->
 <xsl:template exclude-result-prefixes="#all" match="tei:salute">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: seg: see common-->
 
 <!-- ELEMENT: sourceline -->
 <xsl:template exclude-result-prefixes="#all" match="tei:sourceline">
  <br/>
  <span class="source">
   <xsl:apply-templates/>
  </span>
 </xsl:template>

 <!-- ELEMENT: ptr -->
 <xsl:template exclude-result-prefixes="#all" match="tei:ptr">
  <xsl:choose>
   <xsl:when test="@rend='embed'">
    <xsl:choose>
     <xsl:when test="@doc">
      <xsl:variable name="docfile" select="concat('tei/letters/',@doc,'.xml')"/>
      <xsl:apply-templates select="document($docfile)/descendant::tei:div1/*"/>
     </xsl:when>
     <xsl:when test="@href">
      <xsl:variable name="docfile" select="concat('tei/letters/',@href)"/>
      <xsl:apply-templates select="document($docfile)/descendant::tei:div1/*"/>
     </xsl:when>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="@rend='excerpt'">
    <xsl:choose>
     <xsl:when test="@doc">
      <xsl:variable name="docfile" select="concat('tei/letters/',@doc,'.xml')"/>
      <xsl:apply-templates select="document($docfile)/descendant::tei:div1/*"/>
     </xsl:when>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <a href="concat('?docId=letters/',@href,'&amp;chunk.id=',@from,'&amp;brand=mtp&amp;style=letter#X')">
     <xsl:apply-templates/>
    </a>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: ref -->
 <xsl:template exclude-result-prefixes="#all" match="*:ref">
      <a href="{@target}" title="{@n}">
       <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
      </a>
 </xsl:template>


 <!-- =============================================================== -->
 <!-- Letter Named Templates                                          -->
 <!-- =============================================================== -->

 <!-- TEMPLATE: notes -->
 <xsl:template exclude-result-prefixes="#all" name="notes">
  <div align="center">
   <br/>zzz
   <a> <xsl:attribute name="href">javascript://</xsl:attribute> <xsl:attribute name="onClick">
    <xsl:text>javascript:window.open('</xsl:text>view?docId=letters/MTDP00004.xml;doc.view=popup;style=letter;brand=mtp<xsl:text>','popup','width=860,height=600,resizable=yes,scrollbars=no')</xsl:text>
    </xsl:attribute> Editorial Signs </a>
  </div>
  <xsl:call-template name="fnletter"/>
  <br class="clear"/>
  <br class="clear"/>
  <p class="noindgap">
   <xsl:if test=".//sourceDesc/bibl[@n='copy']">
    <xsl:call-template name="hdrcopy"/>
   </xsl:if>
   <xsl:choose>
    <xsl:when test=".//div2[@type='pub']">
     <p class="noindgap">
      <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <i>Previous publication:</i>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <xsl:apply-templates select=".//div2[@type='pub']/*"/>
     </p>
    </xsl:when>
   </xsl:choose>
   <xsl:choose>
    <xsl:when test=".//div2[@type='provenance']">
     <p class="noindgap">
      <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <i>Provenance:</i>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <xsl:apply-templates select=".//div2[@type='provenance']/*"/>
     </p>
    </xsl:when>
   </xsl:choose>
   <xsl:if test=".//app">
    <xsl:if test="not(div1[@type='commentary']/div2[@type='appletter'])">
     <xsl:choose>
      <xsl:when test=".//witList">
       <p class="noindgap">
        <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
        <span class="en-space"><xsl:text> </xsl:text></span>
        <i>Emendations, adopted readings, and textual notes:</i>
        <span class="en-space"><xsl:text> </xsl:text></span>
        <xsl:value-of select=".//div2[@type='appletter']"/>
       </p>
      </xsl:when>
      <xsl:otherwise>
       <p class="noindgap">
        <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
        <span class="en-space"><xsl:text> </xsl:text></span>
        <i>Emendations and textual notes:</i>
        <span class="en-space"><xsl:text> </xsl:text></span>
        <xsl:value-of select=".//div2[@type='appletter']"/>
       </p>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:if>
    <br/>zzz
    <xsl:for-each select=".//note[@type='cp']|//app[not(@type)]">
     <xsl:choose>
      <xsl:when test="name()='note'">
       <p class="center">
        <span class="normal">
         <xsl:text> [</xsl:text>
         <i>
          <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
         </i>
         <xsl:text>] </xsl:text>
        </span>
       </p>
      </xsl:when>
      <xsl:otherwise>
       <p> <xsl:attribute name="class">appnote</xsl:attribute> <xsl:attribute name="id">note<xsl:value-of select="@from"/></xsl:attribute>
        <xsl:attribute name="onmouseover">hiliteText('text_note<xsl:value-of select="@from"/>');</xsl:attribute> <xsl:attribute
        name="onmouseout">unliteText('text_note<xsl:value-of select="@from"/>');</xsl:attribute> <xsl:attribute name="onclick"
        >selectText('text_note<xsl:value-of select="@from"/>');</xsl:attribute> <xsl:apply-templates select="lem"/> &#x2022;
        <xsl:apply-templates select="rdg"/> </p>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:for-each>
    <xsl:choose>
     <xsl:when test=".//div2[@type='collation']">
      <br/>zzz
      <p class="noindent">
       <xsl:text> &#x220e; </xsl:text>
       <i>Collation:</i>
       <xsl:text>&#x2002;</xsl:text>
       <xsl:value-of select="//div2[@type='collation']"/>
      </p>
      <xsl:for-each select=".//app[@type='hc']">
       <p class="noindent"><xsl:apply-templates select="lem"/> &#x2022; <xsl:apply-templates select="rdg"/></p>
      </xsl:for-each>
     </xsl:when>
    </xsl:choose>
   </xsl:if>
  </p>
 </xsl:template>

 <!-- TEMPLATE: fnletter -->
 <xsl:template exclude-result-prefixes="#all" name="fnletter">
  <a name="AN"/>
  <xsl:for-each select="//div1/descendant::tei:note[@place='foot'][not(@type='au')]">
   <div>
    <xsl:attribute name="class">altnote</xsl:attribute>
    <xsl:attribute name="id">note<xsl:value-of select="@n"/></xsl:attribute>
    <xsl:attribute name="onmouseover">hiliteText('text_note<xsl:value-of select="@n"/>');</xsl:attribute>
    <xsl:attribute name="onmouseout">unliteText('text_note<xsl:value-of select="@n"/>');</xsl:attribute>
    <xsl:attribute name="onclick">selectText('text_note<xsl:value-of select="@n"/>');</xsl:attribute>
    <p class="footnote">
     <a>
      <xsl:attribute name="name">
       <xsl:value-of select="concat('an',@n)"/>
      </xsl:attribute>
     </a>
     <span class="small">
      <!-- ticket #184 -->
      <xsl:if test="@type='an'">
       <xsl:variable name="id" select="/TEI/@xml:id"/>
       <xsl:variable name="n" select="concat('an',@n)"/>
       <!-- The 'asterix' behavior in utils.js fires when the user hovers over or 
                                clicks this link -->
        <!-- This div is initially hidden, but gets popped up by the 'asterix' behavior
                                in utils.js when the user hovers over the link.
                            -->
       <div class="citation" id="citblock-{$n}">
        <xsl:call-template name="fillCitBlock">
         <xsl:with-param name="id" select="$id"/>
         <xsl:with-param name="context" select="$n"/>
        </xsl:call-template>
       </div>
      </xsl:if>
      <span class="superscript">
       <xsl:value-of select="@n"/>
      </span>
      <xsl:apply-templates/>
     </span>
    </p>
   </div>
  </xsl:for-each>
 </xsl:template>

 <!-- TEMPLATE: hdrcopy -->
 <xsl:template exclude-result-prefixes="#all" match="tei:sourceDesc" name="hdrcopy">
  <xsl:if test="$doc.view!='print'">
   <a name="APP"/>
   <div align="center">
    <a> <xsl:attribute name="href">javascript://</xsl:attribute> <xsl:attribute name="onClick">
     <xsl:text>javascript:window.open('</xsl:text>view?docId=letters/MTDP00006.xml;doc.view=popup;style=letter;brand=mtp<xsl:text>','popup','width=860,height=600,resizable=yes,scrollbars=no')</xsl:text>
     </xsl:attribute> Description of Texts and Provenance </a>
    <br/>zzz
    <br/>zzz
   </div>
  </xsl:if>
  <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
  <span class="en-space"><xsl:text> </xsl:text></span>
  <i>Copy-text:</i>
  <span class="en-space"><xsl:text> </xsl:text></span>
  <xsl:for-each select="//tei:bibl[@n='copy']">
   <xsl:apply-templates/>
  </xsl:for-each>
 </xsl:template>

<!-- TEMPLATE: align -->
 <xsl:template name="align">
  <xsl:choose>
   <xsl:when test="@type='monogram'">
    <xsl:attribute name="class">
     <xsl:value-of select="@rend"/>
    </xsl:attribute>
    <span class="monogramtext">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@hand">
    <xsl:choose>
     <xsl:when test="matches(@rend, '^text-indent:\d+')">
      <xsl:attribute name="class">hand</xsl:attribute>
      <xsl:attribute name="style">
       <xsl:value-of select="concat(@rend,'em')"/>
      </xsl:attribute>
      <xsl:apply-templates/>
     </xsl:when>
     <xsl:when test="matches(@rend, '^text-hang:\d+')">
      <xsl:attribute name="class">hand</xsl:attribute>
      <xsl:attribute name="style">
       <xsl:value-of select="concat(@rend,'em')"/>
      </xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
      <xsl:attribute name="class">
       <xsl:value-of select="concat('hand ',@rend)"/>
      </xsl:attribute>
      <xsl:apply-templates/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="matches(@rend, '^float[a-z]+')">
    <div>
     <xsl:attribute name="class">
      <xsl:value-of select="@rend"/>
     </xsl:attribute>
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:when test="matches(@rend, '^text-indent:\d+')">
    <xsl:attribute name="style">
     <xsl:value-of select="concat(@rend,'em')"/>
    </xsl:attribute>
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="class">
     <xsl:value-of select="@rend"/>
    </xsl:attribute>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- TEMPLATE: fillCitBlock -->
 <!-- This template creates the innards of a pop-up citation block on the object view page. -->
 <xsl:template exclude-result-prefixes="#all" name="fillCitBlock">
  <xsl:param name="id"/>
  <xsl:param name="parent" select="''"/>
  <xsl:param name="context" select="''"/>

  <!-- Grab the folder data from the session -->


 </xsl:template>


</xsl:stylesheet>
