#!/bin/bash

set -e
# test passed in pandoc 1.19.1

MAINFONT="WenQuanYi Micro Hei"
MONOFONT="WenQuanYi Micro Hei Mono"

# MAINFONT="Tsentsiu Sans HG"
# MONOFONT="Tsentsiu Sans Console HG"

#_version_tag="$(date '+%Y%m%d').$(git rev-parse --short HEAD)"
_version_tag="$(date '+%Y%m%d')"

# default version: `pandoc --latex-engine=xelatex doc.md -s -o output2.pdf`
# used to debug template setting error
lang=(zh)

for d in "${lang[@]}"
do
if [ $d = "en" ]; then
    doc_title="Dev Guide Documentation"
else
    doc_title="Dev Guide 用户文档"
fi;
pandoc -N --toc --smart --latex-engine=xelatex \
--template=templates/template.tex \
--columns=80 \
--listings \
-V title="$doc_title" \
-V author="PingCAP Inc." \
-V date="${_version_tag}" \
-V CJKmainfont="${MAINFONT}" \
-V fontsize=12pt \
-V geometry:margin=1in \
-V include-after="\\input{templates/copyright.tex}" \
"$d/doc.md" -s -o "output_$d.pdf"
done
