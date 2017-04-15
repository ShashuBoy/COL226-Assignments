all: lexer.cmo parser.cmo prolog.cmo structure.cmo
	ocamlc -o prolog structure.cmo lexer.cmo parser.cmo prolog.cmo

lexer.cmo: lexer.ml parser.cmi
	ocamlc -c lexer.ml

parser.cmo: parser.ml parser.cmi
	ocamlc -c parser.ml

prolog.cmo: prolog.ml
	ocamlc -c prolog.ml

parser.cmi: parser.mli
	ocamlc -c parser.mli

lexer.ml: lexer.mll
	ocamllex lexer.mll       # generates lexer.ml

parser.mli: parser.mly structure.cmo
	ocamlyacc parser.mly     # generates parser.ml and parser.mli

parser.ml: parser.mly
	ocamlyacc parser.mly     # generates parser.ml and parser.mli

structure.cmo: structure.ml
	ocamlc -c structure.ml

clean:
	rm -f *.cm*
	rm -f *.mli
	rm -f lexer.ml parser.ml

submit:
	rm -rf 2015CS10262*
	mkdir 2015CS10262_Assignment3
	cp parser.mly lexer.mll prolog.ml structure.ml README.md Makefile prolog ./2015CS10262_Assignment3/
	zip -r 2015CS10262_Assignment3 2015CS10262_Assignment3
