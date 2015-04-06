//: # An Optional is a box
//:
//: ![](Resources/box.jpg)
//:
//: Optionals is an enum to say "I have something" or "it's empty". You can picture it as a box which can be empty or contain something. It's just a box, to know what's inside you need to unwrap it. When defining an optional type, use ?, when unwrapping it, use !.
//:
//: #### Note
//:
//: ? and ! are short name for Optional and ImplicitlyUnwrappedOptional.


var optionalString: String?
optionalString == nil
// optional default - nil
// non-optional need value
var string: String = "Test String"
string == "Test String"

//: #### Syntactic sugar: **?** and **!**
//:
//: short name ? and ! for Optional<T> and ImplicitlyUnwrappedOptional<T> (for which the ‘?’ and ‘!’ type modifiers are syntactic sugar).

//: # To unwrap or not to unwrap?


var i: Int?
var j: Int?
//var k = i + j     // compilation issue
//var k = i! + j!   // no compilation issue but runtime issue if i/j not initialised
//var k = (i ?? 0) + (j ?? 0) // nil

// Most of the time, operating on optionals required unwrapping...
// Except for println and string interpolation
var kitty: String? = "Kitty"
var greeting = "Hello \(kitty)"     // No compiler error!
print("Hello")
println(kitty)      // Also fine.
//var nope = "Hello " + kitty         // Compiler error

//: # Different ways of unwrapping
//:
//: Several way of unwrapping: <br/>
//: 1. either go the brute way, unwrap without checking and risk a runtime error<br>
//: 2. or check before with if statement, you can even use the if let or if var statement<br>
//: 3. or go with optional chaining with elvis operator ?. <br/>

// 1. force unwrapped
var optionalValue: String?
// optionalValue! // no compilation issue but runtime issue because optionaValue is nil

// 2. if let: unwrap with
var optionalName: String?
var hello = "Hello!"
if let name = optionalName {
    hello = "Hello, \(name)" // not executed
}
optionalName = "John Appleseed"
hello = "Hello, \(optionalName)"

if let name = optionalName {
    hello = "Hello, \(name)" // executed
}

// 3. optional chaining
// do not unwrap optionals if not needed, work with then

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

if let roomCount = john.residence?.numberOfRooms {
    println("John's residence has \(roomCount) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}

//: #### Caution when unwrapping
//:
//: Check first or use optional chaining

func toInt(first:String!) -> Int! {
    return Int(first.toInt()!)
}
var myIn:Int = toInt("3")
// var myIn:Int = toInt("3e") // runtime error




//: # Classes
//: Use class followed by the class’s name to create a class. <br/>
//: A property declaration in a class is written the same way as a constant or variable declaration, except that it is in the context of a class. <br/>
//: Likewise, method and function declarations are written the same way.

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = NamedShape(name: "circle")
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//: Notice how self is used to distinguish the name property from the name argument to the initializer.

//: #### Designed for Safety
//: Every property needs a value assigned either in its declaration (as with numberOfSides) or in the initializer (as with name).

//: # Inheritance
//: Methods on a subclass that override the superclass’s implementation are marked with override.
//:
//: The compiler also detects methods with override that don’t actually override any method in the superclass.

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter
triangle.perimeter = 9.9
triangle.sideLength

//: # Computed value
//: Stored vs Computed properties
//:
//: Computed properties, which do not actually store a value. <br/>
//: Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.







//: # Protocol and Extension

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

//: Classes, enumerations, and structs can all adopt protocols.

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

//: # MUTATING
//:
//: ----
//: If you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class(because methods on a class can always modify the class.).
//: The mutating keyword is only used by structures and enumerations.
//: ----

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

7.simpleDescription

