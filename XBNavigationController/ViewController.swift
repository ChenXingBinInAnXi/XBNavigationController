//
//  ViewController.swift
//  XBNavigationController
//
//  Created by chenxingbin on 2018/6/11.
//  Copyright © 2018年 chenxingbin. All rights reserved.
//

import UIKit


extension UIColor {
    //返回随机颜色
    open class var randomColor:UIColor{
        get{
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

class ViewController: UIViewController {

    
    //导航栏返回键：默认为”返回“，可自定义，会覆盖默认设置
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          self.view.backgroundColor = UIColor.randomColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

