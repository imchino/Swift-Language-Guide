//: [Previous](@previous)
/*:
 # Functions
 __`関数`__\
 関数は「特定のタスク」を実行する自己完結型のコード群です。
 関数には、その機能を識別する名前を付けます。
 必要に応じて、この名前を使って関数を「呼び出す」ことでタスクを実行できます。
  
 Swiftの関数構文は統合されています。
 パラメータの名前がない単純なCスタイルから、名前とラベルを持つ複雑なObjective-Cスタイルまで、あらゆるものを柔軟に表現できます。
 パラメータはデフォルト値を提供して、関数呼び出しを簡素化できます。
 また、関数が実行を完了すると、渡された値自体を変更する`in-out`パラメータとして渡すこともできます。
 
 Swiftのすべての関数には、パラメータと戻り値で構成される型があります。
 この関数の型は、Swiftの他の型と同じように使用できます。
 これにより、関数をパラメータとして他の関数に渡したり、関数から関数を返したりすることが容易になります。
 関数を他の関数内に記述すると、ネストした関数スコープ内に有用な機能をカプセル化できます。
 */
/*:
 ## Defining and Calling Functions
 __`関数の定義と呼び出し`__\
 関数を定義する場合、オプションとして、関数がパラメータとして知られる入力として受け取る1つ以上の名前付きの型付き値を定義できます。
 オプションで、関数が完了時に出力として返す値のタイプ（戻りタイプ）を定義することもできます。
  
 すべての関数には、関数が実行するタスクを説明する関数名があります。
 関数を使用するには、その関数をその名前で「呼び出し」、関数のパラメーターのタイプに一致する入力値（引数）を渡します。
 関数の引数は、常に関数のパラメーターリストと同じ順序で指定する必要があります。
 
 次の例の関数は、`greet(person:)`と呼ばれます。
 これは、それが行うことです。
 入力として人の名前を受け取り、その人の挨拶を返します。
 これを行うには、1つの入力パラメーター（personというストリング値）と戻り値のストリングを定義します。
 このタイプには、そのユーザーへの挨拶が含まれます。
 
 When you define a function, you can optionally define one or more named, typed values that the function takes as input, known as parameters. You can also optionally define a type of value that the function will pass back as output when it is done, known as its return type.

 Every function has a function name, which describes the task that the function performs. To use a function, you “call” that function with its name and pass it input values (known as arguments) that match the types of the function’s parameters. A function’s arguments must always be provided in the same order as the function’s parameter list.

 The function in the example below is called greet(person:), because that’s what it does—it takes a person’s name as input and returns a greeting for that person. To accomplish this, you define one input parameter—a String value called person—and a return type of String, which will contain a greeting for that person:

 ````
 func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
 }
 ````
 */


//: [Next](@next)
