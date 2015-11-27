#depends on (builddir).docbook4tex.tex
adoc_docbook4tex_tex_pdf:$(outsrc).adoc.docbook4tex.tex.pdf
	@$(warning ==== .docbook4tex.tex.pdf created in output)
$(buildsrc).docbooktemplate.tex:$(template_dir)/$(tex_template)
	@$(cmd_sync) $< $@ 		
$(buildsrc).adoc.docbook4tex.tex.pdf:$(buildsrc).adoc.docbook4tex.tex  $(buildsrc).docbooktemplate.tex $(tex_libs_in_build) $(builddir)/$(tex_glossary) $(builddir)/$(bib)
	@cd $(builddir) && $(cmd_latexmk) $(buildsrc).docbooktemplate.tex
	@mv $(buildsrc).docbooktemplate.pdf $(buildsrc).adoc.docbook4tex.tex.pdf


