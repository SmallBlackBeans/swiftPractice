//: [Previous](@previous)

import Foundation

/*
 比如文件读取的NSnotFound  和 C++的文件打开返回的是文件句柄 用 -1表示错误
 
 但是他们和正常情况下返回的类型都是相同的，开发者根本无法去预判，或者意识到自己调用的方法返回还要做判断。
 
 使用一个同类型的特殊值来表示某种特殊的意义，通常这些值就叫做 “哨兵值”
 1.错误处理的方式是被动的
 2.哨兵值的方式，使我们无法通过编译器来强制错误处理的行为。
 */


/**
 NSString *tmp = nil;
 
 if ([tmp rangeOfString: @"Swift"].location != NSNotFound) {
 这里还是要执行的
 NSLog(@"Something about swift");
 }
 
 NSNotFound 的值是NSIntegerMax  location 是 0
 */


enum Optional<T> {
    case some(T)
    case none
}

extension Array where Element: Equatable {
    func find(_ element: Element) -> Optional<Index> {
        var index = startIndex
        while index != endIndex {
            if self[index] == element {
                return .some(index)
            }
            formIndex(after: &index)
        }
        return .none
    }
    
    func findIndex(_ element: Element) -> Index? {
        var index = startIndex
        while index != endIndex {
            if self[index] == element {
                return index
            }
            formIndex(after: &index)
        }
        return nil
    }
}


var numbers = [1, 2, 3, 4]
let index = numbers.findIndex(4)
print(type(of: index))//Optional<Int>


//numbers.remove(at: index)❌

switch index {
case let index?:
    numbers.remove(at: index)
case nil:
    print("Not exist")
}


