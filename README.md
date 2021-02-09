# <div align="center">  Viewing Party

![Name of image](https://user-images.githubusercontent.com/67389821/107419591-d4bd9900-6acc-11eb-9047-5024adae3834.png)
## Description
Viewing party is an application in which users can explore movie options and create a viewing party event for the user and their friends.
## Table of Contents
- [Schema](#schema)
- [Technology](#technology)
- [Achievements](#achievements)
- [Instructions](#instructions)
- [Design Strategy](#design-strategy)
  - [Users](#users)
  - [Friends](#friends)
  - [Parties](#parties)
  - [Parties Users](#parties_users)
  - [Movies](#movies)
- [Contributors](#contributors)
- [Acknowledgements](#acknowledgements)

## Schema
![Schema](https://user-images.githubusercontent.com/67389821/107416552-7642eb80-6ac9-11eb-8850-f5479f1aca78.png)

## Technology
   ![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)    ![](https://img.shields.io/badge/Code-HTML-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Code-CSS-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) [![Build Status](https://travis-ci.com/ninesky00/viewing_party.svg?branch=main)](https://travis-ci.com/ninesky00/viewing_party)

## Instructions
This application is hosted on [Heroku](https://stormy-bastion-67887.herokuapp.com/), where you'll be able to view its functionality to the fullest.

For usage on your local machine follow the instructions listed below:
```
git clone git@github.com:ninesky00/viewing_party.git
cd viewing_party
bundle install
rake db:{drop,create,migrate,seed}
rails server
```
Now, navigate to `http://localhost:3000/` on your browser to view the application!

This is the base repo for the [viewing party project](https://backend.turing.io/module3/projects/viewing_party) used for Turing's Backend Module 3.
## Achievements
- Continuous deployment to both Heroku and Travis.
- Utilized TDD to ensure comprehensive application functionality, including both 'happy' and 'sad' paths.
- Utilized principles of MVC to effectively organize code.
- Routing is organized and consistent and demonstrates use RESTful principles.
- All User Stories 100% complete including edge cases.
- 100% test coverage for features and models.
- Tests are well written and meaningful.
- Clear schema design with detailed and accurate diagram.
- Relationships modeled in the database correctly, including appropriate use of foreign keys.
- Project completed within seven-day time frame.
## Contributors 
1. [Joe Jiang](https://github.com/ninesky00)
2. [Catherine Dean](https://github.com/catherinemdean15)
3. [Cydnee Owens](https://github.com/cowens87)

## Acknowledgements
## Versions
- Ruby 2.5.3
- Rails 5.2.4.3

Example wireframes to follow are found [here](https://backend.turing.io/module3/projects/viewing_party/wireframes)
