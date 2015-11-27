#Depends on adoc_docbook4tex
adoc_docbook4tex_tex:$(buildsrc).adoc.docbook4tex.tex
	@$(warning ==== Created adoc_docbook4tex_tex)
$(buildsrc).adoc.docbook4tex.tex: $(buildsrc).adoc.docbook4tex.xml	
	@#-p $(base)/z_compile_room/my_docbooklatex.xsl  -t tex 
	@#dblatex  --verbose -p $(base)/z_compile_room/my_docbooklatex.xsl  -t tex --bib-path=$(builddir)/$(bib) --texstyle=$(builddir)/my_tufte_book_v2.sty $< -o $@
	@#dblatex  --verbose -p $(base)/z_compile_room/my_docbooklatex.xsl  -t tex --bib-path=$(builddir)/$(bib) --texstyle=$(builddir)/my_memoir.sty $< -o $@
	@#-P latex.encoding=utf8
	@dblatex  --verbose -p $(base)/z_compile_room/my_docbooklatex.xsl  -t tex --bib-path=$(builddir)/$(bib) --texstyle=$(builddir)/my_memoir.sty $< -o $@
