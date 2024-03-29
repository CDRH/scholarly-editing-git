<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  
  <xsl:output method="xhtml" indent="no" encoding="UTF-8"/>
  
  <xsl:param name="year"/>
  <xsl:param name="volume"/>
  <xsl:param name="type"/>
  <xsl:param name="title"/>
  <!-- View: blank or fullpage 
  I plan to use this when the edition needs to take up the full width of the page
  -->
  <xsl:param name="view">
    <xsl:choose>
      <xsl:when test="//div[@class='main_content']//div[@class='full_width']">full_width</xsl:when>
      <xsl:otherwise>col8</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  
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
    <xsl:choose>
      <xsl:when test="$type = 'essay'">
        <xsl:text>Essays</xsl:text>
      </xsl:when>
      <xsl:when test="$type = 'review'">
        <xsl:text>Reviews</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="//body/h1[1]/node()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <!-- $edition_author (Optional if not edition) -->
  <xsl:variable name="edition_author">
    <xsl:if test="//body/div[@class='body_author']/node() != ''">
      <xsl:copy-of select="//body/div[@class='body_author']/node()"/>
    </xsl:if>
  </xsl:variable>
  
  <!-- $edition_nav (Optional if not edition) -->
  <xsl:variable name="edition_nav">
    <span class="editionNav">
      <div class="centered-pills">
        <ul class="nav nav-pills">
          <xsl:for-each select="//body/nav[1]/ul/li">
            <li role="presentation">
              <xsl:if test="@class"><xsl:attribute name="class" select="@class"/></xsl:if>
              <xsl:copy-of select="node()"/>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </span>
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
    
    <html class="site_{$type}">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
        <title><xsl:value-of select="$head_title"/> - Scholarly Editing</title>
        <meta name="viewport" content="width=device-width"/>
        
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">&#160;</script>
        <script src="{$siteroot}js/bootstrap/bootstrap.min.js">&#160;</script>
        
        <link href="https://fonts.googleapis.com/css?family=EB+Garamond" rel="stylesheet"/>
        <link rel="stylesheet" href="{$siteroot}template_css/bootstrap/bootstrap.min.css"/>
        <!-- Lightbox: seems common enough we should include elsewhere, but if not, remove and add to individual projects -KMD -->
        
        <link rel="stylesheet" href="{$siteroot}template_js/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"/>
        <script src="{$siteroot}template_js/jquery-lightbox-0.5/js/jquery.lightbox-0.5.min.js">&#160;</script>
        <!--        <link href="https://fonts.googleapis.com/css?family=IM+Fell+French+Canon" rel="stylesheet"/>-->
        <link rel="stylesheet" href="{$siteroot}template_css/new_style.css"/>
        
        <script src="{$siteroot}template_js/javascript_new.js">&#160;</script>
       
        
        
        
        <!-- include any extra CSS/Javascript for the editions -->
        <xsl:copy-of select="$head_extras"/>
        
      </head>
      
      <body>
        <div>
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="//div[@class='main_content']/div[@class='full_width']">
                <xsl:text>container-fluid</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>container</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="id">content</xsl:attribute>
          
          <div class="row">
            
            <div class="col-md-5">
              
              <!-- leaving the html in place to enable a CSS logo, even though we switched to an image. 
              Corresponding CSS is in the CSS file -->
              <h1 class="site_title">
                <!--<a href="{$siteroot}"><span
                  class="word_scholarly"><span class="cap">S</span><span class="word_cholarly"
                    >cholarly</span></span> &#160;<span class="word_editing"><span
                      class="word_edit"><span class="cap">E</span><span class="word_dit"><span
                        class="word_dit_dash">dit</span></span></span><span class="word_ing"
                          >ing</span></span></a>-->
                
                
              </h1>
              <a href="{$siteroot}"><img src="{$siteroot}template_images/indextitle.png" class="header_logo" alt="Scholarly Editing Home Page"/></a>
            </div>
            
            <div class="col-md-7 navright text-right">
              
              <ul class="nav nav-pills text-center sitenav">
                
                <li role="presentation" class="issues">
                  <a href="{$siteroot}se.index.issues.html">Issues</a>
                </li>
                
                <li role="presentation" class="editions">
                  <a href="{$siteroot}se.index.editions.html">Editions</a>
                </li>
                
                <li role="presentation" class="essays">
                  <a href="{$siteroot}se.index.essays.html">Essays</a>
                </li>
                
                <li role="presentation" class="reviews">
                  <a href="{$siteroot}se.index.reviews.html">Reviews</a>
                </li>
                
                <li role="presentation" class="about">
                  <a href="{$siteroot}se.about.html">About</a>
                </li>
                
               
                
              </ul>
              
             <!-- <p class="about_link"><a href="{$siteroot}se.about.html">About</a></p>-->
              
              <h5>The Annual of the Association for Documentary Editing</h5>
              
              <xsl:if test="not($type = 'index')">
                <h5><xsl:value-of select="$year"/>, Volume <xsl:value-of select="$volume"/></h5>
              </xsl:if>
              
            </div>
          </div>
          
          <div class="page_info" id="page_info">
            
            <h2 class="page_title">
              <xsl:copy-of select="$body_title"/>
            </h2>
            
            <xsl:if test="$edition_author != ''">
              <h3>
                <xsl:copy-of select="$edition_author"/>
              </h3>
            </xsl:if>
            
            <xsl:copy-of select="$edition_nav"/>
            
          </div>
          
          
          
          <div>
            <xsl:attribute name="class">
              <xsl:text>main_content</xsl:text>
              <xsl:if test="$type != ''">
                <xsl:text> page_</xsl:text>
                <xsl:value-of select="$type"/>
              </xsl:if>
            </xsl:attribute>
            
            <!-- Add PDF link if an essay or review -->
            <xsl:if test="$type = 'essay' or $type = 'review'"><div class="essay_link"><a href="{$siteroot}{$year}/pdf/{$type}.{$title}.pdf" class="pull-right"><img src="{$siteroot}template_images/pdf.png"/> PDF</a></div></xsl:if>
           
            
            
            
            <!-- remove grids if full width -->
            
            <xsl:choose>
              <xsl:when test="$view = 'col8'">
                <div class="row">
                  <div class="col-md-8 col-md-offset-2">
                    <xsl:copy-of select="$main_content"/>
                  </div>
                </div>
              </xsl:when>
              <xsl:when test="$view != 'full_width'">
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
          
          
          <div class="row footer_splash">
            <div class="row">
              <div class="col-md-10 col-md-offset-1">
                <div class="row">
                  <div class="col-md-10">
                    <div class="footer_text">
                    <span class="creativecommons">
                      <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                        <img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" />
                      </a>
                      <br />
                      This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons
                        Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
                    </span>
                    <span class="cdrh">Sponsored by the <a href="http://cdrh.unl.edu">Center for Digital Research in the Humanities at the University of Nebraska-Lincoln</a>.</span>
                    <span class="issn">ISSN 2167-1257</span>
                    </div><!-- /footer_text -->
                  </div><!-- /col-md-10 -->
                  <div class="col-md-2">
                    <span class="adelogo">
                      <a href="http://www.documentaryediting.org">
                        <img src="{$siteroot}images/adelogo.png" alt="Logo of the Association for Documentary Editing" />
                      </a>
                    </span>
                  </div><!-- /col-md-2 -->
              
                </div><!-- /row -->
              </div><!-- /col10 offset 1 -->
            </div><!-- /row -->
          </div><!-- /footer -->
          
          
          
        
          
        </div><!-- /containter -->
        
       
      </body>
    </html>
    
    
  </xsl:template>
  
  
  
  
  
  
  
</xsl:stylesheet>