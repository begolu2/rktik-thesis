# *Bachelorarbeit Outline*


# Introduction [5p]

Souma is an X allowing Y to do Z. This document describes software architecture with insight into development process where appropriate. The first part concerns motivation for the project, methodology and differentiation to similar products.

”Conceptual” part describes functionality present to a user of the software, “Implementation” part describes technical background of implementation and operation of the service. Finally, “Evaluation and Discussion” presents data about feature usage and outlines future plans for the project.

## Motivation [1p]

Souma started from the personal need to share files with friends in groups of people without reliance on goodwill of centralistic providers of social networking systems. 

Distributed communications systems are built for the use case of  either file transfers or chatting. Want a system that integrates  modes of communication in digital social settings and offers persistence and privacy.

Group brain metaphor, system for distributing attention in a group, hierarchical conversations

Souma study project, feature crawl, group organization cluttered source code, stand-alone application

New start, clean source code, refactoring again and again. Good Rktik.

## Problem: Privacy and Identity [1p]

What is the problem with privacy online?

Why are cloud-based social networks inherently limited with regard to privacy?

Why is communication using multiple Personas important?

What is in a Persona? How are they differentiated?

## Methodology [1p]

Rktik was written mostly in the Python programming language for the backend and uses an HTML + Javascript stack for the frontend.

Most important Libraries used include X, Y, Z. 

### Tracking Source Code and Open Tasks

Source code was tracked using Git and the method described at ___. Git repository is hosted on Git, where also the Wiki and Issue tracker are used under the X, Y, Z rules.

## State of the Art [2p]

State of the art compares one social network restricted to personal space, one open social network, and one old social network.

1. Facebook

Facebook is an X, it is made for Y so they can Z.

Facebook is similar to Rktik in that it ___.

Facebook is different from Rktik in that it ___.

2. Reddit

Reddit is an X, it is made for Y so they can Z.

Reddit is similar to Rktik in that it ___.

Reddit is different from Rktik in that it ___.

3. Email

Email is an X, it is made for Y so they can Z.

Email is similar to Rktik in that it ___.

Email is different from Rktik in that it ___.

# Conceptual

## Overview [1p]

This section will explain the user-facing functionality of the Rktik website. The first subsection deals with patterns, that have been implemented in other sites before, although those implementations might differ substantially. The second subsection describes patterns unique to Rktik.

Patterns will be described in the order users are expected to encounter them using the site.

### Brain Metaphor in User Interface

The Rktik UI uses a brain metaphor in naming concepts to convey the sense that users are participating in the thinking of a virtual mind. Users can create thoughts which consist of a short title text and any number of media attachments (pictures, links, longer texts). These thoughts are posted into mindsets, which are collections of thoughts. 

Every user has a private mindset and a public mindset (blog). Movements are subsection of the site where users can collect thoughts related to the movement’s mission statement. A movement also has both a mindset for members to converse in and a public mindset (blog). When a sufficient number of movement members cast their vote on a thought, it is automatically copied to the movement blog.

## Patterns Adapted from Social Media [5p]

### User accounts

User accounts on Rktik consist of an email address, a password, a set of settings for which email notifications the user wishes to receive and a unique ID. The account feature serves two main purposes:

1. Authorizing a user’s identity by asking them to enter the account-specific password. Authorized users may act on the site as one of the Personas connected to the user account.
2. Binding an email address to a specific user, so that they may be sent notifications and similar messages related to their activity on the site.

Only users of the Rktik site that have a validated user account can act on the site by casting votes, creating thoughts, etc. 

The email address attached to a user account is validated by sending a confirmation email that contains a link the user ought to click. If the user has no access to the email address they cannot click the link.

### Thoughts and Voting

Thoughts are the primary means of communicating in Rktik and rougly equivalent to a post/submission on Facebook or Reddit. They consist of a short text with no more than 300 characters and any number of attachments. A longer title would have required a more flexible site layout in many different places which are to accommodate single thoughts. 

Along each thought, the number of votes cast on them and the context they were posted in is displayed. The context may either be a mindset (blog or mindspace, either of a Persona or a Movement) or, if the thought was posted in reply to another, its parent thought. 

#### Hot Ranking

Thoughts may either be sorted chronologically (in a Blog or chat) or by their hotness value. This is a numeric value which depends on the age of a Thought and the number of votes it has received. Its effect is that thoughts with equal numbers of votes are sorted chronologically, while each vote will push the thought forward in the ordering.

Given the number of upvotes v and the number of hours since the thought was created t, a thoughts hotness is:

	hot = v / pow(t + 2, 1.5)

This algorithm is adapted from the one in use on Hacker News (link).

### Attachments

Thoughts may have any number of attachments for enriching their content. These may either be rendered inside the user interface or presented as links to other websites. 

Currently the following attachment kinds are supported:

* **Links** Can be attached by typing a URL in the thought title or the longform text field.

Links to pictures may be rendered inline with the thought. Clicking the picture displays it enlarged in a modal view. If multiple links to pictures are linked to the thought, the modal view allows browsing the pictures as a gallery with the arrow keys on the keyboard.

Links that point to the soundcloud.com or youtube.com domain may be rendered using the respective embedded widgets to allow playing music and videos respectively without leaving the Rktik website.

* **Longform text** As thought titles are limited to 300 characters, the longform text attachment allows adding a longer text. This text may also be formatted using Markdown, which allows using basic text formatting such as headlines, enumerations, bold and italic text.

### Blogs

Blogs allow users to share their thoughts with an audience and contain thoughts sorted in reverse chronological order. Each Personas and Movement has their own blog. A blog can be followed by otehr users, which will cause its contents to be embedded in their personal frontpage.

Personas can directly post new thoughts on their blog, while Movements can only indirectly place content in it with the voting mechanism (see Movements section).

In addition to the blog, Personas and Movements can also collect content in their personal mindspace (see Mindspace section).

### Frontpage

The Frontpage allows users to see interesting content across all their followed content sources and is similar to the Facebook News Feed and the Reddit Frontpage. This view is specific to the currently activated Persona and contains thoughts from all their followed Blogs as well as thoughts from Mindspaces of Movements they are a member of. All the thoughts from these sources are sorted by their hotness value (see Hotness) with only the top X (TODO: how many) shown.

Anonymous users don’t have any subscriptions, they are shown thoughts from the blogs of top movements (TODO: define what a top movement is).

To the side of the main thought listing, the frontpage also contains a number of other elements:

* **Frontpage Graph Visualization** (see Frontpage Graph Visualization)
* **Top Thought** When a user is logged in, this contains a list of thoughts from top movements they are not currently following.  This is to prevent a filter bubble effect.
* **Discover Movements** A listing of the movements with the highest attention which the activated Persona is not following.
* **Recent Thoughts** The most recent publicly visible thoughts created throughout the whole site.

### Chat

A chat allows for a different mode for communication from posting thoughts and replies in that is is 1) immediate, 2) flat (not nested) and 3) given context through the group of chat participants. The chat module is used for private conversations between Personas and between members of a Movement in its Mindspace. This functionality is similar to the Facebook Messenger.

Messages posted to a chat are stored as thoughts and thereby have the same properties as described in Section Voting and Thoughts. Replies to thoughts posted to a chat are also displayed in the chat listing with an annotation marking them as replies and not direct messages to the ongoing conversation.

### Movements

Movements allow groups of users with a shared interest to exchange their thoughts regarding this subject. Any user may create new Movements by specifying its name and optional mission statement. A Movement may also be created with the *private* option, which will hide contents of the movement mindspace from non-members and only allow users with an invitation code to join the Movement as a member. Invitation codes may be created by any Movement member.

Each Movement has its own blog and mindspace with embedded chat module. Members can post thoughts to the Movement mindspace by using the *Create Thought* interface or posting to the Movement chat. Mindspace contents are sorted by their hotness value (see Hotness). 

**Promoting Content**

Alongside each thought in the Mindspace a progress bar is displayed which indicates how many more votes are required for a thought in the mindspace to be promoted to the Movement blog. This threshold value depends on the number of members of the group. Given the number of members c it is defined as:

	threshold = round(c / 100 + 0.8 / c + log(c, 1.65)) if c > 0 else 1

[picture showing relation threshold and number users]

This formula ensures that a low number of votes is required while a movement is small, creating lots of content on the blog,  while a large movement requires more votes relative to its user count so that only the best content will be posted to the blog.

Movements are similar to Facebook Groups, Reddit’s Subreddit feature and Email newsgroups. All of them distinguish between private and public groups as Rktik does, however they don’t provide group members with the ability of democratically deciding on content to be published separately from the group pool to a public medium.

### Threaded Discussion

Online display of discussions is rendered either as a *flat* or *hierarchical* listing. The flat variation orders postings in the discussion chronologically while the hierarchical variation uses a nested display of postings to reflect their reply-structure. In the flat variation a reply relation to a previous posting may also be established by quoting part of that posting. Postings on the same nesting level in the hierarchical variation can either be sorted chronologically or by another metric, such as the hotness value.

Rktik displays discussions in the replies to a thought in a hierarchical style with thoughts on the same level being ordered by their hotness value. This is the same structure as that employed in Reddit discussion (footnote: Reddit uses a different hotness algorithm for ordering replies than they use for link listings). Facebook discussions have historically used a flat design with a recent switch (todo: when?) to a partially hierarchical display with only one nesting level. The display of discussions in email newsgroups is dependent on the client used to read the newsgroup contents. Many such clients also use a nested reply structure with chronological ordering on a given nesting level.

### Notifications

Notifications inform the user about reactions of other users to their activity on the site or in other cases where the attention of the user should be guided to specific content. They are displayed in a notification drop down in the top left corner of every page and some of them are also sent as email notifications (footnote: a user may also opt out of receiving emails about notifications of a specific type). The notification types are:

* **Reply**: Sent when another user replies to one of the user’s thoughts
* **Mention**: Sent when someone uses the *@<username>* syntax to notify a user directly about a thought.
* **Dialogue**: Sent when a new thought is added in a private conversation with another user
* **Follower**: Sent when a user’s Blog gains a new follower

## Patterns Specific to Rktik.com [3p]

Rktik is set apart from other social networks by its representation of both personal and collective identity. 

On the one hand, users have the option of not just operating under one identity but assuming any number of Personas while using the site. These Personas may reflect different social roles, they can be used to voice unpopular opinions or generally content a user doesn’t want to identify with their real name. 

On the other hand, movements, which reflect groups of users, share many features with individual users. They have a blog which allows them to publish contents in the name of the movement and have a place for internal dialogue, similar to how an individual user can use their notebook to remember content.

### Personal Identity [1p]

The personal identity of a user of the Rktik website is partially decoupled from their physical identity. Other online communities also allow this to different extents: On Reddit, a user may choose an arbitrary name for their user profile, while Facebook asks their users to provide their real name for online communication. Rktik goes one step further by not only allowing arbitrary handle names but also featuring arbitrary numbers of handles which are called Personas. 

On signup, a user creates their first Persona by giving it a name and choosing a color to mark this Persona’s postings. After completed signup a user can create more Personas using the *switch* menu in the upper right corner of every screen. They can also to choose to create a new Persona when they are joining a Movement in order to keep their membership in that Movement separate from their activities in other parts of the site.

Other users can not tell whether any two Personas are linked to the same user. 

### Group Identity [1p]

Groups on other website have an identity communicated by the contents of the group and other markers related to the group’s representation on the website (group name, picture, color scheme). Rktik furthers this concept by communicating not just identity but also a Movement’s *agency* in 1) language employed throughout the website as well as 2) features that suggest group agency.

By calling a movement’s space for internal discussion and exchange *mindspace*, it is implied that the movement has a shared mind, the contents of which are displayed in this place. This notion is also reflected in how users place contents in a group: They *create thoughts* in the *mindspace*.

A movement’s agency is further implied in the functionality of the movement blog. Its contents are not dictated by a designated member of the movement, but selected by Personas voting on thoughts in the movement. The movement members collectively put into action decisions which are then attributed to the movement as a whole when they are displayed on the site. Please see Discussion: Movement Agency for possibilities for further development of the concept of movement agency.

#### Private Groups

When creating a new movement, a user may chose to make it *private*, which 1) hides the movement mindspace from non-members and 2) only allows users with a valid invitation code to enter the movement.

Invitation codes are valid for one week. They can be sent by movement members by either entering the email addresses of invitees or by copying a URL with embedded invitation code and sending this to the invitee (e.g. using a messenger application).

The blog page of private movements indicates the movement founder so that users interested in joining may contact this founder and ask for an invitation.

### Frontpage Graph Visualization [1p]

[image of graph visualization]

The Frontpage contains a visual representation of the frontpage contents in the form of a graph with a force-directed layout. This visual representation is reminiscent of structural representations of connections between neurons, and represents the flow of information from Movements and Personas connected to the user. It shows more how Rktik is like a brain [lol]. The graph contains 

* The frontpage itself as a big red node in the center of the graph
* All blogs the current Persona is following represented as circles filled with the respective source’s color
* All thoughts currently on the frontpage represented as solid white circles with a dotted edge connecting them to the center node and a faint solid edge connecting them to their author’s node
* All thoughts created by blogs present in the node with a creation datetime *after* that of the oldest thought present on the frontpage itself. These are only connected to their author’s node and not to the center node.

Nodes representing thoughts have a pulsating animation, the frequency of which is determined by their current hotness value - new thoughts and those with many votes pulse quickly.

# Implementation and Operation [14p]

## Overview [1p]

This section will detail technical information about the implementation and operation of the Rktik service.

It is divided into subsections for the shared data model *Nucleus*, which can be used in a future peer to peer client as a library, the *Glia* server which provides a web interface to users and finally sections about improving performance and the operation of Rktik in hosted environment.

### Separating Data Model and Web Interface

As Rktik is planned as a semi-decentral service, the object relational manager was decoupled from the rest of the application from the beginning to allow for the easy implementation of client and server applications using this codebase. 

## Shared Data Model: Nucleus [3p]

The Nucleus data model uses the SQLAlchemy ORM in combination with a Postgresql database to provide data persistency. This section lists attributes and methods of all models. The description of methods indicates in brackets if the method is a static or class method and also, if the method’s results are cached using Memcache (see section Improving Performance).

Data models allow JSON serialization via the nucleus.serializable module. This functionality is not documented here in full scope, as it is not part of this thesis, but required for the planned P2P extension (see Discussion: P2P).

### Serializable

The Serializable module provides JSON serialization functionality to data models that inherit from it. This functionality is not in the scope of this thesis, but part of the planned P2P extension (see Discussion: P2P). As the module is required for rights management, I have left it in the codebase submitted along this document and will describe the relevant functionality here.

Serializable objects provide a method *authorize*, which validates that a specific user may execute a specific action on the instance. This method is usually overridden in subclasses with the original Serializable.authorize method still being called.

The method takes one of the strings “insert”, “update”, “delete” as the action and an optional author_id argument, which defaults to the currently active Persona, and defines the actor to be authorized. It returns a boolean indicating whether the action is authorized.

Serializable models may further define the attributes 

* _insert_required
* _update_required
* _stub

as well as the methods

* create_from_changeset
* update_from_changeset
* export

### Nucleus Models

These definitions can be found in the glia.nucleus.models module. Each model is represented by a class definition. See Appendix Nucleus API for technical details such as the attributes and methods provided by each model. This section gives an overview for each model’s properties and responsibilities with respect to the functionality described in the *conceptual* chapter.

#### User

The user model represents a registered user of the site. It has relations to all Personas of this user and stores basic metadata such as the user id, account creation data, email and password hash. The User class is also used for verifying email validation actions and storing the validation state related to the user.

#### Identity

The Identity class is a superclass for Persona and Movement as these two share many attributes and methods related to their being identities. 

Apart from basic information such as the username, associated color, creation and modification timestamps, the Identity model stores relations to the blog and mindspace associated with each instance as well all blogs followed by it.

#### Persona

The Persona class represents personal identities taken by users of the site. Each user may create any number of Personas with their account. 

The Persona model provides methods for toggling instances membership in Movement and their following status with respect to blogs. It also provides a number of cached methods which provide information related to the Persona that is computationally expensive to collect (see Improving Performance).

#### Movement

Movement model instances also inherit from the Identity model and thereby provide all its attributes and methods. They also store the movement’s mission, whether the movement is private and relations to the movement’s admin (founder) and to Movement members.

**MovementMemberAssociation**

The members relation is implemented using the [association object pattern](http://docs.sqlalchemy.org/en/rel_1_0/orm/basic_relationships.html#association-object) to store additional metadata about the membership. 

* Whether the membership is active. Inactive memberships are used to represent Personas who have left the movement and for invitations, which are created as inactive memberships with no associated Persona object
* Timestamps for creation and last modification of the membership
* The member’s role in the movement (currently one of “member” and “admin”)
* When the Persona was present in the Movement chat the last time. 

#### Mindset

This model represents a list of thoughts with an author and is a superclass of Mindspace, Blog and Dialogue.

* **Mindspace** models internal Thoughts of an Identity
* **Blog** models a Blog publication
* **Dialogue** models a conversation between two Identities. The Dialogue model has an additional relation to Personas representing the “other” of a conversation. This means that retrieving the Dialogue between two given Personas is not a simple lookup as the author and other attribute can be filled interchangeably. Therefore, a get_chat classmethod is provided that tries the two lookup possibilities in succession and creates a new Dialogue if both are unsuccessful.

#### Thought

Represents individual content submissions by users of the site. The thought instance only contains the title text and metadata about the thought. All other media related to the Thought is contained in attachments. Thoughts also store the context they were posted in, which may either be a parent thought for replies or a mindset for top-level thoughts.

The thought class is able to generate instances of itself directly from text input received via the UI. This process includes detecting embedded URLs and validating they refer to a valid HTTP resource, creating Percept objects for any text, link or linked picture attachments, relaying notifications related to the creation of this Thought and invalidating caches touched by the new Thought.

Thoughts also have a relation to their votes and several helper methods for accessing information about these votes (has a specific user voted, total amount of votes, hotness value).

#### Upvote

The Upvote model inherits from Thought. Its instances represent votes cast by Personas on other Thoughts. This relation is represented by the Upvote instance referring to the voted Thought as its parent. 

#### Percept

The Percept model represents attachments on Thoughts. The Percept base class is used as an abstract class with subclasses for 

* Links, Linked pictures: Stores a URL.
* Text: Stores the attached text.
* Mentions: Stores a relation to the linked user and the text used to refer to them (these might be different if the mentioned Persona changes their username after being mentioned)
* Tags: Store a relation to an instance of the Tag model (see below).

Percepts are linked to a thought with the association object pattern using the PerceptAssociation class, which stores the author who created the association in addition to Thought and Percept. The association’s author is usually identical with the Thought author, but Movement admins also have the rights to edit Thoughts submitted to the Movement mindspace.

#### Tag

The tag model represents a label attached to a thought by embedding words starting with the hash character ‘#’ in the Thought title or text. Tagged thoughts don’t have a direct relation with a Tag instance but use the TagPercept model as an association object. This way, tags can be renamed globally without touching all Thoughts that have this tag.

#### Notification

Notifications represent direct messages to the user generated automatically when certain events require the user’s attention. The notification base class stores some metadata such as the notification text, URL, unread status and recipient. Subclasses are used to represent specific kinds of notifications:

* MentionNotification: Sent to a Persona when a mention referring them is posted
* ReplyNotification: Sent to a Persona when they receive a reply on one of their Thoughts.
* DialogueNotification: Sent to both sides for new messages in a private conversation between two Personas.
* FollowerNotification: Sent to a Persona when their blog gains a new follower.

### Modeling Data with SQLAlchemy

SQLAlchemy has some limitations, which are X, Y, Z. I wrote a script for automating SQLAlchemy schema migrations based on Flask-Migrate.


## Web Server: Glia [7p]

The Glia web server is responsible for compiling contents of the user interface, serving asynchronous UI updates, validating, storing and modifying information entered by the user, automatically performing maintenance operations and scheduling email delivery.

### Session Management

Session management is responsible for storing information about which user is logged in on which browsers. Rktik uses the Flask-Login extension to provide most of this functionality. 

Users can login using their email and password which, given a correct password, will let Flask-Login store a cookie in their browser recording the logged-in state. 

### Web View and URL Routing

A web app in Flask consists of the components view, route, models and helper functions. Views provide kinds of pages and are mapped by a route to a URL scheme which can be acesses by a user.

The views provided in Glia are

* **index** Frontpage at http://rktik.com/

*Personas*

* **create_persona** Adding a new Persona to the currently logged in account
* **notebook** Private area for storing notes and reposting thoughts for oneself
* **notifications** Access full list of notifications and set email preferences
* **persona** Access basic information and private chat for Personas. Also displays movements the Persona is a member of.
* **persona_blog** Personal blog of Personas

*Thoughts*

* **create_thought** Alternative to creating thoughts using the chat module or inline thought creation tool. Also allows entering longform text.
* **edit_thought** Similar interface to the create_thought view. Also allows removing specific attachments.
* **delete_thought** Confirmation dialog for removing thoughts. 
* **thought** Display a single thought including context, attachments, comments and a box showing metadata about the thought.

*Movements*

* **movement** Redirects members to the mindspace and everyone else to the blog
* **movement_blog** Reverse chronological listing of thoughts in the movement blog. Also allows following the movement and becoming a member.
* **movement_mindspace** Show the movement mindspace contents sorted by *hot* as well as the movement chat and basic movement metadata.
* **invite_members** Provide invitation link for a movement as well as a form for sending email invitations.
* **movement_list** List all movements registered on Rktik

*User account related*

* **activate_persona** Activate a Persona and redirect to referrer or frontpage
* **signup** Create a new user account
* **signup_validation** Validate a user’s email address, redirects to the frontpage.
* **login** Login to a user account using email and password
* **logout** Logout a user account, redirecting to the login view

*Helpers*

* **help** Access help pages stored in *templates/help_\*.html* files
* **tag** List all thoughts marked with a given hashtag

*Before request* 

These special views have the before_requrest decorator which causes them to be executed every time a user visits a page.

* **account_notifications** Remind users of clicking the link in the validation email if they haven’t already
* **mark_notifications_read** Mark all notifications read which have a URL equal to the current page

### Rendering the User Interface using Templates

Templates allow separation of content and markup in the application backend. View functions are used to collect all information neccessary to compile a web page, this information is then passed on to a template that defines the places the information needs to go and the way it needs to be rendered.

Jinja2 provides almost all functionality needed, I extended it using these custom filters and extensions: ___ .

### Asynchronous UI

Most of the content of Rktik is compiled on the server and then rendered in the user’s computer for their screen. When an interaction requires only some part of the screen contents to be changed, site responsiveness can be increased by using asynchronous communication with the server. This allows the client-side code of Rktik to obtain new information from the server and change the site contents accordingly.

This is used in the following parts of the site:

* Chat
* Notifications
* Inserting new comments

### Email Notifications

As users can not be expected to visit the site regularly, it is neccessary to provide a means to get informed about someone communication with me on the site when this is happening. That’s why I put email notifications in the System.

Email delivery is hard because of Spam and the setup is also quite difficult. That’s why I use ___ to deliver Emails. They provide an API which I use in part X of Rktik to schedule email delivery.

The user may opt out of email delivery entirely or setup specific rules for the kind of emails they want to receive. 

### Background Workers

If all computatinos were done when a user is submitting information, the site responsiveness would be quite bad. That’s why a big part of the contents on sites are calculated in advance for any user that visits the site later.

Actions that modify site contents trigger a process that puts a request on a queue to update the page contents with a more recent version. This information is stored in-memory so that site contents can be computet quickly.


## Improving Performance [1p]

Improving performance is important because web users expect fast-loading sites that don’t disrupt their stream of consciousness when they are browsing. This is hard, because especially sorting on big datasets becomes slower and slower the more data is in the system.

For this reason a memcached system is used that stores information A, B, and C in memory. The system is triggered on process X and then performs Y. There are still some problems with Z, but this is not a pressing concern right now.

**Cached Information**

Methods:
* Persona.attention
* Persona.conversation_list (invalidated by Thought.create_from_input)
* Persona.frontpage_sources (invalidated by Persona.toggle_following, Persona.toggle_movement_membership)
* Persona.movements (invalidated by Persona.toggle_movement_membership)
* Persona.repost_mindsets (invalidated by Persona.toggle_movement_membership)
* Persona.suggested_movements

* Movement.attention
* Movement.member_count (invalidated by Persona.toggle_movement_membership)
* Movement.mindspace_top_thought (invalidated by Thought.toggle_upvote)
* Movement.top_movements

* Thought.top_thought (invalidated by Thought.create_from_input)
* Thought.upvote_count (invalidated by Thought.toggle_upvote)
* Thought.iframe_url

Additional:
* Recent thoughts helper Nucleus.helpers.recent_thoughts (invalidated by Thought.create_from_input)
* “Percept” template macro 
* Frontpage graph visualization
* Async chat view 

## Hosting and Deployment [1p]

The site is hosted using the Heroku PAAS. Heroku offers automated deployment in the extent of ___. This is important, because ___. In the future I want to move the hosting to X, because it will be faster even though it has the downside of Y.

Deployment is automated using the scripts ‘push_testing.py’ and ‘push_production.py’. They make sure that the Glia and Nucleus repositories are pushed to Github and then use the Heroku API to  download the latest revision on the remote server, install or update all required libraries and start the server.

Configuration files for development and production use of the Glia server are separate and differ in X, Y, Z.

# Evaluation and Discussion

Rktik is an evolution of the Souma prototype, which has evolved in some areas and taken a completely different approach in others. In this section I will reflect critically on how Rktik measures up to expectations set at the onset of its implementation and underline these findings with data from quantitative usage metrics.

I have collected usage metrics using the external services Google Analytics and Amplitude to find out how people use the site and particularly whether feature usage follows expected patterns. This data is supplemented by raw data posted to the live website. I tried to filter out my own usage of the service as much as possible. Interactions with other users on the site and technical issues make this difficult in some cases.

Depending on how much time I have available to continue work on this project I want to improve areas X, Y, Z. Additionally I want to build a P2P client for Rktik which can be used to communicate using the service without placing ones information in the Rktik server infrastructure.

## Usage Metrics [1p]

Usage metrics are collected using Amplitude and Google Analytics. Collected data includes X, Y, Z, …

Amplitude is a web service that allows tracking events and associated metadata using a Javascript library embedded in all Rktik pages. It is used to track user behavior, specifically how many users interact with certain features of the site.

Please see Appendix: Amplitude measurements for a complete list of captured event types, metadata and usage statistics.

Google Analytics is a web service used to track page load events and analyze visitor metadata sent by their browser and operating system.

Interesting finding 1

Interesting finding 2

Interesting finding 3

## Movement Agency

Movement agency as described in Section: Specific Patterns Movement Identity attributes action of members of a movement to the movement as a whole and thereby communicates the agency of the movement. Currently, movement can post thoughts to their blog as the sole action available. The concept can be furthered by introducing novel movement actions that can be triggered by members:

**Events**

A movement member may propose an event in the movement mindspace. An event consists of a title, location, date, time and privacy setting (members only or public) and can be implemented as an attachment type. Movement members may vote on whether the event proposal is made public which would display it prominently in the movement mindspace or movement blog depending on the events privacy settings. The proposal may be modified after posting in order to satisfy concerns voiced by other members in the events comments section and thereby gain the necessary votes to make it an official event.

**Public Chat**

A movement’s blog may contain a chat module, which non-members can use to converse with the movement. Messages entered into this chat would be displayed in the movement mindspace for members to see. Members can then propose answers and other members can confirm these by voting to a certain threshold. The user who posted the original message into the movement chat would then be shown the answer attributed to the movement as a whole.

**Posting in other parts of the site**

Members may propose a thought to be posted with attribution to the movement in another part of the site. This could be a personal message to a Persona, a reply to any thought not in the movement itself or as a message in the public chat of another movement (as described above).

## API for External Clients [2p]

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

# References

Whatever.

# Appendix

## API Specification

## Source Code

## Usage Metrics

### Amplitude

### Google Analytics