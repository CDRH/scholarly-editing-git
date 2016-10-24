<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="" xmlns="http://www.w3.org/1999/xhtml" version="2.0">

  <xsl:output method="xhtml" indent="no" encoding="UTF-8"/>

  <xsl:param name="year"/>
  <xsl:param name="volume"/>
  <!-- View: blank or fullpage 
  I plan to use this when the edition needs to take up the full width of the page
  -->
  <xsl:param name="view"/>


  <xsl:include href="../config/config.xsl"/>

  <!-- =====================================
    Site Editable Sections 
  ======================================= -->

  <!-- ## Header -->

  <!-- $head_title (Required) -->
  <xsl:variable name="head_title">
    <xsl:copy-of select="//title/node()"/>
  </xsl:variable>

  <!-- $head_extras (Optional) -->
  <xsl:variable name="head_extras">
    <xsl:for-each select="//head/link">
      <xsl:copy-of select="."/>
    </xsl:for-each>
    <xsl:for-each select="//head/script">
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:variable>

  <!-- ## Edition/Page Title, Info and Nav -->

  <!-- $body_title (Required) -->
  <xsl:variable name="body_title">
    <xsl:copy-of select="//body/h1[1]/node()"/>
  </xsl:variable>

  <!-- $edition_author (Optional if not edition) -->
  <xsl:variable name="edition_author">
    <xsl:if test="//body/div[@class='body_author']/node() != ''">
      <h3>
        <xsl:copy-of select="//body/div[@class='body_author']/node()"/>
      </h3> 
    </xsl:if>
  </xsl:variable>

  <!-- $edition_nav (Optional if not edition) -->
  <xsl:variable name="edition_nav">
    <span class="editionNav">
      <div class="centered-pills">
        <ul class="nav nav-pills">
          <xsl:for-each select="//body/nav[1]/ul/li">
            <li role="presentation">
              <xsl:copy-of select="node()"/>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </span>
  </xsl:variable>

  <!-- $edition_controls (Optional) -->
  <xsl:variable name="edition_controls">
    <xsl:copy-of select="//body/div[@class = 'edition_controls']/node()"/>
  </xsl:variable>

  <!-- ## Main Content -->

  <!-- $main_content (Required) -->
  <xsl:variable name="main_content">
    <xsl:copy-of select="//body/div[@class = 'main_content']/node()"/>
  </xsl:variable>

  <!-- =====================================
    HTML Setup
  ======================================= -->

  <xsl:template match="/">

    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <title><xsl:value-of select="$head_title"/> - Scholarly Editing</title>
        <meta name="viewport" content="width=device-width"/>

        <link rel="stylesheet" href="{$siteroot}template_css/bootstrap/bootstrap.min.css"/>
        <!--        <link href="https://fonts.googleapis.com/css?family=IM+Fell+French+Canon" rel="stylesheet"/>-->
        <link rel="stylesheet" href="{$siteroot}template_css/new_style.css"/>



        <!-- include any extra CSS/Javascript for the editions -->
        <xsl:copy-of select="$head_extras"/>

      </head>

      <body>
        <div class="container" id="content">

          <div class="row">

            <div class="col-md-6">

              <h1 class="site_title">
                <a href="http://cors1601.unl.edu/cocoon/scholarlyediting_reorganization/"><span
                    class="word_scholarly"><span class="cap">S</span><span class="word_cholarly"
                      >cholarly</span></span> &#160;<span class="word_editing"><span
                      class="word_edit"><span class="cap">E</span><span class="word_dit"><span
                          class="word_dit_dash">dit</span></span></span><span class="word_ing"
                      >ing</span></span></a>
              </h1>

            </div>

            <div class="col-md-6">

              <ul class="nav nav-pills text-center">

                <li role="presentation">
                  <a href="{$siteroot}se.index.issues.html">Issues</a>
                </li>

                <li role="presentation">
                  <a href="{$siteroot}se.index.editions.html">Editions</a>
                </li>

                <li role="presentation">
                  <a href="{$siteroot}se.index.essays.html">Essays</a>
                </li>

                <li role="presentation">
                  <a href="{$siteroot}se.index.reviews.html">Reviews</a>
                </li>

                <li role="presentation">
                  <a href="{$siteroot}se.about.html">About</a>
                </li>

              </ul>


              <h5>The Annual of the Association for Documentary Editing</h5>

              <h5><xsl:value-of select="$year"/>, Volume <xsl:value-of select="$volume"/></h5>

            </div>
          </div>

          <div class="editionHeader">

            <h2 class="editionTitle">
              <xsl:copy-of select="$body_title"/>
            </h2>

            <xsl:copy-of select="$edition_author"/>

            <xsl:copy-of select="$edition_nav"/>

            <xsl:copy-of select="$edition_controls"/>

          </div>



          <div class="main_content">

            <!-- remove grids if full width -->

            <xsl:choose>
              <xsl:when test="$view != 'fullpage'">
                <div class="row">
                  <div class="col-md-10 col-md-offset-1">
                    <xsl:copy-of select="$main_content"/>
                  </div>
                </div>
              </xsl:when>
              <xsl:otherwise>
                <xsl:copy-of select="$main_content"/>
              </xsl:otherwise>
            </xsl:choose>


          </div><!-- /main_content -->
          
          
          <div class="footer">
            <span class="creativecommons">
              <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                <img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png"/>
              </a>
              <br/>This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative
            Commons Attribution-NonCommercial-ShareAlike 3.0 Unported
            License</a>.</span>
            <span class="adelogo">
              <a href="http://www.documentaryediting.org">
                <img src="http://scholarlyediting.org/images/adelogo.png" alt="Logo of the Association for Documentary Editing"/>
              </a>
            </span>
            <span class="cdrh">Sponsored by the <a href="http://cdrh.unl.edu">Center for
              Digital Research in the Humanities at the University of
              Nebraska-Lincoln</a>.
            </span>
            <span class="issn">ISSN 2167-1257</span>
          </div><!-- /footer -->
          

        </div><!-- /containter -->

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">&#160;</script>
        <script src="{$siteroot}js/bootstrap/bootstrap.min.js">&#160;</script>
      </body>
    </html>


  </xsl:template>







</xsl:stylesheet>