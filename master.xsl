<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:output method="html" encoding="UTF-8" />

	<xsl:key name="UEenParticulier" match="//UE" use="@id" />



	<xsl:template name="head-page-web">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="stylesheet" type="text/css" href="../src/nice.css" />
			<link rel="stylesheet" type="text/css" href="../src/forme.css" />
			<title>Master Informatique</title>
		</head>
	</xsl:template>


	<xsl:template name="menu-page-web">
		<div id="entete">Master Informatique:</div>
		<ul id="menu">
			<li>
				<a href="index.html"> Accueil </a>
			</li>
			<li>
				<a href="listeEnseignants.html"> Les enseignants </a>
			</li>
			<li>
				<a href="listeUE.html"> Les unités d'enseignements </a>
			</li>
		</ul>
	</xsl:template>


	<xsl:template name="pied-page-web">
		<div id="pied">Fait par Campanella Florian et Manon Scholivet</div>
	</xsl:template>


	<xsl:template match="/master">
		<xsl:document href="www/index.html">
			<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
			<html>
				<xsl:call-template name="head-page-web" />
				<body>
					<div id="global">
						<xsl:call-template name="menu-page-web" />
						<div id="contenu">
							<h2>Le Master</h2>
							<xsl:call-template name="listerParcours" />
						</div>
					</div>
					<xsl:call-template name="pied-page-web" />
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
				<xsl:variable name="nom" select="nom" />
				<li>
					<a href="{@id}.html">
						<xsl:value-of select="nom" />
					</a>
				</li>
				<xsl:document href="{@id}.html">
					<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
					<html>
						<xsl:call-template name="head-page-web" />
						<body>
							<div id="global">
								<xsl:call-template name="menu-page-web" />
								<div id="contenu">
									<div>
										<h2>
											<xsl:value-of select="nom" />
										</h2>
										<br />
										<xsl:variable name="resp" select="responsable" />
										<xsl:variable name="idresp" select="//intervenant[nom = $resp]" />
										Responsable :
										<a href="{$idresp/@id}.html">
											<xsl:value-of select="responsable" />
										</a>
										<br />
										Description :
										<xsl:value-of select="description" />
										<xsl:if test="débouché">
											<br />
											Débouché :
											<xsl:value-of select="débouché" />
										</xsl:if>
										<br />
										<xsl:for-each select="semestre">
											<div>
												<xsl:for-each select="bloc-UE">
													<h3>
														<xsl:value-of select="@rôle" />
														&#160;
														<xsl:if test="nbCreditsBloc">
															<xsl:value-of select="nbCreditsBloc" />
															crédits
														</xsl:if>
													</h3>
													<div class="afficherParcours">
														<xsl:if test="refUE">
															<ul>
																<xsl:for-each select="refUE">
																	<xsl:variable name="referenceUE" select="@refUE" />
																	<li>
																		<a href="{$referenceUE}.html">
																			<xsl:value-of
																				select="key('UEenParticulier',$referenceUE)/nom" />
																			(
																			<xsl:value-of
																				select="key('UEenParticulier',$referenceUE)/nbCreditsUE" />
																			crédits)
																		</a>
																	</li>
																</xsl:for-each>
															</ul>
														</xsl:if>
													</div>
												</xsl:for-each>
											</div>
										</xsl:for-each>
									</div>
								</div>
							</div>
							<xsl:call-template name="pied-page-web" />
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
				<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
				<html>
					<xsl:call-template name="head-page-web" />
					<body>
						<div id="global">
							<xsl:call-template name="menu-page-web" />
							<div id="contenu">
								<div class="box">
									<h3 id="{$idUECourant}">
										<xsl:value-of select="nom" />
									</h3>
									<xsl:if test="ref-intervenant">
										<ul>
											<xsl:for-each select="ref-intervenant">
												<xsl:variable name="idIntervenant" select="@ref" />
												<li>
													<a href="{$idIntervenant}.html">
														<xsl:value-of select="//intervenant[@id=$idIntervenant]/nom" />
													</a>
												</li>
											</xsl:for-each>
										</ul>
									</xsl:if>
									<p>
										Cette matière compte pour
										<xsl:value-of select="nbCreditsUE" />
										crédits.
									</p>
									<xsl:if test="lieu_d_enseignement">
										<p>Lieu d'enseignement:</p>
										<ul>
											<xsl:for-each select="lieu_d_enseignement">
												<li>
													<xsl:apply-templates />
												</li>
											</xsl:for-each>
										</ul>
									</xsl:if>
									<xsl:if
										test="//parcours/semestre/bloc-UE/refUE[@refUE=$idUECourant]">
										<p>Cette UE apparaît dans le(s) parcours : </p>
										<ul>
											<xsl:for-each select="//parcours">
												<xsl:variable name="nom" select="nom" />
												<xsl:variable name="idParcours" select="@id" />
												<xsl:for-each select="semestre/bloc-UE/refUE[@refUE=$idUECourant]">
													<li>
														<a href="{$idParcours}.html">
															<xsl:value-of select="$nom" />
														</a>
													</li>
												</xsl:for-each>
											</xsl:for-each>
										</ul>
									</xsl:if>
								</div>
							</div>
						</div>
						<xsl:call-template name="pied-page-web" />
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="menu-lister-UEs">
		<ul id="breadcrumb">
			<li>
				<a href="listeDe3Credits.html">
					UEs de 3 Crédits
					<xsl:call-template name="lister-selon-nbCredits">
						<xsl:with-param name="nbCredits" select="3" />
					</xsl:call-template>
				</a>
			</li>
			<li>
				<a href="listeDe6Credits.html">
					UEs de 6 Crédits
					<xsl:call-template name="lister-selon-nbCredits">
						<xsl:with-param name="nbCredits" select="6" />
					</xsl:call-template>
				</a>
			</li>
		</ul>
	</xsl:template>


	<xsl:template name="listerUE">
		<xsl:document href="www/listeUE.html">
			<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
			<html>
				<xsl:call-template name="head-page-web" />
				<body>
					<div id="global">
						<xsl:call-template name="menu-page-web" />
						<div id="contenu">
							<xsl:call-template name="menu-lister-UEs" />
							<h2>Liste des matières</h2>
							<xsl:for-each select="UE">
								<div class="box">
									<xsl:variable name="idUECourant" select="@id" />
									<a href="{$idUECourant}.html">
										<xsl:value-of select="nom" />
									</a>
									<xsl:if test="ref-intervenant">
										<ul>
											<xsl:for-each select="ref-intervenant">
												<xsl:variable name="idIntervenant" select="@ref" />
												<li>
													<a href="{$idIntervenant}.html">
														<xsl:value-of select="//intervenant[@id=$idIntervenant]/nom" />
													</a>
												</li>
											</xsl:for-each>
										</ul>
									</xsl:if>
									<p>
										Cette matière compte pour
										<xsl:value-of select="nbCreditsUE" />
										crédits.
									</p>
									<xsl:if test="lieu_d_enseignement">
										<p>Lieu d'enseignement:</p>
										<ul>
											<xsl:for-each select="lieu_d_enseignement">
												<li>
													<xsl:apply-templates />
												</li>
											</xsl:for-each>
										</ul>
									</xsl:if>
									<xsl:if
										test="//parcours/semestre/bloc-UE/refUE[@refUE=$idUECourant]">
										<p>Cette UE apparaît dans le(s) parcours : </p>
										<ul>
											<xsl:for-each select="//parcours">
												<xsl:variable name="nom" select="nom" />
												<xsl:variable name="idParcours" select="@id" />
												<xsl:for-each select="semestre/bloc-UE/refUE[@refUE=$idUECourant]">
													<li>
														<a href="{$idParcours}.html">
															<xsl:value-of select="$nom" />
														</a>
													</li>
												</xsl:for-each>
											</xsl:for-each>
										</ul>
									</xsl:if>
								</div>
							</xsl:for-each>
						</div>
					</div>
					<xsl:call-template name="pied-page-web" />
				</body>
			</html>
		</xsl:document>
	</xsl:template>


	<xsl:template name="AfficherIntervenant">
		<!-- <h2>Intervenants du master</h2> <ul> -->
		<xsl:for-each select="/master/intervenant">
			<xsl:variable name="idIntervenantCourant" select="@id" />
			<xsl:variable name="siteWebIntervenant" select="siteWeb" />
			<xsl:variable name="nomIntervenant" select="nom" />
			<xsl:document href="www/{$idIntervenantCourant}.html">
				<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
				<html>
					<xsl:call-template name="head-page-web" />
					<body>
						<div id="global">
							<xsl:call-template name="menu-page-web" />
							<div id="contenu">
								<div class="box">
									<xsl:value-of select="nom" />
									<br />
									<xsl:value-of select="mail" />
									<br />
									<xsl:if test="siteWeb">
										<a href="{$siteWebIntervenant}"> Site perso </a>
										<br />
									</xsl:if>
									<br />
									<xsl:if test="infoComplementaire">
										Infos complémentaires :
										<ul>
											<xsl:for-each select="infoComplementaire">
												<xsl:call-template name="infoComplementaire" />
											</xsl:for-each>
										</ul>
									</xsl:if>
									<xsl:if test="//UE/ref-intervenant[@ref = $idIntervenantCourant]">
										UE enseignée(s):
										<ul>
											<xsl:for-each select="//UE">
												<xsl:variable name="UECourante" select="@id" />
												<xsl:variable name="nomUECourante" select="nom" />
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
									</xsl:if>
									<xsl:for-each select="//parcours">
										<xsl:variable name="nomResp" select="responsable" />
										<xsl:variable name="nomParcours" select="nom" />
										<xsl:if test="$nomIntervenant = $nomResp">
											Cet enseignant est responsable du/des parcours:
											<a href="{@id}.html">
												<xsl:value-of select="$nomParcours" />
											</a>
										</xsl:if>
									</xsl:for-each>
								</div>
							</div>
						</div>
						<xsl:call-template name="pied-page-web" />
					</body>
				</html>
			</xsl:document>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="listerIntervenant">
		<xsl:document href="www/listeEnseignants.html">
			<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
			<html>
				<xsl:call-template name="head-page-web" />
				<body>
					<div id="global">
						<xsl:call-template name="menu-page-web" />
						<div id="contenu">
							<xsl:call-template name="faire-une-liste">
								<xsl:with-param name="objets" select="//intervenant" />
								<xsl:with-param name="nom" select="'intervenants'" />
							</xsl:call-template>
						</div>
					</div>
					<xsl:call-template name="pied-page-web" />
				</body>
			</html>
		</xsl:document>
	</xsl:template>


	<xsl:template name="lister-selon-nbCredits">
		<xsl:param name="nbCredits" />
		<xsl:document href="listeDe{$nbCredits}Credits.html">
			<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
			<html>
				<xsl:call-template name="head-page-web" />
				<body>
					<div id="global">
						<xsl:call-template name="menu-page-web" />
						<div id="contenu">
							<a href="listeUE.html">
								Toutes les UEs
							</a>
							<xsl:call-template name="faire-une-liste">
								<xsl:with-param name="objets"
									select="//UE[nbCreditsUE=$nbCredits]" />
								<xsl:with-param name="nom" select="'UE correspondantes:'" />
							</xsl:call-template>
						</div>
					</div>
					<xsl:call-template name="pied-page-web" />
				</body>
			</html>
		</xsl:document>
	</xsl:template>


	<xsl:template name="faire-une-liste">
		<xsl:param name="objets" />
		<xsl:param name="nom" />
		<h2>
			Liste des
			<xsl:value-of select="$nom" />
		</h2>
		<ul>
			<xsl:for-each select="$objets">
				<xsl:sort select="nom" />
				<xsl:variable name="idObjets" select="@id" />
				<li>
					<a href="{$idObjets}.html">
						<xsl:value-of select="current()/*[1]" />
					</a>
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


	<xsl:template name="infoComplementaire">
		<li>
			<xsl:value-of select="@typeInfo" />
			:
			<xsl:value-of select="." />
		</li>
	</xsl:template>

</xsl:stylesheet>
