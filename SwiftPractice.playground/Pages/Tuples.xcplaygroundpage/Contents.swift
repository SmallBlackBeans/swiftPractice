//: [Previous](@previous)

import Foundation



let success = (200, "HTTP OK")
let fileNotFound = (404, "File not Found")
let redirect:(Int, String) = (302, "Temporary redirect")



var (successCode, successMessage) = success
successCode
successMessage


let (_, errorMessage) = fileNotFound


let tuple1 = (1, 1)
let tuple2 = (1, 2)
tuple1 < tuple2//第一个不相等的位置的数字大小判断
let tuple3 = (1, 2, 3)

let largeTuple1 = (1, 2, 3, 4, 5, 6, 7)
let largeTuple2 = (1, 3, 4, 5, 5, 6, 7)
//largeTuple1 < largeTuple2❌ 超过七个就不能比较了



		