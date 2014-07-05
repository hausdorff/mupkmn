all: mu.ml fsm.ml fsm.mli
	corebuild mu.native

run: all
	./mu.native

clean:
	rm -rf _build
	rm *.cmo *.cmi *.native *.byte
