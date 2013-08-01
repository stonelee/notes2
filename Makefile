debug:
	@nico server --watch --port 8080

server:
	@nico server --port 8080

deploy:
	@git commit -m 'upload'
	@git push origin master
	@rm -rf _site/
	@nico build
	~/bin/ghp-import/ghp-import _site/
	@git push origin gh-pages

.PHONY: debug server publish
