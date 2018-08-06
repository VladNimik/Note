# Note
###### Simple native iPhone application for management of personal notes
# 
##### Autor
Vladyslav Nimizhan (vladnimik@gmail.com)

## Installation
Opening `Notes.xcworkspace` build and run.

## Functionality
The application integrate API at http://private-9aad-note10.apiary-mock.com with different methods: 
 - GET /notes
 - GET /notes/{id}
 - POST /notes
 - PUT /notes/{id}
 - DELETE /notes/{id}
 
Main controller with list of notes is opened after opening of the application. User can find the needed note among all notes using `searchBar`, share or delete note with swipe cell. After removing note user can refresh table and observe all remaining notes. Also user can open note and create new by clicking on button `+` in `navigationBar`. Main page also contain the settings button which open `UIAlertViewController` where user can change the language of application to :
 - English (default)
 - Russian
 - Czech
 
In the second controller `NoteViewController` user can edit existing note. 
 

## Requirements

-  iOS 11.0 
-  XCode 9
-  Swift 4
-  Cocoapods

## Library 
 - Alamofire

## Examples

![Image 1](https://github.com/VladNimik/Note/blob/master/Notes/Assets.xcassets/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.37.18.imageset/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.37.18.png){:height="50%" width="50%"}
![Image 2](https://github.com/VladNimik/Note/blob/master/Notes/Assets.xcassets/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.45.10.imageset/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.45.10.png){:height="50%" width="50%"}
![Image 3](https://github.com/VladNimik/Note/blob/master/Notes/Assets.xcassets/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.45.34.imageset/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-08-06%20at%2010.45.34.png){:height="50%" width="50%"}






