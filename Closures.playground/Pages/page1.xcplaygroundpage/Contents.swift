//: [Previous](@previous)
/*:
 # Closures
 クロージャーは自己完結型の機能ブロックであり、関数をコードに渡して使用できます。
 Swiftのクロージャーは、CおよびObjective-Cのブロック、および他のプログラミング言語のラムダに似ています。

 クロージャは、「定義したコンテキスト」から「任意の定数および変数」への参照をキャプチャおよび保存できます。
 これは、定数と変数のClosing-overとして知られています。
 Swiftは、キャプチャ内容のメモリ管理を全て処理します。
*/
/*:
 __`NOTE`__\
 キャプチャの概念については、[Capturing Values](https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID103)を参照してください。
*/
/*:
 関数で紹介したグローバル関数とネスト関数は、実際にはクロージャーの特別なケースです。
 クロージャーは、次の3つの形式のいずれかを取ります。

 - グローバル関数は名前を持ち、値をキャプチャしないクロージャー
 - ネスト関数は、名前を持ち、それを囲む関数から値をキャプチャできるクロージャー
 - 周囲のコンテキストから値をキャプチャできる軽量の構文で記述された無名クロージャー

 Swiftのクロージャーは一般的な用途において、簡潔で整理された構文を推奨することで最適化され、クリーンで明確なスタイルになります。
 これらの最適化には以下が含まれます。

 - コンテキストからパラメータと戻り値の型を推論する
 - 単行クロージャーからは暗黙的に値を返す
 - 引数名の省略記法
 - 末尾のクロージャー Trailing-cloture 構文
 */
/*:
 ## Closure Expressions
 __`クロージャーの記述式`__\
 より大きな関数の一部として自己完結型のコードブロックを命名および定義する便利な手段として、ネスト関数がありました。
 しかしながら、完全な宣言と名前がない構造の、関数を短くしたようなものを作成したい場合があります。
 特に、「引数として関数をいくつか受け取る」関数またはメソッドを使用する場合のことです。

 クロージャーは、簡潔で焦点を絞った構文でインラインクロージャを記述します。
 明快さや意図を見失うことがないよう手短に記述するために、クロージャ構文を最適化できます。
 以下で、これらの最適化を説明するため sorted(by:)メソッドを例にします。
 各反復は同じ機能をより簡潔に表現します。
*/
/*:
 ### The Sorted Method
 Swift標準ライブラリには、`sorted(by:)`メソッドがあります。
 このメソッドは、指定した順に並べ替えるクロージャー出力に基づいて、配列をソートします。
 ソートプロセスが完了すると、`sorted(by:)`メソッドは「型およびサイズが元の配列と同じ」新しい配列を返します。
 新しい配列の要素は正しく並び替えられた順になります。
 元の配列が`sorted(by:)`メソッドによって変更されることはありません。

 以下のクロージャー式の例では、`sorted(by:)`メソッドを使用して、文字列値の配列をアルファベット逆順に並べ替えます。
 並べ替えられる最初の配列は次のとおりです。
 
 ````
 let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
 ````
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

/*:
 `sort(by:)`メソッドは...
 - 配列のコンテンツと同じ型の2つの引数があるクロージャーを受け取る
 - 値が並べ替えられると、最初の値が次の値の「前に現れるか、後に現れるか」を示す`Bool`値を返す

 並べ替えクロージャーの要件は以下の通りです。
 最初の値が、次の値の...
 - 前に表示される場合 → `true`を返す
 - 後に表示される場合 → `false`を返す

 この例では、文字列値の配列を並べ替えています。
 そのため、並べ替えクロージャは`(String, String）-> Bool`型になります。

 並べ替えクロージャを提供するには、「適切な型の関数を記述し、それを引数として`sort(by:)`メソッドに渡す方法があります。
 
 ````
 func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
 }
 
 var reversedNames = names.sorted(by: backward)
 // reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
 ````
 */
func backward(_ s1: String, _ s2: String) -> Bool {
   return s1 > s2
}
var reversedNames = names.sorted(by: backward)

/*:
 最初の文字列`s1`が2番目の文字列`s2`よりも大きい場合、`backward(_:_ :)`関数は`true`を返し、ソートされた配列で`s1`が`s2`の前に現れます。
 文字の場合、「より大きい」は「アルファベットの後半である」ことを意味します。
 これにより、「Barry」が「Alex」の前に配置されるなど、アルファベットの逆順に並べ替えられます。

 ただし、これは単行関数（`a> b`）を記述する方法としては冗長です。
 クロージャー式構文を使用して、並べ替えクロージャーをインラインで記述するほうが望ましいでしょう。
 */
/*:
 ### Closure Expression Syntax
 一般的なクロージャー式の構文は、次のとおりです。

 ````
 { (parameters) -> return type in
    statements
 }
 ````

 クロージャー式の構文のパラメーターは`in-out`パラメーターにすることができます。
 ただし、デフォルト値を持つことはできません。
 可変長パラメーターに名前を付けると、可変長パラメーターを使用できます。
 パラメーター型および戻り値型として、タプルも使用できます。

 以下の例は、上からのbackward（_：_ :)関数のクロージャー式バージョンを示しています。
 
 ````
 reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
 })
 ````
 */
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})


/*:
 このインラインクロージャのパラメータと戻り値の宣言は、`backward(_:_ :)`関数と同一であることに注意してください。
 どちらの場合も、`(s1: String, s2: String) -> Bool`と記述されています。 ただし、インラインクロージャ式の場合、パラメータと戻り値の型は`{}`の外ではなく、`{}`内に記述されます。
 クロージャーのボディは、`in`キーワードによって開始されます。 `in`キーワードは、クロージャーのパラメータと戻り値の型の定義が終了し、ボディの定義がすぐに始まることを示します。
 
 クロージャーの本体が非常に短い場合、1行で記述することもできます。
 
 ````
 reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
 ````
 
 `sorted(by:)`メソッドの全体的な呼び出しは同じままです。
 `{}`は、まだメソッドの引数全体をラップしていますが、引数がインラインクロージャーになりました。
 */
/*:
 ### Inferring Type From Context
 並べ替えクロージャーの関数は、引数としてメソッドに渡されています。そのため、Swiftはパラメータと返り値の型を推測できます。
 また、`sort(by:)`メソッドは文字列の配列から呼び出されます。
 よって、引数は`(String, String) -> Bool`型の関数でなければなりません。
 これは、`(String, String)`および`Bool`型をクロージャー式の定義の一部として記述する必要がないことを意味します。
 すべての型を推測できるので、戻り矢印`->`およびパラメータ名を囲む括弧`()`も省略できます。

 ````
 reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
 ````
 
 関数またはメソッドにクロージャーをインラインクロージャー式として渡すとき、いつでもパラメータと戻り値の型を推測できます。
 その結果、関数またはメソッドの引数としてクロージャーが使用される場合、インラインクロージャーを完全な形式で記述する必要はありません。
 
 コードの読者が曖昧にならないようにする場合、必要に応じて型を明示することもできます。
 `sort(by:)`メソッドの場合、「ソートが行われている」という事実からクロージャの目的は明らかです。
 文字列の並び替えを支援していることから、読者が「クロージャが文字列値で機能している可能性が高い」と想定しても安全です。
 */
/*:
 ### Implicit Returns from Single-Expression Closures
 単行クロージャーは宣言から`return`キーワードを省略すると、暗黙的に単行コードの結果を返します。

 ````
 // omitting the return keyword
 reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
 ````
 
 ここでは、`sorted(by:)`メソッドの引数になっている関数の型により、クロージャーが`Bool`値を返す必要があることが明確です。 クロージャーのボディに含まれている単一の式`s1>s2`が`Bool`値を返すため、明確なので`return`キーワードを省略できます。
 */
/*:
 ### Shorthand Argument Names
 Swiftは、インラインクロージャーに`省略形の引数名`を自動的に提供しています。
 この引数名を使用すると、`$0, $1, $2`などの名前でクロージャーの引数値を参照できます。

 クロージャー式内で短縮引数名を使用する場合、引数リストを省略してクロージャーを定義できます。
 短縮引数名の数と型は、期待される関数型から推測されます。
 クロージャー式が完全にボディだけで構成されている場合は、`in`キーワードも省略できます。

 ````
 reversedNames = names.sorted(by: { $0 > $1 } )
 ````
 
 `$0`と`$1`はそれぞれ、クロージャーの最初と2番目の`String`型の引数を参照します。
 */
/*:
 ### Operator Methods
 上記のクロージャー式をより短く記述することもできます。
 Swiftの`String`型は、大なり演算子`>`の文字列固有実装を、「2つの`String`型パラメータを持ち、`Bool`型の値を返す」メソッドとして定義しています。
 これは、`sorted(by:)`メソッドに必要なメソッドの型と完全に一致します。
 したがって、大なり演算子`>`を渡すだけで、Swiftは「文字列固有の実装を使用する」とを推測します。
 
 ````
 reversedNames = names.sorted(by: >)
 ````

 詳細については、[演算子メソッド](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID42)を参照してください。
 */
/*:
 ## Trailing Closures
 __`後付けクロージャー`__
 記述が長いクロージャー式を、最後の引数として関数に渡す場合があります。
 クロージャー式が長い場合は、後付けクロージャーとして記述できます。
 後付けクロージャーは、関数の引数であるにもかかわらず、関数呼び出しの括弧`{}`の後に記述されます。 後付けクロージャー構文を使用する場合、クロージャーの引数ラベルを記述しません。

 ````
 // クロージャーを受け取る関数
 func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
 }


 // 後付けクロージャー無しで関数を使用すると...
 someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
 })

 // 後付けクロージャーで関数を使用すると...
 someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
 }
 ````
 
 これまで使用してきた並べ替えクロージャーは、`sorted(by:)`メソッドに後付けクロージャーとして記述できます。
 
 ````
 // 後付けクロージャーで記述したsorted(by:)メソッド
 reversedNames = names.sorted() { $0 > $1 }
 ````
 
 関数またはメソッドに「唯一の引数」として後付けクロージャーだけ提供する場合、呼び出す関数名の直後にある括弧`()`を省略できます。

 ````
 // カッコを省略した後付けクロージャー
 reversedNames = names.sorted { $0 > $1 }
 ````
 
 後付けクロージャーは、クロージャーが単一行にインラインで記述できないほど長い場合に最も役立ちます。
 例として、Swiftの`Array`型には、単一の引数としてクロージャー式を受け取る`map(_:)`メソッドがあります。
 クロージャは、配列内の各アイテムごとに1回だけ呼び出され、そのアイテムの代替マッピング値（他のタイプの場合もある）を返します。
 マッピングの性質と戻り値の型は、指定するクロージャーに任されます。

 `map(_:)`メソッドは、提供されたクロージャーを配列の各アイテムに適用した後、新しい配列を返します。
 `map(_:)`メソッドが返す新しい配列には、すべてのマッピング値が「対応する元の配列アイテム」と同じ順序で並びます。
 
 `map(_:)`メソッドを後付けクロージャで呼び出し、`Int`値の配列を`String`値の配列に変換する方法を次に示します。
 `[16, 58, 510]` は、新たに`["OneSix", "FiveEight", "FiveOneZero"]`を作るために使用されます。

 ````
 let digitNames = [
     0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
     5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
 ]
 let numbers = [16, 58, 510]
 ````
*/
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

/*:
 `digitNames`は、整数を数字と英語の間でマッピングした辞書です。
 また、文字列に変換する準備として、整数の配列`numbers`も定義しておきます。

 クロージャー式を後付けクロージャーとして配列の`map(_:)`メソッドに渡すことで、数値配列から文字列配列を作成できます。
 
 ````
 let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
 }
 // stringsは[String]型になると推論される
 // stringsのアイテムは...["OneSix", "FiveEight", "FiveOneZero"]
 ````
*/
let strings = numbers.map { (number) -> String in
   var number = number
   var output = ""
   repeat {
       output = digitNames[number % 10]! + output
       number /= 10
   } while number > 0
   return output
}

/*:
 `map(_:)`メソッドは配列内の各アイテムに対して、クロージャー式を1回呼び出します。
 型はマッピングされる配列から推測できるため、クロージャーの入力パラメータ`number`の型`Int`を明示する必要はありません。
  
 通常、関数とクロージャーのパラメータは定数ですが、この例では変数`number`をクロージャーのパラメータ`number`で初期化しています。そのため、`number`の値をクロージャーボディ内で変更できます。
 クロージャー式には戻り値の型`String`も指定し、マッピングして出力された配列の型を示します。

 クロージャー式は呼び出されるたびに、文字列`output`を作成します。
 剰余演算子`％`を使用して`number`の最後の桁を計算し、この計算値を使用して`digitNames`辞書から文字列を検索します。
 クロージャーを使用して、ゼロ以上の任意の整数を文字列で表現した配列を作成できました。
 
 __`NOTE`__\
 `digitNames`辞書の添え字の直後に、感嘆符`！`があります。
 これは辞書の添え字がオプショナル値を返し、キーが存在しない場合に辞書検索が失敗する可能性があることを示すためです。 上記の例で`number％10`は添え字として、`digitNames`辞書の有効なキーであることが常に保証されています。
 そのため、感嘆符`!`を使用して、オプショナルの戻り値に格納された文字列値を強制的にアンラップします。
 */
/*:
 まず、`digitNames`辞書から取得した文字列は、出力の先頭に追加され、文字列になった数字を逆に構築します。
 （`number％10`は、`16`の場合は`"6"`、`58`の場合は`"8"`、`510`の場合は`"0"`の値になります。）

 次に、`number`変数は`10`で除算されます。
 整数であるため、除算中に切り捨てられ、`16`は`1`になり、`58`は`5`、`510`なら`51`になります。

 このプロセスは、`number`が`0`になるまで繰り返されます。
 `0`になるとクロージャーは出力文字列を返し、`map(_:)`メソッド全体によって出力配列に追加されます。

 上記の例では後付けクロージャー構文によって、`map(_:)`メソッドの直後にクロージャーの機能がきちんとカプセル化されます。
 したがって、クロージャー全体を`map(_:)`メソッドの括弧`()`で囲む必要がなくなっています。
 
 ````
 // 後付けクロージャーではない記述
 let strings = numbers.map( {(number) -> String in
    var number = number
    ...
    return output
 } )

 // 後付けクロージャーによる記述
 let strings = numbers.map() {(number) -> String in
    var number = number
    ...
    return output
 }
 
 // 引数が後付けクロージャーのみなので、()を省略可能
 let strings = numbers.map {(number) -> String in
    var number = number
    ...
    return output
 }

 ````
 */
/*:
 ## Capturing Values
 __`値のキャプチャ`__\
 クロージャは、それが定義されている周囲のコンテキストから定数・変数をキャプチャできます。
 クロージャーは、定数・変数を定義した元のスコープがもはや存在しない場合でも、ボディ内からこれらの定数・変数を参照および変更できます。

 Swiftでは、値をキャプチャできるクロージャーの最も単純な形式は、別の関数のボディ内に記述されたネスト関数です。
 ネスト関数は、その外部関数の引数をキャプチャでき、外部関数内で定義された定数・変数もキャプチャできます。

 以下に、例として関数`makeIncrementer(forIncrement:)`を示します。
 この関数には、ネスト関数`incrementer()`が含まれています。 ネストされた`incrementer()`関数は、周囲のコンテキストから`runningTotal`と`amount`の2つの値をキャプチャします。 これらの値をキャプチャした後、`makeIncrementer(forIncrement)`は、呼び出されるたびに`runningTotal`を増分するクロージャーとして`incrementer`を返します。

 ````
 func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
 }
 ````
 
 `makeIncrementer(forIncrementer)`の戻り値の型は`() -> Int`です。
 これは、値ではなく関数を返すことを意味します。
 返される関数にパラメータはなく、呼び出されると`Int`値を返します。
 関数が他の関数を返す方法については、[戻り値型としての関数型](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID177)を参照してください。

 `makeIncrementer(forIncrement:)`関数は、`Int`型の変数`runningTotal`を定義し、返される`incrementer()`の現在の合計を保存します。
 この変数`runningTotal`の初期値は`0`です。

 `makeIncrementer(forIncrement:)`関数の`Int`型パラメータには、引数ラベル`forIncrement`とパラメータ名`amount`があります。
 このパラメータに渡される値は、返された`incrementer()`関数が呼び出されるたびにどのくらいの`runningTotal`をインクリメントするかを指定します。 `makeIncrementer(forIncrement:)`関数は、インクリメントを実際に行うネスト関数`incrementer()`を定義します。
 関数`incrementer()`は、単に`runningTotal`に金額`amount`を加算し、結果を返します。
 
 ネスト関数`incrementer()`を単独にしてみると、異様に見えるかもしれません。

 ````
 func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
 }
 ````
 
`incrementer()`関数にパラメータはありません。
 しかし、関数ボディで`runningTotal`と`amount`を参照しています。 周囲の関数から`runningTotal`と`amount`への参照をキャプチャすることによって、自身の関数ボディ内で使用できるようにしています。 参照のキャプチャにより、呼び出した`makeIncrementer(forIncrement:)`関数が終了しても、`runningTotal`と`amount`は消えません。
 そのおかげで、`incrementer()`関数が再び呼び出されたとき、`runningTotal`が使用できます。\

 __`NOTE`__\
 以下に該当する場合、Swiftは最適化として、値のコピーをキャプチャして保存します。
 - 値がクロージャによって変更されていない場合
 - クロージャが作成された後に値が変更されていない場合
 
 また、Swiftは、`不要になった変数`の破棄に関連するすべてのメモリ管理を処理します。
 */
/*:
 `makeIncrementer(forIncrement:)`の動作例を次に示します。

 ````
 let incrementByTen = makeIncrementer(forIncrement: 10)
 ````

 呼び出されると変数`runningTotal`に`10`を加算する関数`incrementer()`を定数`incrementByTen`に設定します。
 `incrementByTen()`から関数を複数回呼び出すと、この動作が実行されていることがわかります。
 
 ````
 incrementByTen()   // 10
 
 incrementByTen()   // 20
 
 incrementByTen()   // 30
 ````
 
 2つめの`incrementer`を作成すると、別の新しい`runningTotal`変数への参照が独自に保存されます。
 
 ````
 let incrementBySeven = makeIncrementer(forIncrement: 7)
 incrementBySeven()     // 7
 ````

 最初のインクリメンタ`incrementByTen`を再度呼び出すと、独自に`runningTotal`変数が加算され続けます。
 `incrementBySeven`によってキャプチャされた変数には影響しません。
 
 ````
 incrementByTen()       // 40
 ````
 
 __`NOTE`__\
 クラスインスタンスのプロパティにクロージャーを割り当てて、クロージャーがそのインスタンスをキャプチャする場合、クロージャーとインスタンスの間に`強い参照`サイクルを作成されます。
 Swiftはキャプチャリストを使用して、これらの`強い参照`サイクルを中断します。 詳細については、[クロージャのストロングリファレンスサイクル](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html#ID56)を参照してください。
 */
/*:
 ## Closures Are Reference Types

 In the example above, incrementBySeven and incrementByTen are constants, but the closures these constants refer to are still able to increment the runningTotal variables that they have captured. This is because functions and closures are reference types.

 Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.

 This also means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.

 ````
 let alsoIncrementByTen = incrementByTen
 alsoIncrementByTen()
 // returns a value of 50

 incrementByTen()
 // returns a value of 60
 ````
 */

//: [Next](@next)
