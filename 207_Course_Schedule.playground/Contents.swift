/*
 207. Course Schedule
 
 https://leetcode.com/problems/course-schedule/description/
 
 There are a total of n courses you have to take, labeled from 0 to n - 1.
 
 Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]
 
 Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?
 
 For example:
 
 2, [[1,0]]
 There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.
 
 2, [[1,0],[0,1]]
 There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 
 Note:
 The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.
 You may assume that there are no duplicate edges in the input prerequisites.
 click to show more hints.
 
 Hints:
 This problem is equivalent to finding if a cycle exists in a directed graph. If a cycle exists, no topological ordering exists and therefore it will be impossible to take all courses.
 Topological Sort via DFS - A great video tutorial (21 minutes) on Coursera explaining the basic concepts of Topological Sort.
 Topological sort could also be done via BFS.
 */

// dfs 也是《算法》上的方法，也是拓扑排序的dfs方法
// http://blog.csdn.net/qinzhaokun/article/details/48541117 介绍了拓扑排序的两种方法：dfs方法和Kahn法
class Solution {
    var onPath = [Bool]()
    var visited = [Bool]()
    var hasCycle = false
    
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard prerequisites.count > 0, prerequisites[0].count > 0 else {
            return true
        }
        // make graph
        var graph = Array<Array<Int>>(repeating: [], count: numCourses)
        for pair in prerequisites {
            var temp = graph[pair[1]]
            temp.append(pair[0])
            graph[pair[1]] = temp
        }
        onPath = Array<Bool>(repeating: false, count: numCourses)
        visited = Array<Bool>(repeating: false, count: numCourses)
        for i in 0..<numCourses {
            if !visited[i] {
                dfs(graph, i)
            }
        }
        return !hasCycle
    }
    
    private func dfs(_ graph: [[Int]], _ node: Int) {
        if hasCycle {
            return
        }
        onPath[node] = true
        visited[node] = true
        for neigh in graph[node] {
            if onPath[neigh] {
                hasCycle = true
                return
            }
            if !visited[neigh] {
                dfs(graph, neigh)
            }
        }
        onPath[node] = false
    }
}

// Kahn法
class Solution1 {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard prerequisites.count > 0, prerequisites[0].count > 0 else {
            return true
        }
        // make graph
        var graph = Array<Array<Int>>(repeating: [], count: numCourses)
        for pair in prerequisites {
            var temp = graph[pair[1]]
            temp.append(pair[0])
            graph[pair[1]] = temp
        }
        
        // compute indegree
        var indegrees = Array<Int>(repeating: 0, count: numCourses)
        var topoResultCount = 0 // 拓扑序列中元素个数
        var queue = [Int]()
        for neighs in graph {
            for neigh in neighs {
                indegrees[neigh] += 1
            }
        }
        
        for i in 0..<indegrees.count {
            if indegrees[i] == 0 {
                queue.append(i)
            }
        }
        while !queue.isEmpty {
            let node = queue.removeFirst()
            topoResultCount += 1
            for neigh in graph[node] {
                indegrees[neigh] -= 1
                if indegrees[neigh] == 0 {
                    queue.append(neigh)
                }
            }
        }
        return topoResultCount == numCourses
    }
}

Solution().canFinish(2, [[1,0]])
Solution1().canFinish(2, [[1,0]])
