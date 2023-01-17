---
title: Apps and MW
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 100
---

<ul>
{% assign sorted_pages = site.pages | sort:"title" %}
{% for item in sorted_pages %}
  {% assign item_dir_parts = item.dir | remove_first: page.dir | split: '/' %}
  {% if item.dir contains page.dir and item_dir_parts.size == 1 %}
    <li>
      <a href="{{ item.url }}">{{ item.title }}</a>
    </li>
  {% endif %}
{% endfor %}
</ul>
