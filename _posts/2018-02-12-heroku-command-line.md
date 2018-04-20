---
title: Heroku command lines
categories: 
tags: heroku
description: Some basic Heroku command lines
permalink: 
---

#### Login and add SSH key
```sh
heroku login
heroku keys:add
```
#### Create a place for the app on Heroku
```sh
heroku create
```
or
```sh
heroku create your-app-name
```
#### Set enviroment variables
```sh
heroku config:set NAME=your_name EMAIL=your_email_address 
```
#### List all set enviroment variables
```sh
heroku config
```
#### Deploy the app to Heroku
```sh
git push heroku master
```

#### Open the app on browser from command line
```sh
heroku open
```

#### Rename the app
```sh
heroku rename new-name
```
More at [Heroku Dev Center](https://devcenter.heroku.com/categories/command-line)
