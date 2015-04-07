//: Objects and Classes
//: ===================

/*: This is a comment that will not be rendered
----
Classes
-------
Use class followed by the class’s name to create a class.
- A property declaration in a class is written the same way as a constant or variable declaration, except that it is in the context of a class.
- Likewise, method and function declarations are written the same way.
- Swift classes do not need a base class (unlike Objective-C), you can subclass `NSObject` if you need.
*/

class Shape {
    // Declared Properties
    var numberOfSides = 0
    
    // Declare initializers (optional)
    
    // Declare Methods
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// An instance of our class.  Use dot syntax to access properites.
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

/*: 
----
Class and Property Naming Style
-------------------------------
Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types UpperCamelCase names (such as SomeClass and SomeStructure here) to match the capitalization of standard Swift types (such as String, Int, and Bool). Conversely, always give properties and methods lowerCamelCase names (such as frameRate and incrementCount) to differentiate them from type names.
*/


/*: 
----
Stored and Computed Properties
------------------------------
- There is no difference between instance variables and properties in Swift.
- Swift creates the backing store for you in something called a **stored property**.
- **Computed properties** do not store values, the derive them from other properties
- Computed properties are always `var` type.
- Include the `@lazy` attribute in front of the delcaration to delay evaluation until its evaluted
*/
class Box {
    var numberOfSides = 4           // Stored property
    var description: String {       // Computed property            return "\(numberOfSides) wheels"
    }
}

/*:
----
Lazy Properties
---------------
- Delay the evaluation until we access it
- Include the `@lazy` attribute in front of the delcaration
*/
import UIKit
class LazyVisit {
    // Lazy Properties
    var firstVisit: Bool = false
    lazy var bigImage: UIImage = UIImage(named: "ReallyBigImage")!
    func login() {
        if (firstVisit == false) {
        //self.imageView.image = bigImage
        }
    }
}

/*:
----
Initializers
------------
- Create an initializer to set up the class when an instance is created.  Use `init()` to create one.
- Every value **must be** initialized before it is used
- Initializers are invoked using the `let instandce = MyClass()` syntax
*/

class NamedShape {
    var numberOfSides: Int = 0
    var name: String!
    var noname: String?
    
    
    init(name: String) {
        // Need to use `self` if property has same name as parameter
        //self.name = name
        self.name = "forced"
        self.noname = "optional"
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var a = NamedShape.init(name:"hi")
println(a.name)
println(a.noname!)

if let n = a.noname {
    println(n)
}

/*:
> A couple of things to note:
> - Unlike Obj-C, initializers do not return a value.
> - Notice how self is used to distinguish the name property from the name argument to the initializer.
> - The arguments to the initializer are passed like a function call when you create an instance of the class. Every property needs a value assigned—either in its declaration (as with numberOfSides) or in the initializer (as with name).
> - Your can use `deinit` to create a deinitializer if you need to perform some cleanup before the object is deallocated.  This is not typically needed.  ARC will take care of the memory management for you.
*/

/*:
----
Subclasses
----------
* Subclasses include their superclass name after their class name, separated by a colon. There is no requirement for classes to subclass any standard root class, so you can include or omit a superclass as needed.
* Methods on a subclass that override the superclass’s implementation are marked with `override`—overriding a method by accident, without override, is detected by the compiler as an error. The compiler also detects methods with override that don’t actually override any method in the superclass.
*/
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

/*:
----
Initializers in Subclasses
--------------------------
- If you are using an inherited property, you need to set your own properties before you call `super.init()`. This is opposite of Obj-C.
- Use `convience` keyword to declare secondary interface to your initializers
- The **designated** intializer sets the defaults and calls `super.init()`
*/
class Animal {
    var name: String
    init(animalName: String) {
        name = animalName
    }
}

class Dog: Animal {
    var hasFourLegs: Bool
    
    init(animalName: String, fourLegs: Bool) {
        // Initialize all subclass properteis before calling superclass
        hasFourLegs = fourLegs
        super.init(animalName: animalName)
        name = "RUFF"
    }
    
    // Convienence initializer
    convenience init(snoopy: Bool) {
        self.init(animalName: "Snoopy", fourLegs: true)
    }
}

// Create instances of our Animal and Dog class
let garfield: Animal = Animal(animalName: "Garfield")
let snoopy: Dog = Dog(snoopy: true)

//: --

//: ### Getters and Setters
//: * In addition to simple properties that are stored, properties can have a getter and a setter.
//: * In the setter for perimeter, the new value has the implicit name newValue. You can provide an explicit name in parentheses after set.
//: * Notice that the initializer for the EquilateralTriangle class has three different steps:
//:  1. Setting the value of properties that the subclass declares.
//:  2. Calling the superclass’s initializer.
//:  3. Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.

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
println(triangle.perimeter)
triangle.perimeter = 9.9
println(triangle.sideLength)

//: ### Property Observers
//: - If you don’t need to compute the property but still need to provide code that is run before and after setting a new value, use `willSet` and `didSet`. 
//: - May be useful to updated UI elements when values change.
//: - For example, the class below ensures that the side length of its triangle is always the same as the side length of its square.
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

// Create an instance of our class
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
println(triangleAndSquare.square.sideLength)
println(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
println(triangleAndSquare.triangle.sideLength)

//: ### Methods in Classes
//: * Methods on classes have one important difference from functions. Parameter names in functions are used only within the function, but parameters names in methods are also used when you call the method (except for the first parameter).  This provides formatting and linguistic similarity to Objective-C.
//: * By default, a method has the same name for its parameters when you call it and within the method itself. You can specify a second name, which is used inside the method.

class Counter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes times: Int) {
        count += amount * times
    }
}
var counter = Counter()
counter.incrementBy(2, numberOfTimes: 7)


//: ### Optional Class Instances
//: - When working with optional values, you can write ? before operations like methods, properties, and subscripting.
//: - If the value before the ? is nil, everything after the ? is ignored and the value of the whole expression is nil. This is called **optional binding**.  Otherwise, the optional value is unwrapped, and everything after the ? acts on the unwrapped value. In both cases, the value of the whole expression is an optional value.
var optionalSquare: Square? //= Square(sideLength: 4.5, name: "optional square")

// ????
var s = optionalSquare?.sideLength
println(s)



 
 
