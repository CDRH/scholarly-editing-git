<?xml version="1.0"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0"
  exclude-result-prefixes="xsl tei xs">
  
  <!-- ==================================================================== -->
  <!--                             IMPORTS                                  -->
  <!-- ==================================================================== -->
  
  <xsl:import href="../../../../template_xslt/lib/html_formatting.xsl"/>
  <xsl:import href="print.xsl"/>
  
  
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  
  <!-- ==================================================================== -->
  <!--                           PARAMETERS                                 -->
  <!-- ==================================================================== -->
  
  <!--Put any edition wide parameters which need to be accessed throughout the template in here.-->
  
  <xsl:variable name="idno" select="//idno[@type='file']"/>
  <xsl:param name="pageid"></xsl:param>
  
  <!-- ==================================================================== -->
  <!--                            HTML Setup                                 -->
  <!-- ==================================================================== -->
  
  <xsl:template match="/">   
    <html>
      <head>
        <!-- $head_title 
     This is what will show in the browser tab/title bar. May want to keep shorter than edition title. -->
        <title>Mark Twain: April Fool, 1884</title>
        
        <!-- $head_extras (Optional) 
     A for-each will pull each of these in, you can include as many css and javascript files as you want. 
     Use choose or if to make calls conditional -->
        <!--<link rel="stylesheet" href="css/mtp.css"/>
        <link rel="stylesheet" href="css/print.css"/>-->
        <link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
        
        <script src="js/dataTables.min.js">&#160;</script>
        <script src="js/dataTables.bootstrap.min.js">&#160;</script>
        <script src="js/script.js">&#160;</script>
        
        <!--<script src="js/shCore.js">&#160;</script>-->
        
        
        <link rel="stylesheet" href="css/aprilfools.css"/>
        
      </head>
      
      <body>
        <!-- $body_title -->
        <!-- different from the title in <title>, this one can contain <em> or other html tags.
         Can be statically set or pulled from XML file. -->
        
        <h1>Mark Twain: April Fool, 1884</h1>
        
        <!-- $body_author
         must be in <div class="body_author"> -->
        <div class="body_author">Leslie Myrick and Christopher Ohge <small>Mark Twain Project, University of California, Berkeley</small></div>
        
        <!-- $edition_navigation 
         Each <li> is pulled in and new navigation is constructed. Appending #page_info at the end sets the 
         links to start at the edition head. If you add classes on the <li>'s, they will be passed through-->
        <nav>
          <ul>
            <li class="first"><a href="intro.html#page_info">Introduction</a></li>
            <li><a href="sun.html#page_info">Sun Interview</a></li>
            <li><a href="UCLC41850.html#page_info">Edition</a></li>
            
            <li><a href="graph/index.html">Network Graph</a></li>
            <li><a href="{$idno}.xml">Page XML &#8659;</a></li>
            <li><a href="extracts.youngidea.xml">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          
          <!-- full width controls, possibly for side panel -->
          
          <xsl:choose>
            <xsl:when test="starts-with($pageid,'U')">
              <div class="full_width"></div>
              <div class="row">
                <div class="col-md-6">
                  <xsl:apply-templates/>
                </div>
                <div class="col-md-6">
                  <xsl:call-template name="sidebar"/>
                </div>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates/>
            </xsl:otherwise>
          </xsl:choose>
          
         
          
            
          
         
          
          
          
          
         
          
          
          
          
        </div>  
      </body>
    </html>
  </xsl:template>
  
  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->
  
 
  
  <xsl:template exclude-result-prefixes="#all" match="tei:date">
    <xsl:if test="ancestor::head"><br/></xsl:if><span class="tei_date"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template exclude-result-prefixes="#all" match="tei:sourceline">
    <br/><span class="tei_sourceline"><xsl:apply-templates/></span>
  </xsl:template>
  
  <!-- Individual projects can override matched templates from the
     imported stylesheets above by including new templates here -->
  <!-- Named templates can be overridden if included in matched templates
     here.  You cannot call a named template from directly within the stylesheet tag
     but you can redefine one here to be called by an imported template -->
  
  <xsl:template name="sidebar">
    <table class="table table-condensed table-sortable">
   <thead>
      <tr>
         <td>Filename</td>
         <td>Pers ID</td>
         <td>Sort Sender</td>
         <td>Display Sender</td>
         <td>Date Sort</td>
         <td>Date Display</td>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            <a href="UCLC41965.html">UCLC41965</a>
         </td>
         <td>DGM</td>
         <td>MacNeill,  </td>
         <td>D. G. MacNeill</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41872.html">UCLC41872</a>
         </td>
         <td>RSG</td>
         <td>Gifford, Robert Swain</td>
         <td>Robert Swain  Gifford</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41959.html">UCLC41959</a>
         </td>
         <td>JEK</td>
         <td>Kellogg Crosby, Jane Elizabeth</td>
         <td>Jane Elizabeth (Crosby) Kellogg</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41992.html">UCLC41992</a>
         </td>
         <td>EKL</td>
         <td>,  Keeler</td>
         <td>Edward K. Lockwood</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41866.html">UCLC41866</a>
         </td>
         <td>GCE</td>
         <td>Eggleston, George Cary</td>
         <td>George Cary  Eggleston</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41986.html">UCLC41986</a>
         </td>
         <td>JWB</td>
         <td>Beach, Joseph Watson</td>
         <td>Joseph Watson  Beach</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41843.html">UCLC41843</a>
         </td>
         <td>DCF</td>
         <td>French, Daniel Chester</td>
         <td>Daniel Chester  French</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41963.html">UCLC41963</a>
         </td>
         <td>JPCH</td>
         <td>Hatton,  </td>
         <td>Joseph Paul Christopher  Hatton</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41870.html">UCLC41870</a>
         </td>
         <td>DF</td>
         <td>Frohman,  </td>
         <td>Daniel  Frohman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41957.html">UCLC41957</a>
         </td>
         <td>RUJ</td>
         <td>Johnson, Robert Underwood</td>
         <td>Robert Underwood Johnson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41864.html">UCLC41864</a>
         </td>
         <td>CCD</td>
         <td>Duncan, Charles C.</td>
         <td>Charles C.  Duncan</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41858.html">UCLC41858</a>
         </td>
         <td>NB</td>
         <td>Brooks,  </td>
         <td>Noah  Brooks</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41978.html">UCLC41978</a>
         </td>
         <td>WS</td>
         <td>Sisson, Wesley </td>
         <td>Wesley E. Sisson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41961.html">UCLC41961</a>
         </td>
         <td>JCK</td>
         <td>Kinney, John Coddington</td>
         <td>John Coddington Kinney</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41955.html">UCLC41955</a>
         </td>
         <td>LH</td>
         <td>Hutton, Laurence </td>
         <td>Laurence Hutton</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41862.html">UCLC41862</a>
         </td>
         <td>RC</td>
         <td>Collyer,  </td>
         <td>Robert  Collyer</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41982.html">UCLC41982</a>
         </td>
         <td>CW</td>
         <td>Watrous, Charles </td>
         <td>Charles Watrous</td>
         <td>1884-03-31</td>
         <td>31 March 1885</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41856.html">UCLC41856</a>
         </td>
         <td>WCB</td>
         <td>Beecher, William Constantine</td>
         <td>William Constantine  Beecher</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC42010.html">UCLC42010</a>
         </td>
         <td>bio10576</td>
         <td/>
         <td/>
         <td>1884-04-14</td>
         <td>April 14 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41976.html">UCLC41976</a>
         </td>
         <td>NS</td>
         <td>Sarony, Napoleon </td>
         <td>Napoleon Sarony</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41833.html">UCLC41833</a>
         </td>
         <td>JHS</td>
         <td>Smith, John Hyatt</td>
         <td>Rev. J. Hyatt Smith</td>
         <td>1884-03-31</td>
         <td>28 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC42004.html">UCLC42004</a>
         </td>
         <td>RWG</td>
         <td>,  </td>
         <td>Richard Watson Gilder</td>
         <td>1884-04-06</td>
         <td>6 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41953.html">UCLC41953</a>
         </td>
         <td>JHJr</td>
         <td>Howard, Jr.,  </td>
         <td>Joseph  Howard, Jr.</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41860.html">UCLC41860</a>
         </td>
         <td>HCB</td>
         <td>Bunner, Henry Cuyler</td>
         <td>Henry Cuyler  Bunner</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41997.html">UCLC41997</a>
         </td>
         <td>CDW</td>
         <td>Warner, Charles Dudley</td>
         <td>Charles Dudley Warner</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41980.html">UCLC41980</a>
         </td>
         <td>ECS</td>
         <td>, Edmund Clarence</td>
         <td>Edmund Clarence Stedman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41854.html">UCLC41854</a>
         </td>
         <td>MSB</td>
         <td>Beach, Moses Sperry</td>
         <td>Moses Sperry  Beach</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41974.html">UCLC41974</a>
         </td>
         <td>RWR</td>
         <td>Raymond, Rossiter Worthington</td>
         <td>R. W. Raymond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41848.html">UCLC41848</a>
         </td>
         <td>EBW</td>
         <td>Waring, Effie Blunt</td>
         <td>Effie Blunt (“Daisy”) Waring</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41951.html">UCLC41951</a>
         </td>
         <td>JH</td>
         <td>Hawthorne,  </td>
         <td>Julian Hawthorne</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41968.html">UCLC41968</a>
         </td>
         <td>HLP</td>
         <td>,  Lillie</td>
         <td>Henry L. Pierce</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41995.html">UCLC41995</a>
         </td>
         <td>EDS</td>
         <td> Douglas, Ellen Montague</td>
         <td>Ellen Montague Douglas Stedman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41852.html">UCLC41852</a>
         </td>
         <td>WSA</td>
         <td>Andrews, William S.</td>
         <td>William S.  Andrews</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41869.html">UCLC41869</a>
         </td>
         <td>CF</td>
         <td>Frohman,  </td>
         <td>Charles  Frohman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41972.html">UCLC41972</a>
         </td>
         <td>OWP</td>
         <td>,  </td>
         <td>Ozias W. Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41989.html">UCLC41989</a>
         </td>
         <td>HPG</td>
         <td>Gray, Henry Peters</td>
         <td>Henry Peters Gray, Jr.</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41846.html">UCLC41846</a>
         </td>
         <td>FDM</td>
         <td>,  </td>
         <td>Francis Davis Millet</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41966.html">UCLC41966</a>
         </td>
         <td>JBM</td>
         <td>Matthews, James Brander</td>
         <td>Brander Matthews</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41873.html">UCLC41873</a>
         </td>
         <td>JLG</td>
         <td>Gilder, Jeannette Leonard</td>
         <td>Jeannette Leonard  Gilder</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41993.html">UCLC41993</a>
         </td>
         <td>HM</td>
         <td>Modrzejewska, Helena </td>
         <td>Helena Modjeska</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41867.html">UCLC41867</a>
         </td>
         <td>CSF</td>
         <td>Fairchild, Charles S.</td>
         <td>Charles S.  Fairchild</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41850.html">UCLC41850</a>
         </td>
         <td>LWA</td>
         <td>Aldrich, Mary Elizabeth Woodman</td>
         <td>Mary Elizabeth "Lilian" Woodman  Aldrich</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41970.html">UCLC41970</a>
         </td>
         <td>JBP</td>
         <td>Pond,  Burton</td>
         <td>James B. Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41987.html">UCLC41987</a>
         </td>
         <td>CdK</td>
         <td>,  Augustus</td>
         <td>Charles de Kay</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41964.html">UCLC41964</a>
         </td>
         <td>CML</td>
         <td>Leoser, Charles McKnight</td>
         <td>charles McKnight Leoser</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41958.html">UCLC41958</a>
         </td>
         <td>CLK</td>
         <td>Kellogg, Clara Louise</td>
         <td>Clara Louise Kellogg</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41991.html">UCLC41991</a>
         </td>
         <td>STK</td>
         <td>Kinney Thomson, Sara </td>
         <td>Sara T. Kinney</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41865.html">UCLC41865</a>
         </td>
         <td>FJ</td>
         <td>Jenkins, Frank </td>
         <td>Frank Jenkins</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41842.html">UCLC41842</a>
         </td>
         <td>JSB</td>
         <td>Billings, John Shaw</td>
         <td>John Shaw  Billings</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41859.html">UCLC41859</a>
         </td>
         <td>CCB</td>
         <td>Buel,  </td>
         <td>Clarence Clough  Buel</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41979.html">UCLC41979</a>
         </td>
         <td>FHS</td>
         <td>Smith, Francis Hoplinson</td>
         <td>Francis Hopkinson Smith</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCCL41964.html">UCCL41964</a>
         </td>
         <td/>
         <td/>
         <td/>
         <td>1884-03-31</td>
         <td/>
      </tr>
      <tr>
         <td>
            <a href="UCLC41962.html">UCLC41962</a>
         </td>
         <td>TWK</td>
         <td>Knox, Thomas Wallace</td>
         <td>Thomas W. Knox</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41956.html">UCLC41956</a>
         </td>
         <td>HI</td>
         <td>Broadribb, John Henry</td>
         <td>Sir Henry Irving</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41836.html">UCLC41836</a>
         </td>
         <td/>
         <td/>
         <td/>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41863.html">UCLC41863</a>
         </td>
         <td>ACD</td>
         <td>Dunham, Austin Cornelius</td>
         <td>Austin Cornelius  Dunham</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41983.html">UCLC41983</a>
         </td>
         <td>CGW</td>
         <td>Whiting, Charles Goodrich</td>
         <td>Charles G. Whiting</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41840.html">UCLC41840</a>
         </td>
         <td>JPL</td>
         <td>Lathrop, George Parsons</td>
         <td>George Parsons Lathrop</td>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41857.html">UCLC41857</a>
         </td>
         <td>HHB</td>
         <td>Boyesen, Hjalmar H.</td>
         <td>Hjalmar H.  Boyesen</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41977.html">UCLC41977</a>
         </td>
         <td>HES</td>
         <td>Scudder, Horace Elisha</td>
         <td>Horace E. Scudder</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41834.html">UCLC41834</a>
         </td>
         <td>BHC</td>
         <td>Cutter, Bloodgood Haviland</td>
         <td>Bloodgood Haviland  Cutter</td>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41960.html">UCLC41960</a>
         </td>
         <td>HCK</td>
         <td>King, Horatio Collins</td>
         <td>Horatio C. King</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41861.html">UCLC41861</a>
         </td>
         <td>WC</td>
         <td>Carey, William </td>
         <td>William  Carey</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41981.html">UCLC41981</a>
         </td>
         <td>ET</td>
         <td>Terry, Alice Ellen</td>
         <td>Dame Ellen Terry</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41855.html">UCLC41855</a>
         </td>
         <td>HWB</td>
         <td>Beecher, Henry Ward</td>
         <td>Henry Ward  Beecher</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41975.html">UCLC41975</a>
         </td>
         <td>HR</td>
         <td>,  </td>
         <td>H. Robinson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41849.html">UCLC41849</a>
         </td>
         <td>GEW</td>
         <td>Waring, George Edwin</td>
         <td>George E. Waring, Jr.</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41969.html">UCLC41969</a>
         </td>
         <td>TFP</td>
         <td>Plunkett, Thomas Fitzpatrick</td>
         <td>Thomas F. Plunkett</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41952.html">UCLC41952</a>
         </td>
         <td>JMH</td>
         <td>Hay, John Milton</td>
         <td>John Milton Hay</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41996.html">UCLC41996</a>
         </td>
         <td>VW</td>
         <td>Waring, Virginia </td>
         <td>Virginia Waring</td>
         <td>1884-04-02</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41853.html">UCLC41853</a>
         </td>
         <td>CYB</td>
         <td>Beach, Charles Yale</td>
         <td>Charles Yale  Beach</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41973.html">UCLC41973</a>
         </td>
         <td>SSC</td>
         <td>Conant, Stillman S.</td>
         <td>Stillman S.  Conant</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41847.html">UCLC41847</a>
         </td>
         <td>DS</td>
         <td>Sage, Dean </td>
         <td>Dean Sage</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41967.html">UCLC41967</a>
         </td>
         <td>EMM</td>
         <td>,  </td>
         <td>Elizabeth (Lily) Millet</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41874.html">UCLC41874</a>
         </td>
         <td>JEG</td>
         <td>Gowen, John E.</td>
         <td>John E.  Gowen</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41994.html">UCLC41994</a>
         </td>
         <td>GWS</td>
         <td>Sheldon, George William</td>
         <td>George W. Sheldon</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41868.html">UCLC41868</a>
         </td>
         <td>MFF</td>
         <td>Fox Fiske, Mary Hewins</td>
         <td>Mary Fiske</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41851.html">UCLC41851</a>
         </td>
         <td>TBA</td>
         <td>Aldrich, Thomas Bailey</td>
         <td>Thomas Bailey  Aldrich</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41988.html">UCLC41988</a>
         </td>
         <td>SRF</td>
         <td>Fiske, Stephen Ryder</td>
         <td>Stephen Ryder  Fiske</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41971.html">UCLC41971</a>
         </td>
         <td>NBP</td>
         <td>Pond Brown, Nella </td>
         <td>Nella Brown Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
   </tbody>
</table>




    
  </xsl:template>
  
</xsl:stylesheet>