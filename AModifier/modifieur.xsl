<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:template match="/">
		<!-- <!DOCTYPE master> -->
		<master xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:noNamespaceSchemaLocation="master.xsd">

			<xsl:call-template name="listerIntervenant" />
			<xsl:call-template name="listerUE" />
			<xsl:call-template name="listerParcours" />


		</master>
	</xsl:template>

	<xsl:template name="listerIntervenant">
		<xsl:for-each select="//objet[@type = 'personne']">
			<intervenant id="{@id}">
				<nom>
					<xsl:value-of select="info[@nom = 'nom']/@value" />&#160;<xsl:value-of select="info[@nom = 'prenom']/@value" />
				</nom>
				<mail>
					<xsl:value-of select="info[@nom = 'mail']/@value" />
				</mail>
			</intervenant>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="listerParcours">
		<xsl:for-each select="//objet[@type = 'programme']">
			<xsl:variable name="idResp" select="info[@nom='responsables']/@value" />
			<xsl:variable name="nomResp"
				select="//objet[@id = $idResp]/info[@nom='nom']/@value" />
			<xsl:variable name="prenomResp"
				select="//objet[@id = $idResp]/info[@nom='prenom']/@value" />
			<xsl:variable name="objectifs" select="info[@nom='objectifs']/@value" />

			<parcours id="{@id}">
				<nom>
					<xsl:value-of select="info[@nom='nom']/@value" />
				</nom>
				<xsl:if test="$nomResp != ''">
					<responsable>
						<xsl:value-of select="$nomResp" />&#160;<xsl:value-of select="$prenomResp" />
					</responsable>
				</xsl:if>
				<xsl:if test="info[@nom='objectifs']">
					<description>
						<p>
							<xsl:value-of select="info[@nom='objectifs']" />
						</p>
					</description>
				</xsl:if>

				<xsl:for-each select="info[@nom='structure']">
					<semestre>
						<xsl:call-template name="semestre">
							<xsl:with-param name="idSemestre" select="@value" />
						</xsl:call-template>
					</semestre>
				</xsl:for-each>
			</parcours>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="semestre">
		<xsl:param name="idSemestre" />
		<xsl:for-each select="//objet[@id=$idSemestre]/info[@nom='structure']">
			<xsl:variable name="idStructure" select="@value" />
			<xsl:variable name="EnsOuBloc" select="//objet[@id = $idStructure]" />
			<xsl:if test="$EnsOuBloc[@type = 'groupe' or @type = 'option']">
				<bloc-UE rôle="{$EnsOuBloc/info[@nom='nom']/@value}">
					<nbCreditsBloc>
						<xsl:value-of select="$EnsOuBloc/info[@nom='nb_credits']/@value" />
					</nbCreditsBloc>
					<xsl:for-each select="$EnsOuBloc/info[@nom = 'structure']">
						<refUE refUE="{@value}" />
					</xsl:for-each>
				</bloc-UE>
			</xsl:if>
		</xsl:for-each>

		<bloc-UE rôle="Obligatoire">
			<xsl:for-each select="//objet[@id=$idSemestre]/info[@nom='structure']">
				<xsl:variable name="idStructure" select="@value" />
				<xsl:variable name="EnsOuBloc" select="//objet[@id = $idStructure]" />
				<xsl:if test="$EnsOuBloc[@type = 'enseignement']">
					<refUE refUE="{$idStructure}" />
				</xsl:if>
			</xsl:for-each>
		</bloc-UE>
	</xsl:template>

	<xsl:template name="listerUE">
		<xsl:for-each select="//objet[@type = 'enseignement']">
			<UE id="{@id}">
				<nom>
					<xsl:value-of select="info[@nom='nom']/@value" />
				</nom>
				<xsl:for-each select="info[@nom='responsables']">
					<ref-intervenant ref="{@value}" />
				</xsl:for-each>
				<nbCreditsUE>
					<xsl:value-of select="info[@nom='nb_credits']/@value" />
				</nbCreditsUE>
				<résumé>
					<xsl:copy-of select="info[@nom='contenu']/*" />
				</résumé>
			</UE>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>