test: force
	cd public; python3 -m http.server
	
commit:
	git add .
	git commit -m 'latest updates'
	
push: 
	eval "$(ssh-agent -s)"
	ssh-add /home/jjw/.ssh/js_github
	git push ssh://git@ssh.github.com:443/jjw/js-website
	
publish: force commit push
	
force:
	soupault --force
  
clean:
	rm -r public/
	rm -f /tmp/tt
	
