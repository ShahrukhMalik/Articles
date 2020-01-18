# Articles
A simple app to show a list of articles, that shows details when items on the list are tapped (a typical master/detail app)

# Content
1. Architecture Overview
2. How to build and run
3. Unit testing and code coverage
4. Screenshots
5. Features

# Architecture Overview
MVVM **(Model-View-View Model)** architecture is used to create this application so that view controllers dont become massive and code remains managable. Major components and there responsibilities for MVVM  architecture are as follows

**- Model** 
Model classes are used to store the actual data or information.

**- View Model** 
View Model is used to format and present data on views. It keeps the model layer separate from the view layer.

**- View** 
View in MVVM contains behaviors, events, and data-bindings that ultimately require knowledge of the underlying model and viewmodel.

# How to build and run
Open .xcodeproj and press **Command + R**

# Unit testing and code coverage
Open .xcodeproj and press **Command + U** to run the test cases. Code coverage is shown in following screenshot:-

![alt text](https://user-images.githubusercontent.com/11407348/72669828-f37b6880-3a4f-11ea-824e-e05ef0b7d06a.png)

# Screenshots
Application supports both portrait and landscape orientations. Auto layouts are used to design screens in accordance with Apple Human Interface guidelines.

**Portrait**

![alt text](https://user-images.githubusercontent.com/11407348/72670541-bd41e700-3a57-11ea-8675-edaf9cf12c99.png)

![alt text](https://user-images.githubusercontent.com/11407348/72670419-8cad7d80-3a56-11ea-84eb-9877ff99160d.png)

**Landscape**

![alt text](https://user-images.githubusercontent.com/11407348/72670552-de0a3c80-3a57-11ea-83e2-fd56733b693d.png)

![alt text](https://user-images.githubusercontent.com/11407348/72670441-b797d180-3a56-11ea-9a53-33c4b3cdb744.png)


# Features
This app demonstrates the use of MVVM architecture for iOS applications.
- Swift 5
- Xcode 11
