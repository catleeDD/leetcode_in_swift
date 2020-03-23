import UIKit

// 19. Remove Nth Node From End of List
// https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/
// Follow up:
// Could you do this in one pass?


 public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
 }

// 一遍，空间O(n)，废弃，正常不会这样做
class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard let h = head, n > 0 else { return head }
        var newHead = head
        var dict = [Int: ListNode]()
        var node:ListNode? = h
        var i = 0
        while node != nil {
            dict[i]=node!
            i+=1
            node = node?.next
        }
        if i==n {
            newHead=head?.next
        }
        if i>n {
            dict[i-n-1]!.next=dict[i-n]!.next
        }
        return newHead
    }
}

// 一遍，空间O(1)，使用两个指针
class Solution2 {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil, n > 0 else { return head }
        let dummy:ListNode? = ListNode(0)
        dummy?.next=head
        var first = dummy
        var second = dummy
        for _ in 0...n {
            first=first?.next//3
        }
        while first != nil {
            first = first?.next
            second = second?.next
        }
        second?.next = second?.next?.next
        return dummy?.next
    }
}

// 1->2->3->4->5, and n = 2. => 1->2->3->5.
// i=5 n=2 5-2
