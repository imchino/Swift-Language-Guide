//: [Previous](@previous)
/*:
 # Structures and Classes
 __`構造体とクラス`__
 引用元: https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
 */
/*:
 構造体とクラスは、プログラムの一部であるコードによって構成される高機能な要素です。
 「定数、変数、および関数」と同じ構文を使用してプロパティとメソッドを定義すると、構造体およびクラスに機能を追加できます。

 Swiftは他のプログラミング言語とは異なり、カスタム構造体やクラス用に個別のインターフェースファイルと実装ファイルを作成しません。
 Swiftは「構造体またはクラス」をファイルに定義すると、他のコードから使用するための外部インタフェースが自動的に準備されます。
 
 ### NOTE
 クラスのインスタンスは「オブジェクト」として知られてきました。
 ただし、他の言語と比較すると、Swiftの「構造体とクラス」は互いに機能的にはるかに似ています。
 したがって、この章の大部分では「クラスまたは構造体」型のインスタンスに適用される機能について説明します。
 このため、より一般的な用語として「インスタンス」が使用されます。
 */
/*:
 ## Comparing Structures and Classes
 構造体とクラスの比較
 Swiftの構造体とクラスには、多くの共通点があります。
 どちらも可能なことは...

 - 値を格納するためのプロパティを定義する
 - 機能を提供するためのメソッドを定義する
 - 添字構文を使用して、値にアクセスするための添字を定義する
 - 初期化子を定義して、初期状態を設定する
 - デフォルト実装を超えて、機能を拡張する
 - プロトコルに準拠して、特定の種類の標準機能を提供する
 
 クラスには、構造体にはない以下の機能があります。

 - あるクラスは別のクラスの特性を `継承` できます。
 - `型キャスト` を使用すると、実行時にクラスインスタンスの型を確認および解釈できます。
 - `デイニシャライザ` を使用すると、クラスのインスタンスは割り当てたリソースを解放できます。
 - `参照カウント` は、クラスインスタンスへの複数の参照を許可します。
 
 クラスがサポートする追加機能には、「複雑さが増す」というデメリットがあります。
 一般的なガイドラインとしては、型推論しやすい構造体が推奨されます。
 適切な場合や必要な場合はクラスを使用します。
 つまり実際には、独自に定義したデータ型のほとんどが構造体か列挙型になることを意味します。
 より詳細な比較については、構造体とクラスの選択を参照してください。
 */
/*:
 ## Definition Syntax
 定義の構文
 構造体とクラスの定義構文は、ほとんど同じです。
 構造体をstructキーワードで、クラスをclassキーワードで紹介します。
 どちらも定義全体をコードブロック{}で囲みます。
 
 ````
 struct SomeStructure {
    // structure definition goes here
 }

 class SomeClass {
    // class definition goes here
 }
 ````
 
 ### NOTE
 新しい構造体やクラスを定義するときはいつでも、新しいSwift型を定義します。
 標準のSwift型（String、Int、Boolなど）の命名規則と一致させるために、UpperCamelCaseの名前を指定します。
 プロパティとメソッドにlowerCamelCase名（frameRateやincrementCountなど）を付けて、型名と区別します。
 
 構造体定義とクラス定義の例です。
 
 ````
 struct Resolution {
    var width = 0
    var height = 0
 }
 
 class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
 }
 ````
 
 上記の例は、ピクセルベースのディスプレイ解像度を表現するために、新しい構造体Resolutionを定義します。
 この構造体には、widthとheightという2つのStoredプロパティがあります。
 Storedプロパティは「構造体またはクラス」の一部として、まとめられた「定数または変数」です。
 これら2つのプロパティは、初期値を整数0に設定することでInt型であると推論されます。

 上記の例では、VideoModeという新しいクラスも定義して、ビデオ表示用の特定ビデオモードを表現しています。
 このクラスには4つの変数Storedプロパティがあります。
 1つ目のresolutionは、新しいResolution構造体インスタンスで初期化されています。これにより、プロパティの型がResolutionになります。
 他の3つのプロパティでは...
 新しいVideoModeインスタンスは、インターレース設定がfalse（「ノンインターレースビデオ」を意味する）、
 再生時のフレームレートとしてframeRateが0.0、
 およびnameというオプションのString値で初期化されます。
 nameプロパティはオプションの型であるため、自動的にデフォルト値のnil、つまり「no name value」が設定されます。
 */
/*:
 ## Structure and Class Instances
 構造とクラスのインスタンス
 Resolution構造体定義とVideoModeクラス定義は、ResolutionまたはVideoModeがどのように見えるかを記述するだけです。
 それら自身は具体的な解像度やビデオモードを説明していません。
 具体的なデータを扱うには、構造体またはクラスのインスタンスを作成する必要があります。

 構造体とクラスのインスタンスを作成するための構文はほぼ同じです。
 
 ````
 let someResolution = Resolution()
 let someVideoMode = VideoMode()
 ````
 
 「構造体またはクラス」の新しいインスタンスを作るには、どちらも初期化構文を使用します。
 基本的なイニシャライザ構文は、Resolution()やVideoMode()のように、「クラスまたは構造体」型名の直後に括弧()を記述します。
 これにより、すべてのプロパティがデフォルト値に初期化された、「クラスまたは構造体」の新しいインスタンスが作成されます。
 クラスと構造体の初期化については、初期化で詳しく説明しています。
 */
/*:
 ## Accessing Properties
 プロパティへのアクセス
 ドットシンタックスで、インスタンスのプロパティにアクセスできます。
 ドットシンタックスは「インスタンス名の直後にピリオド.」で区切って、プロパティ名を記述します。
 
 ````
 print("The width of someResolution is \(someResolution.width)")
 // Prints "The width of someResolution is 0"
 ````
 
 この例では、someResolution.widthはsomeResolutionのwidthプロパティを参照しています。
 実行すると、デフォルトの初期値0を返します。

 VideoModeのresolutionプロパティのwidthプロパティなど、サブプロパティにドリルダウンできます。
 
 ````
 print("The width of someVideoMode is \(someVideoMode.resolution.width)")
 // Prints "The width of someVideoMode is 0"
 ````

 ドットシンタックスから、変数プロパティに新しい値を割り当てることもできます。
 
 ````
 someVideoMode.resolution.width = 1280
 print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
 // Prints "The width of someVideoMode is now 1280"
 ````
 */
/*:
 ## Memberwise Initializers for Structure Types
 構造体型のメンバごとの初期化子
 すべての構造体には、自動的に生成されたmemberwise初期化子があります。
 これを使用して、新しい構造体インスタンスのメンバプロパティを初期化できます。
 新しいインスタンスのプロパティの初期値は、名前を指定してmemberwiseイニシャライザに渡すことができます。
 
 ````
 let vga = Resolution(width: 640, height: 480)
 ````

 構造体とは異なり、クラスのインスタンスはmemberwise初期化子が自動的に生成されません。
 初期化子については、初期化で詳しく説明しています。
 */
/*:
 ## Structures and Enumerations are Value Types
 構造体と列挙型は値型
 値型は「変数または定数」に割り当てられたり、関数に渡されたときに値がコピーされます。

 実際、これまでのほとんど章で値型を使用してきました。
 Swiftのすべての基本型（整数、浮動小数点数、ブール値、文字列、配列、辞書）は値型です。
 これらは構造体として実装されています。

 Swiftでは、すべての構造体と列挙型が値型です。
 つまり、構造体や列挙型のインスタンス、およびその値型プロパティは、コード内で渡されるときに常にコピーされます。
 ### NOTE
 配列、辞書、文字列などの標準ライブラリで定義されたコレクションは、コピーパフォーマンスを最適化してコストを削減します。
 これらのコレクションはただちにコピーを作成しません。
 その代わり、元のインスタンスとコピーする値は、「要素が格納されているメモリ」を共有します。
 コレクションにあるコピー値の1つを変更すると、変更直前に要素がコピーされます。
 コード上では、すぐにコピーが行われたかのように見えます。
 
 この例では、前の例のResolution構造を使用しています。

 ````
 let hd = Resolution(width: 1920, height: 1080)
 var cinema = hd
 ````
 
 この例では、hdという定数を宣言しています。
 それをフルHDビデオの幅と高さ（幅1920、高さ1080）で初期化された、Resolutionインスタンスに設定します。

 次にcinemaという変数を宣言し、hdを現在の値として設定します。
 Resolutionは構造体なので、既存のインスタンスのコピーが作成され、新しいコピー値がシネマに割り当てられます。
 hdとシネマの幅と高さは同じですが、実際にはまったく異なる2つのインスタンスです。
 
 次に、シネマのwidthプロパティは、デジタルシネマ上映むけの2K規格（幅2048, 高さ1080）に修正されます。
 
 ````
 cinema.width = 2048
 ````
 
 シネマのwidthプロパティを確認すると、実際に2048に変更されています。
 
 ````
 print("cinema is now \(cinema.width) pixels wide")
 // Prints "cinema is now 2048 pixels wide"
 ````
 
 ただし、元のhdインスタンスのwidthプロパティは、まだ1920という以前の値です。
 
 ````
 print("hd is still \(hd.width) pixels wide")
 // Prints "hd is still 1920 pixels wide"
 ````
 
 cinemaにhdの現在値を代入したとき、hdの値は「cinemaインスタンス」に新たにコピーされました。
 その結果、同じ数値を持つ2つの「まったく異なるインスタンス」になりました。
 これらは別々のインスタンスです。
 下の図に示すように、cinemaの幅を2048に設定しても、hdに格納されている幅には影響しません。\
 ![sharedStateStruct_2x](sharedStateStruct_2x.png)
 
 列挙型の挙動も同様です。
 
 ````
 enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
 }

 var currentDirection = CompassPoint.west
 let rememberedDirection = currentDirection
 currentDirection.turnNorth()

 print("The current direction is \(currentDirection)")
 print("The remembered direction is \(rememberedDirection)")
 // Prints "The current direction is north"
 // Prints "The remembered direction is west"
 ````
 
 rememberedDirectionにcurrentDirectionの値が割り当てられると、コピーされた値が設定されます。
 その後、currentDirectionの値を変更しても、rememberedDirectionに格納されたコピー値には影響しません。
 */






//: [Next](@next)

