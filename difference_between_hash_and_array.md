## 配列とハッシュの違いについて
配列はarrayクラス、ハッシュはHashクラスのオブジェクトです。Rubyのリファレンスでは、下記のように示されています。

> class Array 
> ---
> 配列クラスです。配列は任意の Ruby オブジェクトを要素として持つことができます。

> class Hash
> ---
> ハッシュテーブル(連想配列とも呼ぶ)のクラスです。ハッシュは任意の種類のオブジェクト(キー)から任意の種類のオブジェクト(値)への関連づけを行うことができます。

どちらも所持するという点では同じなような気がしますがもう少しわかりやすく噛み砕くと、配列はオブジェクトへの参照が<span style="color: red">順番に並んでいる</span>のに対して、<span style="color: blue">キーに複数対応したキーを所持したもの</span>がハッシュという解釈。

トランプが順番に並べられたものが配列、対してバラバラに置いてあるトランプがハッシュのイメージ。
K=13,A＝1と表せる。下記の記事を参照（ほぼ丸パクリです🙇）

- [【 第4回】Ruby初心者向け！配列とハッシュの違いとは？](https://code-schools.com/ruby4/)
- [Ruby リファレンスマニュアル　class Array](https://docs.ruby-lang.org/ja/latest/class/Array.html)
- [Ruby リファレンスマニュアル　class Hash](https://docs.ruby-lang.org/ja/latest/class/Hash.html)
