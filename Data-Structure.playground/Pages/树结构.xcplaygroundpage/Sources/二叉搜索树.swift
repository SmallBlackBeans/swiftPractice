import Foundation


class BST<E: Comparable> {
    class Node {
        var e: E
        var left: Node? = nil
        var right: Node? = nil
        init(_ data: E) {
            e = data
        }
    }
    
    var root: Node?
    //存储属性
    var size: Int = 0
    
    
    func isEmpty() -> Bool{
        return size == 0
    }
    
    // 插入元素e
    func add(e: E) {
        root = add(root, e)
    }
    
    // 二分查找
    func contains(e: E) -> Bool {
        return contains(root,e)
    }
    
    // 遍历
    
    
    
    // MARK: - private
    // 向以node为根的二分搜索树插入 元素e
    private func add(_  node: Node!,_ e: E) -> Node {
        //终止条件
        if(node == nil) {
            size += 1
            return Node(e)
        }
        if(e < node.e) {
            node.left = add(node.left, e)
        }else {
            node.right = add(node.right, e)
        }
        return node;
    }
    
    private func contains(_ node: Node! , _ e: E) -> Bool {
        if(node == nil) {
            return false
        }
        if(node.e == e) {
            return true
        }else if(node.e < e) {
            return contains(node.right, e)
        }else {
            return contains(node.left, e)
        }
    }
}
