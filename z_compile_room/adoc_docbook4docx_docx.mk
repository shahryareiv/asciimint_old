REGEX_DOCBOOK4DOCX_CITE_REPLACE= -pe 's/(?m);(?=[^\r\n\[]+?\])/,/gm;' -pe 's/\[cite:((\w|-|,|;)+)]/+++<citation role="\\citep">\1<\/citation>+++/g;' -pe 's/\[citenp:((\w|-|,|;)+)]/+++\\<citation role="\\citet">\1<\/citation>+++/g;'  
REGEX_DOCBOOK4DOCX_STEM_REPLACE= -pe 's/stem:\[([^\]]+)\]/+++\\(\1\\)+++/g;' 
REGEX_DOCBOOK4DOCX_GREEK= -pe 's/α/\\textalpha/g;'  -pe 's/β/\\textbeta/g;'  -pe 's/γ/\\textgamma/g;'
REGEX_DOCBOOK4DOCX_REMOVE_PNG= -pe 's/(?<=image::)([\w\b-]+).png/\1/g;' 
REGEX_DOCBOOK4DOCX_FIX_COMMENT= -pe 's/\\\%/\%/g;'
REGEX_DOCBOOK4DOCX_REMOVE_SIDENOTE= -pe 's/\*\*\*\*\n.+\n\*\*\*\*//g;'
#$(REGEX_DOCBOOK4DOCX_GREEK)
REGEX_DOCBOOK4DOCX_ALL= $(REGEX_DOCBOOK4DOCX_CITE_REPLACE)  $(REGEX_DOCBOOK4DOCX_FIX_COMMENT)  $(REGEX_DOCBOOK4DOCX_STEM_REPLACE) $(REGEX_DOCBOOK4DOCX_REMOVE_PNG) $(REGEX_DOCBOOK4DOCX_REMOVE_SIDENOTE)

adoc_docbook4docx_docx:$(outsrc).adoc.docbook4docx.docx
	@$(warning ==== Done: .adoc.docbook4docx.docx in output)
$(buildsrc).adoc.docbook4docx.docx:$(buildsrc).adoc.docbook4docx.xml $(docbook2docx_tooldir)/template.xml $(docbook2docx_tooldir)/dbk2wordml.xsl
	@#xsltproc -o $@ --stringparam wordml.template $(docbook2docx_tooldir)/template.xml $(docbook2docx_tooldir)/dbk2wordml.xsl $(buildsrc).adoc.docbook4docx.xml
	@#xsltproc -o $@ --stringparam wordml.template $(docbook2docx_tooldir)/template.xml $(docbook2docx_tooldir)/dbk2wordml.xsl $(buildsrc).adoc.docbook4docx.xml
	@xsltproc -o $@ --stringparam wordml.template $(docx_template_file) $(docbook2docx_tooldir)/dbk2wordml.xsl $(buildsrc).adoc.docbook4docx.xml


$(buildsrc).adoc.docbook4docx.xml:$(buildsrc).adoc_docbook4docxprocessed.txt
		@asciidoctor -a toc --doctype=book --backend docbook $< -o $@
#Process tex file
$(buildsrc).adoc_docbook4docxprocessed.txt:$(buildsrc).adoc.txt
	@$(cmd_sync) $< $@.temp
	@$(cmd_replace)   $(REGEX_DOCBOOK4DOCX_ALL)  $@.temp
	@$(cmd_sync)  $@.temp $@		