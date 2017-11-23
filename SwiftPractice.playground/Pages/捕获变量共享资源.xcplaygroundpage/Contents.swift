//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


extension Array where Element: Comparable {
    mutating func mergeSort(_ begin: Index, _ end: Index) {
        if (end - begin) > 1 {
            let mid = (begin + end) / 2
            mergeSort(begin, mid)
            mergeSort(mid, end)
            merge(begin, mid, end)
        }
    }
    
    private mutating func merge(_ begin: Index, _ mid: Index, _ end: Index) {
        var tmp: [Element] = []
        var i = begin
        var j = mid
        while i != mid && j != end {
            if self[i] < self[j] {
                tmp.append(self[i])
                i = i + 1
            }
            else {
                tmp.append(self[j])
                j = j + 1
            }
        }
        tmp.append(contentsOf: self[i ..< mid])
        tmp.append(contentsOf: self[j ..< end])
        replaceSubrange(begin ..< end, with: tmp)
    }
    
    //利用local function捕获变量的特性
    //local function还有一个副作用，就是它更深层次的隐藏了merge方法的实现，我们甚至都不用把它定义为private，它完全是mergeSort的私人财产。
    mutating func mergeSortLocal(_ begin: Index, _ end: Index) {
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        func merge(_ begin: Index, _ mid: Index, _ end: Index) {
            tmp.removeAll(keepingCapacity: true)
            var i = begin
            var j = mid
            while i != mid && j != end {
                if self[i] < self[j] {
                    tmp.append(self[i])
                    i = i + 1
                }
                else {
                    tmp.append(self[j])
                    j = j + 1
                }
            }
            tmp.append(contentsOf: self[i ..< mid])
            tmp.append(contentsOf: self[j ..< end])
            replaceSubrange(begin ..< end, with: tmp)
        }
        if (end - begin) > 1 {
            let mid = (begin + end) / 2
            mergeSortLocal(begin, mid)
            mergeSortLocal(mid, end)
            merge(begin, mid, end)
        }
        
    }
}

var numbers = [3, 2, 6, 9, 8]
//numbers.mergeSort(numbers.startIndex, numbers.endIndex)
numbers.mergeSortLocal(numbers.startIndex, numbers.endIndex)

