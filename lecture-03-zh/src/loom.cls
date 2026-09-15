% 复用第一讲维护的中文版 Loom 文档类。
\InputIfFileExists{../../lecture-01-zh/src/loom.cls}{}{%
  \ClassError{loom}{Cannot find the shared Chinese Loom class}{}
}
