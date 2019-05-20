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
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: 200, width: kScreenW, height: kTitleViewH)
        let titles = ["精华区","全部帖子","贡献榜"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        //确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: 200 + kTitleViewH, width: kScreenW, height: contentH)
        
        //确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
}


//MARK:- 遵守PageTitleViewDelegate协议
extension HomePageViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int){
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
