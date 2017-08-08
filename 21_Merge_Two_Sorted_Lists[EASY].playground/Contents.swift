/*
 21. Merge Two Sorted Lists
 https://leetcode.com/problems/merge-two-sorted-lists/#/description
 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result = ListNode(0)
        var head = result
        var l1 = l1
        var l2 = l2
        while l1 != nil || l2 != nil {
            if l1 == nil {
                head.next = l2
                break
            } else if l2 == nil {
                head.next = l1
                break
            } else {
                if l1!.val < l2!.val {
                    head.next = l1
                    l1 = l1?.next
                } else {
                    head.next = l2
                    l2 = l2?.next
                }
            }
            head = head.next!
        }
        return result.next
    }
}

class Solution1 {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result = ListNode(0)
        var head = result
        var l1 = l1
        var l2 = l2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                head.next = l1
                l1 = l1?.next
            } else {
                head.next = l2
                l2 = l2?.next
            }
            head = head.next!
        }
        head.next = l1 != nil ? l1 : l2
        return result.next
    }
}