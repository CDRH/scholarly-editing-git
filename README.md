# scholarly-editing
Current production version of Scholarly Editing

To update the development site: 

1: Commit all your changes locally. If you are working from the command line, this will likely mean running the following commands:

- ```git add -A```
- ```git commit -m 'YOUR MESSAGE HERE'```
- ```git push origin master```

If you are running the GitHub GUI, click "commit" and then "sync"

2: Log in to cdrhsearch and pull changes by running the following: 

- ```ssh USERNAME@cdrhsearch.unl.edu```
- ```cd /web/cocoon/test/scholarly-editing-git/```
- ```git pull```

it will ask you for your git username and password. There will also be an error: ```Gtk-WARNING **: cannot open display:``` This can be safely ignored. 

View your site at: http://cdrhsites.unl.edu/cocoon/scholarly-editing-git/

