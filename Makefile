LATEXMK = latexmk
SRC     = paper/main.tex
DEPS    = paper/refs.bib
JOBNAME = aion-paper-06-ethics
PDFDIR  = pdf

.PHONY: all clean veryclean

all: $(PDFDIR)/$(JOBNAME).pdf

$(PDFDIR):
	mkdir -p $@

$(PDFDIR)/$(JOBNAME).pdf: $(SRC) $(DEPS) | $(PDFDIR)
	cd paper && TEXINPUTS="..:.:$(TEXINPUTS)" \
	  LC_ALL=C LANG=C $(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error \
	  -jobname=$(JOBNAME) -output-directory=../$(PDFDIR) main.tex

clean:
	cd paper && LC_ALL=C LANG=C $(LATEXMK) -C -jobname=$(JOBNAME) -output-directory=../$(PDFDIR) main.tex
	rm -f $(PDFDIR)/$(JOBNAME).*

veryclean: clean
	rm -f $(PDFDIR)/$(JOBNAME).pdf
