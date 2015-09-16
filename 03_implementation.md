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
