.PHONY: frontend
frontend:
	bash -c "trap \"kill %1\" EXIT; dune build @melange -w --terminal-persistence=preserve & yarn dev"
