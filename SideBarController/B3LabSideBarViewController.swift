//
//  B3LabSideBarViewController.swift
//  SideBarController
//
//  Created by Luca D'incà on 04/11/14.
//  Copyright (c) 2014 B3LAB. All rights reserved.
//

import Foundation
import UIKit

class B3LabSideBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    private let kSidebarWidth: CGFloat = 90
    private let kSidebarTopBorder: CGFloat = 10
    private let kSidebarCellId = "B3LabCell"
    private let kSidebarCellHeight: CGFloat = 90
    private let kSettingCellId = "SettingsCellID"
    private let kSidebarBackgroundColor = UIColor(red: 0.208, green: 0.208, blue: 0.208, alpha: 1)
    
    var controllers: [AnyObject] = [] {
        didSet {
            setViewControllers(controllers)
            sideBar.reloadData()
        }
    }
    
    var titles: [String] = [] {
        didSet {
            sideBar.reloadData()
        }
    }
    var icons: [UIImage] = [] {
        didSet {
           sideBar.reloadData()
        }
    }
    
    private let sideBar: UITableView = UITableView()
    private var settingsButtonCell: UIView?
    private var settings: UIViewController?
    
    private var sideBarIndex: Int = 0
    
    //MARK: ViewController Init methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sideBar = UITableView()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        sideBar = UITableView()
    }
    
    override init() {
        super.init()
    }
    
    //MARK: ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar.delegate = self
        sideBar.dataSource = self
        sideBar.registerClass(B3LabSideBarCell.self, forCellReuseIdentifier: kSidebarCellId)
        setUpSideBarStyle()
            
        self.view.addSubview(sideBar)

        settingsButtonCell = B3LabSideBarCell(style: .Default, reuseIdentifier: kSettingCellId)
        settingsButtonCell?.frame = CGRect(x: 0,
            y: self.view.frame.height - kSidebarCellHeight,
            width: kSidebarCellHeight,
            height: kSidebarCellHeight)
        (settingsButtonCell as B3LabSideBarCell).title = "settings"
        let tap = UITapGestureRecognizer(target: self, action: "didTapOnSettingsButton")
        settingsButtonCell?.addGestureRecognizer(tap)
        self.view.addSubview(settingsButtonCell!)
    }
    
    override func viewWillAppear(animated: Bool) {
        sideBar.frame = setTableViewSize()
    }
    
    //The array of custom view controllers to display in the left side bar interface,
    //the order in the array corresponds to the display order in the side bar, with
    //the controller at index 0 rappresenting the top-most element in the side bar,
    //the controller at index 1 the below element in the side bar controller.
    private func setViewControllers(viewControllers:[AnyObject]) {
        for controller in viewControllers{
            if (controller as? UIViewController == nil) {
                println("Error viewController doesn't contain UIViewControllers")
                return
            }
        }
        
        if !viewControllers.isEmpty {
            setDefaultSubViewController()
        }
    }
    
    //MARK: Sub view controller utility methods
    private func setContainerControllerSize() -> CGRect {
        return CGRectMake(kSidebarWidth, 0,
            self.view.frame.width - kSidebarWidth,
            self.view.frame.height)
    }
    
    private func replaceVisibleViewControllerWithViewControllerAtIndex(index: Int) -> Bool {
        if index == self.sideBarIndex {
            return false
        }else{
            var incommingViewController = controllers[index] as UIViewController
            var outcommingViewController = controllers[sideBarIndex] as UIViewController
            
            outcommingViewController.willMoveToParentViewController(nil)
            self.addChildViewController(incommingViewController)
            
            //set correct frame for incomming view
            incommingViewController.view.frame = setContainerControllerSize()
            incommingViewController.didMoveToParentViewController(self)
            
            self.view.addSubview(incommingViewController.view)
            
            //remove outcommingview controller from superview
            outcommingViewController.removeFromParentViewController()
            
            self.sideBarIndex = index
        }
        
        return true
    }
    
    private func setDefaultSubViewController(){
        var tempVc = controllers[0] as UIViewController
        self.addChildViewController(tempVc)
        tempVc.view.frame = setContainerControllerSize()
        tempVc.didMoveToParentViewController(self)
        self.view.addSubview(tempVc.view)
    }
    

    //MARK: TableView utility methods
    private func setUpSideBarStyle(){
        sideBar.autoresizingMask = (UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin)
        sideBar.backgroundColor = kSidebarBackgroundColor
        sideBar.scrollEnabled = false
        sideBar.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    private func setTableViewSize() -> CGRect {
        return CGRectMake(0,
            kSidebarTopBorder,
            kSidebarWidth,
            self.view.frame.height - kSidebarTopBorder - kSidebarCellHeight)
    }
    

    //MARK: TableView delegate methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kSidebarCellId)
            as B3LabSideBarCell
        
        if  controllers.count <= titles.count  {
            cell.title = titles[indexPath.row]
        }
        
        if  controllers.count <= icons.count {
            cell.icon = icons[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.replaceVisibleViewControllerWithViewControllerAtIndex(indexPath.row)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kSidebarCellHeight
    }
    
    //MARK: Methods for gesture actions
    func didTapOnSettingsButton() {
        if settings !== nil {
            var navController = UINavigationController(rootViewController: settings!)
            navController.modalPresentationStyle = .FormSheet
            self.presentViewController(navController, animated: true, completion: nil)
        }
    }
}
