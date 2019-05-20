//
//  PageTitleView.swift
//  Knowledge Discipline
//
//  Created by 朱敏 on 2019/5/18.
//  Copyright © 2019 Ora. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kscrollLineH : CGFloat = 2

class PageTitleView: UIView {
    
    //MARK:- 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    private lazy var titleLables : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return scrollLine
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension PageTitleView {
    private func setUI() {
        // 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的label
        setupTitleLabels()
        
        //设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kscrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            // 创建UILabel
            let label = UILabel()
            
            //设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = UIColor.black
            label.textAlignment = .center
            
            //设置label的frame

            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView
            scrollView.addSubview(label)
            titleLables.append(label)
            
            //给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupBottomLineAndScrollLine() {
        // 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        //获取第一个label
        guard let firstLabel = titleLables.first else{ return }
        firstLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        //设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
    }
}

//MARK:- 监听Label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        //获取当前Label的下标
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //获取之前的Label
        let oldLabel = titleLables[currentIndex]
        
        //切换文字的颜色
        currentLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        oldLabel.textColor = UIColor.darkGray
        
        //保存最新Label的下标
        currentIndex = currentLabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
