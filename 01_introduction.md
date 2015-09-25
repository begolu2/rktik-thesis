# Introduction [5p]

Rktik is an online community allowing groups of like minded people to find each other, collect and publish content together. This document describes its software architecture with insight into development process where appropriate. The first part concerns motivation for the project, methodology and differentiation to similar products.

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

[Rktik displays discussions in the replies to a thought in a hierarchical style with thoughts on the same level being ordered by their hotness value. This is the same structure as that employed in Reddit discussion (footnote: Reddit uses a different hotness algorithm for ordering replies than they use for link listings). Facebook discussions have historically used a flat design with a recent switch (todo: when?) to a partially hierarchical display with a single nesting level. The display of discussions in email newsgroups is dependent on the client used to read the newsgroup contents. Many such clients also use a nested reply structure with chronological ordering on a given nesting level.]

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
