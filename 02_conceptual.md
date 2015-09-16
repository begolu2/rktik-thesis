# Conceptual

## Overview

Rktik is a social media website where users share text, links and other media pseudonymously in the context of topic-oriented groups and personal blogs. Contents are sorted based on recency as well as a voting and subscription system.

Rktik is set apart from other social networks by its distinct modelling of personal and collective identity. 

This chapter will explain the user-facing functionality of the Rktik website on a conceptual level. First, general concepts are explained, introducing readers to the mechanics of using Rktik. Subsequent sections give detailed information on how Rktik handles *content*, *identity* and *context*. 

### Terminology

This section gives an overview of terminology used in Rktik without going into much detail. Please see the relevant subsequent sections for more elaborate descriptions.

**Users** are individual persons using the site. They may register by creating a *user account* and one or more associated *personas*. Hereby they are able to create content on the site.

(see [User Accounts])

All actions of users are attributed to their **active persona**, which is a screen name that identifies them across the site. A user may create any number of personas to shape their privacy, but only one of them can be *active* at any time. 

**Thoughts** are short pieces of text submitted by personas and represent the smallest unit of content.

(see [Overview: Thoughts])

Thoughts can link to any number of **percepts**, which are attachments containing either more text or a hyperlink to an external resource.

(see [Attaching Media: Percepts])

**Mindsets** contain lists of thoughts. Any thought may only be contained in one mindset. Every persona has a private and a public mindset (**notebook** and **blog** respectively).

(see [Overview: Mindsets])

**Movements** are groups related to a specific topic. Each of them also has a private mindset for members and a public mindset (blog). 

Any persona can create new movements and follow the (public) blog of any movement or other persona.

(see [Movements])

### Frontpage

The Frontpage is located at the root of Rktik and presents users with a stream of thoughts from their movements and followed blogs. It is similar to the Facebook News Feed and the Reddit Frontpage in that the stream is sorted based both on the recency of a submission and the number of votes it has received (see hotness).  

Anonymous users don’t have any subscriptions, so they are shown thoughts from top movements. These are the seven movements with the highest member count.

To the side of the main thought listing, the frontpage also contains a number of other elements:

* The **Frontpage Graph Visualization** displays a visual representation of Frontpage contents as a graph (see Frontpage Graph Visualization).
* **Top Thought** When a user is logged in, this contains a short list of thoughts from top movements they are not following with their active persona. This allows users to notice particularly popular submissions from contexts they wouldn’t see otherwise.
* **Discover Movements** A listing of top movements the active persona is not following.
* **Recent Thoughts** The most recent publicly visible thoughts submitted throughout the whole site.

#### Frontpage Graph Visualization

![Frontpage Graph Visualization]

The Frontpage contains a visual representation of its contents in the form of a graph with a force-directed layout embedded in a dark blue circle. This layout  communicates the flow of information from a persona’s subscriptions to their Frontpage while also hinting at other content not shown in this context.

The graph represents the Frontpage as a big red node in the center, Identities subscribed to by the active persona (content sources) as medium-sized colored nodes and thoughts as small white nodes. 

Thoughts are connected to the center Frontpage with a dotted edge if they are currently part of the Frontpage stream. Thoughts are also always connected to their author’s identity with a further dotted edge. If an author doesn’t have any of their thoughts embedded in the current Frontpage, it is connected to the center node with a faint dashed edge. Nodes representing thoughts have a pulsating animation with a frequency inversely related to their hotness and capped at 5 Hz TODO: check this).

Thereby, the Frontpage contents surround the center node as a ring of white nodes, pulsating according to their position in the stream. They are connected to a second ring which consists of those Movements and Personas who submitted the thoughts. Other subscribed identities are located a bit further away to show that their posting may also be contained in the Frontpage even though they aren’t right now.

(see implementation: frontpage for technical details)

### Notifications

Notifications try and catch the user’s attention in order to present information which is relevant to them personally. They are displayed in a drop down menu in the top left corner of every page and some of them are also sent as email notifications  [^optout].

[^optout]: A user may also opt out of receiving emails about notifications of a specific type. See [User Accounts]. 

![Notification menu showing one unread notification about a received private message](img/notifications.png) 

There are four notification types:

* **Reply**: Sent when another user replies to one of the user’s thoughts
* **Mention**: Sent when someone uses the *@<username>* syntax to notify a user directly about a thought.
* **Dialogue**: Sent when a new thought is added in a private conversation with another user
* **Follower**: Sent when a user’s Blog gains a new follower

See [Notification] for technical details.

## Content

### Overview: Thoughts

*Thoughts* are the basic building block for content in Rktik and rougly equivalent to a post on Facebook or submission on Reddit. They consist of a short text with no more than 300 characters and any number of attachments. Thoughts can be displayed as part of mindsets in different listing styles, on individual thought pages or as part of a chat conversation (see [Overview: Mindsets]). 

The restriction on title length has been set for two reasons:

1. A short title reduces the flexibility required from page layouts. Longer titles imply a bigger variation in title length which would make the usage of separate display styles for long and short titles neccessary and in turn increase development and maintenance time.
2. Short titles require users to be concise when formulating thoughts. In turn, they make it easier for other users to read and understand titles.

Thoughts can be created using the dedicated *create thought* page, which is linked from all mindsets in which the active persona has editing rights, or using the *inline thought creator*, which is embedded in comments pages and as part of the chat widget. The latter only allows text content up to the length of a thought’s title and let’s users switch to the *create thought* page without losing their input if they wish to continue typing. The dedicated *create thought* page provides separate input fields for title and longform text attachments.

**Reposting**

Thoughts can be *reposted*, which creates a copy of the original thought, but displays it in a different mindset and attributes it to the persona who created the repost. Reposts are always created as comments on their original, thereby notifying the original author about their creation.

### Attaching Media: Percepts

Thoughts may have any number of attachments for enriching their content. These may either be rendered as part of the Rktik website or presented as links to other websites.

Currently the following attachment kinds are supported:

* **Links** Can be attached by embedding a URL inside the thought title or longform text.

	Links to pictures may be rendered inline with the thought. Clicking the picture displays it enlarged in a modal gallery view. If multiple links to pictures are linked to a single thought, the modal view allows browsing through the picture gallery using keyboard and onscreen controls. The display size of pictures is also adapted to the size and number of image attachments.

	Links that point to the soundcloud.com and youtube.com domain will be rendered using the respective embedded iFrame widgets to allow playing music and videos without leaving the Rktik website.

* **Longform text** As thought titles are limited to 300 characters, the longform text attachment allows adding a longer text. This text may also be formatted using the Markdown language ([@Gruber2004]), which provides simple markup for basic text formatting such as headlines, enumerations, bold and italic text.

### Distributing Attention: Voting and Hotness {#hotness}

Personas may vote on thoughts, thereby expressing approval of their content. The number of votes is displayed next to all thoughts.

Apart from being a visible signal about the number of people who have expressed approval of a thought, votes are also used for sorting thoughts. Depending on context, the order of thoughts is either chronological (chat), reverse chronological (blog) or by their *hotness* value. 

Hotness is a numeric value which depends on the age of a thought and the number of votes it has received. It is higher for thoughts more recent and more voted on. Thoughts with equal numbers of votes are effectively in chronological order when presented in order of hotness, while additional votes push the thought forward in the ordering.

Given the number of upvotes v and the number of hours since the thought was created t, a thought’s hotness is:

	hot = v / pow(t + 2, 1.5)

This algorithm is adapted from the sorting algorithm used in the social bookmarking site Hacker News (see [@Salihefendic2010]).

## Identity

### User Accounts

Any user of Rktik can register a personal user account which allows them to create content and vote on submissions. Creating an account requires a valid email address, a password and a name and color value for the user’s first persona.

The account feature serves two main purposes:

1. Authorizing a user’s identity by asking them to enter the account-specific password. Authorized users may act on the site as one of the Personas connected to the user account.
2. Obtaining a valid email address, so that users may be sent notifications and other messages related to their activity on the site.

The email address attached to a user account is validated by sending a confirmation email that contains a link the user has to click. If the user has no access to the email address they cannot click the link which validates the address.

User accounts also stores the user’s email preferences which allow them to disable emails of specific kinds. A user can change these preferences by going to their notifications page or clicking a link embedded in all emails sent by Rktik. In general, emails should be sent as little as possible as users may perceive them as spam if they carry insufficent personal relevance or value. 

### Personal vs. Group Identity

Groups on other website have an identity communicated by the contents of the group and other markers related to the group’s representation on the website (group name, picture, color scheme). Rktik furthers this concept by communicating not just identity but also a Movement’s *agency* in 1) language employed throughout the website as well as 2) features that suggest group agency.

By calling a movement’s space for internal discussion and exchange *mindspace*, it is implied that the movement has a shared mind, the contents of which are displayed in this place. This notion is also reflected in how users place contents in a group: They *create thoughts* in the *mindspace*.

A movement’s agency is further implied in the functionality of the movement blog. Its contents are not dictated by a designated member of the movement, but selected by Personas voting on thoughts in the movement. The movement members collectively put into action decisions which are then attributed to the movement as a whole when they are displayed on the site. Please see Discussion: Movement Agency for possibilities for further development of the concept of movement agency.

—

On the one hand, users have the option of not just operating under one identity but assuming any number of Personas while using the site. These Personas may reflect different social roles, they can be used to voice unpopular opinions or generally content a user doesn’t want to identify with their real name. 

On the other hand, movements, which reflect groups of users, share many features with individual users. They have a blog which allows them to publish contents in the name of the movement and have a place for internal dialogue, similar to how an individual user can use their notebook to remember content.

### Personas

The personal identity of a user of the Rktik website is partially decoupled from their physical identity. Other online communities also allow this to different extents: On Reddit, a user may choose an arbitrary name for their user profile, while Facebook asks their users to provide their real name for online communication. Rktik goes one step further by not only allowing arbitrary handle names but also featuring arbitrary numbers of handles which are called Personas. 

On signup, a user creates their first Persona by giving it a name and choosing a color to mark this Persona’s postings. After completed signup a user can create more Personas using the *switch* menu in the upper right corner of every screen. They can also to choose to create a new Persona when they are joining a Movement in order to keep their membership in that Movement separate from their activities in other parts of the site.

Other users can not tell whether any two Personas are linked to the same user. 

### Movements

Movements allow groups of users with a shared interest to exchange their thoughts regarding this subject. Any user may create new Movements by specifying its name and optional mission statement. A Movement may also be created with the *private* option, which will hide contents of the movement mindspace from non-members and only allow users with an invitation code to join the Movement as a member. Invitation codes may be created by any Movement member.

Each Movement has its own blog and mindspace with embedded chat module. Members can post thoughts to the Movement mindspace by using the *Create Thought* interface or posting to the Movement chat. Mindspace contents are sorted by their hotness value (see Hotness). 

**Promoting Content**

Alongside each thought in the Mindspace a progress bar is displayed which indicates how many more votes are required for a thought in the mindspace to be promoted to the Movement blog. This threshold value depends on the number of members of the group. Given the number of members c it is defined as:

	threshold = round(c / 100 + 0.8 / c + log(c, 1.65)) if c > 0 else 1

[picture showing relation threshold and number users]

This formula ensures that a low number of votes is required while a movement is small, creating lots of content on the blog,  while a large movement requires more votes relative to its user count so that only the best content will be posted to the blog.

Movements are similar to Facebook Groups, Reddit’s Subreddit feature and Email newsgroups. All of them distinguish between private and public groups as Rktik does, however they don’t provide group members with the ability of democratically deciding on content to be published separately from the group pool to a public medium.

#### Private Groups

When creating a new movement, a user may chose to make it *private*, which 1) hides the movement mindspace from non-members and 2) only allows users with a valid invitation code to enter the movement.

Invitation codes are valid for one week. They can be sent by movement members by either entering the email addresses of invitees or by copying a URL with embedded invitation code and sending this to the invitee (e.g. using a messenger application).

The blog page of private movements indicates the movement founder so that users interested in joining may contact this founder and ask for an invitation.

## Context

### Overview: Mindsets
### Blogs & Mindspaces

Blogs allow users to share their thoughts with an audience and contain thoughts sorted in reverse chronological order. Each Personas and Movement has their own blog. A blog can be followed by otehr users, which will cause its contents to be embedded in their personal frontpage.

Personas can directly post new thoughts on their blog, while Movements can only indirectly place content in it with the voting mechanism (see Movements section).

In addition to the blog, Personas and Movements can also collect content in their personal mindspace (see Mindspace section).

### Threaded Discussion

Online display of discussions is rendered either as a *flat* or *hierarchical* listing. The flat variation orders postings in the discussion chronologically while the hierarchical variation uses a nested display of postings to reflect their reply-structure. In the flat variation a reply relation to a previous posting may also be established by quoting part of that posting. Postings on the same nesting level in the hierarchical variation can either be sorted chronologically or by another metric, such as the hotness value.

Rktik displays discussions in the replies to a thought in a hierarchical style with thoughts on the same level being ordered by their hotness value. This is the same structure as that employed in Reddit discussion (footnote: Reddit uses a different hotness algorithm for ordering replies than they use for link listings). Facebook discussions have historically used a flat design with a recent switch (todo: when?) to a partially hierarchical display with only one nesting level. The display of discussions in email newsgroups is dependent on the client used to read the newsgroup contents. Many such clients also use a nested reply structure with chronological ordering on a given nesting level.

### Chat

A chat allows for a different mode for communication from posting thoughts and replies in that is is 1) immediate, 2) flat (not nested) and 3) given context through the group of chat participants. The chat module is used for private conversations between Personas and between members of a Movement in its Mindspace. This functionality is similar to the Facebook Messenger.

Messages posted to a chat are stored as thoughts and thereby have the same properties as described in Section Voting and Thoughts. Replies to thoughts posted to a chat are also displayed in the chat listing with an annotation marking them as replies and not direct messages to the ongoing conversation.

### Dialogues

[Frontpage Graph Visualization]: img/graph.png