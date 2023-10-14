<div align="center">
<h1>『入門 シャレイア語』</h1>
</div>


## 概要
シャレイア語の初学者向け入門書『入門 シャレイア語』を生成するためのファイル郡です。

## 下準備
あらかじめ Node.js の環境を構築しておいてください。

以下のコマンドを実行し、[SaxonJS](https://www.saxonica.com/download/javascript.xml) のコマンドラインインターフェースをインストールしてください。
```
npm install -g xslt3
```
`xslt3` コマンドが使えるようになっていれば問題ありません。

## 生成
XSL-FO ファイルの生成は 2 段階で行います。
第 1 段階で複数のファイルに分割された原稿ファイルを 1 つのファイルにまとめ、第 2 段階で XSL-FO 形式への変換を行います。

以下のコマンドを順に実行してください。
```
xslt3 -xsl:stylesheet/unification.xsl -s:document/manuscript/main.zpml -o:out/unification.xml
xslt3 -xsl:stylesheet/main.xsl -s:out/unification.xml -o:out/document.xml
```

`out/document.xml` が生成されるので、[AH Formatter](https://www.antenna.co.jp/AHF/) などの XSL-FO 処理系で開いてください。

## その他
このリポジトリのファイルの著作権は、全て Ziphil に帰属します。
また、タイプセットした結果の PDF ファイルを、Ziphil に無断で公開および販売することを禁じます。