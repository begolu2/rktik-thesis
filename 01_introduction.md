# Introduction [5p]

Rktik is an online community allowing groups of like minded people to find each other, collect and publish content together. This document describes its software architecture with insight into development process where appropriate. The first part concerns motivation for the project, methodology and differentiation to similar products.

”Conceptual” part describes functionality present to a user of the software, “Implementation” part describes technical background of implementation and operation of the service. Finally, “Evaluation and Discussion” presents data about feature usage and outlines future plans for the project.

## Motivation

Souma started from the wish to share files with friends in groups of people without reliance on goodwill of centralistic providers of social networking systems. As such a system did not exist in 2012, I started developing the *Souma* app myself, changing requirements to the system significantly as I went along.

At first I wanted a system that extends the social environment given by websites such as Facebook with filesharing functionality that can only be provided by a decentral system due to privacy and legal reasons. As the idea was further developed by me and other members of the *Cognitive Networks* study project at University of Osnabrück, priorities shifted to a focus on the more general goal of *humanist social platform*. This would not place economic constraints and existing metaphors for social software systems at the center of its conceptualization, but instead build it up from the ideals of humanism.

This shift in the goals of the study project, combined with the remnants of various side projects embedded in the Souma app, left the code base in a cluttered state. Therefore, after the end of the study project, I started developing Rktik as a new web-based platform based on the server-side component of Souma. It has now a much more limited focus: Developing a social publishing platform that implements a new concept of individual and group identity online. The goals of this process were , in order of priority:

1. Bringing the application from prototype status to an application open for endusers
2. Selecting an effective, yet minimal set of features for personas and movements that allows an efficient management of privacy
3. Stripping out and refactoring code from the Souma prototype that is no longer required in Rktik

## Problem: Privacy and Identity

The essential problem in managing privacy in online systems is the neccessity of service providers to directly access user data, which exists for both cloud-based web applications and many native applications that offload parts of their data processing to web servers (which is the case for most mobile apps). Companies need direct access to user data, so that they can take advantage of central data processing facilities running on web servers. Some of the advantages of server-based systems as opposed to software distributed to and installed on user machines are 1) no software piracy, 2) more efficient maintenance due to direct access to the running system, 3) no need to support a wide range of (possibly low-performance) user hardware.

The proposed P2P extension of Rktik (see [Peer to Peer Extension]) tackles this problem directly, by using cloud infrastructure for transferring data while processing and storing data on user machines. While this exposes the system to aforementioned problems, the advantage gained in letting user’s completely control their privacy can be tremendous. Due to the technical complexity of this approach, this thesis presents a second solution to the problem.

Rktik offers its users increased control over their privacy, by partially decoupling their identity offline from what they publish online. This is achieved by extending the concept of pseudonymity in letting 1) a single person control multiple pseudonyms and 2) letting multiple persons control a shared pseudonym.

## Methodology

The Rktik application is based on the Souma prototype developed in the Cognitive Networks study project (CITE). In line with the goals outlined in [Motivation], the development process included 

1. Defining required functionality
2. Setting up a development environment
3. Implementing features 
4. Setting up third-party infrastructure
5. Finding and removing bugs
6. Evaluation 

The Github issue tracker was used to record these tasks and eventual subtasks. A Git repository, also hosted on Github, was used to track the contents of the source code and links changes in source code over the course of the project to the relevant tasks that these changes affected. While the Git+Github combination offers the most advantages to team-based programming projects, it helped me to avoid getting sidetracked during the development process and instead focus on the most relevant next steps.

The Rktik application is implemented in the Python programming language, using the Flask framework for web applications and the SQLAlchemy object relational mapper. Additionally, some features of the user interface are implemented using the jQuery library. The operating environment is provided by Heroku in the form of a  platform-as-a-service (PAAS). A PAAS allows uploading and running a web application on provisioned servers without having to configure these servers manually. See [Hosting and Deployment] for more details on this process.

These choices were taken from the Souma project, which used the same technological stack.

## State of the Art 

This section describes approaches to social networks which share similarities with Rktik. All of them allow users to publish messages to a single user or many users on the service. I will explain their functionality and focus on their representation of identity and related software features. 

The comparison includes Facebook as a social network mostly used for communication in *peer-groups*, Reddit as an open social network where users mostly publish to the *general public* and email as a communication medium mostly used for *direct communication* with other users. All three services can also be used for one-to-one and one-to-many communication as well as for communication in a social group of limited scope.

In the following, I will explain the basic functionality of each of the services and then detail what makes them similar and different from Rktik.

**Facebook**

Facebook is an online social networking service, it allows friends and acquaintances to keep track of each other’s personal lifes. Facebook offers a similar core functionality to that of Rktik in that users can publish content on their profiles, vote and comment on content of other users and subscribe to their content feeds. Both services center the user interface on a feed of content from subscribed sources that is sorted based on recency as well as other factors. Facebook also allows users to create groups as either public spaces related to a topic or private spaces for exchange of messages between group members. Users may also send private messages to their “friends”.

Facebook is different from Rktik both in policy and features. It requires users to identify with their real name and explicitly forbids creating more than one personal user account.  Contents of the Facebook network are hidden from the public by default and made available only once a friendship connection has been established with a user. Facebook groups can only choose to be either public or private. They can’t exchange some messages privately and publish others to the public.

In addition to the core functionality, Facebook offers many more features from business directories to video calling. I have not included them in this comparison as they don’t compare to features of Rktik.

**Reddit**

Reddit is a social link aggregator, it lets users create link and text submissions and sorts them based on user votes and recency. Submissions are created in “subreddits”, which are subcommunities of Reddit related to a specific topic. Users may also use the comments section on every submission for discussion with other users. Comments can be voted on and are displayed in a hierarchical layout based on their reply-structure. Each subtree is sorted according to number of votes and recency. Users of reddit can collect “karma”, which is a numeric value displayed on their profile that indicates the amount of votes they have received on comments and submissions created on the site.

This core functionality of Reddit is identical to that of Rktik.  Differences between the services can be found in their implementation of user and group identity as well as their layout. 

In contrast to Facebook, Reddit encourages the creation of multiple accounts per user (@Reddit.com). It doesn’t however provide user interface controls for this use case. Every account is identified by its username, which is pseudonymous and does not neccessarily reflect the real identity of a user in any way.   

Users can not directly publish content on their user profile as all submissions must be placed in an existing community/*subreddit*. Subreddits allow the aggregation of content related to a specific topic. These contents can be made visible only to confirmed members of the subreddit, or to the general public. In contrast to Rktik, Reddit doesn’t allow subreddits to aggregate content in a space visible only to members, while also publishing content in a public space.

The content on reddit.com is almost text-only. If a link submission points at an image, a small preview is displayed next to the submission’s title, while links to other content are never rendered inline. 

**Email**

Email is a protocol for distributing messages from an author to one or many recipients. While Rktik, Facebook and Reddit are offerings provided by specific providers, Email is a *method* of message delivery that is implemented by many different service providers worldwide, while still allowing all users to exchange messages with each other. Email messages may also contain any number of media attachments.

A user of Email is identified by their email address. Some email service providers let users chose a username for themselves, while others have policies regarding usage of a real name or other personally identifying features such as their role in a company. As there is no unified user interface for email services, users can chose from a great range of email clients. These can be websites, dedicated email applications or email features embedded in other applications. Available features depend entirely on the client used.

Email can be used in combination with *automated email lists* for similar usecases as those that Rktik was designed for. Automated email lists or *email lists* are distribution services that forwards incoming messages, sent to a special email address, to all users registered with the email list. Registration may be open to the general public or restricted to a group of users defined by the email list operator. Messages sent to the email list may also be read using a web based discussion archive. 

An email list is similar to Rktik movements, subreddits and Facebook groups in that it provides members with a space for discussion and exchange. Submissions are tied to their author and discussion may be hierarchically organized by reply-structure as is the case in Reddit and Rktik. Email does not provide a mechanism for voting on messages, so discussions are sorted chronologically. Email lists also can’t collectively author content and publish it to people outside the email list using email list features.
