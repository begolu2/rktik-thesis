**TODO**

- Citations
- Acknowledgements
- Background Workers?
- Methodology: Deployment / workflow
- Attention irgendwo beschreiben
- Stimmt das: “As described in [Movements], this process 1) guards members’ privacy and 2) may establish stronger cohesion between movement members.” ?
- Habe ich irgendwo auf Informationen in der Peer to Peer section verwiesen die dort gar nicht enthalten sind?
- [Rights Management] in den Anhang mit Auflistung wer was machen darf.
- [API Specification]
- Wird Publishing state beschrieben?
- Tags im conceptual part beschreiebn
- Wird das hot raking beschrieben?
- Werden reposts beschrieben?
- Discussion: Besser nach notifications fragen
- [Cached Information]
- Methodology should include deployment process and Git branching model
- Eventuell Gründe für Nymwars anführen in [Identity]
- Hotness formular in den implementierungsteil verschieben
- rename replies > reactions
- Bugs erwähnen in Evaluation. Gibt es kritische bugs? Ansonsten auf bugtracker verweisen, oder vllt auch eine liste in den appendix?
- Zeit in Dicussion: Vergangenheit. Uuberall korrekt?
- threshold function graph nebeneinander anordnen

**Korrektur lesen**
- Pablo
- Simon Danisch
- Leon?
- 

**Fragen an Helmar**
- Welche Programme soll ich nur per Fußnote referenzieren und welche in die Bibliographi aufnehmen?
- Wie soll ich den Source Code einreichen?
- Macht es Sinn Klassendiagramme etc in den Anhang zu tun?
- Bugs auflisten?

**Table of Contents**


# Introduction

- Motivation
- Problem: Privacy and Identity

## Methodology

- Tracking Source Code and Open Tasks

## State of the Art

- Facebook
- Reddit
- Email


# Conceptual

## Overview

- Rktik.com
- Brain Metaphor
- Frontpage
	- Frontpage Graph Visualization
- Notifications

## Content

- Overview: Thoughts
- Reposts
- Attaching Media: Percepts
- Distributing Attention: Voting and Hotness 

## Identity

- User Accounts
- Personas
- Personal vs. Group Identity
- Movements
	- Promoting Content
	- Private Movements

## Context

- Introduction
- Threaded Discussion
- Mindspaces
	- Chat
- Blogs
- Dialogue


# Implementation

## Overview

- Separating Data Model and Web Interface

## Nucleus

- Serializable
- Nucleus Models
- Modeling Data with SQLAlchemy

## Web Server: Glia

- Session Management
- Web View and URL Routing
- HTML Templates
- Asynchronous UI
- Notifications

## Improving Performance

## Hosting and Deployment

# Evaluation and Discussion

## Usage Metrics

## Movement Agency

## External Clients