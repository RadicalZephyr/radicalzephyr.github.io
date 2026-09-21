# STATUS: modernizing the blog

Parked 2026-09-20. Zola site, hermit theme vendored as a subtree under `themes/hermit`
with local commits on top, deployed by `.github/workflows/build.yml` to GitHub Pages.

## State of the tree

The build port to Zola 0.23.6 is committed (`1d12bc3 Start updating to Zola 0.23.6`)
and verified: `zola build` and `zola build --drafts` both succeed; 26 posts, feed,
highlighting, read times, menu and CV anchors all render. The 1Password post is
committed as a draft (`95da242`) and awaits the author's read.

Build with the Homebrew binary by path. The shell alias `zola` points at a Flatpak that
is not installed:

```bash
/home/linuxbrew/.linuxbrew/bin/zola build --drafts
```

Output is minified to one line with quotes stripped, so grep the generated HTML for
`href=/x` and `id=foo`, not the quoted forms.

## Remaining work, in order

1. **Replace the Liquid leftovers in old posts.** Ten Jekyll tags have rendered as
   literal text since the migration. Content templating is now off globally
   (`skip_content_templating` in `config.toml`), which is why they no longer break the
   build; they are still broken links.
   - Seven `{% post_url <slug> %}`: four targets exist in `content/posts/` and become
     Zola internal links, `@/posts/<slug>.md`. Three targets (`2014-05-01-s-and-e-part-two:-gumption`,
     `2014-05-06-s-and-e-part-three:-the-teenage-liberation-handbook`,
     `2014-06-07-s-and-e-part-seven:-onward`) are posts that were never brought into
     this repo. Ask the author whether they exist elsewhere before touching those three.
   - One `{% include_code "Org Converter" lang:ruby ../plugins/org_converter.rb %}` in
     `2014-10-27-playing-with-org-mode.md`. The Ruby file is not in the repo. Same
     question to the author.
   - Done when `grep -rn '{%' content/` returns nothing and `zola build` still passes
     with `skip_content_templating` removed (the guard is only needed while Liquid
     remains; `content/about/cv.md` uses `{#id}` heading anchors, which Zola's Markdown
     handles itself and Tera would eat, so confirm the anchors survive before removing it).

2. **Decide what `categories` becomes.** All 31 posts carry `categories = [...]` as a
   top-level front-matter key, a Jekyll import. Zola ignores it, so no category pages
   have ever existed here. The theme ships `tags` templates and `page.html` renders
   `page.taxonomies.tags`. Options: move the values under `[taxonomies] tags = [...]` and
   register `taxonomies = [{ name = "tags" }]` in config, or drop the key. Author's call;
   the rename is mechanical once made. `layout = "post"` and `comments = true` on the
   same posts are also inert and can go in the same pass.

3. **Theme drift.** Upstream `VersBinarii/hermit_zola` still uses Tera 1 macros and the
   singular feed keys as of this date, so there is nothing to pull. The local commits on
   the subtree are the only 0.23-compatible version; keep them. Revisit if upstream
   ports to Tera 2.

4. **Highlight theme.** `gruvbox-dark-soft` was chosen as the nearest replacement for
   `zenburn`, which the new highlighter (Giallo) does not ship. Untested against the
   author's taste. The theme list lives in the Giallo README.

## Tera 2 rules learned the hard way

These are the gotchas that cost a build cycle each. They apply to any template edit here.

- Macros are gone. Components are `{% component ns.name(arg) %}…{% endcomponent ns.name %}`,
  called as `{{ <ns.name arg={expr} /> }}`. Expression arguments need the braces.
- Components do not see the template context. Pass `config` and anything else in as an
  argument; the theme's `hermit.footer` and `hermit.social_icons` already do.
- `{% if a.b %}` errors when `a` is undefined. One level of undefined is tolerated
  (`page.extra.toc` is fine, `page.title` on a section page is not). Guard with
  `is defined`, or declare the key in config; `[extra]` now declares `highlightjs`,
  `disqus` and `google_analytics` off for exactly this reason.
- Filters bind tighter than arithmetic: `words / 265 | round` is wrong, `(words / 265) | round | int` is right.
- `get_taxonomy_url` takes `term=`, not `name=`.
