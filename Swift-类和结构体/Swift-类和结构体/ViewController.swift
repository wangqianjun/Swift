//
//  ViewController.swift
//  Swift-类和结构体
//
//  Created by 王钱钧 on 14/10/31.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


func initData() {
    // 构造器语法的最简单形式是在结构体或者类的类型名称后跟随一个空括弧，其属性均会初始化为默认值
    let someResolution = Resolution()
    let someVideoModel = VideoModel()
    
}

