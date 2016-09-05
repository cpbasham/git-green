#!/bin/bash

unparsedQuote=`curl -gs "http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1"`
author=`expr "$unparsedQuote" : '.*\"title\":\"\([^"]*\).*' | php -R 'echo html_entity_decode($argn);'`
quote=`expr "$unparsedQuote" : '.*\"content\":\"<p>\(.*\)<\\\/p>.*' | php -R 'echo html_entity_decode($argn);'`
node -e "console.log(\"$quote\")" > wisdom.txt
node -e "console.log(\"    -- $author\");" >> wisdom.txt
counter="$((`cat wisdomCounter.txt` + 1))"
echo "$counter" > wisdomCounter.txt
git add .
git commit -m "write bit of wisdom #$(counter)"
