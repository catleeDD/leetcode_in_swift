/*
 347. Top K Frequent Elements
 https://leetcode.com/problems/top-k-frequent-elements/#/description
 
 Given a non-empty array of integers, return the k most frequent elements.
 
 For example,
 Given [1,1,1,2,2,3] and k = 2, return [1,2].
 
 Note:
 You may assume k is always valid, 1 <= k <= number of unique elements.
 Your algorithm's time complexity must be better than O(n log n), where n is the array's size.
 */

// 桶排序，重复元素使用一个数组来存
// 三种非比较排序  https://segmentfault.com/a/1190000003054515?_ea=289827
class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var map = [Int: Int]()
        for num in nums {
            if let value = map[num] {
                map[num] = value + 1
            } else {
                map[num] = 1
            }
        }
        var bulket = Array<Array<Int>>(repeating: [], count: nums.count)
        for (key, value) in map {
            bulket[value - 1].append(key)
        }
        var result = [Int]()
        for i in (0..<bulket.count).reversed() {
            for value in bulket[i] {
                result.append(value)
                if result.count == k {
                    return result
                }
            }
        }
        return result
    }
}

// 优先队列（堆实现）
class Solution1 {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var map = [Int: Int]()
        for num in nums {
            if let value = map[num] {
                map[num] = value + 1
            } else {
                map[num] = 1
            }
        }
        var result = [Int]()
        var pq = Heap<(Int, Int)> { $0.1 > $1.1 }
        for (key, value) in map {
            pq.insert((key, value))
        }
        while result.count < k {
            result.append(pq.remove()!.0)
        }
        return result
    }
}

public struct Heap<T> {
    var elements = [T]()
    
    fileprivate var order: (T, T) -> Bool
    
    public init(order: @escaping (T, T) -> Bool) {
        self.order = order
    }
    
    public init(array: [T], order: @escaping (T, T) -> Bool) {
        self.order = order
        buildHeap(fromArray: array)
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    public func peek() -> T? {
        return elements.first
    }
    
    /**
     * Adds a new value to the heap. This reorders the heap so that the max-heap
     * or min-heap property still holds. Performance: O(log n).
     */
    public mutating func insert(_ value: T) {
        elements.append(value)
        swim(elements.count - 1)
    }
    
    /**
     * Removes the root node from the heap. For a max-heap, this is the maximum
     * value; for a min-heap it is the minimum value. Performance: O(log n).
     */
    @discardableResult
    public mutating func remove() -> T? {
        if elements.isEmpty {
            return nil
        } else if elements.count == 1 {
            return elements.removeLast()
        } else {
            let value = elements[0]
            elements[0] = elements.removeLast()
            sink(0)
            return value
        }
    }
    
    mutating func swim(_ index: Int) {
        var childIndex = index
        while childIndex > 0 && order(elements[childIndex], elements[(childIndex - 1) / 2]) {
            swap(&elements[childIndex], &elements[(childIndex - 1) / 2])
            childIndex = (childIndex - 1) / 2
        }
    }
    
    mutating func sink(_ index: Int) {
        var parentIndex = index
        while 2*parentIndex + 2 < elements.count {
            let leftChildIndex = 2*parentIndex + 1
            let rightChildIndex = 2*parentIndex + 2
            
            var next = parentIndex
            if leftChildIndex < elements.count && order(elements[leftChildIndex], elements[next]) {
                next = leftChildIndex
            }
            if rightChildIndex < elements.count && order(elements[rightChildIndex], elements[next]) {
                next = rightChildIndex
            }
            if next == parentIndex { break }
            
            swap(&elements[parentIndex], &elements[next])
            parentIndex = next
        }
    }
    
    // This version has O(n log n) performance.
    private mutating func buildHeap(array: [T]) {
        for value in array {
            insert(value)
        }
    }
    
    // This runs pretty much in O(n).
    private mutating func buildHeap(fromArray array: [T]) {
        elements = array
        for i in (0...elements.count / 2 - 1).reversed() {
            sink(i)
        }
    }
}

Solution1().topKFrequent([1,2], 2)
Solution1().topKFrequent([1,1,1,2,2,3], 2)
Solution1().topKFrequent([1], 1)

Solution().topKFrequent([1,2], 2)
Solution().topKFrequent([1,1,1,2,2,3], 2)
Solution().topKFrequent([1], 1)