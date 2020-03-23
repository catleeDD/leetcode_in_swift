import UIKit

// 448. Find All Numbers Disappeared in an Array
// https://leetcode-cn.com/problems/find-all-numbers-disappeared-in-an-array/


// 脑筋急转弯类型题目
// 想不出来，看答案 https://leetcode-cn.com/problems/find-all-numbers-disappeared-in-an-array/solution/zhao-dao-suo-you-shu-zu-zhong-xiao-shi-de-shu-zi-2/
// 主要思想是利用数组全是正数这一点，用数组本身来记录索引
func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
    var nums = nums
    // 将nums[i]-1的索引的值变成负数，最后剩下的正数可以逆推出没有的数字
    for i in 0 ..< nums.count {
        let index = abs(nums[i])-1
        if nums[index] > 0 {
            nums[index] *= -1
        }
    }
    var ret:[Int] = []
    for i in 0..<nums.count {
        if nums[i] > 0 {
            ret.append(i+1)
        }
    }
    return ret
}

findDisappearedNumbers([4,3,2,7,8,2,3,1])


[5,6]
