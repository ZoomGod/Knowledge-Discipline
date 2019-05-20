//
//  PageContentView.swift
//  Knowledge Discipline
//
//  Created by 朱敏 on 2019/5/18.
//  Copyright © 2019 Ora. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK:- 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    
    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs :[UIViewController], parentViewController : UIViewController?) {
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
            parentViewController?.addChild(childVc)
        }
        //添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDAtaSourse
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    

}

//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
