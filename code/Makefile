all: point.mli point.ml edge.mli edge.ml point_assoc.mli point_assoc.ml pointset.mli pointset.ml topology.mli topology.ml regex.mli regex.ml graph.ml graph.mli mu.ml
	corebuild mu.native

run: all
	./mu.native

clean:
	rm -rf _build
	rm *.cmo *.cmi *.native *.byte
