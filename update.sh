#!/bin/sh

git pull
rm data/*.xml
rm jekyll/notifications/*.md
python scraper/eConsult2Github.py
git add data/*.xml
git add jekyll/notifications/*.md
git commit -a -m 'Automatic refresh'
git push origin master
git subtree push --prefix jekyll origin gh-pages
