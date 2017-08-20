/*
 98. Validate Binary Search Tree
 https://leetcode.com/problems/validate-binary-search-tree/description/
 
 Given a binary tree, determine if it is a valid binary search tree (BST).
 
 Assume a BST is defined as follows:
 
 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.
 Example 1:
   2
  / \
 1   3
 Binary tree [2,1,3], return true.
 Example 2:
   1
  / \
 2   3
 Binary tree [1,2,3], return false.
 
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// inorder
class Solution {
    var list = [Int]()
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        if !isValidBST(root.left) {
            return false
        }
        if list.count == 0 || root.val > list.last! {
            list.append(root.val)
        } else {
            return false
        }
        if !isValidBST(root.right) {
            return false
        }
        return true
    }
}

// inorder stack
class Solution1 {
    func isValidBST(_ root: TreeNode?) -> Bool {
        var pre = Int.min
        var stack = [TreeNode]()
        var root: TreeNode? = root
        while root != nil || !stack.isEmpty {
            while let node = root {
                stack.append(node)
                root = node.left
            }
            let node = stack.popLast()!
            if pre == Int.min || node.val > pre {
                pre = node.val
            } else {
                return false
            }
            root = node.right
        }
        return true
    }
}

//
class Solution2 {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return valid(root, nil, nil)
    }
    
    private func valid(_ root: TreeNode?, _ min: TreeNode?, _ max: TreeNode?) -> Bool {
        guard let root = root else { return true }
        if let min = min, root.val <= min.val {
            return false
        }
        if let max = max, root.val >= max.val {
            return false
        }
        return valid(root.left, min, root) && valid(root.right, root, max)
    }
}
