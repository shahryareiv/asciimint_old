include mk_config
include mk_settings

all:: all_commons all_2pdf_figures all_2png_figures $(format)

include mk_commons
include mk_tex_initials
include mk_figures
include mk_adoc_process

include adoc_pdf.mk
include adoc_html.mk

include adoc_tex_pdf.mk

# adoc_docbook_tex_pdf:$(outsrc).docbook.tex.pdf

include adoc_docbook4tex.mk
include adoc_docbook4tex_tex.mk
include adoc_docbook4tex_tex_pdf.mk

include adoc_docbook4docx_docx.mk

