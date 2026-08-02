#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

build_lecture() {
  local lecture="$1"
  local source_dir="${project_root}/${lecture}/src"
  local build_dir="${project_root}/${lecture}/build"
  local pdf_dir="${project_root}/${lecture}/pdf"

  mkdir -p "${build_dir}" "${pdf_dir}"

  for entry in main main-answers; do
    (
      cd "${source_dir}"
      latexmk \
        -norc \
        -silent \
        -xelatex \
        -interaction=nonstopmode \
        -halt-on-error \
        -synctex=1 \
        -outdir="${build_dir}" \
        "${entry}.tex"
    )
    cp "${build_dir}/${entry}.pdf" "${pdf_dir}/${entry}.pdf"
  done
}

case "${1:-all}" in
  all)
    build_lecture "lecture-01"
    build_lecture "lecture-01-zh"
    build_lecture "lecture-02"
    build_lecture "lecture-02-zh"
    ;;
  en)
    build_lecture "lecture-01"
    build_lecture "lecture-02"
    ;;
  zh)
    build_lecture "lecture-01-zh"
    build_lecture "lecture-02-zh"
    ;;
  lecture-01)
    build_lecture "lecture-01"
    build_lecture "lecture-01-zh"
    ;;
  lecture-02)
    build_lecture "lecture-02"
    build_lecture "lecture-02-zh"
    ;;
  *)
    echo "Usage: scripts/build.sh [all|en|zh|lecture-01|lecture-02]" >&2
    exit 2
    ;;
esac
