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

![alt text](https://cdn1.imggmi.com/uploads/2019/12/20/897df953ba488ddd0328fbbf06dc8177-full.png)

# Screenshots
Application supports both portrait and landscape orientations. Auto layouts are used to design screens in accordance with Apple Human Interface guidelines.

**Portrait**

![alt text](https://cdn1.imggmi.com/uploads/2020/1/18/2fa46776643333e553bf82694ad72055-full.png)

![alt text](https://cdn1.imggmi.com/uploads/2020/1/18/4bd8033c0f3cc5326d0159f574b21055-full.png)

**Landscape**

![alt text](https://cdn1.imggmi.com/uploads/2020/1/18/c3b50a591727371c145195318bfec8ea-full.png)

![alt text](https://cdn1.imggmi.com/uploads/2020/1/18/9a0966be374cd78ac5ab235ec5d7766d-full.png)


# Features
This app demonstrates the use of MVVM architecture for iOS applications.
- Swift 5
- Xcode 11
