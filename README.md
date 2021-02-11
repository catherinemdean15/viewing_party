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
- [Future Functionality](#future-functionality)
- [Contributors](#contributors)
- [Acknowledgements](#acknowledgements)

## Schema
![Schema](https://user-images.githubusercontent.com/67389821/107423165-e143f080-6ad0-11eb-8d79-9875185b18d1.png)

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

## Design Strategy
The design strategy of Viewing Party was to fully encapsulate each piece of functionality of the program and minimally store data, while avoiding API consumption limits:

### Users Table
- The Users Table represents all registered users for the viewing party application. Users are represented in the application as the current user and can also be represented as a friend of another registered user.

### Friends Table
- The Friends Table represents registered users who have been designated by another registered user as a friend.

### Parties Table
- The Parties Table stores information about parties created by users.

### Parties Users Table
- The Parties Users Table links a party to a specific user.
### Movies Table
- The Movies Table stores information about a movie and a movie can have many parties. 
## Achievements
- Continuous deployment to both Heroku and Travis.
- Utilized TDD to ensure comprehensive application functionality, including both 'happy' and 'sad' paths.
- Applied principles of MVC to effectively organize code.
- Routing is organized and consistent and demonstrates use RESTful principles.
- All User Stories 100% complete including edge cases.
- 100% test coverage for features and models.
- Tests are well written and meaningful.
- Clear schema design with detailed and accurate diagram.
- Relationships modeled in the database correctly, including appropriate use of foreign keys.
- Project completed within seven-day time frame.
- Implemented ActionMailer to email users and their guests of Viewing Party details
- Utilized self-referential tables to allow users to have and belong to other users.
- Added functionality via multiple API endpoints to create a dynamic user experience.
- Authenticated user login via sessions implementation.  
## Future Functionality
- Allow users to include a message or link when a new party is created.
- Include movie poster on both the discover and movie details page.
- Enable chat capability via ActionCable.
- Utilize JavaScript to update discover methods using Ajax.
- Allow users to add multiple hosts to a party. 
## Contributors 
1. [Joe Jiang](https://github.com/ninesky00)
2. [Catherine Dean](https://github.com/catherinemdean15)
3. [Cydnee Owens](https://github.com/cowens87)

## Acknowledgements
[The Movie Database](https://developers.themoviedb.org/3/getting-started/introduction)
