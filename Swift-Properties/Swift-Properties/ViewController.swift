//
//  ViewController.swift
//  Swift-Properties
//
//  Created by 王钱钧 on 14/11/4.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//================= 存储属性 Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    let lengt: Int
}

//================= 常量与存储属性
/*
当值类型的实例被声明为常量的时候，它的所有属性也就成了常量
当把一个引用类型的实例赋给一个常量后，仍然可以修改实例的变量属性
*/
var varRangeOfThreeItems = FixedLengthRange(firstValue: 0, lengt: 3)
let letRangeOfThreeItems = FixedLengthRange(firstValue: 0, lengt: 3)
//rangeOfThreeItems.firstValue = 3
func testConstantAndStoredProperties() {
    varRangeOfThreeItems.firstValue = 3
//    letRangeOfThreeItems.firstValue = 4   //因为letRangeOfThreeItems声明为值类型的常量
}



//================== 延迟存储属性
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

func testLazyProperties() {
    let manager = DataManager()
    manager.data.append("Some data")
    manager.data.append("Some more data")
}

//=================== 计算属性 Computed Properties
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

func testComputedProperties() {
    var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
    let initialSquareCenter = square.center
    square.center = Point(x: 10, y: 10)
}

