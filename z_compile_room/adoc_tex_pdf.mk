#Depends on mk_tex_initials
#------------------
adoc_tex_pdf:$(outsrc).adoc.tex.pdf
	$(warning Tex Pdf now completed)

$(buildsrc).adoc.tex.pdf:$(buildsrc).adoc.tex $(buildsrc).template.tex $(tex_libs_in_build) $(builddir)/$(tex_glossary) $(builddir)/$(bib)
	@cd $(builddir) && $(cmd_latexmk) $(buildsrc).template.tex
	@$(cmd_sync) $(buildsrc).template.pdf $(buildsrc).adoc.tex.pdf


$(buildsrc).adoc.tex:$(buildsrc).adoc_texprocessed.txt
	@asciidoctor-latex -a header=no $(buildsrc).adoc_texprocessed.txt
	@$(cmd_sync) $(buildsrc).adoc_texprocessed.tex $@ 	

#Process tex file
$(buildsrc).adoc_texprocessed.txt:$(buildsrc).adoc.txt
	@$(cmd_sync) $< $@.temp
	@$(cmd_replace)   $(REGEX_TEX_ALL)  $@.temp
	@$(cmd_sync)  $@.temp $@





