# Source of <http://cocoaheads-muc.de/>

## Prepare a talk (jumpstart)

1. fork repository,
2. clone repository: `$ git clone git@github.com:mro/cocoaheads-muc.de.git && cd cocoaheads-muc.de`
3. install [nanoc](http://nanoc.ws/): `$ sudo gem install nanoc kramdown i18n`
3. optional: install [pygments](http://pygments.org/): `$ sudo easy_install Pygments && sudo gem install pygments.rb`
4. add a post: `$ mkdir content/posts/<iso_date> && vi content/posts/<iso_date>/index.md`
5. hack, hack, hack
6. `$ nanoc compile && nanoc view`
7. point browser to <http://localhost:3000/> to preview
8. hack, hack, hack
9. make a pull request
