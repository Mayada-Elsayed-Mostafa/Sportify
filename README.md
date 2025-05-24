# Sportify

An iOS sports app that displays sports, leagues, events, and teams data from TheSportsDB API. Includes favorites management using CoreData and offline support.

---

## Features
- **Onboarding Screens**
  - Developed elegant and user-friendly onboarding UI.
   
- **Main Screen**  
  - Tab 1: Sports displayed in a 2-column CollectionView with sport thumbnail and name  
  - Tab 2: Favorite leagues stored using CoreData, similar UI to Leagues screen, offline detection with alert  

- **Leagues**  
  - TableView showing leagues with circular badges and league names  
  - Navigation to LeagueDetails on selection
    
- **Favorites**
    - TableView showing leagues with circular badges and league names  
    - Navigation to LeagueDetails on selection
    - Delete any favorite league
    
- **LeagueDetails**  
  - Favorite/unfavorite league button  
  - Upcoming Events (horizontal CollectionView)  
  - Latest Events (vertical CollectionView)  
  - Teams (horizontal CollectionView with circular team images)  

- **TeamDetails**  
  - Displays team details 

---

## Screenshots


---

## Technical Details

- Swift  
- UICollectionView & UITableView with custom cells  
- CoreData for local favorites storage  
- Networking (Alamofire) with TheSportsDB API  
- Offline detection and alert  
- UINavigationController for navigation  


