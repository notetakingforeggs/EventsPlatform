# Events Scheduler 📅🚀

### An app for scheduling events and adding them to Google Calendar. Backend in Spring (Java), frontend in Flutter (Dart) (Android only... for now).

## Features 🌟

**Backend:** Spring Boot (MVC), Hibernate, PostgreSQL, OAuth, Google Calendar API integration. 

**Frontend:** Flutter with MVVM / Clean Architecture, Go Routing, Provider for state management, deep linking, custom tabs.

**Deep Linking:** Uses ludicacid.com, which... may occasionally redirect you to a cat puppet website 🐱🎭 (don't ask). Has .well-known/assetlinks but you might need to update SHA (more on this below).

## How to Run ⚡

Clone this repo 🧑‍💻

Get the right IDEs (IntelliJ IDEA for backend, Android Studio for frontend).

**Backend setup:**

Uses Maven 🛠️

You need PostgreSQL (Make a DB and add credentials in .properties file).

Set Hibernate to create mode to generate DB tables.

Switch Hibernate to update mode with init on to seed data.

Then, turn init off and keep it on update for future runs.

**Frontend setup:**

Android Studio.

Just run it? 🤞

## Auth & API Keys 🔑

Some stuff is .gitignored, so you'll need your own credentials:

Google OAuth & Calendar API: Create an app in Google Cloud Console.

Generate OAuth credentials (Client ID & Secret) and put them in the right backend config.

Add a test account (App is still in testing mode).

## Deep Linking & SHA Stuff 🕵️‍♂️

Deep linking uses ludicacid.com as it is a domain I already own.

It has the assetlinks.json file in the .well-known dir and is used for deep link verification.

SHA key might change if someone else clones this repo, meaning:

Either they upload a new assetlinks.json to a website they have access to and put the SHA in there...

OR I could manually add their hash to mine so they can try it out 

Done? Maybe? 🤷

If everything is set up, it should work... probably. Enjoy! 🚀