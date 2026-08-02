# 信息论笔记 · Information Theory Notes

牛津大学 **B8.4 Information Theory (2024–25)** 课程的双语 fill-in 学习笔记。课程网站：<https://courses.maths.ox.ac.uk/course/view.php?id=5519>。

这里是信息论课程的 LaTeX 手写风格笔记，使用 [Loom](https://github.com/Polaris-Aeterna/loom-notes) 文档类排版。
本笔记的模板与排版样式来自 [Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes)。

## 目录结构

```
information_theory/
├── lecture-01/                 # 英文版：Lecture 1 — from surprise to shared information
│   ├── src/                    # 源代码
│   │   ├── main.tex            # 学生版主文件（填空模式）
│   │   ├── main-answers.tex    # 答案版主文件（显示答案）
│   │   ├── main-body.tex       # 正文内容，被上面两个文件共享
│   │   ├── loom.cls            # 本地 Loom 文档类（支持答案模式）
│   │   └── sections/           # 分章节源文件
│   │       ├── 01-probability-surprise.tex
│   │       ├── 02-entropy.tex
│   │       ├── 03-divergence.tex
│   │       ├── 04-mutual-conditional.tex
│   │       └── … 08-fano.tex
│   ├── build/                  # 编译工作区（中间文件，gitignore）
│   └── pdf/                    # 最终成品，只放 PDF
│       ├── main.pdf            # 学生版
│       └── main-answers.pdf    # 答案版
├── lecture-01-zh/              # 中文版，结构与 lecture-01/ 同构
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
├── lecture-02/                 # 英文版：Lecture 2 — source coding
├── lecture-02-zh/              # 中文版，结构与 lecture-02/ 同构
├── scripts/build.sh            # 统一构建脚本
├── Makefile                    # make / make en / make zh / make clean
├── .cursor/skills/fill-in-notes/  # 项目化 skill 规范源（Cursor 自动加载）
├── .agents/skills/fill-in-notes/  # → 符号链接到上面，供 Codex 发现同一份
├── fill-in-notes-skill/          # → 符号链接到 .cursor/skills/fill-in-notes/（旧目录镜像）
├── loom-notes-main/            # Loom 仓库完整副本（参考用，只读）
├── notes.pdf                   # 手写扫描底稿
├── tmp/                        # 临时栅格化页面（gitignore）
├── AGENTS.md                   # 项目约定（给 agent 看）
├── README.md                   # 本文件
└── .gitignore
```

## 当前进度

Lecture 1 的中英文版本已覆盖 8 节并保持同步：

1. 概率分布与惊讶度（probability & surprise）
2. 熵（entropy）：定义、二进制熵函数、最大熵
3. 散度（divergence / KL）：定义、非负性、与熵的关系
4. 互信息与条件熵（mutual information & conditional entropy）：链式法则、Shannon 不等式、互信息的几种等价形式
5. 散度不等式（divergence inequalities）
6. 信息处理不等式与信息性质（information properties）
7. 约束下的熵（entropy under constraints）
8. Fano 不等式及其一比特推论（Fano's inequality）

Lecture 2 开始整理信源编码，目前覆盖：

1. 信源编码、码字与期望码长
2. 扩展码
3. 非奇异码、唯一可译码与前缀码

## 双版本机制

本笔记使用 **fill-in study notes** 风格：

- **学生版** `src/main.tex`：关键定义条款、计算步骤、证明空隙留空，供主动回忆填写。
- **答案版** `src/main-answers.tex`：通过 `\showanswerstrue` 开关，把所有填空显示为红色答案。

两个版本共享同一份正文内容 `src/main-body.tex`，只需改一个文件即可同步更新。

## 编译

需要 XeLaTeX + Libertinus 字体（随 TeX Live 或 MacTeX 安装）；中文版另需 `Songti SC` / `PingFang SC`。

```bash
make             # 所有讲次 × 中英文 × 学生版/答案版
make en          # 编译所有英文讲次
make zh          # 编译所有中文讲次
make lecture-01  # 只编译第一讲的中英文版本
make lecture-02  # 只编译第二讲的中英文版本
make clean # 清理 build/ 中的中间产物
```

构建过程严格分层：

- `src/`：只放 `.tex`、文档类、章节和素材；
- `build/`：放 `.aux`、`.log`、`.xdv`、SyncTeX 和构建中的 PDF，整目录忽略；
- `pdf/`：只保留最终的 `main.pdf` 与 `main-answers.pdf`。

## 依赖

- `loom.cls`：基于 `libertinus-otf`、`xeCJK`、`tcolorbox`、`titlesec` 等宏包
- 字体：`Libertinus Serif/Math`、`Songti SC`、`PingFang SC`、`Optima`、`Avenir Next`

## 笔记方法

参考 Loom 的 fill-in method：

| 元素 | 命令 | 作用 |
|---|---|---|
| 核心直觉 | `strand` 环境 | 每节主线 |
| 定义/定理/例子 | `definition` / `theorem` / `example` | 知识点盒子 |
| 填空 | `\answerin[width]{answer}` | 学生版空白，答案版显示答案 |
| 证明空隙 | `\answertodo{hint}{answer}` | 学生版显示提示，答案版显示答案 |
| 文字参考答案 | `\answerprose{answer}` | 学生版不显示，答案版显示红色文字 |
| 主动练习 | `yourturn` + `\workspace` | 练习区 |
| 页边复习 | `\recall{question}` | 复习钩子 |
| 未决问题 | `\loose{...}` | 下一章钩子 |

## 新增章节的步骤

1. 在对应讲次的 `src/sections/` 新建 `NN-slug.tex`（中文版同步建立同名文件）
2. 用 `\input{sections/NN-slug}` 添加到 `src/main-body.tex`（中英文各加一次）
3. 用 `\answerin` / `\answertodo` / `\answerprose` 设计填空与答案
4. 在项目根目录运行 `make`
5. 检查对应 lecture 的 `pdf/main.pdf` 与 `pdf/main-answers.pdf`

## 模板来源与许可证

- 本笔记的 LaTeX 模板与手写风格文档类来自 **[Polaris-Aeterna/loom-notes](https://github.com/Polaris-Aeterna/loom-notes)**。
- `loom-notes-main/` 是该仓库的完整副本，仅作参考使用。
- 笔记内容个人学习使用。Loom 文档类及其仓库遵循原仓库 [MIT 许可证](loom-notes-main/LICENSE)。
