
# API Specification

API Specification documents

# Rights Management

This table show which users/personas are allowed to make changes to specific models.

Rights Management for Mindsets

| 		Mindset 			| 	Creating 	| 	Updating 	| 	Deleting

Personal Mindspace								— Persona —
Personal Blog										— Persona —
Movement Mindspace			Members		       — Author, Admin —
Movement Blog				 Automatic* 			 — Admin —
Dialogue								Members					 — Author —

	* see section ___ on auto-promotion from movement Mindspaces to blogs

# Cached Information

This section gives an overview of values cached using memcache as described in Section [Improving Performance].

Methods:
* Persona.attention
* Persona.conversation_list (invalidated by Thought.create_from_input)
* Persona.frontpage_sources (invalidated by Persona.toggle_following, Persona.toggle_movement_membership)
* Persona.movements (invalidated by Persona.toggle_movement_membership)
* Persona.repost_mindsets (invalidated by Persona.toggle_movement_membership)
* Persona.suggested_movements

* Movement.attention
* Movement.member_count (invalidated by Persona.toggle_movement_membership)
* Movement.Mindspace_top_thought (invalidated by Thought.toggle_upvote)
* Movement.top_movements

* Thought.top_thought (invalidated by Thought.create_from_input)
* Thought.upvote_count (invalidated by Thought.toggle_upvote)
* Thought.iframe_url

Additional:
* Recent thoughts helper Nucleus.helpers.recent_thoughts (invalidated by Thought.create_from_input)
* “Percept” template macro
* Frontpage graph visualization
* Async chat view

# Usage Metrics

## Amplitude

## Google Analytics

# Source Code
