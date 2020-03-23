import UIKit

// 437. Path Sum III

// https://leetcode-cn.com/problems/path-sum-iii/



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
 

// 时间 O nlogn 空间 O logn
class Solution {

    func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
        guard let r = root else { return 0 }
        var num = 0
        num += _pathLineSume(r, sum)
        num += pathSum(r.left, sum)
        num += pathSum(r.right, sum)
        return num
    }
    // 必须成一条线
    func _pathLineSume(_ root: TreeNode?, _ sum: Int) -> Int {
        guard let r = root else { return 0 }
        let val = r.val
        var num = 0
        if val == sum {
            num += 1
        }
        num += _pathLineSume(r.left, sum-val)
        num += _pathLineSume(r.right, sum-val)
        return num
    }
}


// 上面的方法貌似有大量重复计算？
// 可以用存路径和到一个字典中来减少重复计算，注意需要使用dfs+回溯
// https://leetcode-cn.com/problems/path-sum-iii/solution/liang-chong-fang-fa-jian-dan-yi-dong-ban-ben-by-a3/
// 不太能想到，也不知道这样做到底优化在哪，后面返回来再看下
