//: [Previous](@previous)

import Foundation





func loadData() -> () {
    DispatchQueue.global().async {
        print("耗时操作\(Thread.current)")
        DispatchQueue.main.async { 
            print("主线程更新UI")
        }
    }
}