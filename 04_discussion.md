# Evaluation and Discussion

Rktik is an evolution of the Souma prototype, introducing changes in some areas and taking a completely different approach in others. In this section I will reflect critically on how Rktik measures up to expectations set at the onset of its implementation and underline these findings with data from quantitative usage metrics.

## Personal Evaluation

The goals of **completeness**, **feasibility** and **maintainability**, as defined in section [Methodology], have been reached by the implementation described in this document. Development of the necessary features for *publishing* and *discussing* content using personas and movements have been built, and an appropriate environment for the operation of Rktik has been configured. While these initial goals are important, other aspects of Rktik have shown shortcomings in the course of development and testing. In this areas I have identified three aspects based on my own experiences and informal feedback received from acquaintances.

1. Some of the concepts used in Rktik, such as the distinction between a private mindspace and a public blog or the concept of movements, are hard to understand for new users. This problem should be approached by building a tutorial, which explains core mechanics and concepts. It can be presented after signup and should be conceived for both new users with an account and potential, but unregistered users.

2. As described in the section [Improving Performance], the site’s speed is still too low for web user’s expectations. This can be improved by setting up periodically running background processes that precompute database queries and store them in memcache. Site performance could also be improved significantly by moving Rktik to more powerful servers, which however increases the costs of running the service.

3. Rktik features interesting content that is regularly updated. Users who have signed up for an account but do not visit the site regularly could benefit from this through a periodic email newsletter. Each edition of the newsletter may feature the most interesting content on Rktik as measured by votes received on thoughts.

## Usage Metrics

Usage metrics have been collected anonymously using the Amplitude^[[Amplitude website](https://amplitude.com/)] and Google Analytics^[[Google Analytics website](https://www.google.com/analytics/)] services. These are external services which receive usage data via short Javascript scripts embedded in every served page. As I consider this usage data *personal information*, it is collected anonymously. While Google Analytics tracks information about page requests, Amplitude tracks specific, manually defined events in a user’s interaction with the site.

Google Analytics data is included since making rktik.com accessible to the public on July 26th 2015 until October 2nd 2015 for a total of 68 days. Amplitude data is included from August 8th 2015 until October 2nd 2015 for a total of 55 days. This difference exists because I only found out about Amplitude when measurement had already begun.

Google Analytics and Amplitude collect extensive amounts of information. As a complete analysis of the data would go beyond the scope of this thesis, I have focussed on four kinds of measurement: 1) The total number of usage sessions, 2) the number of users per week, 3) the number of users who have used specific features in a given week, and 4) the number of thoughts and votes created. These metrics were chosen because they reflect the total amount of usage, as well as the relative popularity of specific features.

For the purpose of this evaluation, a *user* is defined as a web browser used to access Rktik. In contrast to the definition given in the [Terminology], this does not discriminate between users with an Rktik user account and anonymous users. While it is possible that a person uses more than one web browser to access Rktik, this is not reflected in measurements. Usage assessment using Google Analytics and Amplitude relies on Javascript scripts embedded in the site. If a user has blocked these scripts or disabled Javascript altogether in their browser, their usage is not recorded.

### Usage sessions

The number of sessions was assessed using Google Analytics. A session is defined as a group of interactions between a user and the website that takes place within 30 minutes or until midnight (@Google). A total of 825 sessions were started, most of which took place in the first weeks of operation. The number of sessions following the first two weeks of operation may have been higher if Rktik had been promoted more extensively. This process was stalled due to the currently high access times described in [Improving Performance].

![Number of sessions]

### Users per week

The number of users per week was assessed using Amplitude. The count rises from two users in the first week of measurement to seven users in the third and fourth week. It takes a plunge to three users and then rises from week to week up to a maximum of 17 users in the 9th week of operation.

![Number of weekly users]

### Usage of features

The number of users who have used specific features at least once in a given week was assessed using Amplitude. A count was recorded by firing an Amplitude callback when a user triggered the user interface control associated with the measured action. In the following I list the assessed metrics and events used to measure them and describe the resulting measurement data.

#### Creating a thought

Evaluated: 1) submitting the inline form for creating a thought 2) submitting the form on the dedicated *create thought* view

![Number of users who created thoughts]\

Over the duration of measurement the number of users who create thoughts in a given week varies between one and three. The maximum number of three users was first reached in the fourth week of measurement and in the last three weeks of measurement there were never less than three users creating thoughts. Only a small amount of total users registered an account on Rktik. Out of those registered users, only a small amount actively created content.

#### Editing a thought

Evaluated: Submitting the form for editing a thought in the *edit thought* view.

![Number of users who edited thoughts]\

The number of users who edited thoughts in a given week varies between zero and two. Unexpectedly, this number is not much lower in a given week than the number of users who created thoughts. This means that most users who create thoughts also edit them.

#### Clicking the graph visualization

Evaluated: Completed mouse click in any part of the frontpage graph visualization (see [Frontpage Graph Visualization]).

![Number of users who clicked the frontpage graph visualization]\

The number of users who clicked on the frontpage graph visualization in a given week varies between a minimum of zero users in the first two weeks and a maximum of three users in the fourth week of measurement. As the number of clicks does not return to the maximum of three users and rests at one user per week in the last two weeks of measurement, it may be assumed that users try this feature only once and do not return to it later.

#### Follow or unfollow a blog

Evaluated: Click on the *follow* or *unfollow* buttons located in movement or personal blogs and in movement mindspaces.

![Number of users who followed or unfollowed blogs]\

The number of users who follow or unfollow blogs lies between zero and two users over the course of measurement. This number is unexpectedly low in relation to the total number of active users, especially towards the end of the measurement. This may indicate that users do not understand the purpose of this feature well enough. Educating users about the possibility of controlling the contents of their frontpage by following or unfollowing blogs may lead to a better user experience for them.

#### Toggle membership in a movement

Evaluated: Click on the *Join movement* or *Leave movement* buttons located in movement blogs and movement mindspaces.

![Number of users who toggled their membership status]\

The number of users who toggled their membership in movements is either one or two in the first three weeks, reaches a maximum of three users in the fourth week and varies between one and two users for the remainder of the measurement. Similar to the number of users who follow or unfollow blogs, this number is unexpectedly low and suggests that users do not understand the benefits of controlling their membership in movements well enough.

#### Accessing the notebook view

Evaluated: Loading the notebook view

![Number of users who opened the *notebook view*]\

The number of users who view their notebook is zero in the first week and varies between one and three users for the remainder of the measurement. The feature was not used in the first week because it was only activated in the second week of measurement. Engagement with this feature may be higher if it was more integrated with other features of the site. Right now, the flow of data in and out of the notebook is achieved via the *repost* functionality. This mechanism may be poorly understood by users which could be helped by a more comprehensive tutorial for new users.

#### Toggling a vote

Evaluated: Completed mouse click on a vote button

![Number of users who cast votes]\

The number of users who cast votes rose from one in the first week to four in the third week and remained at this level except for the 5th and 6th weeks, where two and five users engaged with the feature respectively. This feature was the most popular in this comparison, which confirms its nature as a low-barrier way of engaging with content in Rktik.

The evaluation of user metrics shows how different features are accepted by users. Although the explanatory power of these observations is limited due to the low number of users, some interesting observations include the fact that a high number of users edit their posts and that very few users change their blog subscriptions or membership in movements. Especially the latter fact highlights the need for a tutorial that will guide new users through the features of Rktik. The continued observation of these measurements will allow a focussed development of Rktik in the future.

## Movement Agency

Rktik communicates to its users that movements have agency. This is established by attributing actions taken by its members to the movement itself, once they are confirmed by a certain number of other members. As described in [Movements] this process 1) guards members’ privacy and 2) may establish stronger cohesion between movement members.

While this concept may be applicable to a wide range of actions, Rktik’s current implementation only supports attributing authorship of a thought to a movement (see [Promoting Content]). In this section I will present three options for other actions that may be attributed to a movement’s agency through building consensus among its members.

Planning and voting of any such collective actions may be conducted using a novel interface control which allows members to 1) identify the proposed action, 2) propose changes, and 3) vote on its implementation. This control should be designed for the control of all action types to simplify the process for inexperienced users.

**Events**

A movement member may propose an event in the movement mindspace. An event consists of a title, location, date, time and privacy setting (visible only for members or for all users) and can be implemented as an attachment type. Other members can discuss the events and propose changes to be made by the author in order to gain their consensus, and thus the necessary votes for making the event official. Finally, members vote on the event. If this shows that consensus is reached, the movement displays the event prominently in the movement mindspace or movement blog, depending on the event’s privacy settings. The final event posting is attributed to the movement and not its original author. This mechanic would allow movement members to organize collective action outside of Rktik’s online context.

**Public chat**

A movement’s (public) blog may contain a chat module, which non-members can use to converse with the movement as a whole. Messages entered in this chat would be displayed in the movement mindspace for members to see. Members can then propose answers and other members can confirm these by voting on them. The non-member who posted the original message into the movement chat would then be shown the answer attributed to the movement as a whole.

**Creating thoughts in other parts of the site**

Members may propose a thought to be posted with attribution to the movement in another part of Rktik. This could be a personal message to a persona, a reply to any thought not in the movement itself or as a message in the public chat of another movement (as described above). Changes to the proposed thought may be discussed by members beforehand as described for *events* and *public chat* .

## External Clients

Rktik is the successor to Souma, which is a prototype for a decentral social network as described in [Problem: Privacy and Identity]. While Rktik is not built as a decentral system, its design allows a future extension with such functionality. Such an extension would entail two parts: 1) a publicly accessible API for Rktik’s Nucleus backend, and 2) a local client application that connects to this API. Using a local client makes a new usage pattern possible in which a private movement’s  internal data is only stored in encrypted form on the server. Encrypted information about members’ activity would be distributed among them via the API. Information would only be made available in unencrypted form on the rktik.com website once members have decided on a collective action. In this section I will outline the components necessary to build this extension based on the design implemented by Souma (see @Ahrend2015).

**API for Rktik’s Nucleus module**

An API is an interface between two separate pieces of software. JSON and HTTP REST APIs have emerged as de facto standards in web infrastructure (CITE). The API will serialise ORM models into JSON representations that are encrypted, signed and wrapped in a second layer JSON representation for transfer.

[TODO: Diagramm]

The API will be designed primarily for a client that is installed on a user’s computer, but it may also be used for third party services built on data published by Rktik. Usage scenarios include clients for mobile devices or third-party websites that interact with Rktik.

**Local client application**

An external client uses the aforementioned API to exchange data with Rktik’s server-based Nucleus backend and provides its own user interface on the user’s local machine. The implementation of this user interface may reuse most of the code from Rktik’s Glia web server to locally serve a version of the site via a loopback connection ^[TODO: Footnote about loopback connections]. Differences in implementation would be expected mostly from 1) code to access the API, and 2) performance optimizations for personal computers.

While such an implementation of an external client would not technically constitute peer to peer data transfer, as data is still transferred using a server, it would bring all of its advantages with it: End-to-end-encryption of data ensures that the contained *information* is only available at the endpoints of communications. At the same time, the server-based infrastructure would 1) ensure that data is available, even when no local machines are online, and 2) increase synchronization speeds significantly by profiting off the superior connection speeds available in data centers.

[Number of users who clicked the frontpage graph visualization]: img/eval_click_graph.png
[Number of users who created thoughts]: img/eval_create_thought.png
[Number of users who edited thoughts]: img/eval_edit_thought.png
[Number of users who followed or unfollowed blogs]: img/eval_follow.png
[Number of users who toggled their membership status]: img/eval_membership.png
[Number of users who opened the *notebook view*]: img/eval_notebook.png
[Number of sessions]: img/eval_sessions.png
[Number of users who cast votes]: img/eval_vote.png
[Number of weekly users]: img/eval_weekly_users.png
