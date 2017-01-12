<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
 xmlns:session="java:org.cdlib.xtf.xslt.Session" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!-- 
        The templates in this stylesheet are used by both letters and works. 
        If it is decided that you need different behaviors for each content type, 
        just define a new template in the appropriate styleheet. They will supersede these.
    -->

 <!-- =============================================================== -->
 <!-- Import XTF Core Templates and Functions                         -->
 <!-- =============================================================== -->

 <!--<xsl:import href="mtpchar.xsl"/>-->

<xsl:key name="pers" match="*:person" use="@xml:id"/>
<xsl:variable name="prosopo" select="document(personography.xml)"/>


 <!-- =============================================================== -->
 <!-- Common MTP Elements                                             -->
 <!-- =============================================================== -->

 <!-- ELEMENT: ab -->
 <xsl:template exclude-result-prefixes="#all" match="*:ab">
  <xsl:choose>
   <!-- To support direct encoding of CSS -->
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

 <!-- ELEMENT: add -->
 <xsl:template exclude-result-prefixes="#all" match="*:add">
  <xsl:choose>
   <!-- To support direct encoding of CSS -->
   <xsl:when test="@rend">
    <span class="{@rend}">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="matches(text()[1],'^.$|^&amp;#x*[0-9]+;$')">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <span class="add">
     <span class="carat">^</span>
    </span>
    <xsl:apply-templates/>
    <span class="add">
     <span class="carat">^</span>
    </span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template exclude-result-prefixes="#all" match="*:add/text()">
  <xsl:choose>
   <xsl:when test="matches(.,'^.$|^&amp;#x*[0-9]+;$')">
    <span class="caret">
     <xsl:value-of select="."/>
    </span>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
<!-- added Nov 8 by ldm -->
 <!-- ELEMENT: addrLine -->
 <xsl:template exclude-result-prefixes="#all" match="*:addrLine">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
    <br/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: author -->
 <xsl:template exclude-result-prefixes="#all" match="*:author">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: bibl -->
 <xsl:template exclude-result-prefixes="#all" match="*:bibl">
  <xsl:choose>
   <xsl:when test="@rend='inline'">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
  <p class="hang" style="padding-top: 6px;"> 
   <xsl:apply-templates/>
  </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: byline -->
 <xsl:template exclude-result-prefixes="#all" match="*:byline">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:when test="ancestor::*:titlePage">
    <p class="center">
     <xsl:apply-templates/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
    <br/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: cit -->
 <xsl:template exclude-result-prefixes="#all" match="*:cit">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: del -->
 <xsl:template exclude-result-prefixes="#all" match="*:del">
  <xsl:choose>
   <xsl:when test="@rend='double'">
    <span class="doubledel">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="parent::*:del">
    <span class="doubledel">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="matches(text()[1],'^.$|^&amp;#x*[0-9]+;$')">
    <xsl:apply-templates/>
   </xsl:when>
   <xsl:otherwise>
    <span class="del">
     <xsl:apply-templates/>
    </span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template exclude-result-prefixes="#all" match="*:del/text()">
  <xsl:choose>
   <xsl:when test="matches(.,'^.$|^&amp;#x*[0-9]+;$')">
    <span class="virgule">
     <xsl:value-of select="."/>
    </span>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: docTitle -->
 <xsl:template exclude-result-prefixes="#all" match="*:docTitle">
  <div class="tpTitle">
   <xsl:apply-templates/>
  </div>
 </xsl:template>

 <!-- ELEMENT: docAuthor -->
 <xsl:template exclude-result-prefixes="#all" match="*:docAuthor">
  <p class="tpName">
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <!-- ELEMENT: docImprint -->
 <xsl:template exclude-result-prefixes="#all" match="*:docImprint">
  <p class="tpHdr">
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <!-- ELEMENT: docDate -->
 <xsl:template exclude-result-prefixes="#all" match="*:docDate">
  <p class="tpDate">
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <!-- ELEMENT: figDesc, p4 only -->
 <xsl:template exclude-result-prefixes="#all" match="figDesc">
  <xsl:choose>
   <xsl:when test="@rend='captionJust'">
    <p class="captionJust">
     <xsl:apply-templates/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <p class="caption">
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

<!-- ELEMENT: floatingText -->
<!--skg: p5 only-->
<xsl:template exclude-result-prefixes="#all" match="*:floatingText">
<div>
<xsl:choose>
   <!-- To support direct encoding of CSS -->
   <xsl:when test="@rend">
<xsl:attribute name="class">
<xsl:value-of select="@rend"/>
</xsl:attribute>
     <br/><xsl:apply-templates/><br/>
   </xsl:when>
   <xsl:otherwise>
     <br/><xsl:apply-templates/><br/>
   </xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>

 <!-- ELEMENT: graphicGroup -->
 <!--skg: p4 only-->
 <xsl:template exclude-result-prefixes="#all" match="graphicGroup">

  <xsl:variable name="number" select="@number"/>
  <xsl:variable name="orientation" select="@orientation"/>
  <xsl:variable name="rend" select="@rend"/>
  <xsl:variable name="align" select="@align"/>
  <xsl:variable name="location" select="@location"/>
  <xsl:variable name="lineCount" select="count(.//lb) + 1"/>

  <xsl:choose>
   <xsl:when test="$rend='brace'">
    <xsl:choose>
     <xsl:when test="$location='right'">
      <div class="text-box">
       <div class="text">
        <xsl:apply-templates/>
       </div>
       <span class="left-brace-scalable font-{$lineCount}">
        <xsl:choose>
         <xsl:when test="$number=1">&#x007D;</xsl:when>
         <xsl:when test="$number=2">&#x007D;&#x007D;</xsl:when>
         <xsl:when test="$number=3">&#x007D;&#x007D;&#x007D;</xsl:when>
         <xsl:when test="$number=4">&#x007D;&#x007D;&#x007D;&#x007D;&#x007D;</xsl:when>
        </xsl:choose>
       </span>
       <br class="clear"/>
      </div>
      <br class="clear"/>
     </xsl:when>
     <xsl:otherwise>
      <div class="text-box">
       <span class="right-brace-scalable font-{$lineCount}">
        <xsl:choose>
         <xsl:when test="$number=1">&#x007B;</xsl:when>
         <xsl:when test="$number=2">&#x007B;&#x007B;</xsl:when>
         <xsl:when test="$number=3">&#x007B;&#x007B;&#x007B;</xsl:when>
         <xsl:when test="$number=4">&#x007B;&#x007B;&#x007B;&#x007B;&#x007B;</xsl:when>
        </xsl:choose>
       </span>
       <div class="text">
        <xsl:apply-templates/>
       </div>
       <br class="clear"/>
      </div>
      <br class="clear"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
<xsl:when test="$rend='box'">
<div class="line-box">
<xsl:apply-templates/>
</div>
</xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:attribute name="class">graphicgroup</xsl:attribute>
     <xsl:text>{graphic group: </xsl:text>
     <xsl:value-of select="$number"/>
     <xsl:text> </xsl:text>
     <xsl:value-of select="$orientation"/>
     <xsl:text> </xsl:text>
     <xsl:value-of select="$rend"/>
     <xsl:text> </xsl:text>
     <xsl:value-of select="$align"/>
     <xsl:text> </xsl:text>
     <xsl:value-of select="$location"/>
     <xsl:text>}</xsl:text>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: hi -->
 <xsl:template exclude-result-prefixes="#all" match="*:hi">
  <span>
   <xsl:attribute name="class" select="@rend"/>
   <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
  </span>
 </xsl:template>

 <!-- ELEMENT: item -->
 <xsl:template exclude-result-prefixes="#all" match="*:item">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: l  -->
 <xsl:template exclude-result-prefixes="#all" match="*:l">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:when test="ancestor::*:titlePage">
    <p class="center">
     <xsl:apply-templates/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
    <br/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: label -->
 <xsl:template exclude-result-prefixes="#all" match="*:label">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: lb -->
 <xsl:template exclude-result-prefixes="#all" match="*:lb">
  <xsl:choose>
   <xsl:when
    test="ancestor::ab[@type='pt'] | ancestor::lem | ancestor::rdg | ancestor::note[@type='alt'] |      ancestor::note[@type='mwn'] | ancestor::note[@type='in'] | ancestor::note[@type='pt']">
    <xsl:text>&#x01c0;</xsl:text>
   </xsl:when>
   <xsl:when
    test="ancestor::tei:ab[@type='pt'] | ancestor::tei:lem | ancestor::tei:rdg | ancestor::tei:note[@type='alt'] |      ancestor::tei:note[@type='mwn'] | ancestor::tei:note[@type='in'] | ancestor::tei:note[@type='pt']">
    <xsl:text>&#x01c0;</xsl:text>
   </xsl:when>
   <xsl:otherwise>
    <span class="left">
     <!--<br class="clear"/>--><span class="clear"></span>
    </span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: lem -->
 <xsl:template exclude-result-prefixes="#all" match="*:lem">
  <xsl:choose>
   <xsl:when test="parent::*:app[@type='ps']">
    <font color="purple">[</font>
    <xsl:apply-templates/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="@wit"/>
    <xsl:text>)</xsl:text>
    <font color="purple">] </font>
   </xsl:when>
   <xsl:when test="@wit">
    <xsl:apply-templates/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="@wit"/>
    <xsl:text>) </xsl:text>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: lg -->
 <xsl:template exclude-result-prefixes="#all" match="*:lg">
  <xsl:choose>
   <xsl:when test="@rend">
    <div>
     <xsl:call-template name="align"/>
    </div>
   </xsl:when>
   <xsl:otherwise>
    <p>
     <xsl:apply-templates/>
    </p>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: list -->
 <xsl:template exclude-result-prefixes="#all" match="*:list">
  <xsl:choose>
   <xsl:when test="@rend='dtpList'">
    <div class="dtpList">
     <xsl:for-each select="child::*:label">
      <div class="dtpLabel">
       <xsl:apply-templates select="."/>
      </div>
      <div class="dtpItem">
       <xsl:apply-templates select="following-sibling::*:item[1]"/>
      </div>
      <br class="clear"/>
     </xsl:for-each>
    </div>
   </xsl:when>
   <xsl:when test="@rend='bulletList'">
    <ul>
     <xsl:for-each select="child::*:item">
      <li>
       <xsl:apply-templates/>
      </li>
     </xsl:for-each>
    </ul>
   </xsl:when>
   <xsl:otherwise>
    <table class="tblList">
     <xsl:for-each select="child::*:label">
      <tr>
       <td class="gloss" width="20%">
        <xsl:apply-templates select="."/>
       </td>
       <td style="display: table-cell; vertical-align:top;" width="80%">
        <xsl:apply-templates select="following-sibling::*:item[1]"/>
       </td>
      </tr>
     </xsl:for-each>
    </table>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: listBibl -->
 <xsl:template exclude-result-prefixes="#all" match="*:listBibl">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: milestone -->
 <xsl:template exclude-result-prefixes="#all" match="*:milestone">
  <xsl:choose>
   <xsl:when test="@rend">
    <xsl:choose>
     <xsl:when test="@rend='fancy'">
      <img alt="section break" class="hr-fancy" height="15" src="icons//ts_section_break_sm.gif" width="60"/>
     </xsl:when>
     <xsl:when test="@rend='oakleaf'">
      <img alt="section break" class="hr-oakleaf" height="14" src="icons//oakleaf.gif" width="14"/>
     </xsl:when>
     <xsl:when
      test="@rend='heavyrule' or @rend='lightrule' or @rend='heavyparallel' or @rend='lightparallel'        or @rend='doubleruletop' or @rend='doublerulebottom'">
      <hr class="hr-{@rend}"/>
     </xsl:when>
     <xsl:when test="@rend='lighttriple'">
      <img alt="section break" class="hr-lighttriple" src="icons//ts_underscore_triple.gif"/>
     </xsl:when>
     <xsl:when test="@rend='plainrule'">
      <hr style="height:1px" width="75%"/>
     </xsl:when>
     <xsl:when test="@rend='paraph'">
      <img alt="section break" class="hr-fancy" src="icons/ts_paraph.gif"/>
     </xsl:when>
     <xsl:otherwise>
      <p class="center">
       <font color="purple">{<xsl:value-of select="@rend"/>}</font>
      </p>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="@n">
    <xsl:choose>
     <xsl:when test="@n='page'">
      <xsl:text>&#x01c1;</xsl:text>
     </xsl:when>
     <xsl:otherwise>
      <p class="center">
       <xsl:value-of select="@n"/>
      </p>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="@unit='page'">
    <xsl:text>&#x01c1;</xsl:text>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: name -->
 <xsl:template exclude-result-prefixes="#all" match="*:name">
   <xsl:variable name="ref" select="substring-after(@ref,'#')"/>
   <xsl:variable name="note" select="document('personography.xml')//key('pers',$ref)/tei:note"/>
<!--  <a><xsl:attribute name="href">javascript://</xsl:attribute>
     <xsl:attribute name="onClick"><xsl:text>javascript:window.open('popup.html'</xsl:text><xsl:value-of select="$note"/><xsl:text>','popup','width=660,height=600,resizable=yes,scrollbars=yes,menubar=yes')</xsl:text>
</xsl:attribute></a> -->
  <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>

 </xsl:template>

 <!-- ELEMENT: pb -->
 <xsl:template exclude-result-prefixes="#all" match="*:pb">
  <xsl:choose>
   <xsl:when test="ancestor::*:app"> &#x01c1; </xsl:when>
   <xsl:when test="ancestor::*:bibl[@n='copy']"> &#x01c1; </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: ptr -->
 <xsl:template exclude-result-prefixes="#all" match="*:ptr">
  <xsl:choose>
   <xsl:when test="/TEI.2">
    <xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
    <a>
     <xsl:attribute name="href">#<xsl:value-of select="@target"/></xsl:attribute>
     <span class="superscript">
      <xsl:value-of select="@type"/>
     </span>
    </a>
   </xsl:when>
   <xsl:when test="/tei:TEI">
    <xsl:text disable-output-escaping="yes"><![CDATA[</a>]]></xsl:text>
    <a>
     <xsl:attribute name="href">
      <xsl:value-of select="@target"/>
     </xsl:attribute>
     <span class="superscript">
      <xsl:value-of select="@type"/>
     </span>
    </a>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: publisher -->
 <xsl:template exclude-result-prefixes="#all" match="*:publisher">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: pubPlace -->
 <xsl:template exclude-result-prefixes="#all" match="*:pubPlace">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: quote -->
 <xsl:template exclude-result-prefixes="#all" match="*:quote">
  <xsl:choose>
   <xsl:when test="parent::*[@rend='blockquote']">
    <table class="embeddedblockquote">
     <tr>
      <td>
       <span class="xsmall">
        <xsl:apply-templates/>
       </span>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="ancestor::*:table | ancestor::*:list | ancestor::*:div2[@type='clipping']">
    <table class="blockquotetbl">
     <tr>
      <td>
       <span class="small">
        <xsl:apply-templates/>
       </span>
      </td>
     </tr>
    </table>
   </xsl:when>
   <xsl:when test="@rend='blockquote'">
    <div class="blockquote">
     <xsl:apply-templates/>
    </div>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: rdg -->
 <xsl:template exclude-result-prefixes="#all" match="*:rdg">
  <xsl:choose>
   <xsl:when test="parent::*:app[@type='ps']">
    <font color="blue">[</font>
    <xsl:apply-templates/>
    <xsl:text> (</xsl:text>
    <xsl:value-of select="@wit"/>
    <xsl:text>)</xsl:text>
    <font color="blue">]</font>
   </xsl:when>
   <xsl:when test="@wit">
    <xsl:choose>
     <xsl:when test="following-sibling::*:rdg"> <xsl:apply-templates/> (<xsl:value-of select="@wit"/>); </xsl:when>
     <xsl:otherwise> <xsl:apply-templates/> (<xsl:value-of select="@wit"/>) </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 
 <!-- ELEMENT: rs -->
 <xsl:template exclude-result-prefixes="#all" match="*:rs">
  <xsl:apply-templates/>
 </xsl:template>
 
 <!-- ELEMENT: seg -->
 <xsl:template exclude-result-prefixes="#all" match="seg">
  <xsl:choose>
   <xsl:when test="@rend='print'">
    <span class="print">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@hand">
    <span class="normal hand">
     <xsl:apply-templates/>
    </span>
   </xsl:when>
   <xsl:when test="@type='monogram'">
    <xsl:choose>
     <xsl:when test="@rend">
      <span class="noindent">
       <xsl:call-template name="align"/>
      </span>
     </xsl:when>
     <xsl:otherwise>
      <span class="noindent">
       <xsl:apply-templates/>
      </span>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <!-- ELEMENT: sic -->
 <xsl:template exclude-result-prefixes="#all" match="*:sic">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: signed -->
 <xsl:template exclude-result-prefixes="#all" match="*:signed">
  <xsl:choose>
   <xsl:when test="@rend">
    <p>
     <xsl:call-template name="align"/>
    </p>
   </xsl:when>
   <xsl:when test="ancestor::*:titlePage">
    <p class="center">
     <xsl:apply-templates/>
    </p>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
    <br/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: source -->
 <xsl:template exclude-result-prefixes="#all" match="*:source">
  <br/>
  <span class="xsmall">
   <xsl:apply-templates/>
  </span>
 </xsl:template>

 <!-- ELEMENT: space -->
 <xsl:template exclude-result-prefixes="#all" match="*:space">
  <xsl:for-each select="1 to @extent">
   <span class="em-space"><xsl:text> </xsl:text></span>
  </xsl:for-each>
 </xsl:template>

 <!-- ELEMENT: title -->
 <xsl:template exclude-result-prefixes="#all" match="*:title">
  <xsl:choose>
   <xsl:when test="@level='m'">
    <i>
     <xsl:apply-templates/>
    </i>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- ELEMENT: titlePage -->
 <xsl:template exclude-result-prefixes="#all" match="*:titlePage">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- ELEMENT: titlePart -->
 <xsl:template exclude-result-prefixes="#all" match="*:titlePart"> </xsl:template>

 <!-- ELEMENT: witStart -->
 <xsl:template exclude-result-prefixes="#all" match="*:witStart">
  <font color="purple">
   <xsl:text>[witStart] </xsl:text>
  </font>
 </xsl:template>

 <!-- ELEMENT: witEnd -->
 <xsl:template exclude-result-prefixes="#all" match="*:witEnd">
  <font color="purple">
   <xsl:text>[witEnd] </xsl:text>
  </font>
 </xsl:template>

 <!-- ELEMENT: witList -->
 <xsl:template exclude-result-prefixes="#all" match="*:witList">
  <table class="witlist">
   <xsl:for-each select="child::*:witness">
    <tr>
     <td align="left" valign="top" width="18%">
      <xsl:value-of select="@sigil"/>
     </td>
     <td width="82%">
      <xsl:apply-templates/>
     </td>
    </tr>
   </xsl:for-each>
  </table>
 </xsl:template>


 <!-- =============================================================== -->
 <!-- Common MTP Named Templates                                      -->
 <!-- =============================================================== -->

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

<!--for au footnotes-->
 <xsl:template name="footnotes">
  <xsl:param name="chunkid"/>
  <xsl:text disable-output-escaping="yes"><![CDATA[<br class="clear"/>]]></xsl:text>
  <xsl:choose>
   <xsl:when test="/TEI.2">
    <xsl:for-each select="//div1[@id=$chunkid]//note[@type='au' and @place='foot'] | //div2[@id=$chunkid]//note[@type='au' and @place='foot'] | //div3[@id=$chunkid]//note[@type='au' and @place='foot']">
     <xsl:variable name="id" select="@id"/>
     <span class="small">
      <a name="{$id}"/>
      <a href="{concat('#_',$id)}">
       <xsl:value-of select="@n"/>
      </a>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
     </span>
     <br/>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="/tei:TEI">
    <xsl:for-each select="//tei:div1[@xml:id=$chunkid]//tei:note[@type='au' and @place='foot'] | //tei:div2[@xml:id=$chunkid]//tei:note[@type='au' and @place='foot'] | //tei:div3[@xml:id=$chunkid]//tei:note[@type='au' and @place='foot']">
     <xsl:variable name="id" select="@xml:id"/>
     <span class="small">
      <a name="{$id}"/>
      <a href="{concat('#_',$id)}">
       <xsl:value-of select="@n"/>
      </a>
      <span class="en-space"><xsl:text> </xsl:text></span>
      <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
     </span>
     <br/>
    </xsl:for-each>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <!-- Default template to catch anomalies 
 <xsl:template exclude-result-prefixes="#all" match="*">
  <span style="color: aqua; text-decoration: blink">
   <xsl:apply-templates/>
  </span>
 </xsl:template> -->

</xsl:stylesheet>
