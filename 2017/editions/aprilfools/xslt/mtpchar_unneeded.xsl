<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="#all">
    
    <!-- 
        This is a special template that translates certain UNICODE characters to images
    -->
   
   <!-- Note that ensp and emsp use the same image; there's a class for each that determines their width. (That's how Erim set it up.) -->
   <!-- Each character (i.e., not including the spaces) needs @class="glyph". -->
   
   <!-- ENTITY emsp SYSTEM "../figures/blank.gif" NDATA GIF --> <!-- em-space: 2003 -->
   <!-- ENTITY ensp SYSTEM "../figures/blank.gif" NDATA GIF --> <!-- en-space: 2002 -->
   <!-- ENTITY thinsp SYSTEM "../figures/blank.gif" NDATA GIF --> <!-- thinspace: 2009 -->
   <!-- ENTITY langle SYSTEM "../figures/ts_ltangle.gif" NDATA GIF --> <!-- left angle-bracket: 003C -->
   <!-- ENTITY rangle SYSTEM "../figures/ts_rtangle.gif" NDATA GIF --> <!-- right angle-bracket: 003E -->
   <!-- ENTITY caret SYSTEM "../figures/ts_caret.gif" NDATA GIF --> <!-- caret: 2038 -->
   <!-- ENTITY pipe2 SYSTEM "../figures/ts_dblpipe.gif" NDATA GIF --> <!-- double pipe: 2016 -->
   <!-- ENTITY blksq SYSTEM "../figures/ts_endprf.gif" NDATA GIF --> <!-- black square: 220E -->
   <!-- ENTITY whtdia SYSTEM "../figures/ts_whtdia.gif" NDATA GIF --> <!-- white diamond: 25C7 -->
   <!-- ENTITY fistl SYSTEM "../figures/ts_manlft.gif" NDATA GIF --> <!-- L manicule: 261C -->
   <!-- ENTITY fistr SYSTEM "../figures/ts_manrt.gif" NDATA GIF --> <!-- R manicule: 261E -->
   <!-- ENTITY env SYSTEM "../figures/ts_envlop.gif" NDATA GIF --> <!-- envelope: 2709 -->
   <!-- ENTITY chkmk SYSTEM "../figures/ts_chk.gif" NDATA GIF --> <!-- check mark: 2713 -->
   <!-- ENTITY aubl SYSTEM "../figures/ts_wbrklt.gif" NDATA GIF --> <!-- L white bracket: 301A -->
   <!-- ENTITY aubr SYSTEM "../figures/ts_wbrkrt.gif" NDATA GIF --> <!-- R white bracket: 301B -->
   
   <xsl:template match="text()" exclude-result-prefixes="#all">
      <xsl:value-of select="replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(.,
         '&#x003C;','&amp;lt;'),
         '&#x003E;','&amp;gt;'),
         '&#x2003;','&lt;img src=&quot;icons/mtp/blank.gif&quot; class=&quot;em-space&quot; alt=&quot;em-space&quot;&gt;'),
         '&#x2002;','&lt;img src=&quot;icons/mtp/blank.gif&quot; class=&quot;en-space&quot; alt=&quot;en-space&quot;&gt;'),
         '&#x2009;','&lt;img src=&quot;icons/mtp/blank.gif&quot; class=&quot;thinspace&quot; alt=&quot;thinspace&quot;&gt;'),
         '&#x2038;','&lt;img src=&quot;icons/mtp/ts_caret.gif&quot; class=&quot;glyphbase&quot; alt=&quot;caret&quot;&gt;'),
         '&#x2016;','&lt;img src=&quot;icons/mtp/ts_dblpipe.gif&quot; class=&quot;glyph&quot; alt=&quot;double pipe&quot;&gt;'),
         '&#x220E;','&lt;img src=&quot;icons/mtp/ts_endprf.gif&quot; class=&quot;glyph&quot; alt=&quot;square bullet&quot;&gt;'),
         '&#x25C7;','&lt;img src=&quot;icons/mtp/ts_whtdia.gif&quot; class=&quot;glyph&quot; alt=&quot;white diamond&quot;&gt;'),
         '&#x261C;','&lt;img src=&quot;icons/mtp/ts_manlft.gif&quot; class=&quot;glyph&quot; alt=&quot;left manicule&quot;&gt;'),
         '&#x261E;','&lt;img src=&quot;icons/mtp/ts_manrt.gif&quot; class=&quot;glyph&quot; alt=&quot;right manicule&quot;&gt;'),
         '&#x2709;','&lt;img src=&quot;icons/mtp/ts_envlop.gif&quot; class=&quot;glyph&quot; alt=&quot;envelope&quot;&gt;'),
         '&#x2713;','&lt;img src=&quot;icons/mtp/ts_chk.gif&quot; class=&quot;glyph&quot; alt=&quot;check mark&quot;&gt;'),
         '&#x301A;','&lt;img src=&quot;icons/mtp/ts_wbrklt.gif&quot; class=&quot;glyph&quot; alt=&quot;left white bracket&quot;&gt;'),
         '&#x301B;','&lt;img src=&quot;icons/mtp/ts_wbrkrt.gif&quot; class=&quot;glyph&quot; alt=&quot;right white bracket&quot;&gt;')" 
         disable-output-escaping="yes"/>
   </xsl:template>
   
</xsl:stylesheet>

