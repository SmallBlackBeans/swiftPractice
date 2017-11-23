//: [Previous](@previous)

//basic - operations


import Foundation

infix operator %%
public func %% (left:Double, right:Double) -> Double {
    return left.truncatingRemainder(dividingBy: right)
}

let mod1 = 8 % 2

let mod2 = 8.0.truncatingRemainder(dividingBy: 2.5)

let mod3 = 8 %% 2.5

//: Identity opration
//===
//!==

////条件比较 tenary Conditional Operator
//let sum = 10
//let isEqual = sum == 10
//
//if isSumEqualToTen = isEqual ? "yes" : "no"
//
//
////" #### Nil Coalescing Operator
//// opt != nil ? opt! : b
//


//Closed range operation
// begin ... end

