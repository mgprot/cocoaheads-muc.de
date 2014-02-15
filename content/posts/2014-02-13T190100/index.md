--- 
title: "Static Site Generators, Beispiel: nanoc und cocoaheads-muc.de"
speakers: [ Marcus Rohrmoser ]
host: Marcus Rohrmoser
tags:
  - Static Site Generator
  - nanoc
  - ruby
permalink: /posts/2014-02-13-nanoc@cocoaheads-muc.de/
pub: Danach ab ca. 20.00 Uhr ist ein Tisch im Olé Madrid, Häberlstraße 15 reserviert.
---

## Motivation

- Archiv für Vorträge,
- kein CMS, DB, etc.
- einfache Pflege der Website,
- einfaches Hosting (statische Files)

## Wieso nanoc?

- SSG für einfache Bearbeitung + Hosting,
- Kandidaten gibt's viele, [Jekyll](http://jekyllrb.com/) wäre auch eine Option,
- Jekyll bring IMO zu viele Abhängigkeiten mit
- für `nanoc` genügt ein simples

  ~~~~~~~~~
  #!bash
  $ sudo easy_install Pygments
  $ sudo gem install bundle && sudo bundle install
  $ nanoc compile && nanoc view & open -a Safari http://localhost:3000
  ~~~~~~~~~

- Website läuft auch lokal - ideal falls mal kein Netz

## Wie mache ich einen Vortrag?

- Siehe [README bei github](https://github.com/mgprot/cocoaheads-muc.de)

## Was passiert da?

- `Rules`
  - Regeln was mit welchen Sourcen passieren soll,
  - Regeln unter welchen URLs selbige landen,
  - evtl. `preprocess` Schritte (z.B. Tag Übersichtsseiten anlegen),
- `nanoc.yaml`
  - nicht so wichtig (da keine DB etc.)
  - evtl. Deployment (rsync Ziel)
- `layouts/` - na, was wohl?
- `lib/` eigene Anpassungen, z.B. [deutsches Datum](https://github.com/mgprot/cocoaheads-muc.de/blob/master/lib/default.rb#L12)

## Was könnte noch kommen?

- Übersichten
  - Vortragende
  - Tags
- RSS/Atom Feed
- Altvorträge zusammensuchen
- S5 für Präsentationen a la [die da](http://wiki.mro.name/_export/s5/cocoaheads/ragel)

## Links

nanoc
: <http://nanoc.ws/>

nanoc IRC
: [`#nanoc` bei freenode](irc://chat.freenode.net/#nanoc)

kramdown
: <http://kramdown.gettalong.org/syntax.html>

pygments mit nanoc
: <http://clarkdave.net/2013/03/syntax-highlighting-in-nanoc/>

## Danke

- Folien (hust) unter <http://cocoaheads-muc.de/posts/2014-02-13-nanoc@cocoaheads-muc.de/>
