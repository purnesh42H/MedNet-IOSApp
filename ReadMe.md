# MedNet

MedNet – A social media for medical help aims to provide a centralized location to connect with people based on your medical interests and needs. You can build authorized medical profile, and upload your medical documents to access them from anywhere

## App demo and report

- Please see this [demo video](App%20Demo.mov) for a little demo of things I implemented using SQLite database with swift
- Here is the [report](MedNet_ProjectReport.docx) of the project
- Please view the [powerpoint presentation](MedNet.pptx) created to explain the need and application of MedNet

## Database

- Database used: SQLite
- Database create script: CreateScript.sql
- DataBase: /MedNet/MedNet.db
- DataModel Classes:
  - /MedNet/MedNetUser.swift
  - /MedNet/Registered.swift
  - /MedNet/Civilian.swift
  - /MedNet/Doctor.swift
  - /MedNet/VolunteerOrganization.swift
  - /MedNet/Hospital.swift
  - /MedNet/All other classes.swift
  - /MedNet/SQLLiteDataStore.swift

## To run
- iOS projects run on Xcode(A software only available on MacOS). It can be
downloaded through the App store on MacOS
- open file /MedNet/SQLLiteDataStore.swift and change the value of
dbPath variable to the location of MedNet.db in your system. For instance, in my system, the location of db is ```/documents/IdeaProjects/MedNet/MedNet/MedNet.db```
So on line 32 of ```/MedNet/SQLLiteDataStore.swift```
I have set ```dbPath = "/documents/IdeaProjects/MedNet/MedNet/MedNet.db"```
- Open /MedNet/MedNet.xcodeproj
- Set the active scheme to iPhone6s
- command + R

## Contributing

- Fork it!
- Create your feature branch: `git checkout -b my-new-feature`
- Commit your changes: `git commit -m 'Add some feature'`
- Push to the branch: `git push origin my-new-feature`
- Submit a pull request.
