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
            <li><a href="edition.html#page_info">Edition</a></li>
            <!--<li><a href="people.html#page_info">People</a></li>-->
            <li><a href="graph/index.html">Network Graph</a></li>
            <xsl:if test="not($pageid = 'edition')">
              <li><a href="{$idno}.xml">Page XML &#8659;</a></li>
            </xsl:if>
            <li><a href="downloads/aprilfools_xml.zip">Edition XML &#8659;</a></li>
          </ul>
        </nav>
        
        <!-- $site_content -->
        <!-- Must be in <div class="main_content"> 
         Edition controls or anything else can go before or after the apply-templates-->
        <div class="main_content">
          
          <!-- full width controls, possibly for side panel -->
          
          <xsl:choose>
            <xsl:when test="$pageid = 'people'">
              <xsl:apply-templates select="//tei:listPerson"></xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pageid = 'edition'">
              <br/>
                  <xsl:call-template name="sidebar"/>
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
  
<!-- Personography -->
  
  <xsl:template match="listPerson/person">
    <div class="person"><xsl:apply-templates/></div>
  </xsl:template>
  
  <xsl:template match="persName">
    <h4>[<xsl:value-of select="@type"/>] <xsl:apply-templates/></h4>
  </xsl:template>
  
  <xsl:template match="birth"><div class="birth">Birth: <xsl:apply-templates/></div></xsl:template>
  
  <xsl:template match="death"><div class="death">Death: <xsl:apply-templates/></div></xsl:template>
  
  <xsl:template match="sex"><div class="sex">Sex: <xsl:apply-templates/></div></xsl:template>
  
  <xsl:template match="note"><div class="note"> <xsl:apply-templates/></div></xsl:template>
  
  <!-- Other -->
  
  
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
         <td>
            <a class="popper"
               data-toggle="popover"
               title="MacNeill,  "
               content=""
               data-original-title="test">MacNeill,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">All that is known of MacNeill is that he was an employee of The Callender Insulating and Waterproofing Co., a purveyor of insulated cables incorporated in 1883 and owned by W. O. Callender of London, whose son William M. Callender served as President. Macneill may have been brought over from the London office.</p>
            </span>
         </td>
         <td>D. G. MacNeill</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41872.html">UCLC41872</a>
         </td>
         <td>RSG</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Gifford, Robert Swain"
               content=""
               data-original-title="test">Gifford, Robert Swain</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Gifford was an artist best known for his landscape paintings, particularly of the American West, New England, and North Africa. An early member of the Society of American Artists, he was also friends with Clemens's friend the artist Frank Millet, who traveled with him to Germany and Scandinavia in 1882.</p>
                  </span>
         </td>
         <td>Robert Swain  Gifford</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41959.html">UCLC41959</a>
         </td>
         <td>JEK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Kellogg Crosby, Jane Elizabeth"
               content=""
               data-original-title="test">Kellogg Crosby, Jane Elizabeth</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Born at Simsbury, Connecticut, Jane Elizabeth Crosby was the mother of Clara Louise Kellogg. She became her daughter's constant companion and manager on tour: “the sentinel that stood between her daughter and the outside world.” Harriet Prescott Spofford, in her “Biography of Clara Louise Kellogg”, describes Clara's mother as “a case of suppressed genius,” “who “might have made a great mark on the artistic world if she had not so forgotten and absorbed herself in her daughter.” (Spofford, <span class="italic">Our Famous Women: An Authorized Record of The Lives and Deeds of Distinguished American Women of Our Times</span>. Hartford, Conn.: A. D. Worthington, 1884. 359–385))</p>
            </span>
         </td>
         <td>Jane Elizabeth (Crosby) Kellogg</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41992.html">UCLC41992</a>
         </td>
         <td>EKL</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  Keeler"
               content=""
               data-original-title="test">,  Keeler</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">E. K. Lockwood and his wife Harriet were passengers along with Clemens on the <span class="italic">Quaker City</span> excursion. Lockwood started out as a clerk in his father's businesses, and inherited his father's interests in the Winnipauk Woollen Mill in 1869. By 1884 he was primarily, as his letterhead states, a purveyor of house furnishing goods. Like his father, he held the positions of Director of the Norwalk Gas Light Co. and the National Bank of Norwalk.</p>
            </span>
         </td>
         <td>Edward K. Lockwood</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41866.html">UCLC41866</a>
         </td>
         <td>GCE</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Eggleston, George Cary"
               content=""
               data-original-title="test">Eggleston, George Cary</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Eggleston was a journalist, historian, and novelist raised in southern Indiana. He was practicing law in Richmond, Virginia, when the Civil War broke out, and served as a Confederate officer (he later witnessed the surrender at Appomattox). From 1871–75 he served as the editor of <span class="italic">Hearth and Home</span> magazine, where he made the acquaintance of William Dean Howells. In 1875 he published a well-regarded memoir of his service entitled <span class="italic">A Rebel's Recollections</span>, which later formed the subject of his majestic two-volume <span class="italic">A History of the Confederate War</span>. He was also known for Southern novels such as <span class="italic">Dorothy South</span>, <span class="italic">A Carolina Cavalier</span> and <span class="italic">Irene of the Mountains</span>.</p>
                  </span>
         </td>
         <td>George Cary  Eggleston</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41986.html">UCLC41986</a>
         </td>
         <td>JWB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Beach, Joseph Watson"
               content=""
               data-original-title="test">Beach, Joseph Watson</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">J. W. Beach was a Hartford businessman who co-owned Beach and Company with
                     his brothers George and Charles. It is not known when he met Clemens, but his
                     membership in the Hartford Club suggests that he could have known Clemens, who often socialized there.</p>
                  </span>
         </td>
         <td>Joseph Watson  Beach</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41843.html">UCLC41843</a>
         </td>
         <td>DCF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="French, Daniel Chester"
               content=""
               data-original-title="test">French, Daniel Chester</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Daniel Chester French was a prolific sculptor best known for his "Minuteman"
                     at Concord (1874) and statue of Abraham Lincoln at the Lincoln Memorial in
                     Washington D.C. (1920). Louisa May Alcott's sister Mary convinced him to be a
                     sculptor when he was growing up in Concord, Massachusetts. He was also a member of the Boston Author's Club, which included Clemens, William Dean
                     Howells, and Thomas Bailey Aldrich as members.</p>
                  </span>
         </td>
         <td>Daniel Chester  French</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41963.html">UCLC41963</a>
         </td>
         <td>JPCH</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Hatton,  "
               content=""
               data-original-title="test">Hatton,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Joseph Hatton was a journalist (notably for the Sunday <span class="italic">Times</span>) and prolific popular writer. In addition to writing over 30 novels and running a popular column called "Cigarette Papers," he published a biography in 1884 of Henry Irving after traveling with him on tour. In Hatton's book on Irving, he also established himself as an ally in Clemens's crusade for improved copyright laws between the U.S. and Great Britain (328-29). Just before he died, Hatton wrote on 7 July 1907 that recently "Mark Twain came to see me. I had got into the garden nicely packed up in blankets, and was asleep—that sort of dreamy sleep when you don't quite know whether you are asleep or awake. He was very kind and sympathetic, and we had a very pleasant chat" (M. A. P., 10 August 1907).</p>
                  </span>
         </td>
         <td>Joseph Paul Christopher  Hatton</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41870.html">UCLC41870</a>
         </td>
         <td>DF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Frohman,  "
               content=""
               data-original-title="test">Frohman,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Charles Frohman's older brother, Daniel started his career as an office boy for the New York <span class="">Tribune</span>, and then spent five years as a journalist before managing touring companies for New York theaters. In 1880 he organized the Lyceum theater, which made him (and many other actors, such as E. H. Sothern, Henry Miller, and May Robson), famous. He was also a member of the Players Club, where Clemens would also appear. In 1911 Frohman published his <span class="italic">Memoirs of a Manager</span>. He also played a role in the early film industry with the Famous Players Film Company.</p>
                  </span>
         </td>
         <td>Daniel  Frohman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41957.html">UCLC41957</a>
         </td>
         <td>RUJ</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Johnson, Robert Underwood"
               content=""
               data-original-title="test">Johnson, Robert Underwood</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Poet, journalist, and conservationist Robert Underwood Johnson began working for <span class="italic">Scribner's Magazine</span> in 1873, and was named Associate Editor of the <span class="italic">Century Magazine</span> in 1881. He succeeded Richard Watson Gilder as editor, and retired in 1913. Johnson campaigned for International Copyright in the 1880s, and, as the secretary of the American Copyright League, played an important role in passing the copyright law of 1891. He was one of the supporters of the foundation of both Yosemite National Park and, along with  John Muir, of the Sierra Club.</p>
            </span>
         </td>
         <td>Robert Underwood Johnson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41864.html">UCLC41864</a>
         </td>
         <td>CCD</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Duncan, Charles C."
               content=""
               data-original-title="test">Duncan, Charles C.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Charles Duncan was the captain of the <span class="italic">Quaker City</span> when Clemens traveled to Europe and the Levant in 1867. Duncan had gone to sea as a boy and was a ship captain before he was thirty. In 1853 he became a shipping and commission merchant in New York City, operating as Charles C. Duncan and Company. Shortly before the Civil War, he resettled in England and resumed business there while leaving the New York office in the hands of a subordinate, who absconded with the firm’s funds, precipitating its bankruptcy after Duncan’s return in 1865. The <span class="italic">Quaker City</span> excursion was in part a means of recovering from the bankruptcy. Duncan also lectured on the excursion, in New York on 3 and 26 December 1867, in Washington on January 1868, in Cleveland on 10 March 1868, and again in New York on 11 January 1877, when he attacked Clemens by declaring <span class="italic">Innocents</span> was “in no sense” an accurate account of the trip (“About Mark Twain,” New York <span class="italic">World</span>, 12 Jan 1877, 5). Clemens showed his contempt for Duncan in his partial draft of a <span class="italic">Quaker City</span> play, depicting him as the mercenary “Capt. Dusenberry” (see Appendix E of <span class="italic">L2</span>; also the enclosure (note 1) of Clemens's <a href="http://www.marktwainproject.org/xtf/view?docId=letters/UCCL00160.xml;query=quaker%20city%20play;searchAll=;sectionType1=;sectionType2=;sectionType3=;sectionType4=;sectionType5=;style=letter;brand=mtp#1"
                     title="">25 November 1867 letter to Charles Henry Webb</a>. Over the years he and Duncan were intermittently contentious, specifically in 1877 and 1883, when Clemens spoke out in support of Elihu Root's corruption investigation (<a href="http://www.marktwainproject.org/xtf/view?docId=letters/UCCL00174.xml;doc.view=;style=letter;brand=mtp"
                     title="">8 January 68 to Beach</a>, <a href="http://www.marktwainproject.org/xtf/view?docId=letters/UCCL00200.xml;doc.view=;style=letter;brand=mtp"
                     title="">10 March 68 to Fairbanks</a>, L2, 149 n. 6, 203 n. 1; N&amp;J2, 35; N&amp;J3, 18, 24–25). Duncan was dismissed in 1884 as shipping commissioner of the port of New York.</p>
                  </span>
         </td>
         <td>Charles C.  Duncan</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41858.html">UCLC41858</a>
         </td>
         <td>NB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Brooks,  "
               content=""
               data-original-title="test">Brooks,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Noah Brooks began his newspaper career in Boston at the age of eighteen, but six years later he went west, eventually settling in California, where he founded the Marysville <span class="italic">Appeal</span>. During the Civil War he served as Washington correspondent for the Sacramento <span class="italic">Union</span>, and was the last journalist to interview Abraham Lincoln. After the war he became managing editor of the San Francisco <span class="italic">Alta California</span>, when became acquainted with Clemens, initially through their mutual friend Bret Harte (Brooks contributed short fiction, as did Clemens, to Harte's <span class="italic">Overland Monthly</span>). Brooks was the managing editor of the (San Francisco) Daily <span class="italic">Alta California</span> when Clemens undertook the Quaker City voyage in 1867 as an <span class="italic">Alta</span> correspondent (furnishing the material for <span class="italic">Innocents Abroad</span>). In 1871 he started working for the New York <span class="italic">Tribune</span>, and in 1876 he became the editor of the New York <span class="italic">Times</span>. Retiring in 1892, he spent the rest of his life publishing travel literature and memoirs. In his <span class="italic">Autobiography</span>, Clemens recalled that Brooks was "a man of sterling character and equipped with a right heart, also a good historian where facts were not essential" (<a href="http://www.marktwainproject.org/xtf/view?docId=works/MTDP10362.xml;chunk.id=d1e9273;toc.depth=1;toc.id=;citations=;style=work;brand=mtp#X"
                     title="">AutoMT1</a>, 228).</p>
                  </span>
         </td>
         <td>Noah  Brooks</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41978.html">UCLC41978</a>
         </td>
         <td>WS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Sisson, Wesley "
               content=""
               data-original-title="test">Sisson, Wesley </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Wesley Sisson practiced law with his brother in Chicago from 1876 until 1881, when he moved to New York to pursue a career in theatrical management. He was the assistant manager of the Madison Square Theatre in the 1880s, with concurrent management interests in the Lyceum and Criterion Theaters. He also managed tours for several companies, including those of Clara Morris, and Thomas and Alessandro Salvini. In 1891 he moved with his family back to Chicago to return to the practice of law, while exploring prospects for building a new theatre on the south side. By 1890 they had moved back east again, to Mt. Vernon, New York, where Sisson is listed in the 1910 census as Secretary of the Postal Life Insurance company, a position which he held until he retired. </p>
            </span>
         </td>
         <td>Wesley E. Sisson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41961.html">UCLC41961</a>
         </td>
         <td>JCK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Kinney, John Coddington"
               content=""
               data-original-title="test">Kinney, John Coddington</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">John Coddington Kinney was an associate editor of the Hartford <span class="italic">Courant</span> (1872–1890), and was appointed U.S. Marshall for the district of Connecticut (1882–86). In 1890, the year before he died, he was made postmaster of Hartford. During the Civil War he had been a member of the signal corps on Farragut's ship the <span class="italic">Hartford</span>, and wrote about his experiences in “An August Morning with Farragut;" a narrative of the Mobile Bay fight, August 5, 1864,” <span class="italic">Scribner's Magazine</span> 22 (June 1881): 199–208.</p>
            </span>
         </td>
         <td>John Coddington Kinney</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41955.html">UCLC41955</a>
         </td>
         <td>LH</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Hutton, Laurence "
               content=""
               data-original-title="test">Hutton, Laurence </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Editor and critic Laurence Hutton, one of a handful of friends whom Clemens addressed in letters by his nickname (“Larry”), served as drama critic of the <span class="italic">Daily Evening Mail</span> from 1872–4 and literary critic of <span class="italic">Harpers' Magazine</span> from 1886–98. He compiled several important dramatic compendia, e.g. <span class="italic">Actors and Actresses of Great Britain and the United States</span>, 5 vols. (1886–7), which he co-edited with with Brander Matthews. He was a founding member of the Authors and Players Clubs and of the American Copyright League. Hutton was also a notorious collector of death masks and of association copies. </p>
            </span>
         </td>
         <td>Laurence Hutton</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41862.html">UCLC41862</a>
         </td>
         <td>RC</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Collyer,  "
               content=""
               data-original-title="test">Collyer,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Collyer was a former blacksmith from Yorkshire and a Methodist lay-preacher who became an ordained Unitarian minister, serving as pastor of Unity Church in Chicago from 1859 until 1879. In 1879 he became the pastor of Church of the Messiah in New York City. In addition to being a popular lecturer, Collyer also published several sermons, lectures, and books such as <span class="italic">Life of A. H. Conant</span> (1868), <span class="italic">Father Taylor</span> (1906), and <span class="italic">Clear Grit</span> (1913).</p>
                  </span>
         </td>
         <td>Robert  Collyer</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41982.html">UCLC41982</a>
         </td>
         <td>CW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Watrous, Charles "
               content=""
               data-original-title="test">Watrous, Charles </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Watrous was a U.S. Mail agent in San Francisco in the 1860s, and a friend of Bret Harte there (see, for instance, Axel Nissen's <span class="italic">Bret Harte, Prince and Pauper</span> (2000), 239.) As such he probably had at least a passing acquaintance with Noah Brooks. He was forced to step down from his position due his involvement in a vote-buying scandal to elect Timothy Guy Phelps U.S. Senator from California (Portland <span class="italic">Oregonian</span>, 10 Feb 1863, 2), and moved to New York, where he went into the lumber business with his brother-in-law. A member of the Union League, he was involved in the purge of the Tweed ring in 1871. In 1891 he returned to San Francisco with a group of capitalists and engineers sent overland to explore the possibility of a canal through Nicaraugua (“The Big Canal: One of the Miller Party Talks of It It,” San Francisco <span class="italic">Chronicle</span>, 19 May 1891, 2), and died as a result of an illness contracted while inspecting the canal site en route.</p>
            </span>
         </td>
         <td>Charles Watrous</td>
         <td>1884-03-31</td>
         <td>31 March 1885</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41856.html">UCLC41856</a>
         </td>
         <td>WCB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Beecher, William Constantine"
               content=""
               data-original-title="test">Beecher, William Constantine</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">William C. Beecher was Henry Ward Beecher's son. He practiced law, but also
                     wrote a biography of his father, <span class="italic">Henry Ward Beecher: A Sketch
                        of His Career</span> (Hartford: American Publishing Company, 1887).</p>
                  </span>
         </td>
         <td>William Constantine  Beecher</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC42010.html">UCLC42010</a>
         </td>
         <td>bio10576</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=""
               content=""
               data-original-title="test"/>
            <span class="hide popper-content"/>
         </td>
         <td/>
         <td>1884-04-14</td>
         <td>April 14 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41976.html">UCLC41976</a>
         </td>
         <td>NS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Sarony, Napoleon "
               content=""
               data-original-title="test">Sarony, Napoleon </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Napoleon Sarony, celebrity photographer, lithographer and sketch artist, was born in Canada and trained as a lithographer in his father's business. In 1833 he moved to New York City, where he worked for Robertson &amp; Co. lithographers. After the death of his wife he traveled to Europe to study fine arts, but financial straits led him to photography, which he learned in his brother's Birmingham studio. He returned to New York in 1865 set up studio at 630 Broadway. In 1871 moved to 37 Union Square. In the fall of 1884 Clemens and George Washington Cable visited Sarony for tour photographs. Sarony belonged to the Lotos Club and was a founding member of the Salmagundi Club.</p>
            </span>
         </td>
         <td>Napoleon Sarony</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41833.html">UCLC41833</a>
         </td>
         <td>JHS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Smith, John Hyatt"
               content=""
               data-original-title="test">Smith, John Hyatt</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Born in Saratoga, New York, John Hyatt Smith was educated by his schoolmaster father, then sent to Detroit to work as a clerk. There he was a close friend of Anson Burlingame, who later befriended Clemens in Hawaii. Smith studied for the ministry when he wasn't clerking. After ordination in 1848 he served as a Baptist minister in Poughkeepsie, Cleveland, Buffalo, and Philadelphia before he accepted a position at the Lee Avenue Church in Brooklyn. Smith ran as an independent Republican for a seat in the U. S. House of Representatives, and served from 1881–1883. In December 1883 he was called by a Congregational Council presided over by Edward Beecher (brother of Henry Ward Beecher) to fill a temporary pastorship at the East Congregational Church in Brooklyn, where he remained until his death in 1887.</p>
            </span>
         </td>
         <td>Rev. J. Hyatt Smith</td>
         <td>1884-03-31</td>
         <td>28 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC42004.html">UCLC42004</a>
         </td>
         <td>RWG</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  "
               content=""
               data-original-title="test">,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Richard Watson Gilder was a poet, journalist, editor, and one of the founders of the American Copyright League. His editorial career at the helm of the <span class="italic">Century Magazine</span> spanned from the death of his predecessor J. G. Holland in 1881 (when <span class="italic">Scribner's Magazine</span> became <span class="italic">The Century Magazine</span>) to his own death in 1909. He married painter Helena de Kay, founder of the Society of American Artists, and their home, a converted stable named the Studio, was a gathering place for artists, players, and writers. Gilder was a founding member of the Authors Club, which was organized in 1882 and incorporated in 1887.</p>
            </span>
         </td>
         <td>Richard Watson Gilder</td>
         <td>1884-04-06</td>
         <td>6 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41953.html">UCLC41953</a>
         </td>
         <td>JHJr</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Howard, Jr.,  "
               content=""
               data-original-title="test">Howard, Jr.,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Joseph Howard, Jr., was a prominent journalist who worked for the Brooklyn <span class="italic">Eagle</span>, New York <span class="italic">Herald</span>, and the New York <span class="italic">World</span>. 
                     During the Civil War he was briefly imprisoned for creating a hoax document with Francis Avery Mallison that Lincoln had requested a draft for 400,000 troops (just months after the destruction 
                     of the New York City draft riots). He was a founding member of the New York Press Club; he was also a member of Henry Ward Beecher's Plymouth Church, and published a biography of Beecher in 1887. 
                     In a manuscript fragment discovered in one of Clemens's books, he called Howard a "cesspool-siphon of night-cart journalism" (Item #497, A1911 Auction Catalog facsimile, in CU-MARK).</p>
                  </span>
         </td>
         <td>Joseph  Howard, Jr.</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41860.html">UCLC41860</a>
         </td>
         <td>HCB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Bunner, Henry Cuyler"
               content=""
               data-original-title="test">Bunner, Henry Cuyler</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">H. C. Bunner was a writer and editor who oversaw <span class="italic">Puck</span>, the influential humor magazine. His novels included <span class="italic">The
                           Midge</span> (1882), and <span class="italic">The Story of a New York House</span> (1883), yet he was best known for short stories and sketches about life in New York City, in particular those collected in <span class="italic">Short Sixes</span> (1891). His collaborations with Brander Matthews also pushed the boundaries of the short story genre. Clemens probably met Bunner in 1883, when both were inducted into the Kinsmen club, and they both attended a dinner for Laurence Hutton at the Tile Club in New York in 1885. Clemens also jotted in his notebook in 1886 to read Bunner's <span class="">The Midge</span> (<span class="italic">N&amp;J3</span>, pp. 105, 115, 240). Clemens was also a frequent houseguest at Bunner's New York City home near Old Battery Park (see NB 33, entry for 9 December 1893, and 8 December 1893 to Olivia Clemens, MS in CU-MARK).</p>
                  </span>
         </td>
         <td>Henry Cuyler  Bunner</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41997.html">UCLC41997</a>
         </td>
         <td>CDW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Warner, Charles Dudley"
               content=""
               data-original-title="test">Warner, Charles Dudley</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Essayist and novelist George Dudley Warner was a neighbor of Clemens at Nook Farm in Hartford, and co-author of <span class="italic">The Gilded Age</span> (1873). In the 1860s he was an editor of the Hartford <span class="italic">Press</span>, and then of the Hartford <span class="italic">Courant</span>, when the two papers merged. He joined the staff of <span class="italic">Harper's Magazine</span> in 1884 and was responsible for The Editor's Drawer feature until 1892, when he took on The Editor's Study.</p>
            </span>
         </td>
         <td>Charles Dudley Warner</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41980.html">UCLC41980</a>
         </td>
         <td>ECS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=", Edmund Clarence"
               content=""
               data-original-title="test">, Edmund Clarence</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Poet and critic Edmund Clarence Stedman was born in Hartford and attended Yale. In his youth he worked as a correspondent for the <span class="italic">Sun</span> and the <span class="italic">Tribune</span>. He was a member of the Pfaff's Cellar Bohemians before the Civil War, as were many others in this group.  After the war he became a banker on Wall Street from 1865–1890, but continued to write and publish poetry and literary criticism. In 1887 Stedman succeeded in foisting his <span class="italic">Library of American Literature</span> compilation upon Clemens's nephew and business partner, Charles L. Webster, a decision that led to the “lingering suicide” of the publishing firm (AD of 2 June 1906, <a href="http://www.marktwainproject.org/xtf/view?docId=works/MTDP10363.xml;query=stedman;chunk.id=dv0017;toc.depth=1;toc.id=;citations=;style=work;brand=mtp#1"
                     title="">
                     <span class="italic">AutoMT1</span>
                  </a>).</p>
            </span>
         </td>
         <td>Edmund Clarence Stedman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41854.html">UCLC41854</a>
         </td>
         <td>MSB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Beach, Moses Sperry"
               content=""
               data-original-title="test">Beach, Moses Sperry</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Moses S. Beach was a printer and editor of the New York <span class="italic">Sun</span>. He was a long-time member and former trustee of Plymouth Church
                     who, with his daughter Emeline (1850–1924), was among the “most prominent
                     Brooklynites” to meet Clemens on the <span class="italic">Quaker City</span> excursion
                     in 1867. Clemens spoke well of Beach, grateful for the treatment he had 
                     received from him and especially praising his liberality and generosity toward the crew of the Quaker City.</p>
                  </span>
         </td>
         <td>Moses Sperry  Beach</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41974.html">UCLC41974</a>
         </td>
         <td>RWR</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Raymond, Rossiter Worthington"
               content=""
               data-original-title="test">Raymond, Rossiter Worthington</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Rossiter Worthington Raymond was born and raised in Syracuse, New York. After graduating from Brooklyn Polytechnic he enrolled in the Royal Mining Academy at Freiburg, followed by studies at Heidelberg and Munich. He edited <span class="italic">The American Journal of Mining</span> from 1867 to 1890. In 1868 he was appointed United States Commissioner of Mining Statistics, and spent nearly a decade surveying mines in the West. In the early 1870s he also taught Mining Engineering at Lafayette College in Easton, Pennsylvania. He served as secretary of the American Institute of Mining, Metallurgy, and Petroleum Engineers (1884–1911). In 1884 he lived in Brooklyn, where he was a member of Beecher's Plymouth Church, and served as the director of the Boy's Sunday School for nearly 50 years.</p>
            </span>
         </td>
         <td>R. W. Raymond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41848.html">UCLC41848</a>
         </td>
         <td>EBW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Waring, Effie Blunt"
               content=""
               data-original-title="test">Waring, Effie Blunt</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Daughter of Col. George E. Waring, Jr., Effie Blunt Waring was born on Horace Greely's farm. She studied painting with Abbott Thayer in Boston, and lived and painted in the family homestead, the Hypotenuse, in Newport, R. I. In 1904 she founded Aquidneck Cottge Industries, a dharitable organization that taught local working class women domestic skills and crafts, e.g. needlework and embroidery. (Newport <span class="italic">Mercury</span>, 20 Oct 1933, 3)</p>
            </span>
         </td>
         <td>Effie Blunt (“Daisy”) Waring</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41951.html">UCLC41951</a>
         </td>
         <td>JH</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Hawthorne,  "
               content=""
               data-original-title="test">Hawthorne,  </a>
            <span class="hide popper-content">
                    <p xmlns="http://www.w3.org/1999/xhtml">Julian Hawthorne, the son of Nathaniel Hawthorne and Sophia Peabody, was a noted journalist and writer in his own right (mostly of mystery stories), and Clemens's library eventually included his 1885 novel <span class="italic">Noble Blood</span> and his 1903 study of his father, <span class="italic">Hawthorne and his Circle</span> (Gribben, <span class="italic">Mark Twain's Library</span>, p. 1:301). He met Clemens in the early 1870s, and remained good friends with him until his death. During this time he was also employed as the literary editor of the New York <span class="italic">World</span>. They both belonged to the American Copyright League and the Authors Club. About his friendship with Clemens Hawthorne recalled that "I found him as most people did, delightful and fruitful, and very much as he was in his best writing," adding that "He never seemed to be a very happy man ... his mind was too active, searching out and sincere not to be troubled by the riddle of the Universe" ("Mark Twain as I Knew Him," <span class="italic">Overland Monthly and Out West Magazine</span> 87 [April 1929]: 111).</p>
                  </span>
         </td>
         <td>Julian Hawthorne</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41968.html">UCLC41968</a>
         </td>
         <td>HLP</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  Lillie"
               content=""
               data-original-title="test">,  Lillie</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Henry Lillie Pierce was a politician and millionaire chocolate magnate, and an intimate friend of Thomas Bailey Aldrich. In 1849 he secured a position as a clerk in the Baker chocolate factory in Dorchester, owned by his uncle. By 1854, on the death of the heir, Walter Baker, the trustees gave Pierce a ten-year lease on the factory. He had organized the company so successfully that not only was he able to serve as member of the U.S. House of Representatives 1873–1877 and as Mayor of Boston in 1872 and 1878, but by the end of his second ten-year lease the property was conveyed to him by the trustees. Pierce and Thomas Bailey Aldrich were the closest of friends from around 1873 until Pierce's death. He left the family a life interest in Redman Farm, his house and land at Ponkapog, and a total bequest of $400,000. (James Bugbee “Memoir of Henry Lillie Pierce,” <span class="italic">Proceedings of the Massachusetts Historical Society</span>, Second Series, Vol. 11, (Boston: Massachuessetts Historical Society, 1896–1897), 386–410. “A Model Citizen,” <span class="italic">The Critic</span> 30 (Jan 9, 1897): 22).</p>
            </span>
         </td>
         <td>Henry L. Pierce</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41995.html">UCLC41995</a>
         </td>
         <td>EDS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=" Douglas, Ellen Montague"
               content=""
               data-original-title="test"> Douglas, Ellen Montague</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Ellen D. Stedman was the wife of recently embroiled broker Frederick Stuart Stedman, son of poet Edmund Clarence Stedman. She and her daughter Laura were Edmund Clarence Stedman's mainstays in his old age.</p>
            </span>
         </td>
         <td>Ellen Montague Douglas Stedman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41852.html">UCLC41852</a>
         </td>
         <td>WSA</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Andrews, William S."
               content=""
               data-original-title="test">Andrews, William S.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">William S. Andrews was an actor and noted public speaker who often used Mark
                     Twain's works to demonstrate "dialect humor." Later in life he was an
                     influential politician (<span class="italic">L5</span>, 209 n. 1).</p>
                  </span>
         </td>
         <td>William S.  Andrews</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41869.html">UCLC41869</a>
         </td>
         <td>CF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Frohman,  "
               content=""
               data-original-title="test">Frohman,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Charles Frohman was a theatrical manager and producer, notably of the touring Wallack Theatre Company and the Lyceum. In 1900 he met with Clemens to discuss producing "The End of the Earth," a play he co-wrote with Sydney Rosenfeld. Rosenfeld wrote to the New York <span class="italic">Dramatic Mirror</span> on 22 April 1898 that he had that day concluded an agreement with Mark Twain to collaborate on a play, a rough draft of which he had received. On 22 October 1900 the two men met with Frohman, but nothing came of the meeting. In August 1902 Rosenfeld announced to the press that he would produce the play under contract with Leander Sire, possibly as the maiden play for a projected (but never constructed) new theater. It seems never to have made it to the stage. Frohman was among the passengers who died when the Germans sunk the <span class="italic">RMS Lusitania</span>.</p>
                  </span>
         </td>
         <td>Charles  Frohman</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41972.html">UCLC41972</a>
         </td>
         <td>OWP</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  "
               content=""
               data-original-title="test">,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Ozias Walter Pond was a younger brother of James B. Pond, and a manager of musical acts and lecturers for the Redpath Lyceum Bureau. In 1883 he accompanied Henry Ward Beecher on a farewell lecture tour that extended into the spring of 1884. On 1 April he was with Beecher on the road between platform stops in Harrisburg and Cincinnati. Although in his letter to Clemens he claimed a meager acquaintance, he would soon come to know both Clemens and Cable very well—in January 1885 he accompanied the pair on their lecture tour in his brother's place. At the end of the month, however, he was forced to leave the tour due to illness.</p> 
            </span>
         </td>
         <td>Ozias W. Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41989.html">UCLC41989</a>
         </td>
         <td>HPG</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Gray, Henry Peters"
               content=""
               data-original-title="test">Gray, Henry Peters</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Henry Peters Gray served for the New York Volunteers as an Assistant Adjutant-General during the Civil War, and after the war was a longstanding employee of Tiffany &amp; Co.</p>
                  </span>
         </td>
         <td>Henry Peters Gray, Jr.</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41846.html">UCLC41846</a>
         </td>
         <td>FDM</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  "
               content=""
               data-original-title="test">,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Francis Davis Millet was a journalist and artist. After serving as a drummer boy and surgical aide to his father in the Civil War he worked as a reporter for the Boston <span class="italic">Courier</span>, and correspondent for the Boston <span class="italic">Advertiser</span> (1869–70). In the 18701 he studied painting at the Royal Academy of Fine Art in Antwerp, and then in Italy, moving between art studios in Rome and Venice. Upon his return to the U.S. in 1876 he worked as chief assistant to John La Farge in the creation of murals for Trinity Church, Boston, with John LaFarge. He completed a portrait of Clemens in January 1877. From 1877–88 he was a correspondent for the New York <span class="italic">Herald</span> covering the Russo-Turkish War. He died on the Titanic in 1912. </p>
            </span>
         </td>
         <td>Francis Davis Millet</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41966.html">UCLC41966</a>
         </td>
         <td>JBM</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Matthews, James Brander"
               content=""
               data-original-title="test">Matthews, James Brander</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Brander Matthews was a writer on dramatic subjects, novelist, critic, and professor of Dramatic Literature at Columbia University from 1892 to 1924. After earning a law degree from Columbia in 1873 Matthews chose to pursue a literary career. By 1884 he had published <span class="italic">The Theatres of Paris</span> (1880), and <span class="italic">French Dramatists of the Nineteenth Century</span> (1881) as well as two novels. The april fool letter is the first extant piece of correspondence between Clemens and Matthews, whose friendship grew in subsequent decades. They were both members of the Kinsmen Club, the Authors Club, and the American Copyright League.</p>
            </span>
         </td>
         <td>Brander Matthews</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41873.html">UCLC41873</a>
         </td>
         <td>JLG</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Gilder, Jeannette Leonard"
               content=""
               data-original-title="test">Gilder, Jeannette Leonard</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Jeannette Gilder was a journalist who corresponded for the Chicago <span class="italic">Tribune</span> and served as the associate editor of <span class="italic">Putnam's Magazine</span> and <span class="italic">The Critic and Good Literature</span>. She was also the daughter of the clergyman William Henry Gilder, and the sister of the poet and editor Richard Watson Gilder. In 1881–82 Clemens and her had a row about a letter to the editor in the Critic which asked why Clemens had not given credit to the source of his story "A Curious Episode," and Clemens responded by sending an excoriating letter to the editor which assumed the editor was a man (Gilder to Clemens, 6 Dec 1881, ms in CU-MARK; Clemens to Gilder, 12 Dec 1881). Gilder and Clemens were both apologetic for their respective blunders, and Gilder later made a gratuitous gesture by sending Clemens the original manuscript of Holmes's poem to commemorate Clemens's fiftieth birthday in 1885 (Gilder to Clemens, 14 December 1881; Clemens to Boyesen, 11 January 1882; Gilder to Clemens, 9 December 1885, ms in CU-MARK).</p>
                  </span>
         </td>
         <td>Jeannette Leonard  Gilder</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41993.html">UCLC41993</a>
         </td>
         <td>HM</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Modrzejewska, Helena "
               content=""
               data-original-title="test">Modrzejewska, Helena </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Helena Modjeska, whose name on her birth certificate was Jadwiga Benda, was baptised Helena Opid in Kracow. She took as her stage name a simplied version of the stage name of her first husband, Gustaw Zimajer, who went by “Gustaw Modrzejewski.” Under his management she solidified her repuation as the leading tragic actress on the Polish stage. In 1875 she emigrated to California with her second husband Karol Bozenta Chlapowski. She eventually made her way to the New York Stage, with the support of the Gilder circle. After three years in London she returned to New York with further accolades. She retired from the stage in 1907 (Modjeska, <span class="italic">Memories and Impressions of Helena Modjeska.</span> (New York: MacMillan, 1910); <span class="italic">New York Times</span>, 9 April 1909).</p>
            </span>
         </td>
         <td>Helena Modjeska</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41867.html">UCLC41867</a>
         </td>
         <td>CSF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Fairchild, Charles S."
               content=""
               data-original-title="test">Fairchild, Charles S.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Charles Fairchild was born and raised in Ohio. After graduating from Harvard in 1858 he served in the Union Army, and briefly attended Harvard Law (without taking a degree) before entering the paper manufacturing business. He was “a close friend and drinking companion of James R. Osgood and his knights of the quill—Aldrich, Samuel Clemens, and William Dean Howells." He helped Howells to finance his house in Belmont, and for a brief time in the early 1880s they were neighbors. Clemens probably first met him in 1874 at the banquet at the Parker House in Boston for <span class="italic">Atlantic Monthly</span> contributors and supporters. (Fairchild had actually advanced $20,000 to Melancthon Hurd and Henry Houghton to purchase ownership of the magazine from James R. Osgood.) (<span class="italic">L6</span>, p. 319). He was also the brother of General Lucius Fairchild, the Civil War veteran, diplomat, and tenth governor of Wisconsin.</p>
                  </span>
         </td>
         <td>Charles S.  Fairchild</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41850.html">UCLC41850</a>
         </td>
         <td>LWA</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Aldrich, Mary Elizabeth Woodman"
               content=""
               data-original-title="test">Aldrich, Mary Elizabeth Woodman</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Mary Elizabeth "Lilian" (nee Woodman) married the writer and editor Thomas
                     Bailey Aldrich in 1865. In 1920 she published a memoir of her late husband
                     entitled, <span class="italic">Crowding Memories</span>. See also
                       Scharnhorst's <span class="italic">Mark Twain in his Own Time</span>, pp. 95–98. Clemens did not have a high opinion of her. For
                     example, in a 27 December 1893 letter to his daughter Susy he fumed about
                     Lilian, "Lord, I loathe that woman so! She is an idiot—an absolute
                     idiot—&amp; does not know it. She is sham, sham, sham—not a genuine
                     fibre in her anywhere—a manifest &amp; transparent humbug—&amp; her
                     husband, the sincerest man that walks, doesn’t seem aware of it. It is a most
                     extraordinary combination: he, fine in heart, fine in mind, fine in every
                     conceivable way, sincere, genuine, &amp; lovable beyond all men save only Joe
                     Jefferson—&amp; tied for life to this vacant hellion, this
                     clothes-rack, this twaddling, blethering, driveling blatherskite!" (MS
                     facsimile in CU-MARK).</p>
                  </span>
         </td>
         <td>Mary Elizabeth "Lilian" Woodman  Aldrich</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41970.html">UCLC41970</a>
         </td>
         <td>JBP</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Pond,  Burton"
               content=""
               data-original-title="test">Pond,  Burton</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">James Burton Pond was a decorated Civil War officer and lecture manager who fought with John Brown in 1846 in Kansas, and against Quanatrill's gang in Missouri. In 1874 he formed the Pond Lyceum Bureau, having spent some years managing acts on his own in Salt Lake City, followed by a stint with the Redpath Lyceum Bureau. By 1884 he had managed Henry Ward Beecher, Wendell Phillips, Matthew Arnold, and George Washington Cable. Pond wrote several books and articles about his experiences on the lecture circuit, including <span class="italic">A Summer in England with Henry Ward Beecher.</span> (1877), and <span class="italic">Eccentricities of Genius.</span> (1900). </p>
            </span>
         </td>
         <td>James B. Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41987.html">UCLC41987</a>
         </td>
         <td>CdK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  Augustus"
               content=""
               data-original-title="test">,  Augustus</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Charles de Kay was a poet, critic, and founder of the New York Fencers' Club. de Kay took a degree at Yale and spent two years in the company of the literary and artistic celebrities who frequented the salon of his aunt Katherine de Kay Bronson in Paris and Venice. He was the art and literary critic for the New York <span class="italic">Times</span> from 1876 to 1894. He was a founding member of the Author's Club in 1882, and of the National Arts Club in 1899. From 1894–97 he served as consul-general in Berlin.</p>
            </span>
         </td>
         <td>Charles de Kay</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41964.html">UCLC41964</a>
         </td>
         <td>CML</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Leoser, Charles McKnight"
               content=""
               data-original-title="test">Leoser, Charles McKnight</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Charles McKnight Leoser was born in Reading, Penn. and attended West Point. He commanded the Fire Zouaves during the Civil War and mustered out at the rank of Colonel. He was the publisher of <span class="italic">Bonfort's Wine and Spirits Circular</span>, and president of the Wine and Spirits Traders' Society of New York. He served as president of the Lotos Club from 1872–74, and two of his poems appear in <span class="italic">Lotos Leaves</span> (1875) (New York <span class="italic">Times</span>, 26 Feb 1896: 5).</p>
            </span>
         </td>
         <td>charles McKnight Leoser</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41958.html">UCLC41958</a>
         </td>
         <td>CLK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Kellogg, Clara Louise"
               content=""
               data-original-title="test">Kellogg, Clara Louise</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Soprano and musical actress Clara Louise Kellogg was considered the first American prima donna. She made her professional debut as Gilda in <span class="italic">Rigoletto</span> in February 1861 at the new York Academy of Music. Over the next two decades she sang over forty roles in several languages. By the mid-1880s she was reduced to sporadic concert engagements, and retired shortly after marrying her manager, Carl Strakosch, in 1887. She died in New Hartford, Connecticut. She was a close friend of the Gilder family and a frequent participant in the Gilder Friday “At Home” gatherings. </p>
            </span>
         </td>
         <td>Clara Louise Kellogg</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41991.html">UCLC41991</a>
         </td>
         <td>STK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Kinney Thomson, Sara "
               content=""
               data-original-title="test">Kinney Thomson, Sara </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Sara Thomson Kinney, the wife of John Coddington Kinney, was active in the Daughters of the American Revolution and the Women's National Indian Association. In 1884, after attending the second annual Lake Mohonk Conference for Friends of the Indian, she joined the WNIA Home-Building and Loan Committee, whose purpose was to encourage Native American wowen to assimilate into white society.</p>
            </span>
         </td>
         <td>Sara T. Kinney</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41865.html">UCLC41865</a>
         </td>
         <td>FJ</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Jenkins, Frank "
               content=""
               data-original-title="test">Jenkins, Frank </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Jenkins was born in Boontown, N.J. and graduated from Yale in 1874. He moved to New York, where he boarded with fellow April Fool letter writer Horatio C. King, and through that connection soon became Henry Ward Beecher's secretary. He was connected with the <span class="italic">Christian Union</span> in various capacities, including as publisher from 1878–1879, and then joined a banking firm in 1879, advancing to senior partner. However, the firm went into receivership in 1890. After two more failed ventures in managing mines in Minnesota and Cuba, he formed the Jenkins Coal Company. Through his association with Beecher and his memberships in the Lambs and Players Clubs he formed acquaintances with Warner, Hutton, Stedman, and Clemens, as he claims in his letter to the Yale alumni club. Clemens's annotation identifies him as a “stranger” in 1884. Jenkins never married. He died of Bright's disease at his home in the Hotel Ansonia in 1913.</p>
            </span>
         </td>
         <td>Frank Jenkins</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41842.html">UCLC41842</a>
         </td>
         <td>JSB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Billings, John Shaw"
               content=""
               data-original-title="test">Billings, John Shaw</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Dr. John S. Billings served as medical inspector of the Army of the Potomac.
                     After the war he was posted to the office of the U.S. Surgeon General as
                     Lieutenant Colonel, where he established the National Library of Medicine
                     within the War Department's Surgeon General's Library, for which he served as
                     librarian until his retirement from active Army service in 1895. In 1896 he
                     became the first chief librarian of the New York Public Library. He was also a
                     founding member of the Cosmos Club in Washington D.C. He probably knew Clemens from
                     their mutual friend Colonel George Waring, with whom Billings worked on several
                     sanitation projects.</p>
                  </span>
         </td>
         <td>John Shaw  Billings</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41859.html">UCLC41859</a>
         </td>
         <td>CCB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Buel,  "
               content=""
               data-original-title="test">Buel,  </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Buel was an editor and author who worked at the <span class="italic">New York Tribune</span> and <span class="italic">Century Magazine</span>. With Robert Underwood Johnson he co-edited the acclaimed <span class="italic">Battles and Leaders of the Civil War</span> (1887–88).</p>
                  </span>
         </td>
         <td>Clarence Clough  Buel</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41979.html">UCLC41979</a>
         </td>
         <td>FHS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Smith, Francis Hoplinson"
               content=""
               data-original-title="test">Smith, Francis Hoplinson</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Civil engineer, artist, and writer Francis Hopkinson Smith was a friend and clubmate of Clemens. At the time of his death he was best known as an author and illustrator of his own works. He was also a successful landscape painter. Among his engineering projects were the construction of Race Rock Lighthouse and the base of the Statue of Liberty. He was a founding member of the Kinsman Club and the Tile Club.</p>
            </span>
         </td>
         <td>Francis Hopkinson Smith</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCCL41964.html">UCCL41964</a>
         </td>
         <td/>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=""
               content=""
               data-original-title="test"/>
            <span class="hide popper-content"/>
         </td>
         <td/>
         <td>1884-03-31</td>
         <td/>
      </tr>
      <tr>
         <td>
            <a href="UCLC41962.html">UCLC41962</a>
         </td>
         <td>TWK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Knox, Thomas Wallace"
               content=""
               data-original-title="test">Knox, Thomas Wallace</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Thomas Wallace Knox was a Civil War correspondent for the New York <span class="italic">Herald</span> and travel writer, best known for his series of 40 travel adventure books for boys. His war letters were collected in 1866 as <span class="italic">Campfire and Cottonfields</span>. After the war he traveled as a <span class="italic">Herald</span> correspondent with the Russo-American Telegraph Company to build the first telegraph line across Siberia. In 1870 the American Publishing Company published these letters as <span class="italic">Overland Through Asia</span>. In 1877 he traveled around the world, gathering material for his series of travel books. The series list serves as an itinerary for his travels. In 1881 the King of Siam conferred upon him a knighthood in the Order of the White Elephant in return for his service to the country. He was the first American to receive that honor. Knox, who never married, made his home at the Lotos Club and was club secretary from 1880–89. He was also a member of the Authors Club.</p>
            </span>
         </td>
         <td>Thomas W. Knox</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41956.html">UCLC41956</a>
         </td>
         <td>HI</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Broadribb, John Henry"
               content=""
               data-original-title="test">Broadribb, John Henry</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">English stage actor Henry Irving was born John Henry Broadribb, the son of a traveling salesman in Somerset. His first professional appearance was as the Duke of Orleans in Bulwer-Lytton's <span class="italic">Richilieu</span> in September 1856 at the New Royal Lyceum Theatre, Sunderland. In 1871 he joined the Lyceum Theatre in London under the management of Hezekiah Bateman, where he won acclaim for his performance in <span class="italic">The Bells</span>, an adaptation of Erckmann-Chatrian's <span class="italic">Le Juif Polonais</span>. He took over the management of the Lyceum Theatre from Batemen in 1878, the beginning of his long stage and personal partnership with Ellen Terry. In 1895 he became the first actor to receive a knighthood. During a provincial farewell tour in Bradford he was taken ill and died of a stroke hours later.</p>
            </span>
         </td>
         <td>Sir Henry Irving</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41836.html">UCLC41836</a>
         </td>
         <td/>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=""
               content=""
               data-original-title="test"/>
            <span class="hide popper-content"/>
         </td>
         <td/>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41863.html">UCLC41863</a>
         </td>
         <td>ACD</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Dunham, Austin Cornelius"
               content=""
               data-original-title="test">Dunham, Austin Cornelius</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Austin Dunham was a wool merchant, inventor, and president of the Hartford Electric Light Company. In 1870 he joined the Monday Evening Club, where Clemens had read before (see <a href="http://vm149.lib.berkeley.edu:8080/xtf-exp/view?docId=letters/UCCL02497.xml;query=UCCL02497;searchAll=;sectionType1=;sectionType2=;sectionType3=;sectionType4=;sectionType5=;style=letter;brand=mtp#1"
                     title="">11 January 1876 to William Dean Howells</a> at <span class="italic">MTPO</span>). The Dunhams were also good friends with Clemens's friend and collaborator, Charles Dudley Warner.</p>
                  </span>
         </td>
         <td>Austin Cornelius  Dunham</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41983.html">UCLC41983</a>
         </td>
         <td>CGW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Whiting, Charles Goodrich"
               content=""
               data-original-title="test">Whiting, Charles Goodrich</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Charles Goodrich Whiting had a long association beginning in 1868 with the Springfield <span class="italic">Republican</span> as a writer of bucolic essays and poems in his Sunday column “The Saunterer,” and, after 1874, as literary editor. He was elected to the Authors Club of New York in 1888. Cable's first reading of his 1883 tour took place at Springfield, and a very favorable review, possibly written by Whiting, appeared in the <span class="italic">Republican</span> on 22 November.</p>
            </span>
         </td>
         <td>Charles G. Whiting</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41840.html">UCLC41840</a>
         </td>
         <td>JPL</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Lathrop, George Parsons"
               content=""
               data-original-title="test">Lathrop, George Parsons</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">George Parsons Lathrop was an editor, poet, critic, and copyright reformer. He served as associate editor of the <span class="italic">Atlantic Monthly</span> (1875–77), editor-in-chief of the Boston <span class="italic">Courier</span> (1877–79), and literary editor of the New York <span class="italic">Star</span> in the late 1880s. He became secretary of the American Copyright League in 1883. Lathrop married Rose Hawthorne, the daughter of Nathaniel Hawthorne, in 1871. From 1879 to 1883 the couple lived in Concord, Mass. in the Hawthorne homestead, “The Wayside.” Lathrop wrote <span class="italic">A Study of Hawthorne</span> (1876), and was an editor of the Riverside Edition of <span class="italic">The Works of Nathaniel Hawthorne</span> (1882–84). Lathrop was a founding member of the Author's Club and a member of the Player's Club, and of the Papyrus Club in Boston.</p>
            </span>
         </td>
         <td>George Parsons Lathrop</td>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41857.html">UCLC41857</a>
         </td>
         <td>HHB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Boyesen, Hjalmar H."
               content=""
               data-original-title="test">Boyesen, Hjalmar H.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Boyesen was a Norwegian novelist, critic, and professor of German at Cornell
                     University. He met Clemens in the late 1870s and got to know him well during his
                     stay in Paris in 1879 while he was finishing <span class="italic">A Tramp
                        Abroad</span>. He also introduced Clemens to Turgenev (see Mark Twain's NB 18, <span class="italic">NB&amp;J2</span>, pp. 285–350).</p>
                  </span>
         </td>
         <td>Hjalmar H.  Boyesen</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41977.html">UCLC41977</a>
         </td>
         <td>HES</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Scudder, Horace Elisha"
               content=""
               data-original-title="test">Scudder, Horace Elisha</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Horace Elisha Scudder was a Boston journalist, children's writer, biographer, and editor of the <span class="italic">Riverside Magazine</span>, and later, of the  <span class="italic">Atlantic Monthly,</span> following Thomas Bailey Aldrich. He had a long association with various publishing partnerships of H. O. Houghton as a minority partner, along with George H. Mifflin, in the 1870s.  He is best known for the <span class="italic">Bodley Books</span> (1875–87). <span class="italic">The Children's Book</span> (1881), <span class="italic">History of the United States ... for the Use of Schools and Academies</span> (1884), and  <span class="italic">Letters of Bayard Taylor</span> (1884).</p>
            </span>
         </td>
         <td>Horace E. Scudder</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41834.html">UCLC41834</a>
         </td>
         <td>BHC</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Cutter, Bloodgood Haviland"
               content=""
               data-original-title="test">Cutter, Bloodgood Haviland</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Bloodgood Cutter was a farmer and poet from Long Island. At the outset of the <span class="italic">Quaker City</span> voyage Clemens described Cutter in his notebook as “fifty years old, &amp; small of his age. He dresses in homespun, &amp; is a simple minded, honest, old-fashioned farmer, with a strange proclivity for writing rhymes. He writes them on all possible subjects, &amp; gets them printed on slips of paper, with his portrait at the head. These he will give to any man that comes along, whether he has anything against him or not” (<span class="italic">N&amp;J1</span>, 344). Cutter considered himself the Poet Laureate of the excursion. Clemens called him the “Poet Lariat” in <span class="italic">Innocents</span>, adopting Francis Eugene Andrews’s mispronunciation. In 1880 he called him a “mildewed idiot. His friends call him a lunatic—but that is pretty fulsome flattery; one cannot become a lunatic without first having brains” (30 Apr 1880 to Perkins, CtY-BR, in <a href="http://www.marktwainproject.org/" title="">MTPO</a>); 31 Mar and 1 Apr 69 to Fairbanks, <span class="italic">L2</span>, 185). In 1886 Cutter self-published a collection of his poems entitled <span class="italic">The Long Island Farmer's Poems</span>. His poems were never celebrated, yet he was a successful farmer: at his death his estate was worth $900,000.</p>
                  </span>
         </td>
         <td>Bloodgood Haviland  Cutter</td>
         <td>1884-03-29</td>
         <td>29 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41960.html">UCLC41960</a>
         </td>
         <td>HCK</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="King, Horatio Collins"
               content=""
               data-original-title="test">King, Horatio Collins</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Horatio Collins King was a decorated civil war officer, lawyer, publisher of the <span class="italic">Christian Union</span> and the <span class="italic">Christian at Work</span> in the 1870s, and long-time member of Beecher's Plymouth Church, which had been founded by his father-in-law, Joseph Tasker Howard. In 1878 he left publishing and was appointed major of the Thirteenth Regiment of the New York National Guard, of which he was later made Judge Advocate General. He was active in Democratic politics, but was never successful in winning an office.</p>
            </span>
         </td>
         <td>Horatio C. King</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41861.html">UCLC41861</a>
         </td>
         <td>WC</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Carey, William "
               content=""
               data-original-title="test">Carey, William </a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Wiliam Carey worked on the editorial staff for the <span class="italic">Century Magazine</span> for twenty years, as well as acting as a liaison between editors and production men (Arthur John, <span class="italic">The Best Years of the Century</span>, p. 116). A legendary wit and popular with authors, he was also a member of the Authors Club.</p>
                  </span>
         </td>
         <td>William  Carey</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41981.html">UCLC41981</a>
         </td>
         <td>ET</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Terry, Alice Ellen"
               content=""
               data-original-title="test">Terry, Alice Ellen</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Ellen Terry was the leading British stage actress in Shakespearean roles of her day. Her first performance in 1856 was as Mamilius in The Winter's Tale at the Princess Theatre, London, where she remained until the retirement of Charles Kean in 1859. In 1878 Terry joined Irving's company at the Lyceum. She had a long professional and personal relationship with Henry Irving. </p>
            </span>
         </td>
         <td>Dame Ellen Terry</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41855.html">UCLC41855</a>
         </td>
         <td>HWB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Beecher, Henry Ward"
               content=""
               data-original-title="test">Beecher, Henry Ward</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Henry Ward Beecher was the renowned liberal pastor of Plymouth Church in
                       Brooklyn, and the author of several popular books. He was also a social activist who promoted abolition, temperance, and women's rights. Clemens met him in the winter of 1868, and admired his congeniality even when pointing out his flimsy convictions (which would culminate in the Beecher-Tilton adultery trial of 1875). Clemens also published the sketch "Rev. Henry Ward Beecher's Farm," which was published in <span class="italic">Sketches</span> (1872) and <span class="italic">A Curious Dream</span> (1872). They exchanged letters and kept a mostly pleasant acqaintance; Clemens usually saw him when he visited his sister Isabella Hooker, who was Clemens's neighbor in Hartford and a very close friend. A tricky publishing venture at the end of Beecher's life also revealed Clemens's ambivalence to the celebrity pastor. On 3 January 1887 Charles Webster informed Clemens that Beecher was considering an autobiography: “Beecher seemed to think that it might be a pretty good thing to do, and he also seemed to think that other things being equal, he would rather have us publish it than any one else. ... I do not love Beecher any more than you do, but I love his money just as well, and I am certain that that book would sell.” (Beecher had also been advanced a substantial sum by Webster to complete his <span class="italic">Jesus, Life of the Christ</span>, which he also did not finish.) Beecher's death complicated these publishing plans, and in 1888 Clemens settled for the unprofitable biography completed by his son William and son-in-law Samuel Scoville (<span class="italic">N&amp;J3</span>, 272, 276).</p>
                  </span>
         </td>
         <td>Henry Ward  Beecher</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41975.html">UCLC41975</a>
         </td>
         <td>HR</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  "
               content=""
               data-original-title="test">,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">The identity of this letter writer remains a mystery. He or she used the return address of the Gilders' home, and may have been a house guest at the time that the Cable circular arrived. Barring a complete and unlikely transformation of hand and signature it cannot be Clemens's Hartford friend Henry C. Robinson. In addressing the envelope to C. L. Clemens he or she reveals either ignorance of Clemens's first name, or a ruse to further obfuscate his or her own identity by pretending not to know Clemens's first name, or sloppiness.</p>
            </span>
         </td>
         <td>H. Robinson</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41849.html">UCLC41849</a>
         </td>
         <td>GEW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Waring, George Edwin"
               content=""
               data-original-title="test">Waring, George Edwin</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">George E. Waring, Jr. was an author, agriculturalist, and sanitary engineer, and a close friend of Cable, Clemens and James R. Osgood. In 1855 he managed Horace Greeley's farm at Chappaqua, New York. After the Civil War, where he commanded the 4th Missouri Cavalry, he retired his commission to manage Ogden Farm, a model farm in Newport, R.I. Waring wrote both husbandry manuals and bucolic serialized novels, several of which were published by Osgood. In the late 1870s, Waring designed toilets, and from there moved on to design entire sewer systems to alleviate the cholera epidemic at Memphis. In 1895 he established the first organized street cleaning department in New York City. In 1898 william McKinley sent Waring to Cuba to survey sanitary issues, but he contracted yellow fever, and died at home in October 1898.</p>
            </span>
         </td>
         <td>George E. Waring, Jr.</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41969.html">UCLC41969</a>
         </td>
         <td>TFP</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Plunkett, Thomas Fitzpatrick"
               content=""
               data-original-title="test">Plunkett, Thomas Fitzpatrick</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Treasurer of the Union Manufacturing Company and president of the Hartford Silk Company, Thomas Fitzpatrick Plunkett fled to Mexico in 1889 to escape embezzlement charges. He was rumored to have been murdered there shortly after his escape, but apparently lived in Mexico until shortly before he died in Tucson, Arizona, in 1905. The Beach family of Hartford were financial supporters of both companies, and Charles M. Beach was appointed receiver for the Union Mfg Co. Plunkett was a member of the Hartford Club. His father, Massachusetts politician Thomas F. Plunkett (senior), had been a member of the Monday Evening Club.</p>
            </span>
         </td>
         <td>Thomas F. Plunkett</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41952.html">UCLC41952</a>
         </td>
         <td>JMH</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Hay, John Milton"
               content=""
               data-original-title="test">Hay, John Milton</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">John Hay was a writer and statesman who grew up in Warsaw, Illinois, a small
                     town about sixty miles from Clemens's hometown of Hannibal, Missouri, and this
                     common background fostered their long friendship. After graduating from Brown
                     University, Hay began his illustrious career in public service as an assistant
                     private secretary to Abraham Lincoln. Hay met Clemens in the late 1860s, and in 1871 Clemens offered Hay
                     part-ownership of the Buffalo <span class="italic">Express</span>, and to join him
                     in a trip down the Mississippi to furnish material for what would appear in
                     1875 as the "Old Times on the Mississippi" series in the January-June and
                     August issues of the <span class="italic">Atlantic Monthly</span>. Hay declined both
                     offers, but remained appreciative of his work (see
                     also <a href="http://www.marktwainproject.org/xtf/view?docId=letters/UCCL11849.xml;query=john%20hay;searchAll=;sectionType1=;sectionType2=;sectionType3=;sectionType4=;sectionType5=;style=letter;brand=mtp#1"
                     title="">Clemens to John M. Hay, 6? Jan 1871</a>). Clemens also appreciated Hay's <span class="italic">Pike County Ballads</span> (1871) for its verisimilitude to
                        their boyhood region. In 1870 Hay accepted an editorial
                     position on the New York <span class="italic">Tribune</span> under Horace Greeley,
                     and then, after Greeley’s death in 1872, assisted the new editor, Whitelaw
                     Reid. He gave up his <span class="italic">Tribune</span> position in 1875 and pursued a literary career as
                     a poet, novelist, and biographer of Lincoln. Until about 1890 Hay's friendship with Clemens was
                     was lukewarm, kept up mostly through mutual friends, but their relationship
                     changed in 1898, when Hay became Secretary of State under the McKinley (and
                     later Rossevelt) administration. Despite Clemens's anti-imperialist polemics (and
                     Hay's support for Clemens's foe Theodore Roosevelt), their affection for each other
                     remained solid until Hay's death in 1905 (see <a href="http://www.marktwainproject.org/xtf/view?docId=works/MTDP10362.xml;chunk.id=d1e9201;toc.depth=1;toc.id=;citations=;style=work;brand=mtp#X"
                     title="">
                     <span class="italic">AutoMT1</span>, pp.222-24</a>). In a 27 August 1907
                     autobiographical dictation Clemens reminisced, "Hay was a man of great and varied
                     talents and accomplishments, and was conspicuously well equipped for the
                     several great national and international posts which he had filled in his
                     brilliant career; and he climbed to several of them without the help of wealth,
                     and would doubtless have climbed the rest of the way without that help, and all
                     the public would have approved, and would also have affectionately applauded
                     and rejoiced" (<a href="http://www.marktwainproject.org/xtf/view?docId=works/MTDP10364.xml;query=%22john%20hay%22;chunk.id=dv0028;toc.depth=1;toc.id=;citations=;style=work;brand=mtp#3"
                     title="">
                     <span class="italic">AutoMT3</span>, p. 112</a>).</p>
                  </span>
         </td>
         <td>John Milton Hay</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41996.html">UCLC41996</a>
         </td>
         <td>VW</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Waring, Virginia "
               content=""
               data-original-title="test">Waring, Virginia </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">The first wife of Col. George E. Waring, Jr., and mother of Effie, Virginia Waring died in 1891 in Newport, R.I. (Newport <span class="italic:">Mercury</span>, 12 Dec 1891, 1).</p>
            </span>
         </td>
         <td>Virginia Waring</td>
         <td>1884-04-02</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41853.html">UCLC41853</a>
         </td>
         <td>CYB</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Beach, Charles Yale"
               content=""
               data-original-title="test">Beach, Charles Yale</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Charles Beach, a real estate investor, was the son of Moses Beach, and older
                     brother of Emma Beach.</p>
                  </span>
         </td>
         <td>Charles Yale  Beach</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41973.html">UCLC41973</a>
         </td>
         <td>SSC</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Conant, Stillman S."
               content=""
               data-original-title="test">Conant, Stillman S.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Stillman S. Conant was a journalist who contributed to several prominent
                     periodicals of the day, including the <span class="italic">Galaxy</span>, to which
                     Clemens also contributed. He also translated into English (from a German
                     translation) Mikhail Lermontov's poem <span class="italic">The Circassian Boy</span>
                     (Boston: James R. Osgood and Co., 1875). In 1869 he became the managing editor
                     of <span class="italic">Harper's Weekly</span>, a position he held until 1885, when
                     he disappeared off the coast of Coney Island. In 1890 the New York <span class="italic">Times</span> reported the discovery of a skeleton in the dunes
                     near Rockaway Beach that was believed to be Conant, but that was never verified
                     ("A Skeleton in the Dunes. The Disappearance of Stillman S. Conant Recalled,"
                     New York <span class="italic">Times</span>, 14 December 1890, 8).</p>
                  </span>
         </td>
         <td>Stillman S.  Conant</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41847.html">UCLC41847</a>
         </td>
         <td>DS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Sage, Dean "
               content=""
               data-original-title="test">Sage, Dean </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Dean Sage, son of businessman Henry W. Sage, graduated from Albany Law School in 1861, but chose to work in his father's lumber business in Albany. His father was a close friend of the Beecher family, and a longtime member and Trustee of the Plymouth Church. Sage had moved back to Brooklyn from Albany by the time he wrote this April Fool letter to Clemens. He was an avid sportsman who enjoyed writing and collecting books on angling. He died at a fishing camp in Canada in 1902.</p>
            </span>
         </td>
         <td>Dean Sage</td>
         <td>1884-03-30</td>
         <td>30 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41967.html">UCLC41967</a>
         </td>
         <td>EMM</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title=",  "
               content=""
               data-original-title="test">,  </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Elizabeth Greely Merrill, the daughter of Rev. Horatio Merrill of Springfield, Mass, married artist Frank D. Millet in Paris in 1879, with SLC as best man and sculptor Augustus Saint Gaudens as witness. In 1885 the Millets moved to Broadway, a small village in Worcestershire, which had become an artists' colony attracting the likes of William Morris, John Singer Sargent, and Edward Burne-Jones. </p>
            </span>
         </td>
         <td>Elizabeth (Lily) Millet</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41874.html">UCLC41874</a>
         </td>
         <td>JEG</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Gowen, John E."
               content=""
               data-original-title="test">Gowen, John E.</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Colonel John Gowen was an engineer and invester who defined his career by raising the Russian fleet of more than seventy ships after they were sunk at Sevastopol during the Crimean War. He was also an early member of the Lotos Club.</p>
                  </span>
         </td>
         <td>John E.  Gowen</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41994.html">UCLC41994</a>
         </td>
         <td>GWS</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Sheldon, George William"
               content=""
               data-original-title="test">Sheldon, George William</a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">George William Sheldon, art critic and author, graduated from Princeton University in 1863, and spent a year working as a medic in the Union army. He worked as an instructor of languages and literature for a decade at Princeton and then at Union Theological Seminary. From 1876 to 1882 he was an art critic for the New York <span class="italic">Evening Post</span>, and from 1884 to 1886 the dramatic critic of the New York <span class="italic">Commercial Advertiser</span>. He held a concurrent post on the staff of Appleton &amp; Co., for whom he wrote elaborately illustrated art books such as <span class="italic">American Painters</span> (1879), <span class="italic">Hours with Art and Artists</span> (1882), and <span class="italic">Artistic Homes</span> (1882). A year after the April Fool episode, an unsolicited $300 subscription to the latter was a great cause of consternation to Clemens (see SLC's letters to OLC and CLW, 5 Feb 1885).</p>
            </span>
         </td>
         <td>George W. Sheldon</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41868.html">UCLC41868</a>
         </td>
         <td>MFF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Fox Fiske, Mary Hewins"
               content=""
               data-original-title="test">Fox Fiske, Mary Hewins</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Mary Fiske, a Hartford native, wrote plays and drama criticism under the nom de plume "Giddy Gusher." She married the journalist and dramatist Stephen Fiske in 1875.</p>
                  </span>
         </td>
         <td>Mary Fiske</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41851.html">UCLC41851</a>
         </td>
         <td>TBA</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Aldrich, Thomas Bailey"
               content=""
               data-original-title="test">Aldrich, Thomas Bailey</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Thomas Bailey Aldrich met Clemens in 1871. He was best known for his poems and
                        stories about New Hampshire, where he was born and raised, including his novel <span class="italic">The Story of a Bad Boy</span>, which was a forerunner for <span class="italic">Tom Sawyer</span>. He served on the
                     editorial staff of the <span class="italic">Evening Mirror</span>, <span class="italic">Home Journal</span>, and <span class="italic">Saturday Press</span>. From 1861
                     until 1862 he served as Civil War correspondent for the New York <span class="italic">Tribune</span>. In 1865 he married Lilian Woodman and moved to
                     Boston, where James R. Osgood had offered him the editorship of <span class="italic">Every Saturday</span>, a post he held until 1874. He succeeded
                     William Dean Howells as editor of the <span class="italic">Atlantic Monthly</span> in 1881, a position he
                     retained until 1890. While Clemens was not initially enthusiastic about Aldrich's
                     work, he often provided advice (see his 15 and 16, 24, 25 March 1874 letter
                     suggesting changes in his novel <span class="italic">Prudence Palfrey</span>, <span class="italic">L6</span>, 74–82, 89–95). They remained lifelong
                     friends. In his 1904 sketch “Robert Louis Stevenson and Thomas Bailey Aldrich,”
                     Clemens wrote that Aldrich “never had his peer for prompt and pithy and witty
                     and humorous sayings” (<a href="http://www.marktwainproject.org/xtf/view?docId=works/MTDP10362.xml;doc.view=;chunk.id=d1e9377;toc.id=0;style=work;brand=mtp"
                     title="">
                     <span class="italic">AutoMT1</span>, 229</a>, 539 n.
                     229.8).</p>
                  </span>
         </td>
         <td>Thomas Bailey  Aldrich</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41988.html">UCLC41988</a>
         </td>
         <td>SRF</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Fiske, Stephen Ryder"
               content=""
               data-original-title="test">Fiske, Stephen Ryder</a>
            <span class="hide popper-content">
                     <p xmlns="http://www.w3.org/1999/xhtml">Fiske was a journalist, drama critic, and theater manager who started his career working for the New York <span class="italic">Herald</span>. After the Civil War he lived in Rome, where he joined Garibaldi, and then lived in London, where he became the manager of the Royal English Opera Company. Returning to New York in 1874, he managed the Fifth Avenue Theatre in New York (where Madame Modjeska mad her famous debut), contributed dramatic criticism to <span class="italic">The Spirit of the Times</span>, and started the <span class="italic">New York Dramatic Mirror</span>. He was also known for several plays, including <span class="italic">Corporeal Cartouche</span>, <span class="italic">Martin Chuzzlewit</span>, and <span class="italic">My Noble Son-in-Law</span>. He was a noted member of Pfaff's cellar, having established himself during the Civil War as a "Pfaff's bohemian."</p>
                  </span>
         </td>
         <td>Stephen Ryder  Fiske</td>
         <td>1884-04-01</td>
         <td>1 April 1884</td>
      </tr>
      <tr>
         <td>
            <a href="UCLC41971.html">UCLC41971</a>
         </td>
         <td>NBP</td>
         <td>
            <a class="popper"
               data-toggle="popover"
               title="Pond Brown, Nella "
               content=""
               data-original-title="test">Pond Brown, Nella </a>
            <span class="hide popper-content">
               <p xmlns="http://www.w3.org/1999/xhtml">Nella Brown Pond was a dramatic reader, and wife of Ozias W. Pond. Despite early success with the Park Dramatic Company in Boston, she chose not to pursue a life on the stage, but channelled her dramatic talents into the platform by joining James Redpath's Lyceum company.</p>
            </span>
         </td>
         <td>Nella Brown Pond</td>
         <td>1884-03-31</td>
         <td>31 March 1884</td>
      </tr>
   </tbody>
</table>



    
  </xsl:template>
  
</xsl:stylesheet>