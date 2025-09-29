Web:
	rm -rf Web
	mkdir -p Web
	godot --headless --export-release Web Web/Challenge.html
	mv Web/Challenge.html Web/index.html
	cd Web; zip -r ER-Challenge.zip .

.PHONY: Web
