# 信息论笔记 · Information Theory Notes

> 牛津大学 **B8.4 Information Theory (2024–25)** 课程的双语 fill-in 学习笔记。
> Bilingual fill-in study notes for the Oxford course **B8.4 Information Theory (2024–25)**.
>
> 课程网站 / Course site: <https://courses.maths.ox.ac.uk/course/view.php?id=5519>

这里是信息论课程的 LaTeX 手写风格笔记，使用 [Loom](https://github.com/Polaris-Aeterna/loom-notes) 文档类排版。
每讲维护中英双语版本：英文版 `lecture-NN/`、中文版 `lecture-NN-zh/`，两套目录内容同步。
本笔记的模板与排版样式来自 [Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes)。

This repo holds handwritten-style LaTeX lecture notes for Information Theory, typeset with the
[Loom](https://github.com/Polaris-Aeterna/loom-notes) document class. Every lecture is kept in a
bilingual pair — English in `lecture-NN/` and Chinese in `lecture-NN-zh/` — kept in sync with one
shared body. The template and layout come from
[Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes).

---

## 目录结构 / Repository Structure

```
information_theory/
├── lecture-01/                 # 英文版 Lecture 1 — from surprise to shared information (EN)
│   ├── src/                    # 源代码 / source code
│   │   ├── main.tex            # 学生版主文件（填空模式）/ student version (fill-in mode)
│   │   ├── main-answers.tex    # 答案版主文件（显示答案）/ answer version (shows answers)
│   │   ├── main-body.tex       # 共享正文 / shared body, \input by the two entries above
│   │   ├── loom.cls            # 本地 Loom 文档类（扩展答案模式）/ local class w/ answer mode
│   │   └── sections/           # 分章节源文件 / section sources
│   │       ├── 01-probability-surprise.tex
│   │       ├── 02-entropy.tex
│   │       ├── 03-divergence.tex
│   │       ├── 04-mutual-conditional.tex
│   │       ├── 05-divergence-properties.tex
│   │       ├── 06-information-properties.tex
│   │       ├── 07-entropy-properties.tex
│   │       └── 08-fano.tex
│   ├── build/                  # 编译工作区（中间文件，gitignore）/ build workspace
│   └── pdf/                    # 最终成品，只放 PDF / final PDFs only
│       ├── main.pdf            # 学生版 / student version
│       └── main-answers.pdf    # 答案版 / answer version
├── lecture-01-zh/              # 中文版，结构与 lecture-01/ 同构 (ZH, mirrors lecture-01/)
│   ├── src/
│   │   ├── main.tex            # \documentclass[cjk]{loom}
│   │   ├── main-answers.tex
│   │   ├── main-body.tex
│   │   ├── loom.cls
│   │   └── sections/
│   ├── build/
│   └── pdf/
│       ├── main.pdf
│       └── main-answers.pdf
├── lecture-02/                 # 英文版 Lecture 2 — source coding (EN)
├── lecture-02-zh/              # 中文版，结构与 lecture-02/ 同构 (ZH)
├── scripts/build.sh            # 统一构建脚本 / build script
├── Makefile                    # make / make en / make zh / make clean
├── .cursor/skills/fill-in-notes/  # 项目化 skill 规范源（Cursor 自动加载）/ canonical skill
├── .agents/skills/fill-in-notes/  # → symlink，供 Codex 发现同一份 / for Codex
├── .claude/skills/fill-in-notes/  # → symlink，供 Claude Code 发现同一份 / for Claude Code
├── fill-in-notes-skill/          # → symlink（旧目录镜像）/ legacy mirror
├── loom-notes-main/            # Loom 仓库完整副本（参考用，只读）/ upstream copy (read-only)
├── notes.pdf                   # 手写扫描底稿 / handwritten scanned draft
├── tmp/                        # 临时栅格化页面（gitignore）/ temporary rasterized pages
├── AGENTS.md                   # 项目约定（给 agent 看）/ project conventions for agents
├── CLAUDE.md                   # AGENTS.md 的副本，供 Claude Code / mirror of AGENTS.md for Claude Code
├── README.md                   # 本文件 / this file
└── .gitignore
```

## 当前进度 / Progress

**Lecture 1** 的中英文版本已覆盖 8 节并保持同步 / EN + ZH versions cover 8 sections, kept in sync:

1. 概率分布与惊讶度 · probability & surprise
2. 熵 · entropy: definition, binary entropy function, maximum entropy
3. 散度（KL）· divergence / KL: definition, non-negativity, relation to entropy
4. 互信息与条件熵 · mutual information & conditional entropy: chain rule, Shannon's inequalities, equivalent forms of MI
5. 散度性质 · divergence properties
6. 信息处理不等式与信息性质 · data processing inequality & information properties
7. 熵的性质（约束下）· entropy under constraints
8. Fano 不等式及其一比特推论 · Fano's inequality and its one-bit corollary

**Lecture 2** 开始整理信源编码 / starting source coding, currently covering:

1. 信源编码、码字与期望码长 · source coding, codewords & expected length
2. 扩展码 · extended codes
3. 非奇异码、唯一可译码与前缀码 · non-singular, uniquely decodable & prefix codes

## 双版本机制 / Two-Version Mechanism

本笔记采用 **fill-in study notes** 风格：/ These notes use the **fill-in study notes** style:

- **学生版** `src/main.tex`：关键定义条款、计算步骤、证明空隙留空，供主动回忆填写。
  **Student version** — key definition clauses, computations, and proof gaps are left blank for active recall.
- **答案版** `src/main-answers.tex`：通过 `\showanswerstrue` 开关，把所有填空显示为红色答案。
  **Answer version** — the `\showanswerstrue` switch renders every blank as a red answer.

两个版本共享同一份正文 `src/main-body.tex`，只需改一个文件即可同步更新。
Both versions share one body, `src/main-body.tex`, so a single edit updates both.

## 编译 / Building

需要 **XeLaTeX** 与 Libertinus 字体（随 TeX Live / MacTeX 安装）；中文版另需 `Songti SC` / `PingFang SC`。
Requires **XeLaTeX** and the Libertinus fonts (bundled with TeX Live / MacTeX); the Chinese versions
additionally need `Songti SC` / `PingFang SC`.

```bash
make             # 所有讲次 × 中英文 × 学生版/答案版 / all lectures × languages × both versions
make en          # 编译所有英文讲次 / all English lectures
make zh          # 编译所有中文讲次 / all Chinese lectures
make lecture-01  # 只编译第一讲的中英文 / lecture 01 both languages
make lecture-02  # 只编译第二讲的中英文 / lecture 02 both languages
make clean       # 清理 build/ 中的中间产物 / clean build/ intermediates
```

构建过程严格分层 / Build directories are strictly separated:

- `src/`：只放 `.tex`、文档类、章节和素材 / only `.tex`, the class, sections and assets;
- `build/`：放 `.aux`、`.log`、`.xdv`、SyncTeX 和构建中的 PDF，整目录忽略 / `.aux`, `.log`, `.xdv`, SyncTeX and in-progress PDFs; gitignored as a whole;
- `pdf/`：只保留最终的 `main.pdf` 与 `main-answers.pdf` / only the final `main.pdf` and `main-answers.pdf`.

## 依赖 / Dependencies

- `loom.cls`：基于 `libertinus-otf`、`xeCJK`、`tcolorbox`、`titlesec` 等宏包 / built on packages such as `libertinus-otf`, `xeCJK`, `tcolorbox`, `titlesec`
- 字体 / Fonts：`Libertinus Serif/Math`、`Songti SC`、`PingFang SC`、`Optima`、`Avenir Next`

## 笔记方法 / Note-Taking Method

参考 Loom 的 fill-in method / Following Loom's fill-in method:

| 元素 Element | 命令 Command | 作用 Role |
|---|---|---|
| 核心直觉 · big idea | `strand` 环境 / env | 每节主线 / section thesis |
| 定义/定理/例子 · defs/thms/examples | `definition` / `theorem` / `example` | 知识点盒子 / concept boxes |
| 填空 · blank | `\answerin[width]{answer}` | 学生版空白，答案版显示答案 / blank for students, red answer for answers |
| 证明空隙 · proof gap | `\answertodo{hint}{answer}` | 学生版显示提示，答案版显示答案 / hint for students, answer shown |
| 文字参考答案 · prose answer | `\answerprose{answer}` | 学生版不显示，答案版显示红色文字 / hidden for students, red prose in answers |
| 主动练习 · practice | `yourturn` + `\workspace` | 练习区 / active zone |
| 页边复习 · margin review | `\recall{question}` | 复习钩子 / recall prompt |
| 未决问题 · open thread | `\loose{...}` | 下一章钩子 / hook for later |

## 新增章节的步骤 / Adding a New Section

1. 在对应讲次的 `src/sections/` 新建 `NN-slug.tex`（中文版同步建立同名文件）
   Create `NN-slug.tex` in the lecture's `src/sections/` (mirror the file in the Chinese lecture).
2. 用 `\input{sections/NN-slug}` 添加到 `src/main-body.tex`（中英文各加一次）
   Wire it into `src/main-body.tex` with `\input{sections/NN-slug}` (once per language).
3. 用 `\answerin` / `\answertodo` / `\answerprose` 设计填空与答案
   Design the blanks and answers with `\answerin` / `\answertodo` / `\answerprose`.
4. 在项目根目录运行 `make` / Run `make` from the repository root.
5. 检查对应 lecture 的 `pdf/main.pdf` 与 `pdf/main-answers.pdf`
   Check the lecture's `pdf/main.pdf` and `pdf/main-answers.pdf`.

## 模板来源与许可证 / Template Origin & License

- 本笔记的 LaTeX 模板与手写风格文档类来自 **[Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes)**。
  The LaTeX template and handwritten-style document class come from **[Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes)**.
- `loom-notes-main/` 是该仓库的完整副本，仅作参考使用。/ A full copy of that repo, kept for reference only.
- 笔记内容个人学习使用。Loom 文档类及其仓库遵循原仓库 [MIT 许可证](loom-notes-main/LICENSE)。
  Notes are for personal study. The Loom class and repo follow its [MIT License](loom-notes-main/LICENSE).
