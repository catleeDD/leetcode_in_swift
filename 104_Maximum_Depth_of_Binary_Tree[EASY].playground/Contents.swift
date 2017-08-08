/*
 104. Maximum Depth of Binary Tree
 https://leetcode.com/problems/maximum-depth-of-binary-tree/#/description
 
 Given a binary tree, find its maximum depth.
 
 The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
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
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let left = maxDepth(root?.left)
        let right = maxDepth(root?.right)
        return max(left, right) + 1
    }
}

// bfs 天生就是用来计算最大路径的
class Solution1 {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var deepth = 0
        var queue = [root!]
        while !queue.isEmpty {
            deepth += 1
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        return deepth
    }
}

// dfs
class Solution2 {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var deepth = 0
        var stack = [root!]
        var lastValues = [1]
        while !stack.isEmpty {
            let node = stack.popLast()!
            let last = lastValues.popLast()!
            deepth = max(deepth, last)
            if let left = node.left {
                stack.append(left)
                lastValues.append(last + 1)
            }
            if let right = node.right {
                stack.append(right)
                lastValues.append(last + 1)
            }
        }
        return deepth
    }
}