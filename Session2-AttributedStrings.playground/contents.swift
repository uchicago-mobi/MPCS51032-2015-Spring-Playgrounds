/*:
MPCS51032 - Session 2 - Attributed Strings
==========================================
*/

import UIKit

/*:
----
Using Attributed Strings with Labels
------------------------------------
Create a UILabel, change the color and round the corners of the label.  Font and color properties apply to the entire label.
*/
let helloLabel = UILabel(frame: CGRectMake(0, 0, 300, 100))
helloLabel.backgroundColor = UIColor.yellowColor()
helloLabel.layer.masksToBounds = true
helloLabel.layer.cornerRadius = 10.0
helloLabel.textAlignment = NSTextAlignment.Center
helloLabel.text = "Hello Label!"


//: Let the label use an attributed string instead
var attributedString = NSMutableAttributedString()
attributedString = NSMutableAttributedString(string: "Hello World this is a demo!", attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 100.0)!])
helloLabel.attributedText = attributedString


/*:
----
Attributed String Showcase
--------------------------
Note that attributed string attributes are cumulative.  They will persist on that string until you change/undo them.  For work highlighting, you will need to reset the previously highlighted words to the default attributes.
*/

//: Changing the font attribute
attributedString = NSMutableAttributedString(string: "Hello World!", attributes: [NSFontAttributeName:UIFont(name: "ChalkboardSE-Regular", size: 100.0)!])

//: Changing the font over a range
attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AmericanTypewriter-Bold", size: 18.0)!, range: NSRange(location:0,length:5))

//: Change font in range, stroke the letter and change color
attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 100.0)!, range: NSRange(location: 0, length: 1))
attributedString.addAttribute(NSStrokeColorAttributeName, value: UIColor.redColor(), range:  NSRange(location: 0, length: 1))
attributedString.addAttribute(NSStrokeWidthAttributeName, value: 2, range: NSRange(location: 0, length: 1))

//: Change the background color
attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: NSRange(location: 0, length: attributedString.length))
