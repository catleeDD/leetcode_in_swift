/*
 315. Count of Smaller Numbers After Self
 https://leetcode.com/problems/count-of-smaller-numbers-after-self/description/
 
 You are given an integer array nums and you have to return a new counts array. The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].
 
 Example:
 
 Given nums = [5, 2, 6, 1]
 
 To the right of 5 there are 2 smaller elements (2 and 1).
 To the right of 2 there is only 1 smaller element (1).
 To the right of 6 there is 1 smaller element (1).
 To the right of 1 there is 0 smaller element.
 Return the array [2, 1, 1, 0].
 */


// MergeSort
// http://m.blog.csdn.net/morewindows/article/details/8029996
// https://www.hrwhisper.me/leetcode-count-of-smaller-numbers-after-self/
// https://discuss.leetcode.com/topic/31554/11ms-java-solution-using-merge-sort-with-explanation
// 思想是每拿出左边的数就可以跟右边已经拿出来的数构成一个逆序数对，此时设值左边数的count为所有拿出来的数的个数（微软那个逆序数的题是每拿出右边的数都可以跟左边所有数构成逆序数对，因为该题求的是所有逆序数对个数而不是针对每个数的逆序数个数）
// 跟Discussion中不同的是该方法利用数据结构来保存所有元素的index和count，避开了复杂的index排序

class Solution {
    private struct Node {
        let val: Int
        let index: Int //保存之前数组的index，为了之后取出count结果
        var count: Int //该元素的逆序数对个数
        init(_ index: Int, _ val: Int) {
            self.val = val
            self.index = index
            self.count = 0
        }
    }
    
    private func combine(_ myNums: inout [Node], _ left: Int, _ mid: Int, _ right: Int, _ temp: inout [Node]) {
        var i = left, j = mid + 1
        var t = 0
        var rightCount = 0
        while i <= mid, j <= right {
            if myNums[i].val <= myNums[j].val {
                temp[t] = myNums[i]
                temp[t].count += rightCount
                i+=1
            } else {
                temp[t] = myNums[j]
                rightCount+=1
                j+=1
            }
            t+=1
        }
        while i <= mid {
            temp[t] = myNums[i]
            temp[t].count += rightCount
            i+=1
            t+=1
        }
        while j <= right {
            temp[t] = myNums[j]
            j+=1
            t+=1
        }
        for i in 0..<t {
            myNums[left+i] = temp[i]
        }
    }
    
    private func mergeSort(_ myNums: inout [Node], _ left: Int, _ right: Int, _ temp: inout [Node]) {
        if left < right {
            let mid = left + (right - left) / 2
            mergeSort(&myNums, left, mid, &temp)
            mergeSort(&myNums, mid+1, right, &temp)
            combine(&myNums, left, mid, right, &temp)
        }
    }
    
    func countSmaller(_ nums: [Int]) -> [Int] {
        var myNums: [Node] = nums.enumerated().map { (index, val) -> Node in
            return Node(index, val)
        }
        var temp: [Node] = myNums // temp 是为了减少每次创建数组对象的开销
        mergeSort(&myNums, 0, nums.count - 1, &temp)
        var ans = Array<Int>(repeating: 0, count: nums.count)
        for node in myNums {
            ans[node.index] = node.count
        }
        return ans
    }
}


// Binary indexed tree(Fenwick tree) 树状数组
// 思路：把数组内每个数的名次数组找出来，然后从后往前遍历名次数组，每次求（1~名次）范围的累加和，并把对应的名次加一
// http://www.cnblogs.com/whensean/p/6851018.html
// https://www.hrwhisper.me/leetcode-count-of-smaller-numbers-after-self/

class Solution1 {
    // 注意索引是从1开始的
    class FenwickTree {
        private var sums: [Int]
        private var n: Int
        init(_ size: Int) {
            self.n = size
            self.sums = Array<Int>(repeating: 0, count: size+1)
        }
        // x的二进制的最后一位1表示的数
        private func lowbit(_ x: Int) -> Int {
            return x & (-x)
        }
        func add(_ x: Int, _ val: Int) {
            var x = x
            while x <= n {
                sums[x] += val
                x += lowbit(x)
            }
        }
        func sum(_ x: Int) -> Int {
            var x = x
            var res = 0
            while x > 0 {
                res += sums[x]
                x -= lowbit(x)
            }
            return res
        }
    }
    
    func countSmaller(_ nums: [Int]) -> [Int] {
        var temp = nums.sorted()
        var map = [Int: Int]() // 或者直接用indexOf算出index的数组也行
        for i in 0..<temp.count {
            map[temp[i]] = i + 1
        }
        let tree = FenwickTree(nums.count)
        var ans = Array<Int>(repeating: 0, count: nums.count)
        for i in (0..<nums.count).reversed() {
            ans[i] = tree.sum(map[nums[i]]!-1)
            tree.add(map[nums[i]]!, 1)
        }
        return ans
    }
}

// Segment Tree 线段树。跟树状数组一样的思路
// http://www.cnblogs.com/lasclocker/p/5024420.html
// http://www.cnblogs.com/lasclocker/p/4979933.html


class Solution2 {
    class SegmentTreeNode {
        let start: Int
        let end: Int
        var sum: Int
        var ltree: SegmentTreeNode?
        var rtree: SegmentTreeNode?
        init(_ s: Int, _ e: Int) {
            start = s
            end = e
            sum = 0
        }
    }
    
    class SegmentTree {
        var root: SegmentTreeNode
        
        init(_ nums: [Int]) {
            root = SegmentTree.buildTree(nums, 0, nums.count - 1)
        }
        
        private static func buildTree(_ nums: [Int], _ left: Int, _ right: Int) -> SegmentTreeNode {
            let root = SegmentTreeNode(left, right)
            if left == right {
                root.sum = nums[left]
            } else {
                let mid = left + (right - left)/2
                root.ltree = buildTree(nums, left, mid)
                root.rtree = buildTree(nums, mid+1, right)
                root.sum = root.ltree!.sum + root.rtree!.sum
            }
            return root
        }
        
        func add(_ root: SegmentTreeNode, _ i: Int, _ val: Int) {
            if root.start == root.end {
                root.sum += val
            } else {
                let mid = root.start + (root.end-root.start)/2
                if i <= mid {
                    add(root.ltree!, i, val)
                } else {
                    add(root.rtree!, i, val)
                }
                root.sum = root.ltree!.sum + root.rtree!.sum
            }
        }
        
        func sumRange(_ root: SegmentTreeNode, _ i: Int, _ j: Int) -> Int {
            if root.start == i, root.end == j {
                return root.sum
            } else {
                let mid = root.start + (root.end - root.start)/2
                if j <= mid {
                    return sumRange(root.ltree!, i, j)
                } else if i > mid {
                    return sumRange(root.rtree!, i, j)
                } else {
                    return sumRange(root.ltree!, i, root.ltree!.end) + sumRange(root.rtree!, root.rtree!.start, j)
                }
            }
        }
    }

    func countSmaller(_ nums: [Int]) -> [Int] {
        var temp = nums.sorted()
        var map = [Int: Int]() // 或者直接用indexOf算出index的数组也行
        for i in 0..<temp.count {
            map[temp[i]] = i + 1
        }
        //注意要+1
        let tree = SegmentTree(Array<Int>(repeating: 0, count: nums.count+1))
        let root = tree.root
        var ans = Array<Int>(repeating: 0, count: nums.count)
        for i in (0..<nums.count).reversed() {
            ans[i] = tree.sumRange(root, 0, map[nums[i]]!-1)
            tree.add(root, map[nums[i]]!, 1)
        }
        return ans
    }
}

// Binary Search 其实这个方法是O（n^2）的，因为插入数组需要O（n）
// https://leetcode.com/problems/count-of-smaller-numbers-after-self/discuss/
class Solution3 {
    func countSmaller(_ nums: [Int]) -> [Int] {
        var ans = Array<Int>(repeating: 0, count: nums.count)
        var sortedNums = [Int]()
        for i in (0..<nums.count).reversed() {
            ans[i] = findIndex(sortedNums, nums[i])
            sortedNums.insert(nums[i], at: ans[i])
        }
        return ans
    }
    
    private func findIndex(_ sortedNums: [Int], _ target: Int) -> Int {
        var i = 0, j = sortedNums.count
        while i < j {
            let mid = i + (j - i) / 2
            if sortedNums[mid] < target {
                i = mid + 1
            } else {
                j = mid
            }
        }
        return j
    }
}

// Binary Search Tree
// http://www.cnblogs.com/grandyang/p/5078490.html
// http://www.cnblogs.com/yrbbest/p/5068550.html
class Solution4 {
    private class Node {
        let val: Int
        var count: Int //比当前节点值小的所有节点的个数
        var left: Node?
        var right: Node?
        init(_ val: Int) {
            self.val = val
            self.count = 1
        }
    }
    
    private func insertNode(_ root: Node, _ val: Int) -> Int {
        var thisCount = 0
        var root: Node? = root
        while let r = root {
            if val <= r.val {
                r.count += 1
                if r.left == nil {
                    r.left = Node(val)
                    break
                } else {
                    root = r.left
                }
            } else {
                thisCount += r.count
                if r.right == nil {
                    r.right = Node(val)
                    break
                } else {
                    root = r.right
                }
            }
        }
        return thisCount
    }
    
    func countSmaller(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        var ans = Array<Int>(repeating: 0, count: nums.count)
        let root = Node(nums[nums.count-1])
        for i in (0..<nums.count-1).reversed() {
            ans[i] = insertNode(root, nums[i])
        }
        return ans
    }
}



Solution2().countSmaller([5, 2, 6, 1])
Solution3().countSmaller([5, 2, 6, 1])
Solution4().countSmaller([5, 2, 6, 1])
//Solution3().countSmaller([-1,-1,-1])
//Solution2().countSmaller([-1,-1,-1])






