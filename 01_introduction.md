# Introduction [5p]

Rktik is an online community allowing groups of like minded people to find each other, collect and publish content together. This document describes its software architecture with insight into development process where appropriate. The first part concerns motivation for the project, methodology and differentiation to similar products.

”Conceptual” part describes functionality present to a user of the software, “Implementation” part describes technical background of implementation and operation of the service. Finally, “Evaluation and Discussion” presents data about feature usage and outlines future plans for the project.

## Motivation

Souma started from the wish to share files with friends in groups of people without reliance on goodwill of centralistic providers of social networking systems. As such a system did not exist in 2012, I started developing the *Souma* app myself, changing requirements to the system significantly as I went along.

At first I wanted a system that extends the social environment given by websites such as Facebook with filesharing functionality that can only be provided by a decentral system due to privacy and legal reasons. As the idea was further developed by me and other members of the *Cognitive Networks* study project at University of Osnabrück, priorities shifted to a focus on the more general goal of *humanist social platform*. This would not place economic constraints and existing metaphors for social software systems at the center of its conceptualization, but instead build it up from the ideals of humanism.

This shift in the goals of the study project, combined with the remnants of various side projects embedded in the Souma app, left the code base in a cluttered state. Therefore, after the end of the study project, I started developing Rktik as a new web-based platform based on the server-side component of Souma. It has now a much more limited focus: Developing a social publishing platform that implements a new concept of individual and group identity online.

## Problem: Privacy and Identity [1p]

The essential problem in managing privacy in online systems is the neccessity of direct access to user data, which is required for both cloud-based web applications and many native applications that offload parts of their data processing to web servers (which is the case for most mobile apps). Companies need  direct access to user data, so that they can take advantage of central data processing facilities running on web servers. Some of the advantages of server-based systems as opposed to software distributed to and installed on user machines are 1) easier control of software piracy, 2) more efficient maintenance due to direct access to the running system, 3) no need to support a wide range of (possibly low-performance) user hardware.

While the proposed P2P extension of Rktik (see [Peer to Peer Extension]) tackles this problem more directly, …

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
