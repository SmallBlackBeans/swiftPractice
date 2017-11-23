import Foundation
import UIKit
/// ej:
///     let label = UILabel().with {
///         $0.textAlignment = .Center
///         $0.textColor = UIColor.blackColor()
///         $0.text = "Hello, World!"
///     }
public protocol With {}


extension With  {
    public func with<T>(item: T, update: (inout T) throws -> Void) rethrows -> T {
        var this = item; try update(&this); return this
    }
}

extension NSObject: With {}
extension CGPoint: With {}
extension CGRect: With {}
extension CGSize: With {}
extension CGVector: With {}