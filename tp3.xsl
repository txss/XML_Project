<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

 <xsl:output method="html" encoding="UTF-8"/>



  <xsl:template match="/master">
    <html>
	    <head>
		  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		  <title>tp3</title> 
	  	</head>
	    <body>
	     	<xsl:apply-templates/>
	    </body>
    </html>
  </xsl:template>



  <xsl:template match="UE">
    <h2>Matiére <xsl:value-of select="nomUE"/></h2>
    <ul>
    	<xsl:apply-templates select="ref-intervenant"/>
    </ul>
    <p>Cette matiére compte pour <xsl:value-of select="nbCreditsUE"/> crédits.</p>
    <p>Lieu d'enseignement:</p>
    <ul>
    	<xsl:apply-templates select="lieu_d_enseignement"/>
    </ul>
  </xsl:template>



  <xsl:template match="ref-intervenant">
  	<li>
  		<xsl:value-of select="."/>
  	</li>
  </xsl:template>



  <xsl:template match="lieu_d_enseignement">
   	<li>
  		+ <xsl:value-of select="."/>
  	</li>
  </xsl:template>



</xsl:stylesheet>