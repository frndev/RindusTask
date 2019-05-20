# RindusTask

## Endpoints used
- GET /users
- GET /albums?userId={id}
- POST /albums/:id
- PATCH /albums/:id
- DELETE /albums/:id
- GET /posts?userId={id}
- GET /photos?albumId={id}

## Technologies/Architecture
- Swift
- Handling Request/Response with Codable protocol 
- Clean Swift Architecture (View - Interactor - Presenter)
- Modularization
- Custom views
- Image Prefetching in collection view
- Error Handling

## Features
- Show user List
- Show selected user and its profile.
- Add/Edit/Delete album of selected user (Swiping left/right album´s tableView)
- Show posts list of selected user

## How to improve it
- Divide each method of Worker Protocol by use case in a single file to make a cleaner architecture.
- Implement unit tests and UI Tests, although the implemented architecture is prepared for that due to protocol implementation
- Create specific views for empty data from backend, an alert is show at the moment
- Receive photos response with pagination in order to not download innecessary data
- Persist data into app with Core Data, e.g.

### About security and authentication

- Create a way to authenticate users in order to not let them access in R/W mode to confidential data. This user could log in using its credentials.
- Having temporary session that expires if the user is not using the app in a while. When this event occurs, the user has to log in again.
- Hide data with a splashscreen when the user move the app to background
- If there were sensible user data, we could save it into keychain
- We are already using HTTPS protocol 

Francisco Navarro Aguilar
