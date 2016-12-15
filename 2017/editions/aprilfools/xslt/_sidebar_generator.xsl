<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <xsl:import href="aprilfools.xsl"/>
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:variable name="files" select="collection('../xml?recurse=no;select=U*.xml')"/>
    <xsl:variable name="personography" select="document('../xml/personography.xml')"/>
    <table xsl:exclude-result-prefixes="#all" class="table table-condensed table-sortable">


      <thead>
        <tr>
          <!--<td>ID</td>-->
          <td>Filename</td>
          <td>Pers ID</td>
          <td>Sort Sender</td>
          <td>Display Sender</td>
          <td>Date Sort</td>
          <td>Date Display</td>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="$files">
          <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>

          <!-- Split the filename using '\.' -->
          <xsl:variable name="filenamepart" select="substring-before($filename, '.xml')"/>
          <tr>
            <!--<td><xsl:value-of select="/tei:TEI/@xml:id"/></td>-->
            <td>
              <!-- filename -->
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="$filenamepart"/>
                  <xsl:text>.html</xsl:text>
                </xsl:attribute>

                <xsl:value-of select="$filenamepart"/>
              </a>
            </td>
            <xsl:variable name="author_id">
              <xsl:value-of select="substring-after(//tei:head[@type = 'metadata']/tei:name[1]/@corresp, '#')"/>
            </xsl:variable>
            <xsl:variable name="personography_entry" select="$personography//tei:listPerson/tei:person[@xml:id = $author_id]"/>
            <td>
              <!-- persid -->
              <xsl:value-of select="$author_id"/>
            </td>
            <td>
              <!-- sort sender -->
              
              <xsl:variable name="persname">
                <xsl:value-of select="$personography_entry//tei:surname"/>
                <xsl:if test="$personography_entry//tei:forename">
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="$personography_entry//tei:forename[@type = 'first']"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="$personography_entry//tei:forename[@type = 'middle']"/>
                </xsl:if>
              </xsl:variable>
              <xsl:variable name="persname_attribute_clean">
                <xsl:value-of select="$persname"/>
              </xsl:variable>
              
              <a class="popper" data-toggle="popover" title="{$persname_attribute_clean}" content="" data-original-title="test">
                <xsl:value-of select="$persname"/>
              </a>
              <span class="hide popper-content"><xsl:apply-templates select="$personography_entry//tei:note" exclude-result-prefixes="#all"/></span>

             
            </td>
            <td>
              <!-- display name -->
              <xsl:value-of select="$personography_entry//tei:persName[@type = 'display']"/>
            </td>
            <td>
              <!-- date sort -->
              <xsl:value-of select="//tei:head[@type = 'metadata']//tei:date/@when"/>
            </td>
            <td>
              <!-- date display -->
              <xsl:value-of select="//tei:head[@type = 'metadata']//tei:date"/>
            </td>

          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

<xsl:template match="tei:note"><xsl:apply-templates/></xsl:template>
</xsl:stylesheet>
