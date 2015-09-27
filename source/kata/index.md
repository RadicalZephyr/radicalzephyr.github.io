---
layout: default
---

Resources for Katas:

http://www.peterprovost.org/blog/2012/05/02/kata-the-only-way-to-learn-tdd/

<div class="blog-index">
  {% assign kata = true %}
  {% for page in site.pages %}
    {% if page.layout == "kata" and page.title %}
      {% assign content = page.content %}
      <article>
        {% include custom/kata.html %}
      </article>
    {% endif %}
  {% endfor %}
</div>

<aside class="sidebar">
  {% if site.blog_index_asides.size %}
    {% include_array blog_index_asides %}
  {% else %}
    {% include_array default_asides %}
  {% endif %}
</aside>
