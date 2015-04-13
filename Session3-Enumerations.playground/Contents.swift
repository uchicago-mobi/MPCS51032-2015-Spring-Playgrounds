/*:
Session3 - Enumerations
=======================
*/

/*: This is a comment that will not be rendered
----
Enumerations
------------
- An enumeration defines a common type for a group of related values.
- Enforces type safety
- Use `enum` to create an enumeration.
- Like classes and all other named types, enumerations can have methods associated with them.
*/

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue
ace.simpleDescription()

/*:
----
Create Instace from Raw Value
-----------------------------
- Use the `init?(rawValue:)` initializer to make an instance of an enumeration from a raw value.
- Check out all the dizzing ways you could use this.
*/
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

let rank = Rank(rawValue: 11)
rank!.rawValue
rank?.simpleDescription()
rank!.simpleDescription()

/*:
----
Enum Values
-----------
- In the example above, the raw-value type of the enumeration is `Int`, so you only have to specify the first raw value.  The rest of the raw values are assigned in order.
- Unlike Objective-C enums, you can use any `Strings`, `Int`, `Floats`, `Double`, `Char` for enumeration raw values.
- Using enumerations of enumerated types, it is possible to have the `rawValue` be of any type.
*/
enum WebService: String {
    case Post = "http://something/upload"
    case Request = "http://something/request"
}

var postUrl: WebService = WebService.Post
// Use the rawValue property to access the raw value of an enumeration member
println("Post URL: \(postUrl.rawValue)")

// If the type is inferrable, you can access the value using dot syntax.
postUrl = .Request
println("Request URL: \(postUrl.rawValue)")

/*:
----
Enum Value Types
----------------
- The member values of an enumeration are actual values, not just another way of writing their raw values.
- In cases where there isn’t a meaningful raw value, you don’t have to provide one.  If you don't supply a default value, they define their own type
*/
enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

/*:
----
Associated Values
-----------------
- Enums can store `associated values` of any given type
- The value types can be difference for each member
- Associated values and raw values are different: *The raw value of an enumeration member is the same for all of its instances, and you provide the raw value when you define the enumeration.*
*/
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

// Create variable of type `Barcode`
var productBarcode = Barcode.UPCA(8, 438273, 984738, 3)
//productBarcode = .QRCode("abcdefghij")

switch productBarcode {
case let .UPCA(numberSystem,manufacturer,product,check):
    println("UPCA: \(numberSystem) \(manufacturer) \(product) \(check)")
case let .QRCode(productCode):
    println("QR: \(productCode)")
}
