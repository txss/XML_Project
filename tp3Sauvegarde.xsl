<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:output method="html" encoding="UTF-8" />



	<xsl:template match="/master">
		<xsl:document href="www/index.html">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title>tp3++</title>
				</head>
				<body
					style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
					<ul
						style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
						<li style="display:inline; margin-right: 20px;">
							<a href="index.html"> Accueil </a>
						</li>
						<li style="display:inline; margin-right: 20px;">
							<a href="listeEnseignants.html"> Les enseignants </a>
						</li>
						<li style="display:inline;">
							<a href="listeUE.html"> Les unités d'enseignements </a>
						</li>
					</ul>
					<h2 style="margin-top:50px;">Le Master</h2>
					<xsl:call-template name="listerParcours" />
					
				</body>
			</html>
		</xsl:document>
		<xsl:call-template name="AfficherUE" />
		<xsl:call-template name="AfficherIntervenant" />
		<xsl:call-template name="listerUE" />
		<xsl:call-template name="listerIntervenant" />
	</xsl:template>


	<xsl:template name="listerParcours">
		<h1>Les parcours proposés:</h1>
		<ul>
			<xsl:for-each select="/master/parcours">
				<xsl:variable name="nomParcours" select="nomParcours" />
				<li>
					<a href="{$nomParcours}.html">
						<xsl:value-of select="nomParcours" />
					</a>
				</li>
				<xsl:document href="{$nomParcours}.html">
					<html>
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
							<title>tp3++</title>
						</head>
						<body
							style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
							<ul
								style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
								<li style="display:inline; margin-right: 20px;">
									<a href="index.html"> Accueil </a>
								</li>
								<li style="display:inline; margin-right: 20px;">
									<a href="listeEnseignants.html"> Les enseignants </a>
								</li>
								<li style="display:inline;">
									<a href="listeUE.html"> Les unités d'enseignements </a>
								</li>
							</ul>
							<div
								style="border:solid 1px black; margin: 1px; padding-left:5%; margin-top:50px; margin-top:50px; padding-bottom:50px;">
								<p>
									<h2>
										<xsl:value-of select="nomParcours" />
									</h2>
									<br />
									Responsable :
									<xsl:value-of select="responsable" />
									<br />
									Description :
									<xsl:value-of select="description" />
									<br />
									Débouché :
									<xsl:value-of select="débouché" />
									<br />
								</p>

								<xsl:for-each select="semestre">
									<div>
										<xsl:for-each select="bloc-UE">
											<h3>
												<xsl:value-of select="@rôle" />
												: nombre de crédits à choisir :
												<xsl:value-of select="nbCreditsBloc" />
											</h3>
											<xsl:for-each select="refUE">
												<xsl:variable name="referenceUE" select="@refUE" />
												<li>
													<a href="{$referenceUE}.html">
														<xsl:value-of select="//UE[@id=$referenceUE]/nomUE" />
														(
														<xsl:value-of select="//UE[@id=$referenceUE]/nbCreditsUE" />
														crédits)
													</a>
												</li>
											</xsl:for-each>
										</xsl:for-each>
									</div>
								</xsl:for-each>
							</div>
						</body>
					</html>
				</xsl:document>
			</xsl:for-each>
		</ul>
	</xsl:template>


	<xsl:template name="AfficherUE">
		<xsl:for-each select="UE">
			<xsl:variable name="idUECourant" select="@id" />
			<xsl:document href="www/{$idUECourant}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title>tp3++</title>
					</head>
					<body
						style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
						<ul
							style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
							<li style="display:inline; margin-right: 20px;">
								<a href="index.html"> Accueil </a>
							</li>
							<li style="display:inline; margin-right: 20px;">
								<a href="listeEnseignants.html"> Les enseignants </a>
							</li>
							<li style="display:inline;">
								<a href="listeUE.html"> Les unités d'enseignements </a>
							</li>
						</ul>
						<div
							style="border:solid 1px black; margin: 1px; padding-left:5%; margin-top:50px; margin-top:50px;">
							<h3 id="{$idUECourant}">
								<xsl:value-of select="nomUE" />
							</h3>
							<ul>
								<xsl:for-each select="ref-intervenant">
									<xsl:variable name="idIntervenant" select="@ref" />
									<li>
										<a href="{$idIntervenant}.html">
											<xsl:value-of
												select="//intervenant[@id=$idIntervenant]/nomIntervenant" />
										</a>
									</li>
								</xsl:for-each>

								<p>
									Cette matière compte pour
									<xsl:value-of select="nbCreditsUE" />
									crédits.
								</p>
								<p>Lieu d'enseignement:</p>
								<ul>
									<xsl:for-each select="lieu_d_enseignement">
										<li>
											<xsl:apply-templates />
										</li>
									</xsl:for-each>
								</ul>
								<p>Cette UE apparaît dans le(s) parcours : </p>
								<ul>
									<xsl:for-each select="//parcours">
										<xsl:variable name="nomParcours" select="nomParcours" />
										<xsl:for-each select="semestre/bloc-UE/refUE[@refUE=$idUECourant]">

											<li>
												<a href="{$nomParcours}.html">
													<xsl:value-of select="$nomParcours" />
												</a>
											</li>
										</xsl:for-each>
									</xsl:for-each>
								</ul>
							</ul>
						</div>
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="listerUE">
		<xsl:document href="www/listeUE.html">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title>tp3++</title>
				</head>
				<body
					style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
					<ul
						style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
						<li style="display:inline; margin-right: 20px;">
							<a href="index.html"> Accueil </a>
						</li>
						<li style="display:inline; margin-right: 20px;">
							<a href="listeEnseignants.html"> Les enseignants </a>
						</li>
						<li style="display:inline;">
							<a href="listeUE.html"> Les unités d'enseignements </a>
						</li>
					</ul>

					<h2 style="margin-top:50px;">Liste des matières</h2>

					<xsl:for-each select="UE">
						<div style="border:solid 1px black; margin: 1px; padding-left:5%;">
							<xsl:variable name="idUECourant" select="@id" />
							<a href="{$idUECourant}.html">
								<xsl:value-of select="nomUE" />
							</a>
							<ul>
								<xsl:for-each select="ref-intervenant">
									<xsl:variable name="idIntervenant" select="@ref" />
									<li>
										<a href="{$idIntervenant}.html">
											<xsl:value-of
												select="//intervenant[@id=$idIntervenant]/nomIntervenant" />
										</a>
									</li>
								</xsl:for-each>

								<p>
									Cette matière compte pour
									<xsl:value-of select="nbCreditsUE" />
									crédits.
								</p>
								<p>Lieu d'enseignement:</p>
								<ul>
									<xsl:for-each select="lieu_d_enseignement">
										<li>
											<xsl:apply-templates />
										</li>
									</xsl:for-each>
								</ul>
								<p>Cette UE apparaît dans le(s) parcours : </p>
								<ul>
									<xsl:for-each select="//parcours">
										<xsl:variable name="nomParcours" select="nomParcours" />
										<xsl:for-each select="semestre/bloc-UE/refUE[@refUE=$idUECourant]">

											<li>
												<a href="{$nomParcours}.html">
													<xsl:value-of select="$nomParcours" />
												</a>
											</li>
										</xsl:for-each>
									</xsl:for-each>
								</ul>
							</ul>
						</div>
					</xsl:for-each>
				</body>
			</html>
		</xsl:document>
	</xsl:template>


	<xsl:template name="AfficherIntervenant">
		<!-- <h2>Intervenants du master</h2> <ul> -->
		<xsl:for-each select="/master/intervenant">
			<xsl:variable name="idIntervenantCourant" select="@id" />
			<xsl:variable name="siteWebIntervenant" select="siteWeb" />
			<xsl:variable name="nomIntervenant" select="nomIntervenant" />
			<xsl:document href="www/{$idIntervenantCourant}.html">
				<html>
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
						<title>tp3</title>
					</head>
					<body
						style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
						<ul
							style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
							<li style="display:inline; margin-right: 20px;">
								<a href="index.html"> Accueil </a>
							</li>
							<li style="display:inline; margin-right: 20px;">
								<a href="listeEnseignants.html"> Les enseignants </a>
							</li>
							<li style="display:inline;">
								<a href="listeUE.html"> Les unités d'enseignements </a>
							</li>
						</ul>
						<p id="{$idIntervenantCourant}" style="margin-top:50px;">
							<xsl:value-of select="nomIntervenant" />
							<br />
							<xsl:value-of select="mail" />
							<br />
							<xsl:if test="siteWeb">
								<a href="{$siteWebIntervenant}"> Site perso </a>
								<br />
							</xsl:if>
							<br />
							<xsl:apply-templates /> <!-- TODO -->
							<br />
							<br />
							UE enseignée(s):
							<br />
							<ul>
								<xsl:for-each select="//UE">
									<xsl:variable name="UECourante" select="@id" />
									<xsl:variable name="nomUECourante" select="nomUE" />
									<xsl:for-each select="ref-intervenant">
										<xsl:if test="$idIntervenantCourant = @ref">
											<li>
												<a href="{$UECourante}.html">
													<xsl:value-of select="$nomUECourante" />
												</a>
											</li>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</ul>
							<xsl:for-each select="//parcours">
								<xsl:variable name="nomResp" select="responsable" />
								<xsl:variable name="nomParcours" select="nomParcours" />
								<xsl:if test="$nomIntervenant = $nomResp">
									Cet enseignant est responsable du/des parcours:
									<a href="{$nomParcours}.html">
										<xsl:value-of select="$nomParcours" />
									</a>
								</xsl:if>
							</xsl:for-each>
						</p>
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>

	</xsl:template>


	<xsl:template name="listerIntervenant">
		<xsl:document href="www/listeEnseignants.html">
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<title>tp3</title>
				</head>
				<body
					style="background-image: url('http://www.unesourisetmoi.info/data/images/photos/164/fond-d-ecran-ordinateur-gratuit_1.jpg'); background-repeat: no-repeat; background-attachment:fixed; ">
					<ul
						style="position:fixed; top: 0px; display: inline; background: white; padding-bottom: 10px;padding-right: 10px;">
						<li style="display:inline; margin-right: 20px;">
							<a href="index.html"> Accueil </a>
						</li>
						<li style="display:inline; margin-right: 20px;">
							<a href="listeEnseignants.html"> Les enseignants </a>
						</li>
						<li style="display:inline;">
							<a href="listeUE.html"> Les unités d'enseignements </a>
						</li>
					</ul>
					<xsl:call-template name="faire-une-liste">
						<xsl:with-param name="objets" select="//intervenant"/>
						<xsl:with-param name="nom" select="'intervenants'" />
					</xsl:call-template>
				</body>
			</html>
		</xsl:document>
	</xsl:template>


	<xsl:template name="faire-une-liste">
		<xsl:param name="objets" />
		<xsl:param name="nom" />
		<h2 style="margin-top:50px;">Liste de <xsl:value-of select="$nom" /> </h2>
		<ul>
			<xsl:for-each select="$objets">
				<xsl:variable name="idObjets" select="@id"/>
				<li>
					<a href="{$idObjets}.html"><xsl:value-of select="current()/*[1]"/></a>
				</li>
			</xsl:for-each>
		</ul>

	</xsl:template>


	<xsl:template match="ref-intervenant">
		<li>
			<xsl:value-of select="." />
		</li>
	</xsl:template>

	<xsl:template match="Luminy">
		Luminy
	</xsl:template>

	<xsl:template match="St-Jerôme">
		St-Jerôme
	</xsl:template>


	<xsl:template match="any">
		Infos complémentaires:
		<br />
		<xsl:value-of select="." />
	</xsl:template>

</xsl:stylesheet>