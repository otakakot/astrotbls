#!/bin/bash

tmp="tmp"

mkdir -p "${tmp}"

tbls doc "postgres://postgres:postgres@localhost:5432/postgres?sslmode=disable" "${tmp}"

dir="doc/src/pages"

for file in "${tmp}"/*; do
    # ファイルをコピー先ディレクトリにコピー
    cp "${file}" "${dir}"
done

# 指定したディレクトリ以下の全ての .md ファイルを取得
find "${dir}" -name '*.md' | while read file
do
    # ファイル内の文字列を書き換え
    sed -i '' -e 's/(\([a-zA-Z0-9_.-]*\)\.md)/(\.\/\1)/g' "${file}"
    sed -i '' -e 's/(\([a-zA-Z0-9_.-]*\.svg\))/(\.\/\1)/g' "${file}"
done

# .md ファイルに以下のヘッダーを追加
header='---
layout: ../layouts/Layout.astro
---
'

find "${dir}" -name '*.md' | while read file
do
    # 一時ファイルを作成
    temp_file="tmpmd"

    # ヘッダーを一時ファイルに書き込む
    echo "$header" > "$temp_file"

    # 元のファイルの内容を一時ファイルに追加
    cat "$file" >> "$temp_file"

    # 一時ファイルを元のファイルに移動
    mv "$temp_file" "$file"
done

rm -rf "${tmp}"
