# Evaluation and Discussion

Rktik is an evolution of the Souma prototype, introducing changes in some areas and taking a completely different approach in others. In this section I will reflect critically on how Rktik measures up to expectations set at the onset of its implementation and underline these findings with data from quantitative usage metrics.

## Personal Evaluation

The goals of **completeness**, **feasibility** and **maintainability**, as defined in the [Methodology] section, have been reached by the implementation described in this document. Development of the neccessary features for publishing and discussing content using Personas and Movements have been built, and an appropriate environment for the operation of Rktik has been configured. While these initial goals are important, other aspects of Rktik have shown shortcomings in the course of development and testing. In this areas I have identified three aspects based on my own experiences and informal feedback received from acquaintances.

1. Some of the concepts used in Rktik, such as the distinction between a private mindspace and a public blog or the concept of movements, are hard to understand for new users. This problem should be approached by building a tutorial, which explains the core mechanics and concepts in Rktik. It can be presented after signup and should both inform users and 

2. As described in the section [Improving Performance], the site’s speed is still too low to be satisfactory to many users. This can be improved by setting up periodically running background processes, which precompute database queries and store them in memcache. Site performance could also be improved significantly by moving Rktik to more powerful servers, which increases the costs of running the service.

3. Rktik features interesting content that is regularly updated. Users who have signed up for an account but don’t visit the site regularly could benefit from this through a periodic email newsletter. Each edition of the newsletter could feature the most interesting content on Rktik as measured by votes receivd on thoughts.

## Usage Metrics

Usage metrics have been collected anonymously using the Amplitude and Google Analytics services. These are external services who receive usage data via short Javascript scripts embedded in every served page. As I consider this usage data *personal information*, I have collected it anonymously. This prevents me from filtering my own usage of the service from the metrics. While Google Analytics tracks information about page requests, Amplitude tracks specific, manually defined events that can occur after a page was fully loaded.

Google Analytics collected data since making rktik.com accessible to the public on July 26th 2015 until today, October 2nd 2015 for a total of 68 days. Amplitude collected data from August 8th 2015 until today, October 2nd 2015 for a total of 55 days. This difference exists because I only found out about Amplitude when the measurement had already begun. 

Google Analytics and Amplitude collect extensive amounts of information. As a complete analysis of the data would go beyond the scope of this thesis, I have focussed on a number of key metrics.

**Number of usage sessions**

The number of sessions was assessed using Google Analytics. A session is defined as a group of interactions by a user that takes place within 30 minutes or until midnight (@Google). A total of 825 sessions were started, most of which took place in the first weeks of operation. Presumably, these are users who tried the site once but weren’t compelled to return later. 

![eval_sessions]



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