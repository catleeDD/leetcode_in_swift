//: Playground - noun: a place where people can play

import UIKit

class TreeNode<T> {
    var left: TreeNode<T>?
    var right: TreeNode<T>?
    var value: T
    init(value: T) {
        self.value = value
    }
}

func preOrder<T>(node: TreeNode<T>) {
    var stack = [node]
    while !stack.isEmpty {
        var current = stack.popLast()
        while let node = current {
            if let right = node.right {
                stack.append(right)
            }
            debugPrint(node.value)
            current = node.left
        }
    }
}

func inOrder<T>(node: TreeNode<T>) {
    var stack: [TreeNode<T>] = []
    var current: TreeNode<T>? = node
    
    while current != nil || !stack.isEmpty {
        while let node = current {
            stack.append(node)
            current = node.left
        }
        
        if let node = stack.popLast() {
            debugPrint(node.value)
            current = node.right
        }
    }
}

func postOrder<T>(node: TreeNode<T>) {
    var stack = [node]
    var pre: TreeNode<T>?
    while !stack.isEmpty {
        let current = stack.last!
        if current.left == nil && current.right == nil || (pre != nil && (current.left === pre || current.right === pre)) {
            debugPrint(current.value)
            pre = current
            stack.popLast()
        } else {
            if let right = current.right {
                stack.append(right)
            }
            if let left = current.left {
                stack.append(left)
            }
        }
    }
}
