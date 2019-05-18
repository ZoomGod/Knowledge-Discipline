//
//  HomePageViewController.swift
//  Knowledge Discipline
//
//  Created by 朱敏 on 2019/5/18.
//  Copyright © 2019 Ora. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomePageViewController: UIViewController {

    //MARK:- 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: 200, width: kScreenW, height: kTitleViewH)
        let titles = ["精华区","全部帖子","贡献榜"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {
        //确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: 200 + kTitleViewH, width: kScreenW, height: contentH)
        
        //确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childvcs: childVcs, parentViewController:self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.8724850171)
        
    }
}
