import Foundation


protocol Merger {
    associatedtype E
    func merger(_ a: E, _ b: E) -> E
}

class SegmentTree<E> {
    private var tree: [E]?
    private var data: [E]?
//    private var merger: Merger<NSInteger>?
//
//    init(_ arr: [E], _ merger: Merger) {
//    }
    
    
    private func buildSegmentTree(_ treeIndex: NSInteger, left: NSInteger, right: NSInteger ) -> SegmentTree? {
        return nil
    }
}

class NumArray {
    
    init(_ nums: [NSInteger]) {
        if nums.count > 0 {
            
        }
    }
    
    //private var tree: SegmentTree<NSInteger>;
}
