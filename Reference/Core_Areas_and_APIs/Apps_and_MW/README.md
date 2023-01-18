---
title: Apps and MW
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 100
---

<ul>
{% assign sorted_pages = site.pages | where: "parent", "Apps and MW" | sort:"title" %}
{% for item in sorted_pages %}
    <li>
      <a href="{{ item.url }}">{{ item.title }}</a>
    </li>
{% endfor %}
</ul>
