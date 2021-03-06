# Pre-work - Tip Calculator

Tip Calculator is a tip calculator application for iOS.

Submitted by: Lula Villalobos

Time spent: 20 hours spent in total

## User Stories

The following **required** functionality is complete:

* [+] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [+] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [+] UI animations
* [_] Remembering the bill amount across app restarts (if <10mins)
* [+] Using locale-specific currency and currency thousands separators.
* [+] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [+] Improved UI for better user experience
- [+] Make use of other controls


## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://s3-us-west-1.amazonaws.com/examplelulav14/TipCalculator.gif' title='Video Walkthrough' width='300' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I like a lot the iOS developer platform because I believe they've done it pretty simple and smooth for developers to create a basic app pretty quickly without the need to write a lot of code, specially for the visual part of the app. They handle this much more better than Android (even though they both use xml for the visuals) because here you can just add views and controlers manually without a code deficciency, whereas in Android you really need to code everything in xml or you'll probably end up with spaggueti code in xml 

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** You can get a strong reference cycle when you have two classes with a property referencing each other mutually. Basically they'll both be connected creating a cycle, so when you create an instance of those classes and at closure you assign them to a nil value the strong reference will not dissapear.   


## License

Copyright 2017 Lula Villalobos

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
