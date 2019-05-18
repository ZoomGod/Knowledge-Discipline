//
//  PageContentView.swift
//  Knowledge Discipline
//
//  Created by 朱敏 on 2019/5/18.
//  Copyright © 2019 Ora. All rights reserved.
//

import UIKit

class PageContentView: UIView {

    //MARK:- 定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    
    init(frame: CGRect, childVcs :[UIViewController], parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension PageContentView {
    private func setupUI() {
        //将所有子控制器加入父控制器中
        for childVc in childVcs {
            parentViewController.addChild(childVc)
        }
    }
}
