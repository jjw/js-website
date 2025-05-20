test: force
	cd public; python3 -m http.server
	
publish: force
	git add .
	git commit -m 'latest updates'
	eval "$(ssh-agent -s)"
	ssh-add /home/jjw/.ssh/js_github
	git push ssh://git@ssh.github.com:443/jjw/js-website
	
force:
	soupault --force
  
clean:
	rm -r public/
	rm -f /tmp/tt
	
