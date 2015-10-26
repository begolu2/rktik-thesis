
all: thesis_skeleton.latex appendix.tex
	pandoc *.md ref-appendix/references.tex \
	--include-before-body=frontback/dedication.tex \
	--include-before-body=frontback/acknowledgements.tex \
	--include-before-body=frontback/abstract.tex \
	--include-after-body=ref-appendix/appendix.tex \
	--atx-headers \
	--latex-engine=pdflatex --template=thesis_skeleton.latex \
	--bibliography=thesis.bib --csl=acm-sigchi-proceedings-extended-abstract-format.csl \
	-V bibfile='thesis' \
	-V bibtitle='Bibliography' \
	-V documentclass='scrbook' \
	-V fontfamily='libertine' \
	-V author='Vincent Ahrend' \
	-V year='2015' \
	-V department='Institute for Cognitive Science' \
	-V university='University of Osnabrueck' \
	-V title='Rktik' \
	-V subtitle='A Social Network for Groups' \
	-V supervisor='Dr. Helmar Gust, University of Osnabrueck \\ Dr. Kai-Uwe Kühnberger, University of Osnabrueck' \
	-V university_logo='img/uos.png' \
	-f markdown -o thesis.tex
	rm thesis_skeleton.latex ref-appendix/appendix.tex

appendix.tex: ref-appendix/appendix.md
	pandoc -f markdown -t latex ref-appendix/appendix.md -o ref-appendix/appendix.tex

thesis_skeleton.latex: ClassicThesis.tex
	python template_gen.py
