# Introduction

Rktik ^[Rktik is a neologism reminiscent of the German "Arktis" and English "Arctic". It allows for a short domain name ([rktik.com](rktik.com)) and its connection to the Arctic, seafaring, and related concepts offer a variety of options for branding.] is an online community that allows like-minded people to collect and publish content together. Rktik is set apart from similar online services by its distinct modeling of individual user and group identity. This thesis describes Rktik’s conceptualization and software architecture and how it fulfills its development goals. The first chapter motivates the project and gives an introduction to methodology and comparable products. Then a conceptual description of Rktik’s functionality is given. Following that, the technical background of implementation and operation of the service is described. The last chapter contains an evaluation and discussion of the project and its future development.

## Motivation

Rktik is the successor to the Souma app, which started as a hobby project of Vincent Ahrend in 2012 and was then developed from 2013-2014 in the Cognitive Networks study project at University of Osnabrück [@Ahrend2015a]. Souma’s original motivation was the sharing of files with groups of friends in an application with a modern user interface that does not rely on the benevolence of central service providers. Over the course of development however, these goals changed significantly.

At first the aim was to combine social networking functionality with filesharing tools. A combination of these can only be provided by a decentralized system due to privacy and legal reasons. The *Cognitive Networks* study project developed this idea further and priorities shifted to focus on the more general goal of creating a *humanist reconstruction of social networks*. The motivation being “the drive to create a *social network* by understanding human subjects and their modes of being and interacting, and translating this into a virtual space that makes the social network experience more reflective and community based; less egocentric and consumption based” [@Ahrend2015a].

This shift in goals, combined with the remnants of various side projects embedded in the app, obscured the core of the project in Souma’s code base. Therefore, after the end of the study project, Rktik was conceptualized as a new web-based platform based on Souma. This process centered on a more limited focus: Developing a social publishing platform that implements a new concept of individual and group identity online. This concept will allow users to freely create new online identities in order to explore their personality and also to evade the now all-encompassing surveillance of online activities by corporations and government agencies. Sorted by priority, the goals of this process are:

1. Bringing the application from prototype status to being ready and useful for end users by implementing a complete feature set (*completeness*).
2. Selecting the smallest set of features that allows users an efficient management of privacy and can be implemented by a single developer (*feasibility*).
3. Stripping out and refactoring code from the Souma project in order to create a lean code base that can be maintained and extended in the future (*maintainability*).

## Problem: Privacy and Identity

The essential problem in managing privacy in online systems is the need of service providers to directly access user data. This need exists for both, web applications, as well as native applications ^[Native applications are run on the user’s local machine and stand in contrast to web applications that are run on a server and transmit their user interface as a web site.] that offload parts of their data processing to remote servers (which is the case for many native mobile applications). Companies need direct access to user data in order to take advantage of central data processing facilities running on web servers. Some of the advantages of web applications, as opposed to native applications without a remote backend, are: 1) no software piracy, 2) more efficient maintenance and solving of software bugs due to direct access to the running system, and 3) no need to support a wide range of (possibly low-performance) user hardware. 

Besides the need of service providers to access user data, government agencies are also surveilling large parts of online communications. While the extent to which large organizations can access user data is still not fully understood, it can be assumed that accessing unencrypted user data on web servers presents the lowest barriers to access. At the same time, data bound to a real person’s name is more valuable, since it can be easily combined with other data sources that are referring the name. This wide-spread surveillance from multiple fronts stands in stark contrast to the availability of accessible tools for shaping user’s online privacy and identity.

One possible solution is presented in the proposed peer-to-peer extension of Rktik (seesection [External Clients]). It would approach this problem directly by using cloud infrastructure for transferring data, while processing and storing data on user machines. While this solution does not offer the mentioned advantages of web applications, it offers a lot of value to users who place importance on their privacy. Due to the technical complexity of implementing a peer-to-peer protocol, a second solution to the problem was implemented.

The approach pursued in this thesis offers users increased control over their privacy by partially decoupling their offline identity from what they do online. This is achieved by extending the concept of pseudonymity in letting 1) a single person control multiple pseudonyms and 2) letting multiple persons control a shared pseudonym. This functionality allows users to blur the mapping between their real and online identities and thereby reduce the value of their user data to third parties.

## Methodology

The Rktik application is based on the Souma prototype developed in the Cognitive Networks study project (see @Ahrend2015). In line with the goals outlined in section [Motivation], Rtkik’s development process included

1. Defining required functionality
2. Setting up a development environment
3. Implementing features
4. Setting up third-party infrastructure
5. Finding and removing bugs
6. Evaluation

The Github issue tracker^[Access to the issue tracker is restricted to Github accounts registered as Rktik developers. See [Github Features](https://github.com/features)] was used to record these tasks and eventual subtasks. A Git repository, also hosted on Github, was used to track the contents of the source code. Changes in the source code are referenced from the issue tracker when they are connected to the resolution of an issue. Using Git and Github helps to keep an overview of tasks and their relation to specific source code changes and offers quick access to past versions of the source code. This feature can be valuable as it allows deleting code without worrying that it might still be needed later on in development.

The Rktik application is implemented in the Python programming language, using the Flask framework for web applications and the SQLAlchemy object relational mapper. Additionally, some features of the user interface are implemented using the jQuery library. The operating environment is provided by Heroku in the form of a  platform-as-a-service (PAAS). A PAAS allows uploading and running a web application on provisioned servers without having to configure these servers manually. See sectionsection [Hosting and Deployment] for more details on this process.

These choices were taken from the Souma project which used the same technological stack.

## State of the Art

This section describes approaches to social networks that share similarities with Rktik. I will explain their functionality and specifically focus on their representation of identity and related software features.

This comparison includes three social platforms with more than 100 million monthly active users, each of which has a bias towards a different communication structure. This includes Facebook as a social network used for communication within *peer-groups*, Reddit as an open social network where users publish to the *general public* and email as a communication medium used for *direct communication* with other users. All three services can also be used for one-to-one, one-to-many and many-to-many communication.

In the following, I will explain the basic functionality of each of the services and then compare them to Rktik.

**Facebook**

Available since: February 2004 \
Monthly active users: 1.49 billion as of June 30, 2015 ([@Facebook]) \
Website: [facebook.com](http://facebook.com/)

Facebook is an online social networking service, it allows friends and acquaintances to keep track of each other’s personal lifes. Facebook offers a similar core functionality to that of Rktik in that users can publish content on their profiles, vote ^[Votes on Facebook are called “like”.] and comment on content of other users and subscribe to their content feeds. Both services center the user interface on a feed of content from subscribed sources that is sorted based on a combination of recency and other factors. Facebook also allows users to create groups as either public or private spaces. Members can then communicate in a group chat or post messages to the group's feed. Messages can contain events, votes and files/media ^[Files must not be music or executables and their file size cannot exceed 25mb.]. Users may also communicate via private messages.

In contrast to these similarities, Facebook is different from Rktik both in policy and features. It requires users to identify with their real name and explicitly forbids creating more than one personal user account ([@Facebooka]).  Contents of the Facebook network are hidden from the public by default and accessible only once a friendship connection has been established with a user. Facebook groups can only choose to be either public or private. In contrast to Rktik, private groups cannot publish contents publicly and groups in general cannot publish content in the name of the group.

In addition to the core and group functionality, Facebook offers many features ranging from business directories to video calling. These have not been included in this comparison as they do not directly compare to features of Rktik.

**Reddit**

Available since: June 2005 \
Monthly active users: 203 million as of September 15, 2015 (@Reddita) \
Website: [reddit.com](https://reddit.com)

Reddit is a social link aggregator, it lets users create link and text submissions and sorts them based on user votes and recency. Submissions are created in *subreddits*, which are subcommunities of Reddit related to a specific topic. Each submission has a comments section in which its contents are discussed by the community. Comments can also be voted on and are displayed in a hierarchical layout based on their reply-structure. Each subtree is sorted according to number of votes and recency.

Users of reddit can collect *karma*, which is a numeric value that is displayed on their profile and indicates the amount of votes they have received on their own comments and submissions.

This core functionality of Reddit is mostly identical to that of Rktik.  Differences between the services can be found in their implementation of user and group identity as well as the way external contents are displayed.

In contrast to Facebook, Reddit encourages the creation of multiple accounts per user (@Reddit.com). However, it does not provide user interface controls for this. Every account is identified by its username, which is pseudonymous and does not necessarily reflect the real identity of a user in any way.

Users can not directly publish content on a user profile or blog, as all submissions must be placed in one of Reddit’s communities, which are called *Subreddits*. They allow the aggregation of content related to a specific topic. Their contents are visible either for the general public or only for confirmed members, as decided by the subreddit’s founding user. In contrast to Rktik, Reddit does not allow subreddits to aggregate content in a space visible only to members, while also publishing content in a public space.

The content on reddit.com is almost text-only. If a link submission points at an image, a small preview is displayed next to the submission’s title, while links to other content are never rendered inline.

**Email**

Available since: ~ 1971 ^[As the email protocol evolved over time from non-networked messaging protocols, there is no specific point in time from which on email was generally available. In 1971 the first networked electronic mail system for ARPANET was standardized (@[Crocker1982]).] \
Monthly active users: > 2 billion ^[It is difficult to estimate the number of people who actively use email because of the large number of email service providers. The market research firm Radicati estimated a number of 2.6 billion active email users in  2015 (@Radicati2011).] \
Website: none

Email is a protocol for distributing messages from an author to one or many recipients. While Rktik, Facebook and Reddit are offered by their respective providers, Email is a *method* of message delivery that is implemented by many service providers worldwide, while still allowing all users to exchange messages with each other. Email messages may also contain any number of media attachments.

A user of Email is identified by their email address. Some email service providers let users choose a username for themselves, while others have policies regarding usage of a real name or other personally identifying features, such as their role in a company. As there is no single user interface for email, users can chose from a wide range of software clients. These can be websites, dedicated email applications, or email features embedded in other applications. Available features depend entirely on the client used.

Email can be used in combination with *automated email lists* for similar use cases as those Rktik was designed for. Automated email lists, or *email lists*, are distribution services that forward incoming messages, sent to a special email address, to all users registered with the email list. Registration may be open to the general public or restricted to a group of users defined by the email list operator. Messages sent to the email list may also be read using a web based discussion archive.

An email list is similar to Rktik movements, subreddits and Facebook groups in that it provides members with a space for discussion and exchange related to a specific topic. Submissions are tied to their author and discussion may be hierarchically organized by reply-structure as is the case in Reddit and Rktik. Email does not provide a mechanism for voting on messages, so discussions are sorted chronologically. Email lists also do not offer features for collectively authoring content and publishing it to people outside the email list.

Platform	Username    Group Features
---         ---         ---
Facebook    Real name   Discussion, voting, group chat, events, file sharing
Reddit      Pseudonym   Discussion
Email       Both        Discussion, file sharing ^[File sharing may be prohibited by the email list operator.]
Rktik       Pseudonym   Discussion, group chat, publishing

Table: Overview of username restrictions and group features

In conclusion, Rktik as a social platform has many similarities to existing social platforms. Established concepts and functionality such as user profiles, private messaging, media attachments and others are extended with a novel conceptualization of personal and group identity. These new features extend user’s capabilities in shaping their privacy. New group functionality may serve as a catalyst to processes defining the group’s online identity. Other platforms, especially Facebook, also offer extended group features, but are not considering groups as an identity that can publish content itself.
