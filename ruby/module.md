## モジュールとは何か
モジュールは関数や定数の集まりである。Classのように関数や定数を内包している。
## クラスとの違い
モジュールは、インスタンスを作ることはできない。(Module.newなどはできない)

対してクラスは、インスタンスを生み出し、そのデータ状態を維持することが可能となる。
## モジュールを使うメリット
1. さまざまなクラスに機能を共有
クラスと違うのは、モジュールはさまざまなクラスやモジュール内に機能を共有できる点である。
基本、Rubyでは継承などを使用し機能を受け継ぐことが出来るが、ひとつのクラスにひとつのクラスから継承するのが推奨されている。

```rb
module Name   
   def bella   
   end   
   def ana   
   end   
end   
module Job   
   def editor   
   end   
   def writer   
   end   
end   
  
class Combo   
include Name   
include Job   
   def f   
   end   
end   
  
final=Combo.new   
final.bella   
final.ana   
final.editor   
final.writer   
final.f  
```

それに対して、モジュールはさまざまなクラスにincludeすれば同様の機能を共有できる。
2. ネームスペースに使える
大規模な開発において、さまざまな関数名や定数名が使われるためにネームクラッシュが起きることがある。
その際に、モジュール内でそれらを管理することでコンフリクト問題のリスクを軽減することが可能となる。
以下は例となる。

```rb
  
module Library   
   num_of_books = 300   
   def Library.fiction(120)   
   # ..   
   end   
   def Library.horror(180)   
   # ..   
   end   
end  


module Novel   
   total = 123   
   read = 25   
   def Novel.fiction(left)   
   # ...   
   end   
end  

x = Library.fiction(Library::num_of_books)   
y = Novel.fiction(Novel::total)  

```

