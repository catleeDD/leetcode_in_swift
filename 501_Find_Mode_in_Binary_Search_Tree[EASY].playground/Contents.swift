/*
 501. Find Mode in Binary Search Tree
 https://leetcode.com/problems/find-mode-in-binary-search-tree/#/description
 
 Given a binary search tree (BST) with duplicates, find all the mode(s) (the most frequently occurred element) in the given BST.
 
 Assume a BST is defined as follows:
 
 The left subtree of a node contains only nodes with keys less than or equal to the node's key.
 The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
 Both the left and right subtrees must also be binary search trees.
 For example:
 Given BST [1,null,2,2],
 1
  \
   2
  /
 2
 return [2].
 
 Note: If a tree has more than one mode, you can return them in any order.
 
 Follow up: Could you do that without using any extra space? (Assume that the implicit stack space incurred due to recursion does not count).
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

// inorder就是从小到大
class Solution {
    var result: [Int] = []
    var currentValue: Int?
    var currentCount = 0
    var maxCount = 0
    
    func findMode(_ root: TreeNode?) -> [Int] {
        inorder(root)
        return result
    }
    
    private func handleValue(_ value: Int) {
        currentCount += 1
        if value != currentValue {
            currentValue = value
            currentCount = 1
        }
        if currentCount > maxCount {
            maxCount = currentCount
            result.removeAll()
            result.append(value)
        } else if currentCount == maxCount {
            result.append(value)
        }
    }
    
    private func inorder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        inorder(root?.left)
        handleValue(root!.val)
        inorder(root?.right)
    }
}