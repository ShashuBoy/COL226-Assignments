all: interpreter_secd.ml lexer.mll parser.mly
	ocamlc -c interpreter_secd.ml
	ocamlyacc parser.mly
	ocamllex lexer.mll
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml

clean:
	rm -rf ./*.cmo
	rm -rf ./*.cmi
	rm -rf ./lexer.ml
	rm -rf ./parser.ml
	rm -rf ./*.mli