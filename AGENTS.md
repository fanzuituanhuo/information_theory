# Agent Notes for information_theory

## 课程信息

本仓库是**牛津大学 B8.4 Information Theory (2024–25)** 课程的 fill-in 学习笔记。

- 课程：B8.4 Information Theory (2024–25)，University of Oxford
- 课程网站：https://courses.maths.ox.ac.uk/course/view.php?id=5519

## 项目目标

用 Loom 手写风 LaTeX 类编写信息论课程的 **fill-in study notes**。笔记要同时满足：

1. **可读**：概念陈述完整、条理清晰；
2. **可填**：关键定义条款、计算过程、结论判据等留空，供主动回忆；
3. **可出答案**：同一份源码能生成学生版（挖空）和答案版（填红）。

笔记按讲次组织，并为每一讲维护**双语版本**：英文版 `lecture-NN/`、中文版 `lecture-NN-zh/`。每对源码内容同步、共享同一套正文骨架。Lecture 1 覆盖从惊讶度到 Fano 不等式；Lecture 2 开始整理信源编码。

## 目录约定

- `lecture-01/`：英文版工作目录。
  - `src/`：所有源代码和编译输入
    - `main.tex`：学生版入口，只设置宏和文档类，然后 `\input{main-body}`
    - `main-answers.tex`：答案版入口，在 `\input{main-body}` 前设置 `\showanswerstrue`
    - `main-body.tex`：共享正文，包含封面、总览地图、所有 `\input{sections/...}`
    - `sections/*.tex`：分节内容
    - `loom.cls`：本地 Loom 文档类（已扩展答案模式）
    - `assets/`：图片等辅助资源（若以后需要）
  - `build/`：编译工作区；所有 `.aux`、`.log`、`.xdv`、SyncTeX 和临时 PDF 均放这里（gitignore）
  - `pdf/`：最终成品目录，只保留 PDF
    - `main.pdf`：学生版
    - `main-answers.pdf`：答案版
- `lecture-01-zh/`：中文版工作目录，结构与 `lecture-01/` 同构。
- `lecture-02/`：第二讲英文版，聚焦信源编码；目录结构与第一讲同构。
- `lecture-02-zh/`：第二讲中文版，结构与 `lecture-02/` 同构。
- `.cursor/skills/fill-in-notes/`：**项目化版** skill 的规范源（真实文件），Cursor 在本项目自动加载。
- `.agents/skills/fill-in-notes/`：符号链接 → `.cursor/skills/fill-in-notes/`，供 Codex 在本项目发现并加载同一份 skill（Codex 跟随 symlink）。
- `fill-in-notes-skill/`：符号链接 → `.cursor/skills/fill-in-notes/`，旧目录的镜像，保持与规范源一致。
- `loom-notes-main/`：Loom 仓库只读参考副本，包含模板、示例和自带 skill（保留不动）。
- `notes.pdf`：手写扫描底稿（保留不动）。
- `tmp/`：临时栅格化页面（保留但 gitignore）。

## 技术栈

- 引擎：XeLaTeX
- 文档类：`src/loom.cls`（本地副本，已扩展答案模式）
- 加载方式：英文版 `\documentclass{loom}`，中文版 `\documentclass[cjk]{loom}`
- 双版本机制：由 `\ifshowanswers` 条件控制
- 中文支持：`[cjk]` 选项 + `xeCJK`（`CJKmath=true`），正文与数学环境均可直接写中文

## 填空与答案命令

本地 `loom.cls` 新增了三个核心命令，**优先使用它们**而不是旧的 `\fillin` / `\TODO`：

### `\answerin[width]{answer}`

- 学生版：显示为空白下划线（宽度可省略，默认 `2.2cm`）
- 答案版：显示红色答案，居中在下划线上

```tex
\answerin[3cm]{平均不确定性}
```

### `\answertodo{hint}{answer}`

- 学生版：显示 `[fill in: hint]`
- 答案版：显示红色 `[answer]`

```tex
\answertodo{用 Jensen 不等式}{由 Jensen 不等式，\Ent(X)\le\log|\X|。}
```

### `\answerprose{answer}`

- 学生版：**什么都不显示**（不留空、不下划线）
- 答案版：显示红色文字段落

用于纯文字 / workspace 型 `yourturn` 的参考答案，或答案本身就是一段说明而不需要"填在空里"的位置。

```tex
\begin{yourturn}
用一句话写出互信息与条件熵之间的关系。
\workspace[2]
\answerprose{$\MI(X;Y)=\Ent(Y)-\Ent(Y\mid X)$：知道 $X$ 后，对 $Y$ 的不确定性平均减少了 $\MI(X;Y)$。}
\end{yourturn}
```

## 编辑规范

1. **只在对应讲次的 `lecture-NN/src/` 与 `lecture-NN-zh/src/` 里改**，两套目录保持内容同步——改了一边的章节内容，另一边对应章节也要同步。
2. **共享正文在 `main-body.tex`**：新增章节时，在 `main-body.tex` 里加 `\input{sections/xx-xxx}`，不要同时改 `main.tex` 和 `main-answers.tex`。
3. **保持 fill-in 比例**：约 70% 阅读、30% 填空。不要把所有细节填死，也不要空得读不懂。
4. **侧栏答案传统**：学生版中的可见填空或 workspace 旁，用简短的
   `\studentrecall{答案}` 放置“问号 + 答案”侧栏提示；该提示在答案版隐藏。
   相邻空属于同一题时可以共用一条，避免侧栏重叠。
5. **定理与证明处理**：
   - 定理、引理、命题、推论的陈述默认完整给出，不挖空。
   - 证明默认不挖空，保持推导连贯可读；不要按 skill 示例把证明机械改成 proof skeleton。
   - 证明后适合加一个简短 `yourturn`，让学生复述关键动作、关键等式或一句话直觉。
   - 主动回忆优先放在定义关键条款、对照表、例题计算、结论判据、`yourturn`，或证明后的简短"关键思想回忆"中。
   - 只有特别适合训练的一步短证明，才可少量用 `\answertodo` 挖一个核心动作。
6. **符号一致性**（本项目宏，定义在两个入口文件中）：
   - 期望 `\E` → `\mathbb{E}`
   - 概率 `\PP` → `\mathbb{P}`
   - 字母表 `\X` → `\mathcal{X}`，`\Y` → `\mathcal{Y}`
   - 熵 `\Ent` → `\mathrm{H}`
   - 互信息 `\MI` → `\mathrm{I}`
   - 散度 / KL `\KL` → `\mathrm{D}`
7. **中文字体**：中文版通过 `[cjk]` + `xeCJK` 支持，正文和数学环境中的中文都可直接写。
8. **每节固定节奏**：
   - `\section{标题}`
   - `\warmth{0}\quad\whisper{...}`
   - `\begin{strand} ... \end{strand}`
   - 知识点盒子 + 表格 + `\answerin` / `\answertodo` / `\answerprose` + `yourturn`
   - `\recall{...}`

## 编译检查

修改后必须两个版本、两套语言都能编译通过：

```bash
make             # 所有讲次的中英文学生版与答案版
make en          # 所有英文讲次
make zh          # 所有中文讲次
make lecture-02  # 第二讲中英文学生版与答案版
make clean # 清理 build/ 中间产物
```

编译中间文件统一放在各 lecture 的 `build/`，最终 PDF 复制到 `pdf/`。不要直接在 `src/` 中运行裸 `latexmk`，也不要把中间文件写入 `pdf/`。

如果出现字体或宏包错误，先检查是否使用了系统未安装的字体，再检查中文版是否漏了 `[cjk]` 选项。

## 与 Loom skill 的关系

- `.cursor/skills/fill-in-notes/`：**项目化版** skill 的规范源（真实文件）。Cursor 在本项目自动加载它；新会话中若用户说「把这一章做成 fill-in notes」或类似触发语，会加载这一份。它指向本项目的路径与宏。
- `.agents/skills/fill-in-notes/`：符号链接 → `.cursor/skills/fill-in-notes/`，供 Codex 在本项目发现同一份 skill（Codex 从 `.agents/skills/` 向上扫描，且跟随 symlink）。
- `fill-in-notes-skill/`：符号链接 → `.cursor/skills/fill-in-notes/`，旧目录的镜像，内容始终与规范源一致。
- `loom-notes-main/skill/`：Loom 仓库自带的 skill（上游通用参考，只读）。
- `~/.codex/skills/fill-in-notes/`：Codex **全局**通用版 skill（所有项目共用，本仓库不改动它）。在本项目里它与项目化版同名共存——Codex 会把两者都列入选择器；本项目任务请优先选/触发项目化版（描述里含 information_theory）。

注意：上游 / 通用版 skill 里的示例使用的是旧的 `\fillin` / `\TODO`，而本项目实际使用的是本地扩展的 `\answerin` / `\answertodo` / `\answerprose`。请按本项目规范执行。

## 注意事项

- 不要修改 `loom-notes-main/` 里的官方文件，除非是要同步更新 Loom 版本。
- `fill-in-notes-skill/` 与 `.agents/skills/fill-in-notes/` 都是符号链接，**不要**改成真实文件或单独编辑；要改 skill 就改规范源 `.cursor/skills/fill-in-notes/`。
- 不要修改 `notes.pdf`（手写底稿）。
- 新增图片统一放在对应 lecture 的 `src/assets/`。
- 最终 PDF 输出到各 lecture 的 `pdf/`；中间文件只放 `build/`，源码目录 `src/` 保持纯净。
- `tmp/` 是临时栅格化页面，保留但已被 gitignore。
