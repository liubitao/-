//
//  ViewController.swift
//  test
//
//  Created by TQ on 2019/8/6.
//  Copyright © 2019 TQ. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let arr = [2,4,5,6,3,1,9,7,8]
        /***** 冒泡  **/
        //        let sortArr = self.bubbleSort(arr: arr)
        
        /***** 选择  **/
        //        let sortArr = self.optimizeChoiceSort(arr: arr)
        
        /***** 插入 **/
        //        let sortArr = self.optimizeInsertionSort(arr: arr)
        
        /***** 希尔  **/
//        let sortArr = self.shellSort()
        /***** 归并  **/
//        let sortArr = self.insertionSort(arr: arr, left: 0, right: arr.count-1)
        /***** 快排  **/
//        let sortArr = self.quickRecursiveSort(arr, leftBound: 0, rightBound: arr.count - 1)
        
        /***** 计数  **/
        let sortArr = self.countSort(arr: arr)
        
        print("\(sortArr)")
    }
    
    
    
    // MARK: -------------------------
    // MARK: 冒泡（时间复杂程度 O(n^2） 最多的时候O(n^2） 最少O(n）） 空间复杂程度 O(1) 稳定
    /***** 冒泡排序  **/
    func bubbleSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = sortArr.count
        for i in 0..<count{
            for j in 0..<count-i-1{
                if sortArr[j] > sortArr[j+1] {
                    sortArr.swapAt(j, j+1)
                }
            }
        }
        
        return sortArr
    }
    
    /***** 优化冒泡排序  **/
    func optimizeBubbleSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = sortArr.count
        for i in 0..<count{
            var sorted = false
            for j in 0..<count-i-1{
                if sortArr[j] > sortArr[j+1] {
                    sortArr.swapAt(j, j+1)
                    sorted = true
                }
            }
            
            if sorted == false {
                break
            }
        }
        
        return sortArr
    }
    
    // MARK: -------------------------
    // MARK: 选择 （时间复杂程度 O(n^2） 最多的时候O(n^2） 最少O(n^2）） 空间复杂程度 O(1) 不稳定
    /***** 选择排序  **/
    func choiceSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = sortArr.count
        for i in 0..<count {
            var minIndex = i
            for j in i..<count {
                if sortArr[minIndex] > sortArr[j] {
                    minIndex = j
                }
            }
            sortArr.swapAt(minIndex, i)
        }
        return sortArr
    }
    
    /***** 优化选择排序  **/
    func optimizeChoiceSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = sortArr.count
        for i in 0..<count/2 {
            var minIndex = i
            var maxIndex = i
            for j in i..<count-i {
                minIndex = sortArr[minIndex] > sortArr[j] ? j : minIndex
                maxIndex = sortArr[maxIndex] < sortArr[j] ? j : maxIndex
            }
            /***** 当最大的值和最小的值刚好是数组的两个对应端的时候  **/
            if minIndex == count - 1 - i && maxIndex == i {
                sortArr.swapAt(minIndex, i)
            }else{
                sortArr.swapAt(minIndex, i)
                sortArr.swapAt(maxIndex, count - 1 - i)
            }
        }
        return sortArr
    }
    
    
    // MARK: -------------------------
    // MARK: 插入 （时间复杂程度 O(n^2） 最多的时候O(n^2） 最少O(n）） 空间复杂程度 O(1) 稳定
    func insertionSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = arr.count
        for i in 0..<count {
            for j in stride(from: i, to: 0, by: -1) {
                if sortArr[j] < sortArr[j-1] {
                    sortArr.swapAt(j, j-1)
                }
            }
        }
        return sortArr
    }
    
    func optimizeInsertionSort(arr: [Int]) -> [Int] {
        var sortArr = arr
        let count = arr.count
        for i in 0..<count {
            var index = i
            let temp = sortArr[i]
            for j in stride(from: i, to: 0, by: -1) {
                if temp < sortArr[j-1] {
                    index = j-1
                    sortArr[j] = sortArr[j-1]
                }
            }
            sortArr[index] = temp
        }
        return sortArr
    }
    
    // MARK: -------------------------
    // MARK: 希尔排序 （时间复杂程度 O(n^1.3） 最多的时候O(n^2） 最少O(n）） 空间复杂程度 O(1) 不稳定
    
    var data: [Int] = [2,4,5,6,3,1,9,7,8,10]
    func shellSort() -> [Int] {
        
        self.recursiveShellSort(incremental: data.count/2)
        data = self.insertionSort(arr: data)
        return data
    }
    
    func recursiveShellSort(incremental: Int){
        if incremental == 0 {
            return
        }
        for index in 0..<data.count - incremental {
            let a = data[index]
            let b = data[index + incremental]
            if a > b{
                data.swapAt(index, index + incremental)
            }
        }
        self.recursiveShellSort(incremental: incremental/2)
    }
    
    
    // MARK: -------------------------
    // MARK: 归并排序 （时间复杂程度 O(nlog2n） 最多的时候O(nlog2n） 最少O(nlog2n）） 空间复杂程度 O(n) 稳定
    func megerRecursiveSort(arr: [Int], left: Int, right: Int) -> [Int]{
        if left == right {
            return arr
        }
        
        let mid = left + (right - left)/2
        print("\(mid)")
        var arr = megerRecursiveSort(arr: arr, left: left, right: mid)
        
        arr = megerRecursiveSort(arr: arr, left: mid + 1, right: right)
        
        return megerSort(arr: arr, leftPtr: left, rightPtr: mid + 1, rightBound: right)
    }
    
    
    /// - Parameters:
    ///   - leftPtr: 左边起点
    ///   - rightPtr: 右边的起点
    ///   - rightBound: 右边终点
    func megerSort(arr: [Int], leftPtr: Int, rightPtr: Int, rightBound: Int) -> [Int] {
        var sortArr = arr
        var leftPtr = leftPtr
        var rightPtr = rightPtr
        let mid = rightPtr - 1
        var k = leftPtr
        while leftPtr <= mid && rightPtr <= rightBound {
            if arr[leftPtr] < arr[rightPtr] {
                sortArr[k] = arr[leftPtr]
                k+=1
                leftPtr+=1
            }else{
                sortArr[k] = arr[rightPtr]
                k+=1
                rightPtr+=1
            }
        }
        
        while leftPtr <= mid {
            sortArr[k] = arr[leftPtr]
            k+=1
            leftPtr+=1
        }
        while rightPtr <= rightBound {
            sortArr[k] = arr[rightPtr]
            k+=1
            rightPtr+=1
        }
        return sortArr
    }
    
    // MARK: -------------------------
    // MARK: 快速排序 （时间复杂程度 O(nlog2n） 最多的时候O(n^2） 最少O(nlog2n）） 空间复杂程度 O(nlog2n) 稳定
    func quickRecursiveSort(_ arr: [Int], leftBound: Int, rightBound: Int) -> [Int] {
        if leftBound >= rightBound {
            return arr
        }
        let (sortArr, mid) =  self.quickSort(arr: arr, leftBound: leftBound, rightBound: rightBound)
            
        let leftArr = self.quickRecursiveSort(sortArr, leftBound: leftBound, rightBound: mid)
        let rightArr =  self.quickRecursiveSort(leftArr, leftBound: mid + 1, rightBound: rightBound)
        
        return rightArr
    }
    
    /*****
     1.两端交换
     2.两端扫描，一端留坑，一端填坑
     3.一端扫描，
     **/
    func quickSort(arr: [Int], leftBound: Int, rightBound: Int) -> ([Int],Int) {
        let anchor = arr[rightBound]
        
        var sortArr = arr
        
        var leftPtr = leftBound
        var rightPtr = rightBound - 1
        while leftPtr < rightPtr {
            if sortArr[leftPtr] > anchor && sortArr[rightPtr] <= anchor {
                sortArr.swapAt(leftPtr, rightPtr)
                leftPtr+=1
                rightPtr-=1
                
                print("\(leftPtr), \(rightPtr)")
            }
            
            if sortArr[leftPtr] <= anchor {
                leftPtr+=1
                print("\(leftPtr), \(rightPtr)")
            }
            if sortArr[rightPtr] > anchor{
                rightPtr-=1
                print("\(leftPtr), \(rightPtr)")
            }
        }
        
        if rightPtr+1 != rightBound {
            sortArr.swapAt(leftPtr, rightBound)
        }
        print("--------(\(sortArr)")
        return (sortArr,leftPtr)
    }
    
    // MARK: -------------------------
    //k 是数据范围的大小
    // MARK: 计数排序 （时间复杂程度 O(n+k） 最多的时候O(n+k） 最少O(n+k）） 空间复杂程度 O(n+k) 稳定
    func countSort(arr: [Int]) -> [Int] {
        var countArr = Array<Int>.init(repeating: 0, count: 10)
        var sortArr = arr
        for i in arr {
            countArr[i]+=1
        }
        var j = 0
        for (value, count) in countArr.enumerated() {
            for _ in 0..<count {
                sortArr[j] = value
                j+=1
            }
        }
        return sortArr
    }
    
    
}

