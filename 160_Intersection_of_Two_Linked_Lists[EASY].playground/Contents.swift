/*
 160. Intersection of Two Linked Lists
 
 https://leetcode.com/problems/intersection-of-two-linked-lists/#/description
 
 
 Write a program to find the node at which the intersection of two singly linked lists begins.
 
 
 For example, the following two linked lists:
 
 A:          a1 → a2
                    ↘
                     c1 → c2 → c3
                    ↗
 B:     b1 → b2 → b3
 begin to intersect at node c1.
 
 
 Notes:
 
 If the two linked lists have no intersection at all, return null.
 The linked lists must retain their original structure after the function returns.
 You may assume there are no cycles anywhere in the entire linked structure.
 Your code should preferably run in O(n) time and use only O(1) memory.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode: Equatable {}
public func == (l: ListNode, r: ListNode) -> Bool {
    return l.val == r.val
}

class Solution {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headB == nil || headA == nil {
            return nil
        }
        var a = headA
        var b = headB
        
        var countA = count(of: a)
        var countB = count(of: b)
        while countA > countB {
            a = a?.next
            countA -= 1
        }
        while countB > countA {
            b = b?.next
            countB -= 1
        }
        while a != b {
            a = a?.next
            b = b?.next
        }
        return a
    }
    
    private func count(of listNode: ListNode?) -> Int {
        var count = 0
        var head = listNode
        while head != nil {
            count += 1
            head = head?.next
        }
        return count
    }
}

//这道题还有一种特别巧妙的方法，虽然题目中强调了链表中不存在环，但是我们可以用环的思想来做，我们让两条链表分别从各自的开头开始往后遍历，当其中一条遍历到末尾时，我们跳到另一个条链表的开头继续遍历。两个指针最终会相等，而且只有两种情况，一种情况是在交点处相遇，另一种情况是在各自的末尾的空节点处相等。为什么一定会相等呢，因为两个指针走过的路程相同，是两个链表的长度之和，所以一定会相等。
class Solution1 {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headB == nil || headA == nil {
            return nil
        }
        var a = headA
        var b = headB
        
        while a != b {
            a = a != nil ? a?.next : headB
            b = b != nil ? b?.next : headA
        }
        return a
    }
}