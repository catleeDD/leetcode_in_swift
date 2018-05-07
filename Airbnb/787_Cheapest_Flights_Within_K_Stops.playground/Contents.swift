/*
 787. Cheapest Flights Within K Stops
 https://leetcode.com/problems/cheapest-flights-within-k-stops/description/
 
 There are n cities connected by m flights. Each fight starts from city u and arrives at v with a price w.
 
 Now given all the cities and fights, together with starting city src and the destination dst, your task is to find the cheapest price from src to dst with up to k stops. If there is no such route, output -1.
 
 Example 1:
 Input:
 n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
 src = 0, dst = 2, k = 1
 Output: 200
 Explanation:
 The graph looks like this:
 
 
 The cheapest price from city 0 to city 2 with at most 1 stop costs 200, as marked red in the picture.
 Example 2:
 Input:
 n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
 src = 0, dst = 2, k = 0
 Output: 500
 Explanation:
 The graph looks like this:
 
 
 The cheapest price from city 0 to city 2 with at most 0 stop costs 500, as marked blue in the picture.
 Note:
 
 The number of nodes n will be in range [1, 100], with nodes labeled from 0 to n - 1.
 The size of flights will be in range [0, n * (n - 1) / 2].
 The format of each flight will be (src, dst, price).
 The price of each flight will be in the range [1, 10000].
 k is in the range of [0, n - 1].
 There will not be any duplicated flights or self cycles.
 */

// dfs 超时
class Solution {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        var flightsOfN = Array<Array<Array<Int>>>(repeating: [[Int]](), count: n)
        for flight in flights {
            let i = flight[0]
            if flightsOfN[i].count != 0 {
                flightsOfN[i].append(flight)
            } else {
                flightsOfN[i] = [flight]
            }
        }
        var result = dfs(flightsOfN, src, dst, K)
        if result == Int.max {
            result = -1
        }
        return result
    }
    
    private func dfs(_ flights: [[[Int]]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        // 注意这句可能漏
        if src == dst {
            return 0
        }
        if 0 == K {
            var minVal = Int.max
            for flight in flights[src] {
                if flight[1] == dst {
                    minVal = min(minVal, flight[2])
                }
            }
            return minVal
        } else {
            var minVal = Int.max
            for flight in flights[src] {
                let result = dfs(flights, flight[1], dst, K-1)
                if result != Int.max {
                    minVal = min(minVal, flight[2] + result)
                }
            }
            return minVal
        }
    }
}


// dfs 优化 ：
// 1 数组变成字典，减少空数组个数，从而减少遍历次数
// 2 visited数组
// 3 剪枝（prunning）需要将至今为止的cost和ans传入作比较，如果cost+price>=result则continue遍历
// http://zxi.mytechroad.com/blog/dynamic-programming/leetcode-787-cheapest-flights-within-k-stops/
class Solution0 {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        var flightsOfN = [Int:[[Int]]]()
        for flight in flights {
            flightsOfN[flight[0], default:[[Int]]()].append([flight[1], flight[2]])
        }
        var result = Int.max
        var visited = Array<Bool>(repeating: false, count: n)
        visited[src] = true
        dfs(flightsOfN, src, dst, K, &visited, 0, &result)
        return result == Int.max ? -1 : result
    }
    
    private func dfs(_ flights: [Int:[[Int]]], _ src: Int, _ dst: Int, _ k: Int, _ visited: inout [Bool], _ cost: Int, _ result: inout Int) {
        if src == dst {
            result = cost
            return
        }
        if k < 0 || flights[src] == nil {
            return
        }
        for flight in flights[src]! {
            if visited[flight[0]] {
                continue
            }
            // prunning
            if cost + flight[1] >= result {
                continue
            }
            visited[flight[0]] = true
            dfs(flights, flight[0], dst, k - 1, &visited, cost + flight[1], &result)
            visited[flight[0]] = false
        }
    }
}

// bfs (剪枝)
class Solution2 {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        var flightsOfN = [Int:[(Int,Int)]]()
        for flight in flights {
            flightsOfN[flight[0], default:[(Int,Int)]()].append((flight[1], flight[2]))
        }
        var result = Int.max
        var queue = [(Int,Int)]()//dst, cost
        queue.append((src,0))
        var count = K+1
        while !queue.isEmpty {
            for _ in 0..<queue.count {
                let cur = queue.removeFirst()
                if cur.0 == dst {
                    result = min(result, cur.1)
                }
                if flightsOfN[cur.0] != nil {
                    for flight in flightsOfN[cur.0]! {
                        //prunning
                        if cur.1 + flight.1 >= result {
                            continue
                        }
                        queue.append((flight.0, cur.1 + flight.1))
                    }
                }
            }
            count -= 1
            if count < 0 {
                break
            }
        }
        return result == Int.max ? -1 : result
    }
}

Solution2().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0)

Solution0().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
Solution0().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)
//Solution1().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
//Solution2().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
//Solution1().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)
//Solution2().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)

// 注意这是错误的，看Solution11。
class Solution1 {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        //src到当前点的最小距离
        var prices = Array<Int>(repeating: Int.max, count: n)
        prices[src] = 0
        // 注意K+1
        for _ in 0..<K+1 {
            for flight in flights {
                if prices[flight[0]] != Int.max {
                    prices[flight[1]] = min(prices[flight[1]], prices[flight[0]] + flight[2])
                }
            }
            print(prices)
        }
        return prices[dst] == Int.max ? -1 : prices[dst]
    }
}



// Bellman-Ford algorithm 正常的算法会遍历n-1遍。这个算法的原理是动态规划，每次遍历得到的结果都是最多停止K次的最短路径，最终结果是最多停止n-1次的最短路径，也就是最终的最短路径。
// 还有一点，其实真正的Bellman-Ford算法只用Solution1那样写就行了，因为最终都能算出最短路径。
class Solution11 {
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        //src到当前点的最小距离
        var prices = Array<Int>(repeating: Int.max, count: n)
        prices[src] = 0
        // 注意K+1
        for _ in 0..<K+1 {
            var temp = prices
            for flight in flights {
                if prices[flight[0]] != Int.max {
                    temp[flight[1]] = min(temp[flight[1]], prices[flight[0]] + flight[2])
                }
            }
            prices = temp
            print(prices)
        }
        return prices[dst] == Int.max ? -1 : prices[dst]
    }
}

Solution().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
Solution().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)
//Solution1().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
//Solution2().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1)
//Solution1().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)
//Solution2().findCheapestPrice(3, [[0,1,2],[1,2,1],[2,0,10]], 1, 2, 1)

Solution1().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0)
Solution11().findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0)


// https://stackoverflow.com/questions/19482317/bellman-ford-vs-dijkstra-under-what-circumstances-is-bellman-ford-better?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
// 贝尔曼-福特算法与迪科斯彻算法类似，都以松弛操作为基础，即估计的最短路径值渐渐地被更加准确的值替代，直至得到最优解。在两个算法中，计算时每个边之间的估计距离值都比真实值大，并且被新找到路径的最小长度替代。 然而，迪科斯彻算法以贪心法选取未被处理的具有最小权值的节点，然后对其的出边进行松弛操作；而贝尔曼-福特算法简单地对所有边进行松弛操作，共|V | − 1次，其中 |V |是图的点的数量。在重复地计算中，已计算得到正确的距离的边的数量不断增加，直到所有边都计算得到了正确的路径。这样的策略使得贝尔曼-福特算法比迪科斯彻算法适用于更多种类的输入。


// Dijkstra算法比较不容易想到，直接看答案吧


