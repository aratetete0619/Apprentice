## HTTPメソッドとは？
HTTP メソッドは、ウェブ上で情報をやり取りする際に、ウェブブラウザがウェブサーバーに対してどのようなアクションを求めるのかを伝えるための手段です。ちょっとした例で考えると、レストランのウェイターに注文するときに、何をしたいのかを伝える方法がいくつかあると想像してください。例えば「このメニューをください」、「追加の水をください」、「お会計をお願いします」など。

同じように、HTTP メソッドもウェブサーバーに対して何をしたいのかを伝える方法です。主なHTTP メソッドには以下のようなものがあります。

1. **GET**: これはウェブサーバーに「情報を見せて」とお願いするメソッドです。ウェブページを表示したいときや、画像を見たいときなどに使われます。

2. **POST**: これはウェブサーバーに「情報を保存して」とお願いするメソッドです。例えば、ウェブサイトでアカウントを作成したり、フォームに入力したデータを送信したりする時に使われます。

3. **PUT**: これはウェブサーバーに「情報を更新して」とお願いするメソッドです。既存の情報を新しい情報で置き換える時に使います。

4. **DELETE**: これはウェブサーバーに「情報を削除して」とお願いするメソッドです。ウェブサイト上の何かを削除したいときに使われます。

5. **PATCH**: これも情報を更新するためのメソッドですが、PUTと異なり、情報の一部分だけを変更します。

これらのHTTP メソッドを使うことで、ウェブブラウザはウェブサーバーに対して、具体的に何をしたいのかを伝えることができます。それぞれのメソッドは特定の種類のアクションを表していて、ウェブサーバーはそのアクションに応じて適切なレスポンスを返します。