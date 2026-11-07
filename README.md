# شازززگاید (Shaazzz Guide)

Persian competitive-programming guide: tutorial posts for each topic plus a curated problem sheet, built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and hosted on GitHub Pages at **[guide.shaazzz.ir](https://guide.shaazzz.ir)**.

## Table of Contents

1. [How the project fits together](#how-the-project-fits-together)
2. [Requirements (Linux)](#requirements-linux)
3. [Run locally (test your changes)](#run-locally-test-your-changes)
4. [Writing a blog post](#writing-a-blog-post)
5. [Adding problems](#adding-problems)
6. [Deploy to production](#deploy-to-production)
7. [Configuration files](#configuration-files)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)

## How the project fits together

```
Shaazzz-Guide/
├── Posts/                   # SOURCE of every blog post (edit these)
├── tags.json                # topic -> post file + Persian title, grouped by level
├── judges.json              # online judges (name, icon, url)
├── problems.csv             # problem sheet, downloaded from Google Sheets (generated)
├── problems.json            # problems.csv converted to JSON (generated)
├── build.sh                 # download sheet + run all three scripts
├── requirements.txt         # Python dependencies (mkdocs-material)
├── scripts/
│   ├── csv_to_json.py       # problems.csv  -> problems.json
│   ├── blog_generator.py    # Posts/*.md + problems.json -> Blog/docs/Level*/*.md, problemset.md
│   ├── nav.py               # tags.json -> `nav:` section of Blog/mkdocs.yml
│   └── generate.sh          # server-side one-shot: pull, regenerate, commit, push, deploy
└── Blog/
    ├── mkdocs.yml           # MkDocs config (nav section is auto-generated)
    ├── overrides/           # theme overrides + judge icons
    ├── docs/                # what MkDocs builds from
    │   ├── Level1/, Level2/ # GENERATED from Posts/ — never edit by hand
    │   ├── problemset.md    # GENERATED
    │   ├── index.md, coming_soon.md, CNAME, assets/, stylesheets/, javascripts/
    │   │                    # hand-written, tracked in git — NOT regenerated
    └── site/                # static site produced by `mkdocs build` (ignored by git)
```

Pipeline: `problems.csv` → `csv_to_json.py` → `problems.json` → `blog_generator.py` (merges every post in `Posts/` with the problems tagged for it) → `Blog/docs/` → MkDocs → `Blog/site/`.

> **Do not `rm -rf Blog/docs`.** Only `Blog/docs/Level*/` and `Blog/docs/problemset.md` are generated; the other files in `Blog/docs/` (home page, CNAME, CSS, JS, images) are written by hand and the scripts will not recreate them. The generated pages are rewritten from scratch every run (so a problem removed from the sheet disappears on the next run), but `blog_generator.py` never **deletes** a page: if a topic is removed or renamed in `tags.json`, its old `Blog/docs/Level*/<topic>.md` stays behind and MkDocs still publishes it as an orphan page. That is why every regeneration below starts with `rm -rf Blog/docs/Level*` — it is safe, those files are fully regenerated.

## Requirements (Linux)

- `git`, `curl`
- Python 3.9+ with `venv` (Debian/Ubuntu: `sudo apt install python3 python3-venv python3-pip`)
- Python packages: `mkdocs-material` (pulls in `mkdocs`, `pymdown-extensions`, `mkdocs-material-extensions`); see `requirements.txt`

No `sudo` is needed for anything below.

## Run locally (test your changes)

All commands are run from the repository root.

```bash
# 1. clone and enter
git clone https://github.com/kian2009n/Shaazzz-Guide.git
cd Shaazzz-Guide

# 2. Python environment (one time; later just `source .venv/bin/activate`)
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# 3. (optional) refresh the problem sheet — skip to test posts with the committed problems.csv
URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vT4u9dg9TRV_VjxMhv4TuXOTRcKUGQz2_vt2eh2-PUn6sC6wEi9_djsKzVLMpK2R63XvIKO94TVjmmZ/pub?gid=1911820389&single=true&output=csv"
curl -Ls "$URL" -o problems.csv

# 4. regenerate Blog/docs from Posts/ + problems
rm -rf Blog/docs/Level*             # drop generated pages (and nothing else) so removed topics don't linger
python3 scripts/csv_to_json.py      # problems.csv  -> problems.json
python3 scripts/blog_generator.py   # Posts/ + problems.json -> Blog/docs/Level*/, problemset.md
python3 scripts/nav.py              # tags.json -> nav in Blog/mkdocs.yml

# 5. serve with live reload
cd Blog
mkdocs serve -a 127.0.0.1:8000      # open http://127.0.0.1:8000
```

Steps 3–4 are what `./build.sh` does, with two differences: `build.sh` does not remove the old `Blog/docs/Level*` first, and it calls `python` (not `python3`), which does not exist on most Linux distributions. Run the commands above instead (or `sudo apt install python-is-python3` if you want to use `build.sh`).

While `mkdocs serve` is running, MkDocs watches `Blog/docs/`, not `Posts/`. After editing a post, run `python3 scripts/blog_generator.py` again (from the repo root) and the browser reloads by itself. Use `-a 0.0.0.0:8000` to reach the preview from another machine, or a different port if 8000 is taken.

To check that the whole site builds (what the deploy will do) without serving it:

```bash
cd Blog && mkdocs build        # output in Blog/site/, ignored by git
```

`mkdocs build --strict` (fail on any warning) currently aborts because of the harmless `materialx.emoji` deprecation warning — use plain `mkdocs build`, or apply the one-line config change described in [Troubleshooting](#troubleshooting), after which `--strict` passes.

Checklist before you push: the page renders in RTL with Persian text, inline code and math look right, every problem appears under the right topic, and `git status` shows only the files you meant to change (`Posts/`, `tags.json`, the regenerated `Blog/docs/Level*`, `problems.csv`/`problems.json`, `Blog/mkdocs.yml` if the nav changed).

## Writing a blog post

1. Create or edit `Posts/<topic>.md`.
2. Start with an intro paragraph, **no H1/H2** — the generator adds the title and the «توضیحات» / «سوال ها» headers. Use `###` for sections and `####` for subsections.
3. Any [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/) feature is available: admonitions (`!!! tip "نکته"`, `??? success "اثبات"`), code blocks with line numbers and annotations (```` ```cpp linenums="1" ```` + `// (1)!`), MathJax (`$...$`, `$$...$$`), inline highlighted code (`` `#!cpp vector<int>` ``).
4. The site is RTL. Wrap Latin fragments that must keep their order (e.g. `C++`, `#include <...>`) in `<span dir="ltr">…</span>`; inline code is already forced LTR by `Blog/docs/stylesheets/extra.css`.
5. Register the post in `tags.json` under its level (the key must equal the tag used in the problem sheet, matched case-insensitively):

   ```json
   "Level2": {
       "your_topic": { "path": "your_topic.md", "blog_title": "عنوان فارسی" }
   }
   ```

6. Regenerate and preview as in [Run locally](#run-locally-test-your-changes).

## Adding problems

Problems live in the shared Google Sheet (ask a maintainer for edit access):
**[Shaazzz Guide Problem Sheet](https://docs.google.com/spreadsheets/d/1wvFlQJMeln2OvCurF8qe1GtehI_2411a3jd6rTgKWEs/edit?gid=1911820389#gid=1911820389)**

| Column | Content | Rules |
|---|---|---|
| Judge | key from `judges.json` | `cf`, `cses`, `atcoder`, `quera`, `oj`, `usaco`, … — consistent spelling |
| Name | exact problem title | copy-paste, keep case |
| URL | direct, permanent link | |
| TAG | topic key from `tags.json` | prefer **one** tag; use `a \| b` only when the problem truly needs both (and is hard) |
| Difficulty | Codeforces-style rating 800–3500 | judge it yourself, rate non-CF problems on the same scale |

The site does not read the sheet at build time: download it (step 3 above) and commit the new `problems.csv`/`problems.json` together with the regenerated `Blog/docs/`.

## Deploy to production

Hosting is GitHub Pages on the `gh-pages` branch of this repository; `Blog/docs/CNAME` points it to `guide.shaazzz.ir`. You need push access to the repo and git authentication (SSH key or token) set up.

```bash
source .venv/bin/activate

# 1. refresh problems and regenerate (same as local steps 3–4)
curl -Ls "$URL" -o problems.csv
rm -rf Blog/docs/Level*
python3 scripts/csv_to_json.py && python3 scripts/blog_generator.py && python3 scripts/nav.py

# 2. commit the sources + generated docs to main (`git add Blog/docs` also records deleted pages)
git add Posts tags.json judges.json problems.csv problems.json Blog/docs Blog/mkdocs.yml
git commit -m "update posts/problems"
git push origin main

# 3. build and publish gh-pages
cd Blog
mkdocs gh-deploy            # builds Blog/site and force-pushes it to the gh-pages branch
```

`mkdocs gh-deploy` does both the build and the push; the site updates a minute or two later. Deploying without step 2 is possible but leaves `main` out of sync with the live site, so always commit first.

`scripts/generate.sh` is a one-shot version of the whole flow for a server that already has credentials (`git pull` → `sudo rm -rf Blog/docs` → regenerate → commit → push → `gh-deploy`). It deletes all of `Blog/docs` and relies on `git pull` to restore the hand-written files, uses `sudo`, and auto-commits everything — do not run it on a machine with uncommitted work. `scripts/rollback.sh` force-pushes `HEAD^` to `main` (undo the last commit on the server); use with care.

## Configuration files

- **`tags.json`** — levels → topics → `{ "path": "<file in Posts/>", "blog_title": "<Persian title>" }`. Order here is the order in the sidebar. Levels with no topics show «به زودی...».
- **`judges.json`** — `{ "<judge key>": { "name", "icon", "url", "admonition"? } }`. To add a judge, add an entry and an SVG at `Blog/overrides/.icons/judge/<iconname>.svg`.
- **`Blog/mkdocs.yml`** — theme, extensions, extra CSS/JS. The `nav:` block at the end is rewritten by `scripts/nav.py` — never edit it by hand and never add anything after it.
- **`problems.csv` / `problems.json`** — generated; do not edit by hand.

## Troubleshooting

- `python3: command not found` / `No module named venv` → `sudo apt install python3 python3-venv`.
- `mkdocs: command not found` → the venv is not active: `source .venv/bin/activate`.
- `build.sh: python: command not found` → run the three `python3 scripts/...` commands directly, or `sudo apt install python-is-python3`.
- `FileNotFoundError: ./problems.csv` or `./tags.json` → run the scripts from the repository root, not from `scripts/` or `Blog/`.
- Red box «Warning from the Material for MkDocs team» during build → a general notice from the theme about the future MkDocs 2.0, not about this project; ignore it.
- `materialx.emoji ... is deprecated` during build → harmless with the current `mkdocs-material` 9.x; the site builds fine. Replacing `materialx.emoji.*` with `material.extensions.emoji.*` in `Blog/mkdocs.yml` silences it.
- Port already in use → `mkdocs serve -a 127.0.0.1:8001`.
- Preview does not change after editing a post → you edited `Posts/` but did not rerun `python3 scripts/blog_generator.py`; MkDocs only watches `Blog/docs/`.
- Home page / CSS / images missing → `Blog/docs` was deleted; restore the tracked files with `git checkout Blog/docs` and regenerate.
- A topic you removed from `tags.json` (or from the sheet) still shows up as a page, or `mkdocs build` says pages "exist in the docs directory, but are not included in the nav" → a stale generated file; run `rm -rf Blog/docs/Level*` and regenerate. (`Blog/site/` never goes stale: `mkdocs build`/`gh-deploy` clean it on every run.)

## Contributing

1. Fork, create a branch.
2. Edit `Posts/` (and the sheet if you add problems), update `tags.json`.
3. Regenerate (`rm -rf Blog/docs/Level*`, then `csv_to_json.py`, `blog_generator.py`, `nav.py`) and check the site locally.
4. Commit the sources together with the regenerated `Blog/docs/` and open a pull request. Maintainers deploy with `mkdocs gh-deploy`.

---

**Website**: [guide.shaazzz.ir](https://guide.shaazzz.ir)
