<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

 <xsl:output method="html" encoding="UTF-8"/>

  <xsl:template match="master">
    <html>
    <head>
	  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	  <title>tp3</title> 
  	</head>
    <body>
    	<ul>
     		<xsl:apply-templates/>
        </ul>
    </body></html>
  </xsl:template>

  <xsl:template match="UE">
    Matiére <xsl:value-of select="UE"/>
    <xsl:apply-templates select="unite"/>
  </xsl:template>

  <xsl:template match="unite">
    <h2 style="color:blue;">Matiére <xsl:value-of select="nomUE"/></h2>
   
  </xsl:template>


</xsl:stylesheet>