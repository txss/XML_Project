all: clean dtd xsd web tidy xq java

clean:
	rm -rf www/
	rm -f *.class

dtd:
	xmllint --noout --valid donnesFinales_dtd.xml 
	
xsd:
	xmllint --noout --schema master.xsd donnesFinales_schema.xml
	
web:
	xsltproc master.xsl donnesFinales_schema.xml
	
tidy:
	tidy -im -utf8 www/*.html
	 
xq:
	 java -cp saxon/saxon9he.jar net.sf.saxon.Query indent=no xq.txt > www/xq.xhtml
	
java:  
	javac ExtraireListeUE.java
	java ExtraireListeUE
