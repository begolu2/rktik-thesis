# Evaluation and Discussion

Rktik is an evolution of the Souma prototype, introducing changes in some areas and taking a completely different approach in others. In this section I will reflect critically on how Rktik measures up to expectations set at the onset of its implementation and underline these findings with data from quantitative usage metrics.

## Personal Evaluation

The goals of **completeness**, **feasibility** and **maintainability**, as defined in the [Methodology] section, have been reached by the implementation described in this document. Development of the neccessary features for publishing and discussing content using Personas and Movements have been built, and an appropriate environment for the operation of Rktik has been configured. While these initial goals are important, other aspects of Rktik have shown shortcomings in the course of development and testing. In this areas I have identified three aspects based on my own experiences and informal feedback received from acquaintances.

1. Some of the concepts used in Rktik, such as the distinction between a private mindspace and a public blog or the concept of movements, are hard to understand for new users. This problem should be approached by building a tutorial, which explains the core mechanics and concepts in Rktik. It can be presented after signup and should both inform users and 

2. As described in the section [Improving Performance], the site’s speed is still too low to be satisfactory to many users. This can be improved by setting up periodically running background processes, which precompute database queries and store them in memcache. Site performance could also be improved significantly by moving Rktik to more powerful servers, which increases the costs of running the service.

3. Rktik features interesting content that is regularly updated. Users who have signed up for an account but don’t visit the site regularly could benefit from this through a periodic email newsletter. Each edition of the newsletter could feature the most interesting content on Rktik as measured by votes receivd on thoughts.

## Usage Metrics

Usage metrics have been collected anonymously using the Amplitude and Google Analytics services. These are external services which receive usage data via short Javascript scripts embedded in every served page. As I consider this usage data *personal information*, I have collected it anonymously. This prevents me from filtering my own usage of the service from the metrics. While Google Analytics tracks information about page requests, Amplitude tracks specific, manually defined events that can occur after a page was fully loaded.

Google Analytics collected data since making rktik.com accessible to the public on July 26th 2015 until today, October 2nd 2015 for a total of 68 days. Amplitude collected data from August 8th 2015 until today, October 2nd 2015 for a total of 55 days. This difference exists because I only found out about Amplitude when the measurement had already begun. 

Google Analytics and Amplitude collect extensive amounts of information. As a complete analysis of the data would go beyond the scope of this thesis, I have focussed on three key metrics: 1) The total number of usage sessions, 2) the number of users per week, 3) the number of users who have used specific features  and 4) the number of thoughts and votes created. I chose these metrics because they reflect both the total amount of usage as well as the relative popularity of specific features.

For the purpose of this evaluation, a *user* is defined as a web browser used to access Rktik. In contrast to the definition given in [Terminology], this does not discriminate between users with an Rktik user account and anonymous users. While it is possible, that a person uses more than one web browser to access Rktik, this is not differentiated as it is not technically feasible to identify this behavior. Usage assessment using Google Analytics and Amplitude relies on Javascript scripts embedded in the site. If a user has blocked these scripts or disabled Javascript altogether in their browser, their usage is not recorded.

### Usage sessions

The number of sessions was assessed using Google Analytics. A session is defined as a group of interactions by a user that takes place within 30 minutes or until midnight (@Google). A total of 825 sessions were started, most of which took place in the first weeks of operation. 

![Number of sessions]

### Users per week

The number of users per week was assessed using Amplitude. The count rises from two users in the first week of measurement to seven users in the third and fourth week, takes a plunge to three users and then rises from week to week up to a maximum of 17 users in the 9th week of operation.

![Number of weekly users]

### Usage of features

The number of users who have used specific features at least once in a given week was assessed using Amplitude. A count was recorded by firing an Amplitude callback when a user triggers the user interface control associated with the measured action.

#### Creating a thought

Evaluated: 1) submitting the inline form for creating a thought 2) submitting the form on the dedicated *create thought* view

![Number of users who created thoughts]\

The number of users who create thoughts varies between one and three over the duration of measurement. The maximum number of three users was first reached in the fourth week of measurement and in the last three weeks of measurement there were never less than three users creating thoughts. While only a small amount of total users register an account, only a small amount of registered users actually create content on the site.

#### Editing a thought

Evaluated: Submitting the form for editing a thought in the *edit thought* view.

![Number of users who edited thoughts]\

The number of users who edited thoughts in a given week varies between zero and two users. Unexpectedly, this number is not much lower in a given week than the number of users who created thoughts which means that most users who create thoughts also edit them.

#### Clicking the graph visualization

Evaluated: Completed mouse click in any part of the frontpage graph visualization (see [Frontpage Graph Visualization]).

![Number of users who clicked the frontpage graph visualization]\

The number of users who clicked on the frontpage graph visualization varies between a minimum of zero users in the first two weeks and a maximum of three users in the fourth week of measurement. As the number of of clicks does not return to the maximum of three users and rests at one user per week in the last two weeks of measurement, it may be that users try this feature only once and don’t return to it later.

#### Follow or unfollow a blog

Evaluated: Complete asynchronous callback following a click on the *follow* or *unfollow* buttons located in movement or personal blogs and in movement mindspaces.

![Number of users who followed or unfollowed blogs]\

The number of users who follow or unfollow blogs lies between zero and two users over the course of measurement. This number is unexpectedly low in relation to the total number of active users, especially towards the end of the measurement. This may indicate that users don’t understand the purpose of this feature well enough. Educating users about the possibility of controlling the contents of their frontpage by following or unfollowing blogs may lead to a better user experience for them.

#### Toggle membership in a movement

Evaluated: Complete asynchronous callback following a click on the *Join movement* or *Leave movement* buttons located in movement blogs and movement mindspaces.

![Number of users who toggled their membership status]\

The number of users who toggle their membership in movements is one or two in the first three weeks, reaches a maximum of three users in the fourth week and varies between one and two users for the remainder of the measurement. Similar to the number of users who follow or unfollow blogs, this number is unexpectedly low and suggests that users don’t understand the benefits of controlling their membership in movements well enough.

#### Accessing the notebook view

Evaluated: Loading the notebook view

![Number of users who opened the *notebook view*]\

The number of users who view their notebook is zero in the first week and varies between one and three users for the remainder of the measurement. The feature was not used in the first week because it was only activated in the second week of measurement. Engagement with this feature may be higher if it was more integrated with other features of the site. Right now, the flow of data in and out of the notebook is achieved via the *repost* functionality. This mechanism may be poorly understood by users which could be helped by a more comprehensive tutorial for new users.

#### Toggling a vote

Evaluated: Completed mouse click on a vote button

![Number of users who cast votes]\

The number of users who cast votes rises from one in the first week to four in the third week and remains at this level except for the 5th and 6th weeks where two and five users engaged with the feature respectively. This feature is the most popular in this comparison, which confirms its nature as a low-barrier way of engaging with content in Rktik. 

## Movement Agency

Movement agency as described in Section: Specific Patterns Movement Identity attributes action of members of a movement to the movement as a whole and thereby communicates the agency of the movement. Currently, movement can post thoughts to their blog as the sole action available. The concept can be furthered by introducing novel movement actions that can be triggered by members:

**Events**

A movement member may propose an event in the movement mindspace. An event consists of a title, location, date, time and privacy setting (members only or public) and can be implemented as an attachment type. Movement members may vote on whether the event proposal is made public which would display it prominently in the movement mindspace or movement blog depending on the events privacy settings. The proposal may be modified after posting in order to satisfy concerns voiced by other members in the events comments section and thereby gain the necessary votes to make it an official event.

**Public Chat**

A movement’s blog may contain a chat module, which non-members can use to converse with the movement. Messages entered into this chat would be displayed in the movement mindspace for members to see. Members can then propose answers and other members can confirm these by voting to a certain threshold. The user who posted the original message into the movement chat would then be shown the answer attributed to the movement as a whole.

**Posting in other parts of the site**

Members may propose a thought to be posted with attribution to the movement in another part of the site. This could be a personal message to a Persona, a reply to any thought not in the movement itself or as a message in the public chat of another movement (as described above).

## External Clients [2p]

An API is an application programming interface, which means ___.  

I want to build the API primarily for a client that is installed on a users computer, but it may also be used for third party services built on data published by Rktik. Usage scenarios might include A, B, C.

An external client has the advantages A, B, C. The disadvantages are X, Y, Z.

The API needs the capabilities of ___ presented as API endpoints with respective functionality. It also needs to be robust against abuse from third parties.

### Serialization and Encryption

Data transmitted via the API is to be end-to-end encrypted unless it is visible on the public part of the website. JSON and HTTP REST APIs have emerged as defacto standards in the web infrastructure. The API will serialise ORM models into JSON representations which are then encrypted and wrapped in another JSON representation.

[graphic]

Please see Appendix: API Specification for the full API specification.

### Peer to Peer Extension

Peer to peer is usually referring to a network transport model that doesn’t use server relays for data transmission, but instead exchanges data directly between end user machines. 

Server based infrastructure however has become very inexpensive while offering an unsurpassed performance. The original motivation for peer to peer transfer can still be retained using a server based network if the information transferred is only passing from peer to peer without being readable while in the server-based network. 

This is achieved by using end-to-end-encryption. While there are many libraries available that implement cryptographic primitives there is no clearly identifiable industry standard. The Souma prototype’s encryption was built using the Google Keyczar library and its implementations of the AES and RSA algorithms in combination with an HTTP based mechanism for key exchange.

[Number of users who clicked the frontpage graph visualization]: img/eval_click_graph.png
[Number of users who created thoughts]: img/eval_create_thought.png
[Number of users who edited thoughts]: img/eval_edit_thought.png
[Number of users who followed or unfollowed blogs]: img/eval_follow.png
[Number of users who toggled their membership status]: img/eval_membership.png
[Number of users who opened the *notebook view*]: img/eval_notebook.png
[Number of sessions]: img/eval_sessions.png
[Number of users who cast votes]: img/eval_vote.png
[Number of weekly users]: img/eval_weekly_users.png