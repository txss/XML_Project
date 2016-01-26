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
	    <body style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
	    <h2>Le Master</h2>
	     	<xsl:call-template name="listerParcours" />
	     	<xsl:call-template name="listerUE" /> 
	     	<xsl:call-template name="listerIntervenant" />
	     	
	    </body>
    </html>
  </xsl:template>

  <xsl:template name="listerParcours">
    <xsl:for-each select="/master/parcours">
      <p>
	  		<h2><xsl:value-of select = "nomParcours" /> </h2> <br/>
	  		Responsable : <xsl:value-of select = "responsable" />    <br/>
	  		Description : <xsl:value-of select = "description" />   <br/>
	  		Débouché : <xsl:value-of select = "débouché" />     <br/>
      </p>
      
      <xsl:for-each select="semestre">
         <div>
            <xsl:for-each select="bloc-UE">
              <h3><xsl:value-of select="@rôle" /> : nombre de crédits à choisir : <xsl:value-of select="nbCreditsBloc" /> </h3>
              <xsl:for-each select="refUE" >
    			<xsl:variable name="referenceUE" select="@refUE" />
    				<li>
    		   			<a href="#{$referenceUE}"><xsl:value-of select="//UE[@id=$referenceUE]/nomUE" /> (<xsl:value-of select="//UE[@id=$referenceUE]/nbCreditsUE" /> crédits)</a>
    				</li>
    		  </xsl:for-each>
            </xsl:for-each>
         </div>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>


  <xsl:template name="listerUE">
  	<h2>Liste des matières</h2>
  	
  	<xsl:for-each select="UE">
  		<div style="border:solid 1px black; margin: 1px; padding-left:5%;">
  		<xsl:variable name="idUECourant" select="@id" />
  		<h3 id="{$idUECourant}"><xsl:value-of select="nomUE"/></h3>
  		<ul>
    	<xsl:for-each select="ref-intervenant" >
    		<xsl:variable name="idIntervenant" select="@ref" />
    		<li>
    		    <a href="#{$idIntervenant}"><xsl:value-of select="//intervenant[@id=$idIntervenant]/nomIntervenant" /> 
    		    </a>
    		</li>
    	</xsl:for-each>
    	
    	<p>Cette matière compte pour <xsl:value-of select="nbCreditsUE"/> crédits.</p>
   		<p>Lieu d'enseignement:</p>
    	<ul>
    		<xsl:for-each select="lieu_d_enseignement">
    			<li><xsl:value-of select="."/></li>
    		</xsl:for-each>
    	</ul>
    </ul>
    </div>
  	</xsl:for-each>
  </xsl:template>


  <xsl:template name="listerIntervenant">
  	<h2>Intervenants du master</h2>
  	<ul>
  	<xsl:for-each select="/master/intervenant">
  		<xsl:variable name="idIntervenantCourant" select="@id" />
  		<li>
  			<p id="{$idIntervenantCourant}">
  			<xsl:value-of select="nomIntervenant"/> <br/>
  			<xsl:value-of select="mail"/> <br/>
  			<xsl:value-of select="siteWeb"/> <br/>
  			</p> 			
  		</li>
  	</xsl:for-each>
    </ul>
  </xsl:template>
  
  
  <xsl:template match="ref-intervenant">
  	<li>
  		<xsl:value-of select="."/>
  	</li>
  </xsl:template>



</xsl:stylesheet>