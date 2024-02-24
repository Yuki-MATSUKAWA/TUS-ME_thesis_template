#!/usr/bin/env perl

# 変数
# %O: 実行時オプション
# %S: 入力ファイル名
# %D: 出力ファイル名
# %B: 処理するファイル名の拡張子を除いた文字列

#################
##### LaTeX #####
#################
# -synctex=1: SyncTeX が有効になり，適切な pdf viewer を用いることで pdf の文章から該当するソースコードに飛べる．
# -halt-on-error: コンパイル中にエラーが発生した場合，コンパイルを終了する．
# -interaction=nonstopmode: コンパイル中にエラーが起きても，ユーザーにどう処理するかの指示を求めずにコンパイルを続行する．
# -file-line-error: tex ファイルの何行目でエラーが発生したかを表示．
# $max_repeat: 最大コンパイル回数．

## pLaTeX でコンパイルするならこれを使う．
# $latex = 'platex -synctex=1 -halt-on-error -file-line-error %O %S';
## upLaTeX でコンパイルするならこれを使う．
# $latex = 'uplatex -synctex=1 -halt-on-error -file-line-error %O %S';
## LuaLaTeX でコンパイルするならこれを使う．
$lualatex = 'lualatex -synctex=1 -halt-on-error -file-line-error %O %S';
$max_repeat = 5;

###########################
##### BibTeX/BibLaTeX #####
###########################
# kanji=utf8: 文字コードを UTF-8 に指定．
# $biber: BibLaTeX のバックエンドで Biber を動かすときの設定．
# --bblencoding=utf8: bbl ファイルのエンコーディングを UTF-8 に指定．
# -u: 入力ファイルのエンコーディングを UTF-8 に指定．
# -U: 出力ファイルのエンコーディングを UTF-8 に指定．
# --output_safechars: Unicode 文字を LaTeX の命令を使ってエンコーディングした形で出力させる．
## pLaTeX で pBibTeX を使うときはこれ．
# $bibtex = 'pbibtex %O %S';
## upLaTeX で upBibTeX を使うときはこれ．
# $bibtex = 'upbibtex kanji=utf8 %O %S';
## LuaLaTeX のときはこれ．
$bibtex = 'upbibtex %O %S';
## BibLaTeX を使うときはこれ．
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';

#################
##### index #####
#################
# 索引を作成する場合に使用．
$makeindex = 'upmendex %O -o %D %S';

#####################
##### dvi / pdf #####
#####################
## LuaLaTeX の場合は不要．
# $dvipdf = 'dvipdfmx %O -o %D %S';

# $pdf_mode: pdf ファイルの出力形式を指定．
## 1: $latex により dvi ファイルを生成する．pdf ファイルを出力しない．
## 2: $pdflatex により dvi ファイルなどを経由せずに直接 pdf ファイルを作成．
## 3: $latex により dvi ファイルを生成し，$dvipdf により pdf ファイルを作成．
## 4: $lualatex により直接 pdf ファイルを作成．
## 5: $xelatex により dvi を生成後，$xdvipdfmx により pdf を作成．
$pdf_mode = 4;
$pdf_previewer = "start %S";

######################################
##### 生成ファイルの出力先フォルダ #####
######################################
$out_dir = 'latex.out';