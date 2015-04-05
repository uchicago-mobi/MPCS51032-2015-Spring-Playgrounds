//: MPCS51032 - Session 1 Swift Playground
//: This playgournd contains basic elements of using Swfit for those with experience using Objective-C.  For a more thorough introduction, consult Apple Developer documentation.  This playground uses some examples from Apple's Swift book and Guided.playground.  It also uses some examples from RayWenderlich.com.  

import UIKit
var str = "Hello, Swift"

//: # Variables and Constants #
//: Use `let` to make a constant and `var` to make a variable. The value of a constant doesn’t need to be known at compile time, but you must assign it a value exactly once. 

var myVariable = 44
myVariable = 55
let myConstant = 42
myConstant = 50

//: A constant or variable must have the same type as the value you want to assign to it. you don’t always have to write the type explicitly. Providing a value when you create a constant or variable lets the compiler infer its type.

let inferredConstant = 42
let implicitInteger = 70
let implicitDouble = 70.0


//: More examples of inference...
let languageName = "Swift"  // inferred as String
var version = 1.0           // inferred as Double
let introduced = 2014       // inferred as Int
let isAwesome = true        // inferred as Bool

//: And just for fun, unicode characters
let π = 3.1415927

//: If the initial value doesn’t provide enough information (or if there is no initial value), specify the type by writing it after the variable, separated by a colon.

let explicitDouble: Int = 70
let explicitString: String = "Apple"

//: Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type.
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//: There’s an even simpler way to include values in strings: Write the value in parentheses, and write a backslash (\) before the parentheses. For example:

let name = "lisa"
let age = 8
println(name)
println("Hello my name is \(name) and I am \(age) years old")

// You can even do operations in the blackslashed group
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//: # Semicolons
//: Semicolons are optional at the end of a line (Swift is a conscise language).

let dog = "Snoopy"
let cat = "Garfield";

// Semicolons are required if you have multiple statements on the same line
let mouse = "Mickey"; let duck = "Donald"

//: # Swift Types

//: ## Strings
//: Some basic string maniuplations

var greeting = "Hello class"
greeting = greeting + " World"
println(greeting)

//: Swift has its own string library.  The Swift String type has API methods that allow you to manipulate their values.
greeting.append(Character("!"))
println(greeting)

//: The Swift String type is also bridged to the Objective-C NSString type, providing all the API methods with which you are no doubt familiar if you’ve used Objective-C.

import Foundation       // Access the Foundation frameworksgreeting = "this string should be capitalized".capitalizedString
println(greeting)

// Another NSString method
greeting = "hello".stringByAppendingString(" world")
println(greeting)

// Value types are always copied
var alternateGreeting = greeting
alternateGreeting += " and beyond!"
println(alternateGreeting)
println(greeting)

//: ## Characters


//: ## Booleans
//: Swift has a Boolean type, Bool, that holds a value of either true or false. Once again, you can rely on type inference when creating a variable or constant of this type.  Note that Swift does not map 0/1 to true/false as in Objective-C.  Swift does not support macros.

let always = true
let never = false



//: ## Tuples
//: Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not have to be of the same type as each other.  Tuples observe the `let` or `var` mutability declarion.
var employee = ("Homer","7G",20)
println(employee.0)
println(employee.1)
println(employee.2)

//: Explicity declare tuple values
var employee2: (String, String, Int) = ("Carl","7G",21)

//: A tuple can be deconstructed into its elements
let (firstName, sector, years) = employee2
let string = "Name:\(firstName.uppercaseString) Sector:\(sector) Year Worked:\(years)"
println(string)


//: # Collections and Fast Enumeration

//: ## Arrays and Dictionaries #
//: Create arrays and dictionaries using brackets ([]), and access their elements by writing the index or key in brackets.
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",]
occupations["Jayne"] = "Public Relations"

//: To create an empty array or dictionary, use the initializer syntax.
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

//: If type information can be inferred, you can write an empty array as [] and an empty dictionary as [:]—for example, when you set a new value for a variable or pass an argument to a function.
shoppingList = []
occupations = [:]

//: ## Fast enumeration
let numbers = [1, 2, 3]
let strings = ["Homer", "Marge", "1"]

//: Iterate throught the array
for var i = 0; i < count(strings); i++ {
    println(strings[i])
}

for string in strings {
    println(string)
}

//: Fancy new ways to iterate through arrays

// ".each" based
strings.map({ (string: String) -> Void in
    println(string)
    })

strings.filter { (string: String) -> Bool in
        return string.hasPrefix("A")
}

strings.filter { $0.hasPrefix("A") }

//: Iterate through dictionaries
let luckyNumbers = ["Corinne": 17, "Isa": 11, "Lea": 1337]

for (key, value) in luckyNumbers {
    println("The lucky number of \(key) is \(value)")
}


//: # Control Flow
//: Use if and switch to make conditionals, and use for-in, for, while, and do-while to make loops. Parentheses around the condition or loop variable are optional. Braces around the body are required.

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
    teamScore += 3
} else {
    teamScore += 1
    }
}
println(teamScore)

//: ## If Statements
//: Evaluate a condition
let temp = 70

if temp > 70 {
    println("It's hot out")
} else if temp > 50 {
    println("Its nice out")
} else {
    println("It's cold out")
}

//: ## For Loops
//: The `for-in` loop performs a set of statements for each item in a range, sequence, collection, or progression.  The `for` loop performs a set of statements until a specific condition is met, typically by incrementing a counter each time the loop ends

//: Range operator `...`
for index in 0...5 {
    println(index)
}

//: Closed range operature `..<` show
for index in 0..<5 {
    println(index)
}

//: C-style `for` loops
for var index = 0; index < 5; index++ {
    println(index)
}

//: You use for-in to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order.
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
println(largest)

//: ## While Loops
//: Swift supports while loops as well as do-while loops,
var i = 0
while i < 5 {
    println(i)
    i++
}

// The do-while varint
i = 0
do {
    println("Hello world")
    i++
} while (i<5)

//: ## Switch Statement
//: Switches support any kind of data and a wide variety of comparison operations—they aren’t limited to integers and tests for equality.  Note that there in break statement after each case.  Switch statements must be exhaustive and may require using a `default` case.

let vegetable = "red pepper"
switch vegetable {
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup."
}


//: # Optionals
//: In the Objective-C runtime, messaging nil returns nil, which means the null pointer is effectively safe. However, this doesn’t particularly help you if you’re expecting the reference to be non-nil. The usual way around this is to do an assertion check that the variable is never nil. In debug mode, your app would crash if it encounters nil, so you can find the bug and fix it before releasing the code.

//: When you do need the nil value, you can use an optional. Optionals are a way of wrapping up the concept of “has a value” or “may have a value” into a language- wide feature. 

// Declare an optional
var device: String?
// Declare an optinal and assign it a value
var phone: String? = "iPhone 6"
// The value type is 'optional'
println(phone)

//: Need to **unwrap** the value of the optional.  Unwrapping using `if-let` assigns the value to a new constant.  If the optional value is nil, the conditional is false and the code in braces is skipped. Otherwise, the optional value is unwrapped and assigned to the constant after let, which makes the unwrapped value available inside the block of code.
if let unwrappedPhone = phone {
    println("The unwrapped value of phone is: \(unwrappedPhone)")
}

//: When you are using optionals, you are asking a series of question:
//:  - Is the value `nil`?
//:  - If yes, then do something
//:  - If no, then unwrap it and copy the value to a new constant
//: This makes handling `nil` value safe.  There are many classes in `UIKit` that may return `nil`.  For example a `UIView` may return `nil` if it is not instantiated correctly.  It would not have mattered that much in Objective-C since you could still safely send messages to the `nil` instance (e.g. [view setBackgroundColor]).

//: ## Forced unwrapping
//: If you already know that a particular optional contains a value, then you can use what is known as forced unwrapping. This means you don’t need the if statement to check if the optional contains a value.

var optionalString: String? = "Hello World!"
println("Force unwrapped! \(optionalString!.uppercaseString)")

//: This is convienent, but elimates the safety design of Swift
//: ## Implicit unwrapping
var optionalString2: String! = "Hello World!"
println("Implicit unwrapped! \(optionalString2.uppercaseString)")

//: ## Optional Chaining
//: Optional chaining is a concise way to work with optionals quickly without using if/let and a conditional block each time.

var maybeString: String? = "The eagle has landed"
// If `maybeString` is not `nil` then `.uppercaseString` will be evaluated.  If it is `nil`, it will return `nil`
let uppercase = maybeString?.uppercaseString


//: # Functions
//: Use func to declare a function. Call a function by following its name with a list of arguments in parentheses. Use -> to separate the parameter names and types from the function’s return type.
func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}

// Run the function
greet("Bob", "Tuesday")

//: Use a tuple to make a compound value—for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number.
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
        max = score
    } else if score < min {
        min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
println(statistics.sum)
println(statistics.2)
