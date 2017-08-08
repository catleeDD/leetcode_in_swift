/*
 101. Symmetric Tree
 
 https://leetcode.com/problems/symmetric-tree/#/description
 
 Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
 
 For example, this binary tree [1,2,2,3,4,4,3] is symmetric:
 
     1
    / \
   2   2
  / \ / \
 3  4 4  3
 But the following [1,2,2,null,3,null,3] is not:
     1
    / \
   2   2
    \   \
    3    3
 Note:
 Bonus points if you could solve it both recursively and iteratively.
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
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isMirror(root?.left, root?.right)
    }
    
    private func isMirror(_ r1: TreeNode?, _ r2: TreeNode?) -> Bool {
        if r1 == nil, r2 == nil {
            return true
        }
        if r1 == nil || r2 == nil {
            return false
        }
        if r1?.val != r2?.val {
            return false
        }
        return isMirror(r1?.left, r2?.right) && isMirror(r1?.right, r2?.left)
    }
}

class Solution1 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        var queue = [root?.left, root?.right]
        while !queue.isEmpty {
            let r1 = queue[0]
            queue.removeFirst()
            let r2 = queue[0]
            queue.removeFirst()
            if r1 == nil, r2 == nil {
                continue
            }
            if r1 == nil || r2 == nil {
                return false
            }
            if r1?.val != r2?.val {
                return false
            }
            queue.append(r1?.left)
            queue.append(r2?.right)
            queue.append(r1?.right)
            queue.append(r2?.left)
        }
        return true
    }
}

// stack 或者 queue都行，因为都是对称的，顺序没有影响
class Solution2 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        var stack = [root?.left, root?.right]
        while !stack.isEmpty {
            let r1 = stack.removeLast()
            let r2 = stack.removeLast()
            if r1 == nil, r2 == nil {
                continue
            }
            if r1 == nil || r2 == nil {
                return false
            }
            if r1?.val != r2?.val {
                return false
            }
            stack.append(r1?.left)
            stack.append(r2?.right)
            stack.append(r1?.right)
            stack.append(r2?.left)
        }
        return true
    }
}