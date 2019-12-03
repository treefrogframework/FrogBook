# Makefile for Pandoc documentation

# You can set these variables from the command line.
PANDOCOPTS    =
PANDOCBUILD   = pandoc
PANDOCSOURCE  = source
PAPER         =
BUILDDIR      = build

# User-friendly check for pandoc
ifeq ($(shell which $(PANDOCBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(PANDOCBUILD)' command was not found. Make sure you have Pandoc installed, then set the PANDOCBUILD environment variable to point to the full path of the '$(PANDOCBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Pandoc installed, grab it from https://pandoc.org/)
endif

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

help:
	@echo "First use \`make <language>\` where <language> is one of these:"
	@echo "  english       to build english documentation"
	@echo "Please use \`make <target>\` where <target> is one of these:"
	@echo "  html       to make standalone HTML files"
	@echo "  json       to make JSON files"
	@echo "	 markdown   to make markdown files"
	@echo "  gfm	    to make gfm files"
	@echo "  odt	    to make odt files"
	@echo "  docx	    to make docx files"
	@echo "  epub       to make epub files"
	@echo "  latex	    to make LaTeX files"
	@echo "  man	    to make man pages"
	@echo "  plain	    to make plain text files"
	@echo "  asciidoc   to make asciidoc files"
	@echo "  epub       to make an epub"
	@echo "  man        to make manual pages"

clean:
	rm -rf $(BUILDDIR)/*
	rm -rf $(PANDOCSOURCE)/*

html:
	@mkdir -p $(BUILDDIR)/html
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) "$${0}" -f rst -t html -o "$(BUILDDIR)/html/$$(basename $${0} .rst).html"' {} \;
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

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

docx:
	@mkdir -p $(BUILDDIR)/docx
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t docx -o "$(BUILDDIR)/docx/$$(basename $${0} .rst).docx"' {} \;
	@echo "Build finished. The odt files are in $(BUILDDIR)/docx."

epub:
	@mkdir -p $(BUILDDIR)/epub
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t epub -o "$(BUILDDIR)/epub/$$(basename $${0} .rst).epub"' {} \;
	@echo "Build finished. The epub files are in $(BUILDDIR)/epub."

latex:
	@mkdir -p $(BUILDDIR)/latex
	@find $(PANDOCSOURCE) -iname "*.rst" -type f -exec sh -c '$(PANDOCBUILD) --resource-path=$(PANDOCSOURCE) "$${0}" -f rst -t epub -o "$(BUILDDIR)/latex/$$(basename $${0} .rst).tex"' {} \;
	@echo "Build finished. The latex files are in $(BUILDDIR)/latex."

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

