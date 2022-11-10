---
title: Support
permalink: Support/
layout: default
nav_exclude: true
---

<h1 class="no_toc">Contents</h1>

<ol>
{% assign sorted_pages = site.pages | sort:"nav_order" %}
{% for item in sorted_pages %}
  {% assign item_dir_parts = item.dir | remove_first: page.dir | split: '/' %}
  {% if item.dir contains page.dir and item_dir_parts.size == 1 %}
    <li>
      <a href="{{ item.url }}">{{ item.title }}</a>
    </li>
  {% endif %}
{% endfor %}
</ol>
