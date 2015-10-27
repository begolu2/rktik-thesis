**TODO**

# Schreiben:
- Citations
- Acknowledgements
- Methodology: Deployment / workflow
- [Rights Management] in den Anhang mit Auflistung wer was machen darf.
- Tags im conceptual part beschreiebn
- Eventuell Gründe für Nymwars anführen in [Identity]
- Force-directed graph layout in implementation beschreiben

# Fragen:
- Ist attention beschrieben?
- Stimmt das: “As described in [Movements], this process 1) guards members’ privacy and 2) may establish stronger cohesion between movement members.” ?
- Habe ich irgendwo auf Informationen in der Peer to Peer section verwiesen die dort gar nicht enthalten sind?
- [API Specification]
- Wird Publishing state beschrieben?
- Werden reposts im conceptual part beschrieben?
- Discussion: Besser nach notifications fragen
- [Cached Information]
- Hotness formel in den implementierungsteil verschieben
- rename replies > reactions
- Zeit in Dicussion: Vergangenheit. Uuberall korrekt?

# Format und Drumherum
- threshold function graph nebeneinander anordnen
- Zitatformat ändern
- “section” vor alle verweise
- real -> offline identity
- Screenshots in State of the Art
- Terminology verweist auf das Übersichtsdiagramm. Der Verweis sollte direkt auf das Diagramm zeigen.
- hyperref durch ref [erweitern](https://en.wikibooks.org/wiki/LaTeX/Hyperlinks#Hyperref)
- graph viz labeln  wegen schwarzweißdruck

# Thesis mit Markdown schreiben
- [Citations](http://pandoc.org/demo/example19/Extension-citations.html)

**Korrektur lesen**
- Pablo
- Simon Danisch
- Leon?
- 

**Fragen an Helmar 1**

- Welches Format sollen Referenzen haben? 
	Namen+Jahreszahl
- Welche Programme/Tools soll ich nur per Fußnote referenzieren und welche in die Bibliographie aufnehmen?
	Fußnote
- Wie soll ich den Source Code einreichen?
- Macht es Sinn Klassendiagramme etc in den Anhang zu tun?
	UML Klassendiagramme oder eigene Diagrammformen im Text
- Bugs auflisten?
	Nein
- Was mache ich mit Bugs? 
	Bugs erwähnen wenn sie Einfluss auf konzeptuelle Entwicklung haben
- Wie ist das weitere vorgehen?
	Email an Gust, dann 3 Kopien an Prüfungsamt

**Fragen an Helmar 2**
- Bekomme ich noch einen Schein für CogNet3?

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