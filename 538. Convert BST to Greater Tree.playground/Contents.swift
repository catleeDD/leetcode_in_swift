import UIKit

// 538. Convert BST to Greater Tree
// https://leetcode-cn.com/problems/convert-bst-to-greater-tree/




 
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
 
// 自己想出的比较笨的方法
class Solution {
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        guard let r = root else { return nil }
        // 注意这几个顺序，第1和第4不能改
        r.val += getSum(r.right)//1
        convertBST(r.right)//2
        convertBST(r.left)//3
        addValue(r.left, r.val)//4
        return r
    }
    func getSum(_ root: TreeNode?) -> Int {
        guard let r = root else { return 0 }
        return r.val + getSum(r.left) + getSum(r.right)
    }
    func addValue(_ root: TreeNode?, _ val: Int) {
        guard let r = root else { return }
        r.val += val
        addValue(r.left, val)
        addValue(r.right, val)
    }
}


// 看了答案后
// https://leetcode-cn.com/problems/convert-bst-to-greater-tree/solution/ba-er-cha-sou-suo-shu-zhuan-huan-wei-lei-jia-shu-3/

// 其实我一开始是想到了使用反中序遍历的，这样就是一个从大到小的序列，每次累加即可。但是我没有想到怎么获取右字数的最大值（也就是右子树最左边的值）。其实用一个变量来储存最大值即可！或者储存上一个结点即可！

class Solution1 {
    var sum = 0
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        guard let r = root else { return nil }
        convertBST(r.right)
        sum += r.val
        r.val = sum
        convertBST(r.left)
        return r
    }
}



// 还有个空间为O（1）的牛逼算法：线索二叉树，看答案吧
// 主要思路：还是反中序遍历，如何做到不用额外空间呢？正常我们遍历时候会将未访问的node放到栈中（不管递归还是非递归），比如这道题就是先把root放到栈里，然后遍历右子树，这样当右子树遍历完毕，就把root弹出栈，需要占用数高h的空间。而使用线索二叉树的思路，可以在准备访问右子树时，先将右子树最左边的node的left指向自己，也就是最终中序遍历列表中在当前node之前的那个节点（简称当前节点后继节点）的left指向当前node，然后遍历右子树，这样当右子树遍历完后，刚好直接就回到了当前node，（注意此时需要判断当前节点后继节点是否已经设置，如果是需要删除），就没有用额外空间。
