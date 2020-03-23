import UIKit
// 543. Diameter of Binary Tree
// https://leetcode-cn.com/problems/diameter-of-binary-tree/


  
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
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if root?.left == nil && root?.right == nil {
            return 0
        }
        var sumWithRoot = 0
        sumWithRoot += (root?.left != nil) ? 1 + maxPathFrom(root?.left) : 0
        sumWithRoot += (root?.right != nil) ? 1 + maxPathFrom(root?.right) : 0
        return max(diameterOfBinaryTree(root?.left), diameterOfBinaryTree(root?.right), sumWithRoot)
    }

    func maxPathFrom(_ root: TreeNode?) -> Int {
        if root?.left == nil && root?.right == nil {
            return 0
        }
        return 1 + max(maxPathFrom(root?.left), maxPathFrom(root?.right))
    }
}


// 看答案 https://leetcode-cn.com/problems/diameter-of-binary-tree/solution/er-cha-shu-de-zhi-jing-by-leetcode-solution/
// 任何一个path都一定经过一个root和左右子树
// 使用一个全局变量记录最大值，不用判断经过root还是不经过root
// 在计算深度的时候顺便把以每一个节点为root的path都给算一下，跟全局最大值进行比较、更新最大值
class Solution2 {
    var ret = 0
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        depth(root)
       return ret
    }

    func depth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let L = depth(root?.left)
        let R = depth(root?.right)
        ret = max(ret, L+R)
        return 1 + max(L, R)
    }
}
