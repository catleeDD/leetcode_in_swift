/*

124. Binary Tree Maximum Path Sum
https://leetcode.com/problems/binary-tree-maximum-path-sum/#/description
 
Given a binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain at least one node and does not need to go through the root.

For example:
Given the below binary tree,

  1
 / \
2   3
Return 6.
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

class Solution {
    func maxPathSum(_ root: TreeNode?) -> Int {
        return __findMaxPathDown(root).1
    }
    
    //第一个Int是单个path（通过root的左边`或`后边路径）的最大sum(还可能使用除了这棵树的其他分支)
    //第二个Int是如果只使用这颗树的最大sum
    private func __findMaxPathDown(_ root: TreeNode?) -> (Int, Int) {
        if let root = root {
            let left = __findMaxPathDown(root.left)
            let right = __findMaxPathDown(root.right)
            
            // 至少需要有一个root
            let singlePathMax = max(max(0, left.0), max(0, right.0)) + root.val
            let allPathMax = max(left.1, right.1, max(0, left.0) + max(0, right.0) + root.val)
            return (singlePathMax, allPathMax)
        } else {
            return (Int.min, Int.min)
        }
    }
}

class Solution1 {
    var maxValue: Int = Int.min
    
    func maxPathSum(_ root: TreeNode?) -> Int {
        __findMaxPathDown(root)
        return maxValue
    }
    
    //返回单个path（通过root的左边`或`后边路径）的最大sum
    private func __findMaxPathDown(_ root: TreeNode?) -> Int {
        if let root = root {
            let left = __findMaxPathDown(root.left)
            let right = __findMaxPathDown(root.right)
            maxValue = max(maxValue, max(0, left) + max(0, right) + root.val)
            return max(max(0, left), max(0, right)) + root.val
        } else {
            return Int.min
        }
    }
}




