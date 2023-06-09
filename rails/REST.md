## RESTとは？
RESTとは、「REpresentational State Transfer」の略で、ウェブ上でデータをやりとりするための設計思想です。RESTを使ったAPIを「RESTful API」とも呼びます。RESTにはいくつかの原則があり、これらを守ることで、シンプルで使いやすく、拡張性の高いAPIを作ることができます。

RESTの4つの主な原則は以下の通りです：

1. **リソースの識別**: RESTでは、ウェブ上のあらゆる情報やデータを「リソース」と呼びます。これらのリソースは、URL（Uniform Resource Locator）によって一意に識別されます。たとえば、ユーザーの情報は`http://example.com/users`のようなURLで表されます。

2. **HTTPメソッドの使用**: RESTはHTTPメソッドを使ってリソースに対する操作を表します。主なHTTPメソッドには、GET（データの取得）、POST（データの作成）、PUT（データの更新）、DELETE（データの削除）などがあります。これらのメソッドを使うことで、何をしたいのかをはっきりと示すことができます。

3. **表現の状態転送**: RESTの名前にもある「REpresentational」が示すように、リソースの状態はその表現と共にクライアントとサーバーの間でやりとりされます。一般的に、リソースの表現はJSONやXML形式で行われます。クライアントはリソースの表現を使って、リソースの状態を理解し、必要な操作を行います。

4. **ステートレス性**: RESTでは、各リクエストはそれ自体で完結しており、クライアントとサーバーの間には状態が保存されません。これにより、サーバーは複数のリクエストを独立して扱うことができ、スケーラビリティ（拡張性）が高まります。

これらの原則に従ってAPIを設計することで、わかりやすく、使いやすく、メンテナンスしやすいAPIを作ることができます。
