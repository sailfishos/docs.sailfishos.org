---
title: Reference
permalink: Reference/
nav_exclude: true
layout: default
---

The Sailfish OS reference documentation describes all the key areas of the OS.

<ul>
{% assign sorted_pages = site.pages | sort:"nav_order" %}
{% for item in sorted_pages %}
  {% assign item_dir_parts = item.dir | remove_first: page.dir | split: '/' %}
  {% if item.dir contains page.dir and item_dir_parts.size == 1 %}
    <li>
      <a href="{{ item.url }}">{{ item.title }}</a>
    </li>
    <ul>
    {% for subitem in sorted_pages %}
      {% assign subitem_dir_parts = subitem.dir | remove_first: item.dir | split: '/' %}
      {% if subitem.dir contains item.dir and subitem_dir_parts.size == 1 %}
        <li>
          <a href="{{ subitem.url }}">{{ subitem.title }}</a>
        </li>
      {% endif %}
    {% endfor %}
    </ul>
  {% endif %}
{% endfor %}
</ul>


