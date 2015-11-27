adoc_pdf:$(outsrc).adoc.pdf	
	@$(warning .adoc.pdf in output)	
$(buildsrc).adoc.pdf:$(buildsrc).adoc_processed.txt
	@asciidoctor  --trace -a toc -r asciidoctor-pdf -a pagenums -b pdf $< -o $@