import UIKit


/*
 27. Remove Element
 https://leetcode-cn.com/problems/remove-element/
 
 Given an array nums and a value val, remove all instances of that value in-place and return the new length.

 Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

 The order of elements can be changed. It doesn't matter what you leave beyond the new length.

 Example 1:

 Given nums = [3,2,2,3], val = 3,

 Your function should return length = 2, with the first two elements of nums being 2.

 It doesn't matter what you leave beyond the returned length.
 Example 2:

 Given nums = [0,1,2,2,3,0,4,2], val = 2,

 Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and 4.

 Note that the order of those five elements can be arbitrary.

 It doesn't matter what values are set beyond the returned length.
 Clarification:

 Confused why the returned value is an integer but your answer is an array?

 Note that the input array is passed in by reference, which means modification to the input array will be known to the caller as well.

 Internally you can think of this:

 // nums is passed in by reference. (i.e., without making a copy)
 int len = removeElement(nums, val);

 // any modification to nums in your function would be known by the caller.
 // using the length returned by your function, it prints the first len elements.
 for (int i = 0; i < len; i++) {
     print(nums[i]);
 }

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/remove-element
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

// n2
class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var count = 0
        
        for i in 0..<nums.count {
            if nums[i] != val {
                count += 1
                let temp = nums[i]
                for j in (0 ... i).reversed() {
                    nums[j] = j == 0 ? temp : nums[j-1]
                }
            }
        }
        
        return count
    }
    
    
}


// n 前后指针
class Solution2 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var count = nums.count
        var i = 0, j = nums.count - 1
        while i <= j {
            if nums[i] == val {
                while i < j {
                    if nums[j] != val {
                        nums.swapAt(i, j)
                        j -= 1
                        break
                    }
                    j -= 1
                }
            }
            i += 1
        }
        
        i = nums.count-1
        while i >= 0 && nums[i] == val {
            count -= 1
            i -= 1
        }
        
        return count
    }
}


// n 快慢指针，自己想出的版本
class Solution3 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slow = 0
        for fast in 0..<nums.count {
            if nums[slow] == val {
                if nums[fast] != val {
                    nums.swapAt(slow, fast)
                    slow += 1
                }
            } else {
                slow += 1
            }
        }
        
        return slow
    }
}

// n 快慢指针，答案版本，非常精彩，思路是快指针遍历一遍，将不是val的值往前顺序堆积，同时有个慢指针记录前排不是val的数的长度。精彩之处在于满指针后面的值不care
// https://leetcode-cn.com/problems/remove-element/solution/yi-chu-yuan-su-by-leetcode/
class Solution4 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slow = 0
        for fast in 0..<nums.count {
            if nums[fast] != val {
                nums[slow] = nums[fast]
                slow += 1
            }
        }
        
        return slow
    }
}

// Solution2的优化版本
class Solution5 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0, j = nums.count-1
        while i <= j {
            if nums[i] == val {
                nums.swapAt(i, j)
                j -= 1
            } else {
                i += 1
            }
        }
        return i
    }
}

//[3,2,2,3] 3
//[4，1，2，3，5] 4
//[]

let s = Solution2()
var nums:[Int] = [1]
s.removeElement(&nums, 1)

nums


