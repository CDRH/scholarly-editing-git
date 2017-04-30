<xsl:stylesheet version="2.0" 
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:tei="http://www.tei-c.org/ns/1.0" 
		xmlns:xlink="http://www.w3.org/1999/xlink" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		>


   <!-- ====================================================================== -->
    <!-- Import MTP Common Templates                                            -->
    <!-- ====================================================================== -->

    <xsl:import href="mtpCommon.xsl"/>

   <!-- ====================================================================== -->
    <!-- Include Component Templates                                            -->
    <!-- ====================================================================== -->
    <xsl:include href="component.xsl"/>

   <!-- ====================================================================== -->
    <!-- Global Variables                                            -->
    <!-- ====================================================================== -->
    <xsl:variable name="xtfURL" select="'http://www.marktwainproject.org/xtf/'"/>
    <xsl:variable name="iconPath" select="'icons/'"/>

    <!-- ====================================================================== -->
    <!-- XHTML Output                                                           -->
    <!-- ====================================================================== -->

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" encoding="UTF-8" indent="no"
        media-type="text/html; charset=UTF-8" method="xhtml" omit-xml-declaration="yes"/>
 


  <xsl:template match="/tei:TEI/tei:text/tei:body">
    <xsl:variable name="abbreviated.title" select="//teiHeader/titleStmt/title"/>
        
           
               
                   
                       
                        
			  <xsl:for-each select="/tei:TEI/tei:teiHeader/tei:revisionDesc/tei:listChange/tei:change">
			    <xsl:value-of select="."/><xsl:text>: </xsl:text><xsl:value-of select="@who"/><xsl:text> </xsl:text><xsl:value-of select="@when"/><xsl:text>
</xsl:text>
       <xsl:if test="position() != last()">
            <xsl:value-of select="'; '" />
        </xsl:if>
			  </xsl:for-each>
                            <!-- textual content -->
                            <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/*"/>
                            <!-- authorial notes next -->
                            <xsl:if test="//note[@type='au' and @place='foot']">
                                <xsl:text disable-output-escaping="yes"><![CDATA[<br class="clear"/>]]></xsl:text>
                                <xsl:for-each select="//tei:note[@type='au' and @place='foot']">
                                    <span class="small">
                                        <xsl:value-of select="@n"/>
                                        <span class="en-space"><xsl:text> </xsl:text></span>
                                        <xsl:apply-templates select="*|text()[not(normalize-space()='')]"/>
                                    </span>
                                    <br/>
                                </xsl:for-each>
                            </xsl:if>
                            <!-- end content-text -->
                        
                        <!-- end content-primary -->
			<xsl:if test="//tei:div1[@type='commentary']">
                            <!-- secondary content -->
                            <div id="content-secondary">
                                <div id="notes">
				  <xsl:if test="//tei:note[@type='an']">				  
                                    <h2>Explanatory Notes</h2>
                                    <xsl:for-each select="//tei:div1/descendant::tei:note[@place='foot']">
                                      <p class="footnote">
                                        <xsl:attribute name="id">
                                          <xsl:value-of select="@xml:id"/>
                                        </xsl:attribute>
                                        <xsl:apply-templates select="." mode="footnotes"/>
                                      </p>
                                    </xsl:for-each>
				  </xsl:if>
                                    <!--<br class="clear"/>--><!-- kmd -->
                                    <br class="clear"/>
                                    <!-- end explanatory notes -->
                                    <!-- textual commentary -->
                                    
                              
                                <xsl:if test="$idno != 'intro' or not($idno)">
                                  <h2>Textual Commentary</h2>
                                    <p class="noindgap">
                                        <xsl:call-template name="hdrcopy"/>
                                        <xsl:choose>
                                            <xsl:when test="//tei:div2[@type='pub']">
                                                <p class="noindgap">
                                                    <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
                                                    <span class="en-space"><xsl:text> </xsl:text></span>
                                                    <i>Previous publication:</i>
                                                    <span class="en-space"><xsl:text> </xsl:text></span>
                                                    <xsl:apply-templates select="//tei:div2[@type='pub']/*"/>
                                                </p>
                                            </xsl:when>
                                        </xsl:choose>
                                        <xsl:choose>
                                            <xsl:when test="//tei:div2[@type='provenance']">
                                                <p class="noindgap">
                                                    <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
                                                    <span class="en-space"><xsl:text> </xsl:text></span>
                                                    <i>Provenance:</i>
                                                    <span class="en-space"><xsl:text> </xsl:text></span>
                                                    <xsl:apply-templates select="//tei:div2[@type='provenance']/*"/>
                                                </p>
                                            </xsl:when>
                                        </xsl:choose>
                                        <!-- end textual commentary -->
                                        <!-- begin apparatus -->
                                        <xsl:if test="//tei:app">
                                            <xsl:if test="not(tei:div1[@type='commentary']/tei:div2[@type='appletter'])">
                                                <xsl:choose>
                                                    <xsl:when test="//tei:listWit">
                                                        <p class="noindgap">
                                                            <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
                                                            <span class="en-space"><xsl:text> </xsl:text></span>
                                                            <i>Emendations, adopted readings, and textual notes:</i>
                                                            <span class="en-space"><xsl:text> </xsl:text></span>
                                                            <xsl:value-of select="//tei:div2[@type='appletter']"/>
                                                        </p>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <p class="noindgap">
                                                            <span class="ts_endprf"><xsl:text>▮</xsl:text></span>
                                                            <span class="en-space"><xsl:text> </xsl:text></span>
                                                            <i>Emendations and textual notes:</i>
                                                            <span class="en-space"><xsl:text> </xsl:text></span>
                                                            <xsl:value-of select="//tei:div2[@type='appletter']"/>
                                                        </p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:if>
                                            <br/>
                                            <xsl:for-each select="//tei:note[@type='cp']|//tei:app[not(@type)]">
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
                                                        <p>
                                                            <xsl:attribute name="class">appnote</xsl:attribute>
                                                            <xsl:attribute name="id">note<xsl:value-of select="@from"/></xsl:attribute>
                                                            <xsl:apply-templates select="tei:lem"/> &#x2022; <xsl:apply-templates select="tei:rdg"/>
                                                        </p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:for-each>
                                            <xsl:choose>
                                                <xsl:when test="//tei:div2[@type='collation']">
                                                    <br/>
                                                    <p class="noindent">{010}
                                                        <xsl:text> &#x220e; </xsl:text>
                                                        <i>Collation:</i>
                                                        <xsl:text>&#x2002;</xsl:text>
                                                        <xsl:value-of select="//tei:div2[@type='collation']"/>
                                                    </p>
                                                    <xsl:for-each select="//tei:app[@type='hc']">
                                                        <p class="noindent">{011}<xsl:apply-templates select="tei:lem"/> &#x2022;
                                                                <xsl:apply-templates select="tei:rdg"/></p>
                                                    </xsl:for-each>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:if>
                                    </p>
                                </xsl:if>
                                    <!-- end apparatus -->


				    <!-- prosopography -->
                                  <xsl:if test="//tei:name[@corresp]">
                                        <xsl:variable name="NAMES" select="document('../xml/personography.xml')"/>
                                        <div>
                                            <h2>Persons Mentioned</h2>
                                            <xsl:for-each-group select="//tei:text//tei:name" group-by="@corresp">
					      <xsl:sort select="current-grouping-key()"/>
                                              <xsl:if test="@corresp != '#SLC'">
					      <xsl:variable name="name" select="."/>
					      <xsl:variable name="id" select="substring-after(@corresp,'#')"/>
                                                <p>
                                                     <b>
                                                       <xsl:value-of disable-output-escaping="yes" select="$NAMES//tei:person[@xml:id=$id]/tei:persName[@type='display']"/>
                                                    </b>&#xA0;&#xA0;(<xsl:value-of select="$NAMES//tei:person[@xml:id=$id]/tei:birth/@when"/>&#x2013;<xsl:value-of select="$NAMES//tei:person[@xml:id=$id]/tei:death/@when"/>)
                                                    <br/>
                                                          <div class="normal">
                                                            <xsl:apply-templates select="$NAMES//tei:person[@xml:id=$id]/tei:note/*"/>
                                                        </div>
                                                        <br/>
                                                </p>
                                              </xsl:if>
                                            </xsl:for-each-group>
                                        </div>
                                    </xsl:if>

                                </div>
                                <!-- end notes -->
                            </div>
                            <!-- end content-secondary -->
                        </xsl:if>
                    
                    <!-- end content -->

                
                <!-- end object -->
        
    </xsl:template>


</xsl:stylesheet>

