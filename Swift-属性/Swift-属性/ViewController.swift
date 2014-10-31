//
//  ViewController.swift
//  Swift-属性
//
//  Created by 王钱钧 on 14/10/31.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

/*

属性分为：
    1、存储属性（Store Properties）
    2、计算属性（Computed Properties）
    3、类型属性（Type Properties）
    存储属性和计算属性通常用于特定类型的实例
    类型属性可以直接用于类型本身

*/

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        lazyTest()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}


/*
================== 1 存储属性 （常量、变量） =================
*/
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)

// 常量和存储属性
func contantAndProperties() {
    //结构体属于值类型，当值类型被声明为常量的时候，它的所有属性也就成了常量
    //rangeOfFourItems.firstValue = 3;
}


// 延迟存储属性: 是指当第一次被调用的时候才会去计算其初始值的属性（lazy）
// 必须将延迟存储属性声明为变量（var），属性的值在实例构造完成之前可能无法得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明为延迟属性
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    
}
func lazyTest() {
    let manager = DataManager()
    // 由于此时importer是lazy属性，只有在用到时才会去创建它。
    manager.data.append("Some data")
    manager.data.append("Some more data")
}


//



















