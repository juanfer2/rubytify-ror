# Rubytify
  API for artists:
  - Artists:
  https://rubitify-api.herokuapp.com/api/v1/artists
  - Albums by artist:
  https://rubitify-api.herokuapp.com/api/v1/artists/:id/albums
  - Songs by album:
  https://rubitify-api.herokuapp.com/api/v1/albums/:id/songs
  - Aleatory song by genre:
  https://rubitify-api.herokuapp.com/api/v1/genres/:genre_name/random_song

## Instructions

- For the rubytify instructions check this gist: https://gist.github.com/AyendaHoteles/235cd0955799dfc1c9ec5fa28d00f2ae 
- To upload the code create your own fork of this repo and start a pull request to this repo once you're done with your changes.

## Installation
  install gems
```bash
bundle
```
  run migrations
```bash
rails db:migrate
```

  run task for import data from spotify 
```bash
rake imported:import_data_spotify
```
  run project 
```bash
rails s
```
## Postman collection
  https://www.getpostman.com/collections/d6a230add566928cf46e

 ![alt text](https://github.com/juanfer2/rubytify-ror/blob/master/screens/screen-rubitify.png?raw=true)
