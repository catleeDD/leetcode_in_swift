/*
 102. Binary Tree Level Order Traversal
 
 https://leetcode.com/problems/binary-tree-level-order-traversal/discuss/
 
 Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
 
 For example:
 Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
 return its level order traversal as:
 [
  [3],
  [9,20],
  [15,7]
 ]
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

// marker
class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else {
            return result
        }
        var queue = [TreeNode]()
        queue.append(root)
        // marker，也可以用nil代替
        queue.append(TreeNode(Int.min))
        var temp = [Int]()
        while let node = queue.first {
            queue.removeFirst()
            if node.val == Int.min {
                result.append(temp)
                if !queue.isEmpty {
                    queue.append(TreeNode(Int.min))
                }
                temp = []
                continue
            }
            temp.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return result
    }
}

// 不用marker，直接用循环
class Solution1 {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else {
            return result
        }
        var queue = [TreeNode]()
        queue.append(root)
        while !queue.isEmpty {
            var temp = [Int]()
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
                temp.append(node.val)
            }
            result.append(temp)
        }
        return result
    }
}

// dfs
class Solution2 {
    private var result = [[Int]]()
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        helper(root, 0)
        return result
    }
    
    private func helper(_ root: TreeNode?, _ height: Int) {
        guard let root = root else { return }
        if height == result.count {
            result.append([])
        }
        var temp = result[height]
        temp.append(root.val)
        result[height] = temp
        helper(root.left, height+1)
        helper(root.right, height+1)
    }
}