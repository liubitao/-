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
        let sortArr = self.shellSort()
        
        print("\(sortArr)")
    }
    
    
    
    // MARK: -------------------------
    // MARK: 冒泡
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
    // MARK: 选择
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
    // MARK: 插入
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
    // MARK: 希尔排序
    
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
    
    
    
    
    
    
    
}

