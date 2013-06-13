debug:
	@nico server --watch

server:
	@nico server

publish:
	@git push origin master
	@rm -rf _site
	@nico build
	@ghp-import _site
	@git push origin gh-pages

.PHONY: debug server publish
