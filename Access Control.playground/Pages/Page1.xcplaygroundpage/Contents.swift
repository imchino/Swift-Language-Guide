/*:
 アクセス制御は、他のソースファイルやモジュールから一部のコードに対するアクセスを制限します。
 この機能により、実装の詳細を隠したり、そのコードにアクセスするための優先的なインターフェイスを指定できます。

 特定のアクセスレベルを個々の型（クラス、構造体、および列挙型）、およびそれに属するプロパティ、メソッド、初期化子、および添え字に適用できます。
 グローバル定数、変数、および関数と同様に、プロトコルは特定のコンテキストに制限できます。

 さまざまなレベルのアクセス制御を提供することに加えて、Swiftは典型的なシナリオにデフォルトのアクセスレベルを提供することによって、明示的なアクセス制御レベルを指定する必要性を減らします。
 事実として、ターゲットが単体であるアプリ開発では、明示的なアクセス制御レベルを指定する必要はまったくありません。
 
 ### NOTE
 アクセス制御を適用できるさまざまなコード（プロパティ、型、関数など）は、以降のセクションでは簡潔に"エンティティ"と呼びます。
 */
/*:
 ## Modules and Source Files
 モジュールとソースファイル
 Swiftのアクセス制御モデルは、モジュールとソースファイルの概念に基づいています。

 モジュールはコードを配布できる単一のユニットとして、構築および出荷されます。
 Swiftのimportキーワードを使用して、別のモジュールにインポートできるフレームワークまたはアプリケーションです。

 Xcodeの各ビルドターゲット（アプリバンドルやフレームワークなど）は、Swiftでは個別のモジュールとして扱われます。
 アプリケーションのコードの一部分をスタンドアロンのフレームワークとしてグループ化した場合、そのフレームワーク内で定義したものはすべて、アプリケーション内でインポートして使用する時点で、別のモジュールの一部になります。

 ソースファイルは、モジュール内の単一のSwiftソースコードファイルです。
 事実上の、アプリまたはフレームワーク内の単一のファイルです。
 個々の型を別々のソースファイルに定義するのが一般的です。
 ただし、単一のソースファイルに複数の型、関数などの定義を含めることもできます。
 */
/*:
 ## Access Levels
 アクセスレベル

 Swiftは、コード内のエンティティに対して5つの異なるアクセスレベルを提供します。
 アクセスレベルは、エンティティが定義されているソースファイル、およびそのソースファイルが属するモジュールに関連します。

 オープンアクセスとパブリックアクセス
 エンティティは「定義元モジュール」から任意のソースファイルで使用できます。
 「定義しているモジュールをインポートする他のモジュール」から他のソースファイルでも使用できます。
 フレームワークにパブリックインタフェースを指定するときは、通常、オープンアクセスまたはパブリックアクセスを使用します。
 オープンアクセスとパブリックアクセスの違いは後述します。

 インターナルアクセス
 エンティティを「定義元モジュール」の任意のソースファイル内で使用できます。
 ただし、そのモジュール外のソースファイルでは使用できません。
 通常、アプリまたはフレームワークの内部構造を定義するときには、インターナルアクセスを使用します。
  
 ファイルプライベートアクセス
 エンティティが定義されているソースファイル内のみに、その使用を制限します。
 特定の機能がファイル全体にわたって使用されるとき、ファイルプライベートアクセスを使用して、機能の実装詳細を隠します。

 プライベートアクセス
 エンティティの使用を、それを囲む宣言、および同じファイル内にあるその宣言のエクステンションに制限します。
 特定の機能の実装詳細が単一の宣言内でのみ使用されている場合は、その詳細を非表示にするためにプライベートアクセスを使用します。

 
 
 */
