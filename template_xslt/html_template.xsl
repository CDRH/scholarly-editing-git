<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="" xmlns="http://www.w3.org/1999/xhtml" version="2.0">

  <xsl:output method="xhtml" indent="no" encoding="UTF-8"/>

  <xsl:param name="year"/>
  <xsl:param name="volume"/>


  <xsl:include href="../config/config.xsl"/>

  <xsl:template match="/">

    <html>

      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <title><xsl:copy-of select="//title/node()"/> - Scholarly Editing</title>
        <meta name="viewport" content="width=device-width"/>


        <link rel="stylesheet" href="{$siteroot}template_css/bootstrap/bootstrap.min.css"/>

        <link href="https://fonts.googleapis.com/css?family=IM+Fell+French+Canon" rel="stylesheet"/>

        <link rel="stylesheet" href="{$siteroot}template_css/new_style.css"/>

        <link rel="stylesheet" href="{$siteroot}{$year}/editions/youngidea/css/style.css"/>



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
            <xsl:copy-of select="//body/h1[1]/node()"/>
          </h2>
          <h3>
            <span class="author">Young Idea Author</span>
          </h3>

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


        </div>
        <div class="main_content">

          <xsl:copy-of select="//body/div[@class = 'main_content']/node()"/>
        </div>
          
        </div><!-- /containter -->
          
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">&#160;</script>
        <script src="{$siteroot}js/bootstrap/bootstrap.min.js">&#160;</script>
      </body>
    </html>


  </xsl:template>







</xsl:stylesheet>
