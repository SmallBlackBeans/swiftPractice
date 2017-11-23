//
//  StoryBoardManager.swift
//  StoryBoardExtension
//
//  Created by 韩承海 on 2017/3/17.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import Foundation
enum LogLevel: Int {
    case verbose = 1
    case debug = 2
    case info = 3
    case warning = 4
    case error = 5
}
extension LogLevel: Comparable {}

func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

struct PrintLogger {
    let minimumLogLevel: LogLevel
}

extension PrintLogger: Logger {
    func writeLogEntry(
        logLevel: LogLevel,
        _ message:@autoclosure () -> String,
        file: StaticString,
        line: Int,
        function: StaticString)
    {
        if logLevel >= minimumLogLevel {
            print("\(logLevel) – \(file):\(line) – \(function) – \(message())")
        }
    }
}

protocol Logger {
    /// 打印一条日志
    /// 类型必须遵循 Logger 协议的必选参数
    /// - 注意：Logger 的调用者永远不应该调用此方法
    /// 总是调用 log(_:,_:) 方法
    func writeLogEntry(
        logLevel: LogLevel,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: Int,
        function: StaticString)
}

extension Logger {
    /// Logger 协议的公开 API
    /// 只是调用 writeLogEntry(_:,_:,file:,line:,function:) 方法
    func log(
        logLevel: LogLevel,
        _ message: @autoclosure () -> String,
        file: StaticString = #file,
        line: Int = #line,
        function: StaticString = #function)
    {
        writeLogEntry(logLevel: logLevel, message,
                      file: file, line: line,
                      function: function)
    }
}

let logger: Logger = PrintLogger(
    minimumLogLevel: .verbose)
logger.log(logLevel: .error, "An error occurred") // 撒花🎉

