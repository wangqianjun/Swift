//
//  ViewController.swift
//  Swift-构造过程
//
//  Created by 王钱钧 on 14/11/5.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

// 与OC中构造器不同，Swift的构造器无需返回值

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testCustomizationInit()
//        testDelegationForValueTypes()
        testInitProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//================1 存储型属性的初始赋值
/*
类和结构体在实例创建时，必须为所有存储属性设置合适的初始值。存储属性的值不能处于一个未知的状态
*/
// 构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

func testInit() {
    var f = Fahrenheit()
}


//================2 定制化构造过程
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        self.temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.5
    }
}

// 可选属性类型
class SurveyQuestion {
    let name: String
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
        // 只要在构造过程结束前常量的值不能确定，你可以在构造过程中的任意时间点修改常量属性的值
        name = "Arthur"
    }
    
    func ask() {
        println(text)
    }
}

func testCustomizationInit() {
    let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
    //    boilingPointOfWater.temperatureInCelsius = 0
    var freezingPointWater = Celsius(fromKelvin: 273.15)
    freezingPointWater.temperatureInCelsius = 0
    
    let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
    cheeseQuestion.ask()
    cheeseQuestion.response = "Yeah, I do like cheese!"
    println(cheeseQuestion.name)
    
    //对于某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改，所以如下赋值是错误的
    //cheeseQuestion.name = "Doris"
}


//================3 默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

struct  Size {
    var width = 0.0, height = 0.0
}

func testDefaultInit() {
    // 类的默认构造器
    var item = ShoppingListItem()
    
    // 结构体的逐一成员构造器
    let twoByTwo = Size(width: 0.0, height: 2.0)
}

//================4 值类型的构造器代理
/*
构造器可以通过调用其他构造器来完成实例的部分构造过程。这一过程成为构造代理，它能减少多个构造器间的代码重复
*/
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {
        println("basic init")
    }
    
    init(origin: Point, size: Size) {
        println("origin init")
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        println("center init")
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x:originX, y:originY), size: size)
    }
    
}

func testDelegationForValueTypes() {
    let basicRect = Rect()
    let originRect = Rect(origin: Point(x:2.0, y:2.0), size: Size(width: 5.0, height: 5.0))
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
}

//================5 类的继承和构造过程
/*
类里面的所有存储属性，包括其父类的属性，都必须在构造过程中设置初始值

Swift提供两种类型的构造器：指定构造器、便利构造器
1）指定构造器，是类中最主要的构造器，每个类都必须拥有至少一个指定构造器
2）便利构造器，是类中比较次要的、辅助型构造器

构造器链三条规则
1）指定构造器必须调用其直接父类的指定构造器
2）便利构造器必须调用同一类中定义的其他构造器
3）便利构造器必须最终以调用一个指定构造器结束
指定构造器必须总是向上代理， 便利构造器必须总是横向代理

两段式构造过程
1）每个存储型属性通过引入它们的类的构造器来设置初始值
2）给每个类一次机会在新实例准备使用之前进一步定制它们的存储属性

Swift编译器将执行4种有效的安全检查，以确保两段式构造过程能顺利完成：
1）指定构造器必须保证 它所在类引入的所有属性 都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器
2）指定构造器必须先向上代理调用父类构造器，然后再为 继承的属性 设置新值
3）便利构造器必须先代理调用同一类中得其他构造器，然后再为任意属性赋新值
4）构造器在第一阶段构造完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self的值

构造器的继承和重载
和Objective-C不同，Swift中子类不会默认继承父类的构造器

*/


class People {
    var name: String
    var discription: String?
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // 便利构造器
    convenience init(name: String) {
        
        // 必须 先 代理调用同一类中其他构造器
        self.init(name: name, age: 1)
        
        // 然后才能为新属性赋新值，反之则编译错误
        self.discription = "人类"
    }
}

class Student: People {
    var number: Int
    
    //指定构造器
    init(name: String, age: Int, number: Int) {
        
        //所在类中得所有新引入的属性，必须初始化完成，才能调用父类初始化方法
        self.number = number
        
        // 必须向上代理父类的构造器
        super.init(name: name, age: age)
        
        // 必须父类构造器调用结束，才能为继承的属性赋新值
        self.name = "student arthur"
    }
    
    
    //便利构造器
    convenience init(name: String) {
        self.init(name: name, age: 1, number: 10000)
    }
    
}

func testInitProgress() {
    let arthur = People(name: "Arthur")
    let doris = People(name: "Doris", age: 23)
}

//================6 通过闭包和函数来设置属性的默认值
/*
如果某个存储型属性的默认值需要特别的定制或准备,可以使用闭包或全局函数来为其属性提供定制的默认值
每当某个属性所属的新类型实例被创建时，对应的闭包或函数会被调用，而它们的返回值会被当做默认值赋值给这个属性
*/
class SomeClass {
    
    let someProperty: String = {
        // 闭包执行时，实例的其他部分还没有被初始化，这意味着你不能访问其他属性，不能用self，或调用实例方法
        return "Arthur"
    }() // 这个小括号用来告诉Swift需要立刻执行此闭包，如果少了小括号，相当于是将闭包本身作为值赋给了属性，问不是将闭包的返回值赋给属性
}
