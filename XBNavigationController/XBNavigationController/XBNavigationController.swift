//
//  XBNavigationController.swift
//  ZGSwiftTest
//
//  Created by chenxingbin on 2018/4/23.
//  Copyright © 2018年 chenxingbin. All rights reserved.
//

import UIKit


class XBWrapController : UIViewController{
    
    lazy var rootViewController : UIViewController = {
        let wrapNavigationController = self.childViewControllers.first;
        return (wrapNavigationController?.childViewControllers.first)!;
    }()
    
    
    override var hidesBottomBarWhenPushed: Bool{
        get {return self.rootViewController.hidesBottomBarWhenPushed}
        set {super.hidesBottomBarWhenPushed = newValue}
    }
    
    override var title: String?{
        get {return self.rootViewController.title}
        set {super.title = newValue}
    }

    override var childViewControllerForStatusBarStyle: UIViewController?{
        get {return self.rootViewController}
    }
    
}



extension String{
    func abc(str : String)->String?{
        return nil
    }
}


class XBNavigationController: UINavigationController {
    
    weak var  rootNavigationController: XBNavigationController?
    

    // MARK: 重写
    convenience override init(rootViewController: UIViewController) {
        self.init();
        self.viewControllers = [self.wrapNavigationController(viewController: rootViewController)] as! [UIViewController];
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.rootNavigationController != nil) {
            self.rootNavigationController?.pushViewController(viewController, animated: animated);
        }else{
          
            if self.childViewControllers.count > 0 {
                self .configDefaultLeftBArItem(viewController: viewController)
            }
            super .pushViewController(self.wrapNavigationController(viewController: viewController)!, animated: animated)
        }
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if (self.rootNavigationController != nil) {
            return self.rootNavigationController!.popViewController(animated: animated)
        }else{
            let popedController = super.popViewController(animated: animated);
            return self.debagNavigationController(viewController: popedController);
        }
    }
    
    
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        
        if (self.rootNavigationController != nil) {
            return self.rootNavigationController!.popToViewController(viewController, animated: animated)
        }else{
            let wrapController = viewController.navigationController?.parent;
            var vc = viewController;
            if (wrapController?.isMember(of: XBWrapController.self))!{
                vc = wrapController!;
            }
            if self.childViewControllers.contains(vc) == false {
                return nil;
            }
            let controllers = super.popToViewController(vc, animated: animated)
            return (self.debagNavigationController(viewControllers: controllers) as! [UIViewController])
        }
    }
    
    
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if (self.rootNavigationController != nil) {
            return self.rootNavigationController?.popToRootViewController(animated: animated)
        }else{
            let controllers = super.popToRootViewController(animated: animated)
            return self.debagNavigationController(viewControllers: controllers) as? [UIViewController]
        }
        
    }
    
    override var viewControllers: [UIViewController]{
        get {
            if (self.rootNavigationController != nil) {
                return (self.rootNavigationController?.viewControllers)!;
            }else{
                let viewControllers = super.viewControllers
                return self.debagNavigationController(viewControllers: viewControllers)! as! [UIViewController]
            }
        }
        set{
            super.viewControllers = newValue
        }
    }
    
    
    override var visibleViewController: UIViewController?{
        get {
            if (self.rootNavigationController != nil) {
                return (self.rootNavigationController?.visibleViewController)!;
            }else{
                let visibleViewController = super.visibleViewController
                return self.debagNavigationController(viewController: visibleViewController)
            }
        }
        
    }
    
    
    
    override var delegate: UINavigationControllerDelegate?{
        get {
            if (self.rootNavigationController != nil) {
                return self.rootNavigationController?.delegate;
            }else{
                return super.delegate
            }
        }
        set {
            if (self.rootNavigationController != nil){
                self.rootNavigationController?.delegate = newValue;
            }else{
                super.delegate = newValue;
            }
        }
    }
    
    
    override var interactivePopGestureRecognizer: UIGestureRecognizer?{
        get {
            if (self.rootNavigationController != nil) {
                return self.rootNavigationController?.interactivePopGestureRecognizer;
            }else{
                return super.interactivePopGestureRecognizer;
            }
        }
    }
    
    
    override var isToolbarHidden: Bool{
        get {
            if (self.rootNavigationController != nil) {
                return (self.rootNavigationController?.isToolbarHidden)!;
            }else{
                return super.isToolbarHidden;
            }
        }
        set {
            if (self.rootNavigationController != nil) {
                self.rootNavigationController?.isToolbarHidden  = newValue;
            }else{
                super.isToolbarHidden = newValue
            }
        }
    }
    
    
    
    override var toolbar: UIToolbar!{
        get {
            if (self.rootNavigationController != nil) {
                return self.rootNavigationController?.toolbar;
            }else{
                return super.toolbar;
            }
        }
    }
    
    
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if (self.rootNavigationController != nil) {
           
            if(super.viewControllers.count > 0){
                var temp = [UIViewController]()
                
                    viewControllers.forEach { (vc) in
                    let v = self.wrapNavigationController(viewController: vc);
                    if ((v) != nil){
                        temp.append(v!);
                    }
                }
                return (self.rootNavigationController?.setViewControllers(temp, animated: animated))!
                
            }
            
        }
        
        super .setViewControllers(viewControllers, animated: animated)
    }
    
    
    
    override func viewWillLayoutSubviews() {
        if (self.rootNavigationController == nil) {
            if(self.navigationBar.isHidden == false){
                self.navigationBar.isHidden = true;
            }
        }
        super.viewWillLayoutSubviews()
    }
    
 
    
     // MARK: private
    func configDefaultLeftBArItem(viewController:UIViewController!) -> Void{
        var rootViewControler = viewController;
        if viewController .isKind(of: UINavigationController.self){
            rootViewControler = viewController.childViewControllers.first!;
            if (rootViewControler?.isMember(of: XBWrapController.self))! {
                rootViewControler = rootViewControler?.childViewControllers.first;
                rootViewControler = rootViewControler?.childViewControllers.first;
            }
        }
        if ((rootViewControler?.navigationItem.leftBarButtonItem) == nil) {
            let leftItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action:#selector(XBNavigationController.onLeftBarItemClick(sender:)))
            rootViewControler?.navigationItem.leftBarButtonItem = leftItem;
        }
        
    }
    
    @objc func onLeftBarItemClick(sender:AnyObject){
        self.popViewController(animated: true)
    }
    
    
    
    
    //包裹一层带有控制器导航栏的XBNavigationController控制器
    func wrapNavigationController(viewController:UIViewController!) -> UIViewController?{
        if viewController.isMember(of: XBWrapController.self) {
            return viewController;
        }
        let wrapViewController = XBWrapController();
        var navigaionControllerClass = type(of:self);
        
        
        var vc = viewController;
        if viewController.isKind(of: UINavigationController.self) {
            assert(viewController.isKind(of: XBNavigationController.self));
            let naviC = viewController as! XBNavigationController;
            vc = self.debagNavigationController(viewController: naviC.childViewControllers.first);
            navigaionControllerClass = type(of: naviC);
        }
        let navigationController = navigaionControllerClass.init();
        navigationController.rootNavigationController = self;
        navigationController.viewControllers = [vc] as! [UIViewController];
        
        wrapViewController.view.addSubview(navigationController.view);
        wrapViewController.addChildViewController(navigationController);
        return wrapViewController;
    }
    
    //解析一个XBWrapController的控制器
    func debagNavigationController(viewController:UIViewController?) -> UIViewController? {
        guard let vc = viewController else {
            return nil;
        }
        if (vc.isMember(of: XBWrapController.self)) {
            let wrapViewController  = vc as! XBWrapController;
            return wrapViewController.rootViewController;
        }
        return nil;
    }
    
    
    func debagNavigationController(viewControllers : [UIViewController?]?) -> [UIViewController?]?{
        guard let array = viewControllers else {
            return nil
        }
        if array.count <= 0{
            return array;
        }
        var temp = [UIViewController?]()
        array.forEach { (vc) in
            if let final = vc{
                temp.append(debagNavigationController(viewController: final))
            }else{
                temp.append(nil)
            }
        }
        return temp;
    }
}







