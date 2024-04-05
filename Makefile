BUILDDIR = build
SOURCEDIRS = $(shell ls -d */ | grep -v "^build")
PDFBUILDS = $(addprefix $(BUILDDIR)/, $(SOURCEDIRS:/=.pdf))

.DEFAULT_GOAL := all

.PHONY : clean
clean :
	-rm -r $(BUILDDIR)

.PHONY : all
all : $(PDFBUILDS)

$(PDFBUILDS) : $(BUILDDIR)/%.pdf : %/main.tex
	mkdir -p $(BUILDDIR)
	latexmk -pdf \
		-output-directory=$(BUILDDIR) \
		$*/main
