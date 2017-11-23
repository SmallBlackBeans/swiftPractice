import Foundation
import UIKit


protocol StoryBoardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryBoardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryBoardIdentifiable{}




extension UIStoryboard {
    enum StoryBoard: String {
        case Home
        case Mine
        case Message
    }
    
    convenience init(storyboard: StoryBoard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyborad(storyboard: StoryBoard, bundle: Bundle? = nil) -> UIStoryboard{
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}



extension UIStoryboard {
    func instantiateViewController<T: UIViewController>() -> T where T: StoryBoardIdentifiable {
        let optionalViewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier)
        guard let viewController = optionalViewController as? T else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}