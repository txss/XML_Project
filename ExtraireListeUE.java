package xml;


import java.io.File;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class CreateDom {


	public static void main(String[] args) throws Exception {
		File xmlFile = new File("donnesFinales.xml");
		//File listeUe = new File("ListeUEs.xml");

		Document donneesXml = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().parse(xmlFile);


		// création d'un document vide
		Document docOutXml = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().newDocument();

		// récupération des données
		NodeList nList = donneesXml.getDocumentElement().getElementsByTagName("UE");
			
		// création de la racine
		Element racine = docOutXml.createElement("UE");

		// Ajout de noeuds contenant les noms des UEs récupérer 
		for (int i = 0; i < nList.getLength(); i++) {
			Node nNode = nList.item(i);
			Node ue = racine.appendChild(docOutXml.createElement("nomUE"));
			ue.appendChild(docOutXml.createTextNode(((Element) nNode)
					.getElementsByTagName("nomUE").item(0).getTextContent()));
		}

		docOutXml.appendChild(racine);

		// Serialization
		TransformerFactory myFactory = TransformerFactory.newInstance();
		Transformer transformer = myFactory.newTransformer();

		transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		transformer.setOutputProperty(OutputKeys.METHOD, "xml");
		transformer.transform(new DOMSource(docOutXml), new StreamResult(System.out));
		
		//transformer.transform(new DOMSource(docOutXml), new StreamResult(listeUe));
	}
}