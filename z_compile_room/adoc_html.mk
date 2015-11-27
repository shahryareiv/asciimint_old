REGEX_HTML_GREEK= -pe 's/α/\\textalpha/g;'  -pe 's/β/\\textbeta/g;'  -pe 's/γ/\\textgamma/g;'
REGEX_HTML_FIX_COMMENT= -pe 's/\\\%/\%/g;'
REGEX_HTML_REMOVE_SIDENOTE= -pe 's/\*\*\*\*\n.+\n\*\*\*\*//g;'
#$(REGEX_HTML_GREEK) 
REGEX_HTML_ALL= $(REGEX_HTML_FIX_COMMENT)  $(REGEX_HTML_REMOVE_SIDENOTE)

html_libs= $(notdir $(wildcard $(html_libdir)/*))
html_libs_in_build=$(addprefix $(builddir)/,$(html_libs))

adoc_html:$(outsrc).adoc.html	all_2png_figures
	@$(warning ==== .adoc.html in output)	
$(buildsrc).adoc.html:$(buildsrc).adoc_htmlprocessed.txt
	@asciidoctor -a toc  -a pagenums -a imagesdir=$(images_4html_outdir) -b html5 $< -o $@


$(buildsrc).adoc_htmlprocessed.txt:$(buildsrc).adoc_processed.txt
	@$(cmd_sync) $< $@.temp
	@$(cmd_replace)   $(REGEX_HTML_ALL)  $@.temp
	@$(cmd_sync)  $@.temp $@

#all html packages (css, js, ttf, images) to be in build: deps on all html packages to be in lib
$(html_libs_in_build):$(addprefix $(html_libdir)/,$(html_libs))
	@$(cmd_sync) $(html_libdir)/$(notdir $@) $@