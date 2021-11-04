---
title: Style Guides
permalink: Develop/L10n/Style_Guides/
has_children: true
parent: L10n
layout: default
---

Having a style guide massively improves translations for a given language, consistency, mood, voice, you name it. We strongly encourage all Sailfish OS languages to have one.

Existing style guides are [listed here](/Develop/L10n#style). Guides of existing community languages progress is in this [TJC post](https://together.jolla.com/question/145988/official-announcement-contribute-language-style-guides-not-a-question/).

To create a guide for a new language, please take e.g. [English (United Kingdom)](/Develop/L10n/Style_Guides/English_%28United_Kingdom%29) as reference, by copying [its source](https://github.com/sailfishos/docs.sailfishos.org/blob/master/Develop/L10n/Style_Guides/English_%28United_Kingdom%29/README.mdpp) to your own `.../Style_Guides/Your_Language/README.mdpp`.

Then start shaping its contents to match your language grammar and culture.

You'll see existing style guides peppered with templates for maximum re-use, e.g.
```wiki
!INCLUDE "../Templates/Grammar_voice.mdpp"
For example:
* Correct: '''Create Account Settings in...'''
* Incorrect: '''Account Settings are created in...'''
```

If your language has a different rule than the template says (e.g. passive voice preferred over active), simply replace with [template's source](https://github.com/sailfishos/docs.sailfishos.org/blob/master/Develop/L10n/Style_Guides/Templates/Grammar_voice.mdpp):
```wiki
== Voice ==
Whenever possible, use the passive voice. Keep the message clear and the sentences short

For example:
* Correct: '''<an example of passive voice in your language>'''
* Incorrect: '''<an example of active voice in your language>'''
```

Then carry on through all other sections in the same fashion. If you have doubts, post in [SFOS Forum](https://forum.sailfishos.org/c/localisation/20) to consult the fellow speakers. If you feel like some sections are not relevant or lack information, it's ok to skip them, someone else will complement them in the future.

Finally, test and submit your contribution as per [documentation instructions](https://github.com/sailfishos/docs.sailfishos.org/blob/master/README.md).
