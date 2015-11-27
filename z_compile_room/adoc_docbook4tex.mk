REGEX_DOCBOOK_CITE_REPLACE= -pe 's/(?m);(?=[^\r\n\[]+?\])/,/gm;'   -pe 's/\[cite:([\w|-]+),([0-9]+)]/+++<citation role="\\citep\[page \2\]">\1<\/citation>+++/g;' -pe 's/\[cite:((\w|-|,|;)+)]/+++<citation role="\\citep">\1<\/citation>+++/g;' -pe 's/\[citenp:((\w|-|,|;)+)]/+++\\<citation role="\\citet">\1<\/citation>+++/g;'  
# REGEX_DOCBOOK_STEM_REPLACE= -pe 's/stem:\[([^\]]+)\]/+++\\[\1\\]+++/gm;' 
REGEX_DOCBOOK_STEM_REPLACE= -pe 's/stem:\[([^\]]+)\]/+++<inlineequation><alt>\\(\1\\)<\/alt><\/inlineequation>+++/gm;' 
REGEX_DOCBOOK_GREEK= -pe 's/α/\\textalpha/g;'  -pe 's/β/\\textbeta/g;'  -pe 's/γ/\\textgamma/g;'
REGEX_DOCBOOK_REMOVE_PNG= -pe 's/(?<=image::)([\w\b-]+).png/\1/g;' -pe 's/(?<=image:)([\w\b-]+).png/\1/g;' 
REGEX_DOCBOOK_FIX_COMMENT= -pe 's/\\\%/\%/g;'
#$(REGEX_DOCBOOK_GREEK)
REGEX_DOCBOOK_ALL= $(REGEX_DOCBOOK_CITE_REPLACE)  $(REGEX_DOCBOOK_FIX_COMMENT)  $(REGEX_DOCBOOK_STEM_REPLACE) $(REGEX_DOCBOOK_REMOVE_PNG)


adoc_docbook4tex:$(buildsrc).adoc.docbook4tex.xml
	$(warning docbook created)
$(buildsrc).adoc.docbook4tex.xml:$(buildsrc).adoc_docbookprocessed.txt
		@asciidoctor  -a toc --doctype=book --backend docbook $< -o $@
#Process tex file
$(buildsrc).adoc_docbookprocessed.txt:$(buildsrc).adoc.txt
	@$(cmd_sync) $< $@.temp
	@$(cmd_replace)   $(REGEX_DOCBOOK_ALL)  $@.temp
	@mv  $@.temp $@	