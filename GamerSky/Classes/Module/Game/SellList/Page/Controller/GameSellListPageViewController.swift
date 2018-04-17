//
//  SellListPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import DNSPageView

class GameSellListPageViewController: UIViewController {
    
    // MARK: - LazyLoad
    /// 中文的日期
    private lazy var timeStrings = [String]()
    /// 毫秒(用于获取数据)
    private lazy var times = [String]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        getTime()
    }
}

// MARK: - 设置 UI 界面
extension GameSellListPageViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
    
    private func setUpNavi() {
        
        title = "发售表"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func getTime() {
        
        // 遍历出去年和今年的12个月
        (-1...0).forEach { (year) in
            
            var date = Date()
            date.add(.year, value: year)
            (1...12).forEach { (month) in
                
                timeStrings.append("\(date.year)年\(month)月")
                if let time = "\(date.year)年\(month)月\(1)日".date(withFormat: "yyyy年MM月dd日")?.dateString() {
                    times.append(time)
                }
            }
        }
        setUpPageView()
        print(times)
    }
    
    private func setUpPageView() {
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.bottomLineHeight = 2
        style.isShowBottomLine = true
        style.titleFontSize = 18
        style.bottomLineColor = MainColor
        style.titleColor = .black
        style.titleSelectedColor = MainColor
        style.isTitleScrollEnable = true
        
        // 创建每一页对应的controller
        var childViewControllers = [GameSellListViewController]()

        for i in 0..<timeStrings.count {
            
            let controller = GameSellListViewController()
            controller.date = times[i]
            childViewControllers.append(controller)
        }
        
        // 创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: kTopH, width: ScreenWidth, height: ScreenHeight), style: style, titles: timeStrings, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
}