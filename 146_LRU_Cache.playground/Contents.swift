/*
 146. LRU Cache
 https://leetcode.com/problems/lru-cache/#/description
 
 Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.
 
 get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
 put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.
 
 Follow up:
 Could you do both operations in O(1) time complexity?
 
 Example:
 
 LRUCache cache = new LRUCache( 2 /* capacity */ );
 
 cache.put(1, 1);
 cache.put(2, 2);
 cache.get(1);       // returns 1
 cache.put(3, 3);    // evicts key 2
 cache.get(2);       // returns -1 (not found)
 cache.put(4, 4);    // evicts key 1
 cache.get(1);       // returns -1 (not found)
 cache.get(3);       // returns 3
 cache.get(4);       // returns 4
 
 */


//The problem can be solved with a hashtable that keeps track of the keys and its values in the double linked list. One interesting property about double linked list is that the node can remove itself without other reference. In addition, it takes constant time to add and remove nodes from the head or tail.

//One particularity about the double linked list that I implemented is that I create a pseudo head and tail to mark the boundary, so that we don't need to check the NULL node during the update. This makes the code more concise and clean, and also it is good for the performance as well.

// 关键点： 1 使用dummy head 和 value 2 Node中需要有key来作为map中的索引
class Node<K, V> {
    var next: Node?
    var pre: Node?
    var key: K?
    var value: V?
    
    // 为了使用dummy只能变成可选的了
    init(key: K?, value: V?) {
        self.key = key
        self.value = value
    }
}

class DoubleLinkedList<K, V> {
    
    private var head: Node<K, V>?
    private var tail: Node<K, V>?
    
    init() {
        head = Node<K, V>(key: nil, value: nil)
        head?.pre = nil
        tail = Node<K, V>(key: nil, value: nil)
        tail?.next = nil
        head?.next = tail
        tail?.pre = head
    }
    
    // 链表都是先连接后删除，画个图就知道了
    func addToHead(_ node: Node<K, V>) {
        // 连接顺序不重要
        node.pre = head
        node.next = head?.next
        // 删除顺序重要，可以先写完再调整顺序
        head?.next?.pre = node
        head?.next = node
    }
    
    func remove(_ node: Node<K, V>) {
        // 顺序不重要
        node.pre?.next = node.next
        node.next?.pre = node.pre
    }
    
    func pop() -> Node<K, V>? {
        let temp = tail?.pre
        if let temp = temp {
            remove(temp)
        }
        return temp
    }
    
    func display() -> String {
        var description = ""
        var current = head
        
        while current != nil {
            description += "Key: \(String(describing: current?.key)) Value: \(String(describing: current?.value)) \n"
            current = current?.next
        }
        return description
    }
}


class LRUCache<K : Hashable, V> : CustomStringConvertible {
    
    let capacity: Int
    var count = 0
    
    private let queue: DoubleLinkedList<K, V>
    private var map: [K: Node<K, V>]
    
    init(_ capacity: Int) {
        self.capacity = capacity
        queue = DoubleLinkedList()
        map = [K : Node<K, V>](minimumCapacity: capacity)
    }
    
    func get(_ key: K) -> V? {
        if let node = map[key] {
            queue.remove(node)
            queue.addToHead(node)
            return node.value
        } else {
            return nil
        }
    }
    
    func put(_ key: K, _ value: V) {
        if let node = map[key] {
            node.value = value
            queue.remove(node)
            queue.addToHead(node)
        } else {
            let node = Node(key: key, value: value)
            map[key] = node
            if count < capacity {
                queue.addToHead(node)
                count += 1
            } else {
                guard let node = queue.pop(), let key = node.key else { return }
                map.removeValue(forKey: key)
                queue.addToHead(node)
            }
        }
    }
    
    subscript (key: K) -> V? {
        get {
            return get(key)
        }
        
        set(value) {
            guard let value = value else { fatalError() }
            put(key, value)
        }
    }
    
    var description : String {
        return "SwiftlyLRU Cache(\(count)) \n" + queue.display()
    }
}

let cache = LRUCache<Int, Int>( 2 /* capacity */ )

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4


