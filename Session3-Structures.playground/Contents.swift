/*:
Session3 - Structures
======================================
Classes and structures in Swift have many things in common. Both can:
- Define properties to store values
- Define methods to provide functionality
- Define subscripts to provide access to their values using subscript syntax
- Define initializers to set up their initial state
- Be extended to expand their functionality beyond a default implementation
- Conform to protocols to provide standard functionality of a certain kind

Classes have additional capabilities that structures do not:
- Inheritance enables one class to inherit the characteristics of another.
- Type casting enables you to check and interpret the type of a class instance at runtime.
- Deinitializers enable an instance of a class to free up any resources it has assigned.
- Reference counting allows more than one reference to a class instance.
*/


/*:
----
Define Structures
----------
- Use `struct` keywordto create a structure
*/
struct Resolution {
    var width = 0
    var height = 0
}

class Resolution2 {
    var width = 0
    var height = 0
}

let someResolution = Resolution()

// Access the properties of an instance of a struct using dot syntax
println("The width of someResolution is \(someResolution.width)")

/*:
----
Memberwise Initializers for Structure Types
-------------------------------------------
- All structures have an automatically-generated memberwise initializer, which you can use to initialize the member properties of new structure instances
- Initial values for the properties of the new instance can be passed to the memberwise initializer by name
*/

var vga = Resolution(width: 640, height: 480)
println("The width of vga is \(vga.width)")

vga.width = 1080
println("The width of vga is now \(vga.width)")


/*:
----
Value type vs Reference type
----------------------------
Swift has two categories of Types: Value and Reference.
- **Value type** is a type whose value is **copied** when it is assigned to a variable or constant, or when it is passed to a function.
- Value types: struct, enum, tuple⁣

- **Reference types** are not copied when they are assigned to a variable or constant, or when they are passed to a function.  A reference to the same existing instance is used instead.
- Reference types: class, function
*/

class Rectangle {
    var length: Int = 0
    var width: Int = 0
}
var rectangle1 = Rectangle()
rectangle1.length = 12

var rectangle2 = rectangle1
rectangle2.length = 24

println(rectangle1.length)
println(rectangle2.length)




// Now lets try with structures
struct EquilateralTriangle {
    var length: Int = 0
}

var triangle1 = EquilateralTriangle()
triangle1.length = 10

var triangle2 = triangle1
triangle1.length = 12

println(triangle1.length)
println(triangle2.length)

/*:
----
Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
------------------------------------------------------------------
- Swift’s `String`, `Array`, and `Dictionary` types are implemented as structures. This means that strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.
- `NSString`, `NSArray`, and `NSDictionary` in Foundation are implemented as classes, not structures. `NSString`, `NSArray`, and `NSDictionary` instances are always assigned and passed around as a reference to an existing instance, rather than as a copy.
*/
var rectanglesList1 = [rectangle1, rectangle2]
var rectanglesList2 = rectanglesList1

rectanglesList2.append(Rectangle())
rectanglesList2[1].length = 15

rectanglesList1
rectanglesList2

/*:
----
Identity Operators
------------------
Because classes are reference types, it is possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same is not true for structures and enumerations, because they are always copied when they are assigned to a constant or variable, or passed to a function.)  It can sometimes be useful to find out if two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:

- Identical to (===) means that two constants or variables of **class** type refer to exactly the same class instance
- Not identical to (!==)

- “Equal to” (==) means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.
*/


/*:
----
Apple's Guide to Choosing Between Classes and Structures
--------------------------------------------------------
You can use both classes and structures to define custom data types to use as the building blocks of your program’s code.

However, structure instances are always passed by value, and class instances are always passed by reference. This means that they are suited to different kinds of tasks. As you consider the data constructs and functionality that you need for a project, decide whether each data construct should be defined as a class or as a structure.

As a general guideline, consider creating a structure when one or more of these conditions apply:

- The structure’s primary purpose is to encapsulate a few relatively simple data values.
- It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
- Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
- The structure does not need to inherit properties or behavior from another existing type.

Examples of good candidates for structures include:
- The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
- A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
- A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.

In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.
*/

