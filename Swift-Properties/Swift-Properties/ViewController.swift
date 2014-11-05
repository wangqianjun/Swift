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
//        testComputedProperties()
//        testPropertyObservers()
//        testGlobalAndLocalVariables()
//        testTypeProperties()
        testFoo()
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
        
        // 便捷setter声明（newValue）
        
    }
}

// 只读计算属性（只有getter，没有setter）
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}


func testComputedProperties() {
    var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
    let initialSquareCenter = square.center
    square.center = Point(x: 10, y: 10)
    
}


//=================== 属性观察器 Property Observers （延迟属性除外）
/*
属性观察器监控和相应属性值得变化，每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同时也不例外
注意：不需要为无法重载的计算属性添加属性观察器，因为可以通过setter直接监控和响应值得变化
*/
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
           println("About to set totalSteps to \(newTotalSteps)")
        }
        
        // didSet观察器在totalSteps的值改变后被调用
        // 如果在didSet观察器里面为属性赋值，这个值会替换观察器之前设置的值
        didSet {
            if totalSteps > oldValue {
                println("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

func testPropertyObservers() {
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
}



// =================== 全局变量，局部变量 Global and Local Variables
/*
计算属性和属性观察器所描述的模式也可以用于全局变量和局部变量
*/

var globalVariable: Int = 0 {
willSet(newValue) {
    println("global variable will set new value: \(newValue)")
}

didSet {
    println("global variable did set new value: \(globalVariable)")
}

}

struct GlobalStruct {
    var var1: Int
    var var2: String
    
}

var globalStructVar: GlobalStruct = GlobalStruct(var1: 0, var2: "") {
willSet(newValue) {
    println("global struct will set new value: \(newValue.var1, newValue.var2)")
}

didSet {
    println("global struct will set new value: \(globalStructVar.var2), \(globalStructVar.var1)")
}

}

func testGlobalAndLocalVariables() {
    globalVariable = 3
    globalStructVar = GlobalStruct(var1: 1, var2: "test")
    
    var localVariable: Int = 0 {
        willSet(newValue){
            println("local variable will set new value: \(newValue)")
        }
        
        didSet {
            println("local variable did set new value: \(localVariable)")
        }
    }
    
    localVariable = 4
    
}


//======================= 类型属性 Type Properties
/*
实例的属性属于一个特定类型实例，每次类型实例化后都拥有自己的一套属性值，实例之间相互独立
也可以为类型本身定义属性，不管类型有多少个实例，这些属性只有唯一一份。

注意：
    对于值类型（结构体、枚举）可以定义存储型和计算型 类型属性
    对于类（class）则只能定义计算型类型属性
    值类型的存储型类型属性可以是变量或常量
    计算型类型属性跟实例的计算属性一样定义成变量属性
*/

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static let letStoredTypeProperty = "let value"
    static var computedTypeProperty: Int {
        get {
            return 1
        }
        
        set(newValue) {
            
        }
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static let letStoredTypeProperty = "let value"
    static var computedTypeProperty: Int {
        get {
            return 1
        }
        
        set(newValue) {
            
        }
    }

}

class SomeClass {
    //class var storedTypeProperty = "Some value" // 不支持存储型类型属性
    class var computedTypeProperty: Int {
        get {
            return 1
        }
        
        set(newValue) {
            
        }
    }
}

func testTypeProperties() {
    println(SomeStructure.storedTypeProperty)
}

//========================= 例子
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

func testFoo() {
    var leftChannel = AudioChannel()
    var rightChannel = AudioChannel()
    
    println(AudioChannel.maxInputLevelForAllChannels)
    
    leftChannel.currentLevel = 7
    
    println(AudioChannel.maxInputLevelForAllChannels)
    
    rightChannel.currentLevel = 10
    
    println(AudioChannel.maxInputLevelForAllChannels)
}



