#
#  Makefile
#

help:
	@echo
	@echo "  make serve       Run a development server."
	@echo "  make view        Open the dev page in the browser."
	@echo "  make edit        Open the project in Atom."
	@echo "  make deploy      Deploy to gh-pages."
	@echo "  make view-live   View the live site on Github pages."
	@echo

serve:
	while :; do gitbook serve --watch; sleep 1; done

view:
	open http://localhost:4000/

edit:
	atom .

book.pdf: book.json *.md
	gitbook pdf

deploy:
	gitbook build .
	ghp-import _book
	git push origin gh-pages

view-live:
	open http://larsyencken.github.io/gitbook-mcpy/
