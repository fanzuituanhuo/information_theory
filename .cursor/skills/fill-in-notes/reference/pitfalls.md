# Pitfalls — XeLaTeX / unicode-math / this repo

## Engine & dual build
- **Must use XeLaTeX** (`latexmk -xelatex`), never pdflatex — class loads `fontspec`.
- Always build **both** student and answer entries, **both** languages:

```bash
make             # every lecture pair
make lecture-02  # one bilingual lecture pair
```

- Intermediate `.aux`/`.log`/`.xdv` stay in `src/`; final PDFs only in `pdf/`.
- Run twice (or latexmk): selvage rail uses `remember picture`; TOC/`\ref` need pass 2.
- Chinese entry: `\documentclass[cjk]{loom}` — missing `[cjk]` breaks Chinese.
- Non-macOS: swap `\newfontfamily` lines in `lecture-01-zh/src/loom.cls` if needed
  (e.g. Songti SC / PingFang SC substitutes).

## Answer-mode commands
- New blanks: `\answerin` / `\answertodo` / `\answerprose` only. Bare `\fillin` /
  `\TODO` have no answer-mode fill and break the dual-PDF workflow.
- `\answerprose` shows **nothing** in student mode — use it for prose reference
  answers under `yourturn`/`\workspace`, not as a visible blank.
- Math-mode answers: `\answerin` handles math vs text; prefer
  `\answerin[…]{\text{…}}` when the blank sits in a display and the answer is
  Chinese/words.
- Several blanks on one display line overflow — stack in `aligned` instead of one row.

## unicode-math
- `\mathbb` in a subscript needs braces: `\PP^1_{\X}`, not `\PP^1_\X`.
- `\widehat` over a `\mathbb` macro needs braces: `\widehat{\E}`.
- Do **not** load `amssymb` — conflicts with unicode-math (`\eth already defined`).

## Layout
- Wide table columns: use `L` (wrapping `X`); header over `L` as
  `\multicolumn{1}{l}{\color{indigo}…}`.
- Long `\warp{key}` tags clip — keep keys short.
- Margin notes don't auto-avoid: don't put `\loose` right after a `yourturn` that
  ends with `\recall` — they overprint. Close with an inline `strand` or separate them.
- Optima lacks some glyphs (e.g. `→`): in `\block`/headings use `$\to$`.

## Project hygiene
- Edit only under the matching `lecture-NN/src/` and `lecture-NN-zh/src/`. Do not modify
  `loom-notes-main/` unless syncing upstream Loom. Do not modify
  `fill-in-notes-skill/` (upstream generic skill, kept for reference) or
  `notes.pdf` (handwritten draft).
- New images → the relevant `lecture-NN/src/assets/` (or the Chinese counterpart).
- New sections: add `\input{…}` only in `main-body.tex`, not in both entry files.
  Mirror the same `\input` in the other language's `main-body.tex`.
- When bulk-replacing Chinese, use UTF-8-aware tools (plain `perl -CSD` can mojibake).

## Verify before declaring done
```bash
# English
cd lecture-01/src
latexmk -xelatex main && latexmk -xelatex main-answers
gs -dQUIET -dBATCH -dNOPAUSE -sDEVICE=png16m -r130 -dFirstPage=2 -dLastPage=2 -o p2.png ../pdf/main.pdf
grep -cE 'Overfull \\hbox \([0-9]{2,}\.' main.log
grep -c undefined main.log
grep -c 'Font shape .*undefined' main.log

# Chinese — same with lecture-01-zh/src
```
Aim for 0 on the greps; actually look at the rasterized page.
