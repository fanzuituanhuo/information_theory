---
name: fill-in-notes
description: >-
  Turn a textbook chapter, lecture, or paper into Loom fill-in study notes for
  this information_theory repo — bilingual (English lecture-NN/ + Chinese
  lecture-NN-zh/), readable exposition with active-recall blanks, dual
  student/answer PDFs via \answerin, \answertodo, and \answerprose. Use when
  the user wants fill-in notes, guided study notes, "读+填 笔记", "被动+主动
  learning notes", or to convert a chapter/PDF into notes they can fill in.
  NOT for a plain summary, a polished paper, or notes with every detail
  spelled out.
---

# Fill-in notes — this project

Produce study notes that a learner both **reads** and **fills**. Work only in
the matching `lecture-NN/src/` (English) and `lecture-NN-zh/src/` (Chinese)
pair; keep both in sync. Prefer project conventions over the upstream Loom skill examples
(`\fillin` / `\TODO` / proof skeletons).

## Pipeline

1. **Read the source; find the spine.** Name ONE organizing idea; reorganize
   around it. Do not transcribe section-by-section if a better shape exists.
2. **Edit the existing tree** (do not copy `loom-notes-main/template/`):
   - shared body: `lecture-NN/src/main-body.tex` (and `lecture-NN-zh/src/main-body.tex`)
   - new section: `lecture-NN/src/sections/NN-slug.tex` (and the matching Chinese path)
   - wire it with `\input{sections/NN-slug}` in `main-body.tex` only
3. **Draft each section in the Loom grammar** (table below + project rhythm).
4. **Engineer gaps (~70% read / 30% fill).** See [reference/method.md](reference/method.md).
5. **Compile both versions, both languages** and fix [reference/pitfalls.md](reference/pitfalls.md):

```bash
# From the repository root: all lectures and languages
make

# Or build only one bilingual lecture pair
make lecture-02
```

## Project fill-in commands (use these)

| Command | Student | Answers (`\showanswerstrue`) |
|---|---|---|
| `\answerin[width]{answer}` | blank underline (default `2.2cm`) | red answer on the line |
| `\answertodo{hint}{answer}` | `[fill in: hint]` | red `[answer]` |
| `\answerprose{answer}` | nothing | red prose paragraph |

Do **not** use bare `\fillin` / `\TODO` in new content — they have no answer mode.

Project tradition: pair each visible student blank, or a small group of closely
related blanks, with a nearby concise `\studentrecall{answer}`. This places a
blue question mark plus the answer in the student-version margin and hides the
duplicate hint in the answer version. Keep the margin answer short and position
it beside the relevant blank; do not let adjacent margin notes overlap.

```tex
熵度量的是信源的 \answerin[3cm]{平均不确定性}。
\answertodo{用 Jensen 不等式}{由 Jensen 不等式，\Ent(X)\le\log|\X|。}
\answerprose{$\MI(X;Y)=\Ent(Y)-\Ent(Y\mid X)$：知道 $X$ 后对 $Y$ 的不确定性平均减少了 $\MI(X;Y)$。}
```

Entry files: `main.tex` (student) and `main-answers.tex` (`\showanswerstrue` then
`\input{main-body}`). Shared macros live in both entries:
`\E`→`\mathbb{E}`, `\PP`→`\mathbb{P}`, `\X`→`\mathcal{X}`, `\Y`→`\mathcal{Y}`,
`\Ent`→`\mathrm{H}`, `\MI`→`\mathrm{I}`, `\KL`→`\mathrm{D}`.

## The Loom grammar — what goes where

| beat | device | role |
|---|---|---|
| one-line thesis | `strand` env | big idea, read-only |
| when to use it | `\trigger{…}` | cue line |
| sub-heading | `\block{…}` | quiet section lead |
| quick-reference | `tabularx` w/ `L` column | cheat-sheet / dictionary |
| definition | `definition` | state it; blank a key clause with `\answerin` |
| result | `theorem`/`lemma`/`prop`/`cor` | state in full (read) |
| proof | `proof` | keep readable by default (see method) |
| worked instance | `example` | setup given |
| do-it-yourself | `yourturn` + `\workspace[n]` | active zone |
| grok meter | `\warmth{0..5}` | self-assessment |
| margin recall | `\recall{question}` | parked prompt |
| open thread | `\loose{…}` | exercise for later |
| cross-ref | `\warp{key}` / `\pick{key}` | recurring object |

Full command list: [reference/loom-commands.md](reference/loom-commands.md).

## Per-section rhythm (this repo)

```tex
\section{标题}
\warmth{0}\quad\whisper{...}
\begin{strand} ... \end{strand}
% knots + tables + \answerin / \answertodo / \answerprose + yourturn
\recall{...}
```

## Symbols

- expectation: `\E` · probability: `\PP`
- alphabet: `\X` / `\Y`
- entropy: `\Ent` · mutual information: `\MI` · KL divergence: `\KL`
- CJK is fine in text and math (`[cjk]` + `CJKmath`)

## Honest scoping

- Restating a source for personal study is fine; before publishing notes that
  closely track a copyrighted book, attribute clearly and prefer original examples.
- Keep source numbering in knot titles when useful, e.g. `Theorem 4.1 (… Thm. 2.16)`.

## See also

- [reference/method.md](reference/method.md) — 70/30 gaps, proof policy
- [reference/pitfalls.md](reference/pitfalls.md) — XeLaTeX / layout traps
- [reference/loom-commands.md](reference/loom-commands.md) — Loom devices + answer cmds
- `AGENTS.md` — full project conventions
- `loom-notes-main/` — upstream template/examples (read-only reference); `loom-notes-main/skill/` is the generic upstream skill
