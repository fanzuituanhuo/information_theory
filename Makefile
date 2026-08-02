.PHONY: all en zh lecture-01 lecture-02 clean

all:
	./scripts/build.sh all

en:
	./scripts/build.sh en

zh:
	./scripts/build.sh zh

lecture-01:
	./scripts/build.sh lecture-01

lecture-02:
	./scripts/build.sh lecture-02

clean:
	@for lecture in lecture-01 lecture-01-zh lecture-02 lecture-02-zh; do \
		cd "$$lecture/src" && latexmk -C -outdir=../build main.tex && \
		latexmk -C -outdir=../build main-answers.tex && cd ../..; \
	done
