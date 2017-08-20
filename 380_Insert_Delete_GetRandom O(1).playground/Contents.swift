/*
 380. Insert Delete GetRandom O(1)
 
 https://leetcode.com/problems/insert-delete-getrandom-o1/description/
 
 Design a data structure that supports all following operations in average O(1) time.
 
 insert(val): Inserts an item val to the set if not already present.
 remove(val): Removes an item val from the set if present.
 getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.
 Example:
 
 // Init an empty set.
 RandomizedSet randomSet = new RandomizedSet();
 
 // Inserts 1 to the set. Returns true as 1 was inserted successfully.
 randomSet.insert(1);
 
 // Returns false as 2 does not exist in the set.
 randomSet.remove(2);
 
 // Inserts 2 to the set, returns true. Set now contains [1,2].
 randomSet.insert(2);
 
 // getRandom should return either 1 or 2 randomly.
 randomSet.getRandom();
 
 // Removes 1 from the set, returns true. Set now contains [2].
 randomSet.remove(1);
 
 // 2 was already in the set, so return false.
 randomSet.insert(2);
 
 // Since 2 is the only number in the set, getRandom always return 2.
 randomSet.getRandom();
 */

/*
 添加和获取耗时O(1)是Array的特性，或者说是Map/Table的特性，思考下php的array就明白其实是index的mapping了。
 Random要求O(1)那就是需要知道数据结构的大小，并且保证储存的元素是相邻的。
 
 其实就是一个table/map，KEY是添加的元素，value是他储存在array中的位置；
 然后一个array和上面的table/map对应；
 再一个变量size记录总共有多少个元素，便于random.
 
 添加，直接添加到SIZE的位置，MAP里记录，SIZE++
 RANDOM，通过SIZE随便RANDOM一个数，直接从ARRAY里直接获取。
 删除，为了保证所有元素在ARRAY中是相邻的，像LIST那样。用ARRAY模拟就是删除之后，后面所有的都前移，但是要求O(1)，可以把最后一个元素和它换一下。换的时候相应的改变MAP/TABLE里的信息，删除map里本来最后一个KEY（因为我们换到前面了），最后SIZE--，使得array[size]指向的位置虽然不为空，但是是标记为删除的元素，就是刚才换过来的，而RANDOM不会影响。
 */
import Foundation

class RandomizedSet {
    
    var nums = [Int]()
    var indices = [Int: Int]()
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if indices.keys.contains(val) {
            return false
        }
        indices[val] = nums.count
        nums.append(val)
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let index = indices[val] else { return false }
        if index < nums.count - 1 {
            let last = nums[nums.count - 1]
            nums[index] = last
            indices[last] = index
        }
        indices.removeValue(forKey: val)
        nums.removeLast()
        return true
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        return nums[Int(arc4random_uniform(UInt32(nums.count)))]
    }
}

for i in 0..<100{
//    print(arc4random())
    let num = arc4random_uniform(10)
    print(num) //0~9
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * RandomizedSet obj = new RandomizedSet();
 * boolean param_1 = obj.insert(val);
 * boolean param_2 = obj.remove(val);
 * int param_3 = obj.getRandom();
 */