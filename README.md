# README

# Superhero Mission Maker

## A Rails app using basic authentication and the Official Marvel API

Surprisingly, the Marvel API is ridiculously out of date but the app is still fun to use, to a degree.  I designed this app with the purpose of being able to write code that dynamically pulls data from a public API in real-time.

I had to figure out how to decode the url using MD5 and pass in my API login and key in order to gain access to API data.

## Current flaws

There's no styling of any kind whatsoever, currently.  The app works as intended but needs some work.

I use re-routes to denote successful creation, however, sometimes Superhero creation fails and as a result re-routes you to the last created Superhero, so I need to add a check and probably some kind of notification when creation fails