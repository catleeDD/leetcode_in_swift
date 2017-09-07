/*
 4. Median of Two Sorted Arrays
 https://leetcode.com/problems/median-of-two-sorted-arrays/description/
 
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Example 1:
 nums1 = [1, 3]
 nums2 = [2]
 
 The median is 2.0
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]
 
 The median is (2 + 3)/2 = 2.5
 */

// kth num 解法 o(log(m+n))
class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let l = (nums1.count+nums2.count+1) / 2
        let r = (nums1.count+nums2.count+2) / 2
        // 很巧妙，不管奇偶都管用
        return (Double(findKth(nums1, nums2, l)) + Double(findKth(nums1, nums2, r))) / 2.0
    }
    
    private func findKth(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Int {
        if nums1.count > nums2.count {
            return findKth(nums2, nums1 ,k)
        }
        if nums1.count == 0 {
            return nums2[k-1]
        }
        if k == 1 {
            return min(nums1[0], nums2[0])
        }
        let pa = min(nums1.count, k/2)
        let pb = k - pa
        if nums1[pa-1] < nums2[pb-1] {
            return findKth(Array(nums1[pa..<nums1.count]), nums2, k - pa)
        } else {
            return findKth(nums1, Array(nums2[pb..<nums2.count]), k - pb)
        }
    }
}

Solution().findMedianSortedArrays([1,3], [2])
Solution().findMedianSortedArrays([1,2], [3,4])

// 还有一种o(log(min(m,n))) 解法，比较难理解