//: [Previous](@previous)
/*:
 # Initialation
 __`初期化`__\
 https://docs.swift.org/swift-book/LanguageGuide/Initialization.html
*/
/*:
 初期化は、使用するクラス、構造体、または列挙型のインスタンスを準備するプロセスです。
 このプロセスでは、そのインスタンスにある各Storedプロパティに初期値を設定し、新しいインスタンスを使用する準備が整う前に必要なその他の設定または初期化を実行します。

 この初期化プロセスは、初期化子を定義することによって実装します。
 これは、ある型の「新しいインスタンスを作成する」ために呼び出す特別なメソッドのようなものです。
 Objective-Cのイニシャライザとは異なり、Swiftのイニシャライザは値を返しません。
 イニシャライザの主な役割は「ある型の新しいインスタンス」が初めて使用される前に、それを正しく初期化することです。

 クラス型インスタンスは、デイニシャライザを実装することもできます。
 デイニシャライザは、そのクラスのインスタンスが「割り当て解除される直前」にカスタムクリーンアップします。
 デイニシャライザの詳細については、「デイニシャライズ」を参照してください。
 */
/*:
 ## Setting Initial Values for Stored Properties
 ストアドプロパティに初期値を設定する

 クラスと構造体は、そのインスタンスが作成される前に、すべてのストアドプロパティに適切な初期値を設定する必要があります。
 ストアドプロパティは不確定な状態のままにはできません。
 以下のどちらかの方法で、初期値を設定します。
 
 - イニシャライザでストアドプロパティの初期値を設定する
 - プロパティの定義の一部としてデフォルトのプロパティ値を割り当てる

 以下のセクションでこれらのアクションについて説明します。
 
 ### NOTE
 初期値をストアドプロパティに割り当てるか、初期化子内でその初期値を設定した場合、プロパティオブザーバは機能しません。
 */
/*:
 ### Initializers
 初期化子は「ある型の新しいインスタンス」を作成するために呼び出されます。
 基本の初期化子は、initキーワードを使用して書かれた「パラメータのないインスタンスメソッド」と言えます。
 
 ````
 init() {
    // perform some initialization here
 }
 ````

 以下の例は、華氏スケールで表現された温度を保存するためのFahrenheitという新しい構造体を定義します。
 Fahrenheit構造体には、Double 型のストアドプロパティtemperatureが1つあります。
 
 ````
 struct Fahrenheit {
    var temperature: Double

    init() {
        temperature = 32.0
    }
 }
 
 var f = Fahrenheit()
 print("The default temperature is \(f.temperature)° Fahrenheit")
 // Prints "The default temperature is 32.0° Fahrenheit"
 ````

 この構造体では、パラメータがない単一の初期化子initを定義しています。
 これは、保存された温度を32.0（華氏度で表した水の凝固点）の値で初期化します。
 */
/*:
 ### Default Property Values
 デフォルトのプロパティ値
 上記のように、イニシャライザ内でストアドプロパティの初期値を設定できます。
 あるいは、プロパティの宣言の一部としてプロパティの初期値を指定します。
 プロパティの定義時に初期値をプロパティに割り当てることで、プロパティの初期値を指定します。

 ### NOTE
 プロパティが常に同じ初期値をとる場合は、イニシャライザ内で値を設定するのではなく、デフォルト値を指定してください。
 最終結果は同じですが、デフォルト値はプロパティの初期化をその宣言により密接に結び付けます。
 初期化子がよりシンプルになるので、そのデフォルト値からプロパティの型を推測できるようになります。
 この章で後述するように、デフォルト値を使用すると「デフォルトの初期化子」と「初期化子の継承」が利用しやすくなります。
 
 プロパティが宣言された時点で、そのtemperatureプロパティに初期値を指定しておくと、構造体Fahrenheitを上記よりシンプルに記述できます。
 
 ````
 struct Fahrenheit {
    var temperature = 32.0
 }
 ````
 */
/*:
 # Customizing Initialization
 初期化のカスタマイズ
 次の方法で、初期化プロセスをカスタマイズできます。
 - 入力パラメータとオプショナル型のプロパティを使用する
 - 初期化中に定数プロパティを割り当てる
 */
/*:
 ## Initialization Parameters
 初期化パラメータ
 初期化プロセスをカスタマイズする値の型と名前を記述することで、初期化パラメータを初期化子の一部として定義できます。
 初期化パラメータの機能と構文は、「関数およびメソッドパラメータ」と同じです。

 次の例では、摂氏で表される温度を格納する構造体Celsiusを定義します。
 Celsius構造体は、以下の2つのカスタム初期化子を実装しています。
 - init(fromFahrenheit:)
 - init(fromKelvin:)
 
 これらは、異なる温度スケールの値で構造体の新しいインスタンスを初期化します。
 
 ````
 struct Celsius {
 
    var temperatureInCelsius: Double
 
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
 
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
 }
 
 let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
 // boilingPointOfWater.temperatureInCelsius is 100.0

 let freezingPointOfWater = Celsius(fromKelvin: 273.15)
 // freezingPointOfWater.temperatureInCelsius is 0.0
 ````
 
 最初の初期化子には、引数ラベルfromFahrenheitおよびパラメータ名fahrenheitという初期化パラメータがあります。
 2番目の初期化子は、引数ラベルfromKelvinとパラメータ名kelvinという初期化パラメータがあります。
 いずれの初期化子も、それらの引数を摂氏値に変換し、この値をtemperatureInCelsiusというプロパティに格納します。
 */
/*:
 ## Parameter Names and Argument Labels
 パラメータ名と引数のラベル
 初期化パラメータは「関数およびメソッドパラメータ」と同様に、初期化子のボディ内で使用するパラメータ名と、初期化子を呼び出すときに使用する引数ラベルの両方を持つことができます。

 しかし、初期化子は「関数やメソッド」のような関数名はありません。
 したがって、初期化パラメータの名前と種類は「どのイニシャライザを呼び出すか」を識別する役割を果たします。
 このため、Swiftは初期化子内のすべてのパラメータに対して、自動引数ラベルを提供しません（提供していない場合）。

 次の例では、を定義します。
 構造体Colorには、red、green、blueという3つの定数プロパティがあります。
 これらのプロパティは、色の赤、緑、青の量を示すために0.0~1.0の値を格納します。

 構造体Colorは、赤、緑、青の各成分に対して、3つのDouble型パラメータを持つイニシャライザがあります。
 また、2つ目として、すべての色成分に対して同じ値を設定するパラメータwhiteを持つ初期化子もあります。
 
 ````
 struct Color {
    let red, green, blue: Double
 
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
 
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
 }
 ````
 
 両イニシャライザは、各イニシャライザパラメータに名前付きの値を指定することで、新しいColorインスタンスを作成できます。
 
 ````
 let magenta  = Color(red: 1.0, green: 0.0, blue: 1.0)
 let halfGray = Color(white: 0.5)
 ````
 
 引数ラベルを使用せずに、初期化子を呼び出すことはできません。
 定義されている引数ラベルを省略するとコンパイルエラーになります。
 
 ````
 let veryGreen = Color(0.0, 1.0, 0.0)
 // this reports a compile-time error - argument labels are required
 ````
 */
/*:
 ### Initializer Parameters Without Argument Labels
 引数ラベルなしの初期化パラメータ
 初期化パラメータに引数ラベルを使用したくない場合は、その引数ラベルの代わりにアンダースコア（_）を使用します。

 以下は、上例の初期化パラメータからのCelsius構造体の拡張版です。
 すでに摂氏スケールであるDouble値から「新しいCelsiusインスタンス」を作成する初期化子を追加しています。
 
 ````
 struct Celsius {
    var temperatureInCelsius: Double

    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
 }
 
 let bodyTemperature = Celsius(37.0)
 // bodyTemperature.temperatureInCelsius is 37.0
 ````
 
 初期化子を呼び出すコードCelsius(37.0)は、引数ラベルが無くてもその意図を明確にしています。
 このように、ラベルなしでDouble値を指定して呼び出せるようにするには、init(_ celsius：Double)と適切に記述します。
 */
/*:
 ### Optional Property Types
 オプショナル型のプロパティ
 独自に宣言した型に論理的（初期化中に値を設定できない、または後で「値なし」になる可能性があるため）に「値なし」状態が許可されているストアドプロパティがある場合、オプショナル型で宣言します。
 オプショナル型のプロパティは、nil値で自動的に初期化されます。
 これは、初期化中にそのプロパティが「まだ値がない」ことを意図的に示唆します。

 次の例では、responseというオプショナルのString型プロパティを使用して、SurveyQuestionクラスを定義します。
 
 ````
 class SurveyQuestion {
    var text: String
    var response: String?

    init(text: String) {
        self.text = text
    }

    func ask() {
        print(text)
    }
 }
 
 let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
 cheeseQuestion.ask()
 // Prints "Do you like cheese?"
 
 cheeseQuestion.response = "Yes, I do like cheese."
 ````
 
 アンケートの質問に対する回答は、質問があるまで知ることができません。
 そのため、responseプロパティはString?、またはOptional<String>型で宣言されます。
 SurveyQuestionの新しいインスタンスが初期化されると、自動的に初期値にnil（文字列なし）が割り当てられます。
 */
/*:
 ### Assigning Constant Properties During Initialization
 初期化中に定数プロパティの値を割り当てる
 初期化が完了するまでに確定した値を設定したい場合、初期化中のどの時点でも定数プロパティに値を割り当てることができます。
 定数プロパティに値が割り当てられると、それ以上修正することはできません。

 ### NOTE
 クラスインスタンスの場合、定数プロパティはそれを導入したクラスによってのみ初期化中に値を変更できます。
 継承後のサブクラスでは変更できません。

 \
 上記のSurveyQuestionに定義されている質問のtextプロパティを変数ではなく定数にすることで「SurveyQuestionのインスタンスが作成された後で質問が変更されない」ことを示すことができます。
 textプロパティが定数になっていても、クラスの初期化子内で設定できます。
 
 ````
 class SurveyQuestion {
    let text: String
    var response: String?

    init(text: String) {
        self.text = text
    }
 
    func ask() {
        print(text)
    }
 }
 let beetsQuestion = SurveyQuestion(text: "How about beets?")
 beetsQuestion.ask()
 // Prints "How about beets?"
 beetsQuestion.response = "I also like beets. (But not with cheese.)"

 ````
 */
/*:
 ## Default Initializers
 デフォルト初期化子
 Swiftは、すべてのプロパティに既定値が提供されている「1つも初期化子がない構造体またはクラス」に対して、デフォルト初期化子を提供します。
 デフォルトイニシャライザは、単純にすべてのプロパティに既定値を設定して新しいインスタンスを作成します。

 この例では、ShoppingListItemクラスを定義します。
 このクラスは、買い物リスト内の商品の名前、数量、購入状況をカプセル化します。
 
 ````
 class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
 }
 
 var item = ShoppingListItem()
 ````
 
 ShoppingListItemクラスのすべてのプロパティは既定値があり、スーパークラスを持たない基本クラスです。
 ゆえに、ShoppingListItemは、その「すべてのプロパティをデフォルト値に設定した新しいインスタンス」を作成するデフォルト初期化子が自動的に実装されます。
 nameプロパティはオプショナルString型であるため、コードを記述していなくても自動的にデフォルト値のnilを受け取ります。
 上記の例では、ShoppingListItemクラスのデフォルトイニシャライザを使用しています。
 イニシャライザ構文ShoppingListItem()で新しいインスタンスを作成し、変数itemに割り当てています。
 */
/*:
 ### Memberwise Initializers for Structure Types
 構造体のメンバワイズ初期化子
 独自のカスタム初期化子を定義していない場合、構造体型は自動的にメンバワイズ初期化子を受け取ります。
 デフォルト値がないプロパティがあってもメンバワイズ初期化子を受け取る点は、デフォルト初期化子とは異なります。

 メンバワイズイニシャライザは、新しい構造体インスタンスのメンバプロパティを初期化するシンプルな方法です。
 「新しいインスタンスのプロパティ」の初期値は、名前でメンバワイズイニシャライザに渡すことができます。

 以下の例は、2つのプロパティwidthとheightを持つ構造体Sizeを定義します。
 どちらのプロパティも、デフォルト値0.0を割り当てることによってDouble型であると推論されます。

 Size構造体は、init(width: height: )メンバワイズイニシャライザを自動的に受け取ります。
 これを使用して、新しいSizeインスタンスを初期化できます。
 
 ````
 struct Size {
    var width = 0.0, height = 0.0
 }
 
 let twoByTwo = Size(width: 2.0, height: 2.0)
 ````
 
 メンバワイズ初期化子を呼び出すとき、既定値があるプロパティの値を省略できます。
 上記の例ではSize構造体のheightとwidth、両方のプロパティに既定値があります。
 どちらか一方または両方のプロパティを省略できます。
 初期化子は、省略されたプロパティに既定値を使用します。
 次に例を示します。
 
 ````
 let zeroByTwo = Size(height: 2.0)
 print(zeroByTwo.width, zeroByTwo.height)
 // Prints "0.0 2.0"

 let zeroByZero = Size()
 print(zeroByZero.width, zeroByZero.height)
 // Prints "0.0 0.0"
 ````
 */
/*:
 ## Initializer Delegation for Value Types
 値型に対するイニシャライザのデリゲート
 イニシャライザは、インスタンス初期化の一部を「他のイニシャライザを呼び出して」実行できます。
 このプロセスはとして知られています。
 イニシャライザのデリゲートすることで、「複数のイニシャライザにまたがってコードが重複する」ことを避けます。

 イニシャライザのデリゲートが「どのように機能するか、どのような形式が許可されるか」は、値型とクラス型で異なります。
 値型（構造体と列挙型）は継承をサポートしていません。
 ゆえに、その型が提供する「別の初期化子」にしかデリゲートできないため、デリゲートプロセスは比較的単純です。
 クラスは他のクラスから継承できます。
 つまり、クラスには「継承したすべてのストアドプロパティに初期化中に適切な値が割り当てる」責任が発生します。
 この責任は「クラス継承と初期化」で説明されています。

 値型の場合は、独自のカスタム初期化子を作成するときに、self.initを使用して同じ値型の他の初期化子を参照します。
 self.initはイニシャライザの中からしか呼び出せません。

 値型にカスタム初期化子を定義すると、その型のデフォルト初期化子（構造体はメンバワイズ初期化子）にアクセスできなくなります。
 この制約により、より複雑なイニシャライザで提供されている追加の必須設定が、自動イニシャライザを使用している人によって誤って回避されるという事態が防止されます。
 
 ### NOTE
 デフォルト初期化子とメンバワイズ初期化子に加え、さらに独自のカスタム初期化子で初期化できるようにするには、カスタム初期化子を「値型の元の実装の一部」としてではなくエクステンションに記述します。
 詳しくは、エクステンションを参照してください。
 
 \
 次の例では、幾何学的な四角形を表現する構造体Rectを定義しています。
 この例では、SizeとPointという2つのサポート構造体が必要です。
 どちらも、すべてのプロパティに対して規定値0.0を提供します。
 
 ````
 struct Size {
    var width = 0.0, height = 0.0
 }
 
 struct Point {
    var x = 0.0, y = 0.0
 }
 ````
 
 次の方法のいずれかで、Rect構造体を初期化できます。
 - 規定値のゼロで初期化されたoriginおよびsizeプロパティ値を使用する
 - 特定のoriginおよびsizeを指定する
 - 特定のcenterおよびsizeを指定する
 
 これらの初期化オプションは、Rect構造体の定義の一部である3つのカスタム初期化子として実装されています。
 
 ````
 struct Rect {
    var origin = Point()
    var size = Size()

    init() {}
 
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
 }
 ````
 
 最初の初期化子init()は、カスタム初期化子がなければ、受け取るはずだったデフォルト初期化子と機能的には同じです。
 この初期化子には、空のボディ{}があります。
 このイニシャライザを呼び出すと...
 originのプロパティが既定値であるPoint(x: 0.0, y: 0.0)と
 sizeのプロパティが既定値であるSize(width: 0.0, height: 0.0)で
 初期化されたRectインスタンスが返されます。
 
 ````
 let basicRect = Rect()
 // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
 ````
 
 2番目の初期化子init(origin:size:)は、カスタム初期化子がなければ、受け取ったであろうメンバワイズ初期化子と機能的に同じです。
 この初期化子は、単にoriginとsize引数の値を適切なストアドプロパティに代入します。
 
 ````
 let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                       size:   Size(width: 5.0, height: 5.0))
 // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
 ````
 
 3番目のイニシャライザinit(center:size:)は、もう少し複雑です。
 まず、centerとsize値に基づいて、適切なoriginの計算から始めます。
 次に、init(origin:size:)イニシャライザを呼び出し（デリゲート）、新しいoriginとsizeをプロパティに格納します。
 
 ````
 let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                       size:   Size(width: 3.0, height: 3.0))
 // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
 ````
 
 init(center:size:)イニシャライザは、適切なプロパティに新しいoriginとsizeの値を割り当てる可能性があります。
 いずれにせよ、init(center:size:)イニシャライザでは、「同じ機能を持つ既存のイニシャライザ」を活用した方が便利かつ意図が明確です。
 
 ### NOTE
 init()とinit(origin:size:)初期化子を自分で定義せずに、この例と同じプログラムを書く方法があります。
 詳しくはエクステンションを見てください。
 */
/*:
 */
//: [Next](@next)
