# Conceptual

## Overview [1p]

This section will explain the user-facing functionality of the Rktik website on a conceptual level. The first subsection deals with patterns, that have been implemented in other sites before, although those implementations might differ substantially. The second subsection describes patterns unique to Rktik.

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
