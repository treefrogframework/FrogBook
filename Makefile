# Makefile for Pandoc documentation

# You can set these variables from the command line.
PANDOCBIN     	= pandoc
PANDOCOPTION  	= --highlight-style=pygments 
PANDOCBUILD   	= $(PANDOCBIN) $(PANDOCOPTION)
PANDOCBUILDALL  = $(PANDOCBUILD) --metadata pagetitle=$(PANDOCTITLE) --toc --toc-depth=5 --resource-path=$(PANDOCSOURCE)
PANDOCSOURCE  	= source
BUILDDIR      	= build
PANDOCTITLE   	= "TreeFrog Documentation"
# BELOW: You can change to: pdflatex, lualatex, pdfroff, wkhtml2pdf, prince, or weasyprint
PANDOCPDFENGINE = xelatex 

# User-friendly check for pandoc
ifeq ($(shell which $(PANDOCBIN) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(PANDOCBIN)' command was not found. Make sure you have Pandoc installed, then set the PANDOCBIN environment variable to point to the full path of the '$(PANDOCBIN)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Pandoc installed, grab it from https://pandoc.org/)
endif

# Ordered file sources to get a beautiful all-in-one document
ORDEREDSOURCE = $(PANDOCSOURCE)/index.rst \
		$(PANDOCSOURCE)/introduction.rst	\
		$(PANDOCSOURCE)/introduction/*rst \
		$(PANDOCSOURCE)/install.rst \
	       	$(PANDOCSOURCE)/generator.rst \
	       	$(PANDOCSOURCE)/controller.rst \
	       	$(PANDOCSOURCE)/controller/*.rst \
	       	$(PANDOCSOURCE)/model.rst \
	       	$(PANDOCSOURCE)/model/*.rst \
	       	$(PANDOCSOURCE)/view.rst \
	       	$(PANDOCSOURCE)/view/*.rst \
	       	$(PANDOCSOURCE)/helper-reference.rst \
	       	$(PANDOCSOURCE)/helper-reference/*.rst \
	       	$(PANDOCSOURCE)/security.rst \
	       	$(PANDOCSOURCE)/debug.rst \
	       	$(PANDOCSOURCE)/test.rst \
	       	$(PANDOCSOURCE)/deployment.rst \
	       	$(PANDOCSOURCE)/cooperation-with-the-reverse-proxy-server.rst \
	       	$(PANDOCSOURCE)/cooperation-with-the-reverse-proxy-server.rst \
	       	$(PANDOCSOURCE)/performance-comparison-of-web-applications-frameworks.rst \
	       	$(PANDOCSOURCE)/performance.rst

# By default: build all-in-one HTML doc
.DEFAULT_GOAL = allhtml

.PHONY: help english clean html allhtml json markdown gfm odt allodt docx alldocx epub allepub latex alllatex allpdf pdf man plain asciidoc 

help:
	@echo "First use \`make <language>\` where <language> is one of these:"
	@echo "  english       to build english documentation"
	@echo "Please use \`make <target>\` where <target> is one of these:"
	@echo "  html       to make standalone HTML files"
	@echo "  allhtml    to make an all-in-one HTML (DEFAULT)"
	@echo "  json       to make JSON files"
	@echo "  markdown   to make markdown files"
	@echo "  gfm	    to make gfm files"
	@echo "  odt	    to make odt files"
	@echo "  allodt	    to make an all-in-one odt file"
	@echo "  docx	    to make docx files"
	@echo "  alldocx    to make an all-in-one docx file"
	@echo "  epub       to make epub files"
	@echo "  allepub    to make an all-in-one epub file"
	@echo "  latex	    to make LaTeX files"
	@echo "  alllatex   to make an all-in-one LaTeX file"
	@echo "  pdf	    to make PDF files"
	@echo "  allpdf	    to make an all-in-one PDF file"
	@echo "  man	    to make man pages"
	@echo "  plain	    to make plain text files"
	@echo "  asciidoc   to make asciidoc files"

clean:
	rm -rf $(BUILDDIR)/*
	rm -rf $(PANDOCSOURCE)/*

html:
	@mkdir -p $(BUILDDIR)/html
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t html -o "$(BUILDDIR)/html/$$(basename $${0} .rst).html"' {} \;
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

allhtml:
	@mkdir -p $(BUILDDIR)/allhtml
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) -s -f rst -t html -o build/allhtml/documentation.html
	@echo "Build finished. The all-in-one HTML page is in $(BUILDDIR)/allhtml."

json:
	@mkdir -p $(BUILDDIR)/json
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t json -o "$(BUILDDIR)/json/$$(basename $${0} .rst).json"' {} \;
	@echo "Build finished. The JSON files are in $(BUILDDIR)/json."

markdown:
	@mkdir -p $(BUILDDIR)/md
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t markdown -o "$(BUILDDIR)/md/$$(basename $${0} .rst).md"' {} \;
	@echo "Build finished. The markdown files are in $(BUILDDIR)/md."

gfm:
	@mkdir -p $(BUILDDIR)/gfm 
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t gfm -o "$(BUILDDIR)/gfm/$$(basename $${0} .rst).md"' {} \;
	@echo "Build finished. The gfm files are in $(BUILDDIR)/gfm."

odt:
	@mkdir -p $(BUILDDIR)/odt
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t odt -o "$(BUILDDIR)/odt/$$(basename $${0} .rst).odt"' {} \;
	@echo "Build finished. The odt files are in $(BUILDDIR)/odt."

allodt:
	@mkdir -p $(BUILDDIR)/allodt
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) -s -f rst -t odt -o build/allodt/documentation.odt
	@echo "Build finished. The odt file is in $(BUILDDIR)/allodt."

docx:
	@mkdir -p $(BUILDDIR)/docx
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --toc --toc-depth=5 --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t docx -o "$(BUILDDIR)/docx/$$(basename $${0} .rst).docx"' {} \;
	@echo "Build finished. The odt files are in $(BUILDDIR)/docx."

alldocx:
	@mkdir -p $(BUILDDIR)/alldocx
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) -s -f rst -t docx -o build/alldocx/documentation.docx
	@echo "Build finished. The docx file is in $(BUILDDIR)/alldocx."

epub:
	@mkdir -p $(BUILDDIR)/epub
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --epub-metadata=$(PANDOCSOURCE)/epub_conf.yml --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t epub -o "$(BUILDDIR)/epub/$$(basename $${0} .rst).epub"' {} \;
	@echo "Build finished. The epub files are in $(BUILDDIR)/epub."

allepub:
	@mkdir -p $(BUILDDIR)/allepub
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) -s -f rst -t epub -o build/allepub/documentation.epub
	@echo "Build finished. The epub file is in $(BUILDDIR)/allepub."

latex:
	@mkdir -p $(BUILDDIR)/latex
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t epub -o "$(BUILDDIR)/latex/$$(basename $${0} .rst).tex"' {} \;
	@echo "Build finished. The latex files are in $(BUILDDIR)/latex."

alllatex:
	@mkdir -p $(BUILDDIR)/alllatex
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) -s -f rst -t latex -o build/alllatex/documentation.tex
	@echo "Build finished. The latex file is in $(BUILDDIR)/alllatex."

pdf:
	@mkdir -p $(BUILDDIR)/pdf
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --pdf-engine=$(PANDOCPDFENGINE) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -o "$(BUILDDIR)/pdf/$$(basename $${0} .rst).pdf"' {} \;
	@echo "Build finished. The PDF files are in $(BUILDDIR)/pdf."

allpdf:
	@mkdir -p $(BUILDDIR)/allpdf
	@$(PANDOCBUILDALL) $(ORDEREDSOURCE) --pdf-engine=$(PANDOCPDFENGINE) -s -f rst -o build/allpdf/documentation.pdf
	@echo "Build finished. The PDF file is in $(BUILDDIR)/allpdf."

man:
	@mkdir -p $(BUILDDIR)/man
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t man -o "$(BUILDDIR)/man/$$(basename $${0} .rst).man"' {} \;
	@echo "Build finished. The man files are in $(BUILDDIR)/man."

plain:
	@mkdir -p $(BUILDDIR)/plain
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t plain -o "$(BUILDDIR)/plain/$$(basename $${0} .rst).txt"' {} \;
	@echo "Build finished. The plain files are in $(BUILDDIR)/plain."

asciidoc:
	@mkdir -p $(BUILDDIR)/asciidoc
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t asciidoc -o "$(BUILDDIR)/asciidoc/$$(basename $${0} .rst).txt"' {} \;
	@echo "Build finished. The asciidoc files are in $(BUILDDIR)/asciidoc."

english:
	rm -rf $(BUILDDIR)
	rm -rf $(PANDOCSOURCE)
	mkdir $(PANDOCSOURCE)
	cp -R en/* $(PANDOCSOURCE)/

