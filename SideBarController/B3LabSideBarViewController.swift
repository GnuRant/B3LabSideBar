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
    var controllers: [AnyObject]! = []
    let sideBar: UITableView?
    
    var sideBarIndex: Int = 0
    
    struct B3LabSideBarCostants {
        let SIDEBAR_WIDTH:CGFloat = 120
        let SIDEBAR_TOP_BORDER: CGFloat = 80
    }
    
    
    ////////////////////////////////////////////////////////////////////////////
    /////////////////// UIVIEWCONTROLLER FILECYCLE METHODS /////////////////////
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        sideBar = UITableView()
    }
    
    init(controllers arrayViewControllers:[AnyObject]) {
        super.init()
        setViewControllers(arrayViewControllers)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(sideBar != nil){
            self.setUpSideBar()
            sideBar!.delegate = self
            sideBar!.dataSource = self
            self.view.addSubview(sideBar!)
        }else{
            print("Error: sideBar is not initialized")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        sideBar?.frame = setTableViewSize()
    }
    
    //The array of custom view controllers to display in the left side bar interface,
    //the order in the array corresponds to the display order in the side bar, with
    //the controller at index 0 rappresenting the top-most element in the side bar,
    //the controller at index 1 the below element in the side bar controller.
    func setViewControllers(viewControllers:[AnyObject]) {
        for controller in viewControllers{
            if (controller as? UIViewController == nil) {
                print("Error viewController doesn't contain UIViewControllers")
                return
            }
        }
        
        controllers = viewControllers
        
        if !viewControllers.isEmpty {
            setDefaultSubViewController()
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////
    ////////////////// SUBVIEWCONTROLLER UTILITY METHODS ///////////////////////
    
    func setContainerControllerSize() -> CGRect {
        return CGRectMake(B3LabSideBarCostants().SIDEBAR_WIDTH, 0,
            self.view.frame.width - B3LabSideBarCostants().SIDEBAR_WIDTH,
            self.view.frame.height)
    }
    
    func replaceVisibleViewControllerWithViewControllerAtIndex(index: Int) -> Bool {
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
    
    func setDefaultSubViewController(){
        var tempVc = controllers[0] as UIViewController
        self.addChildViewController(tempVc)
        tempVc.view.frame = setContainerControllerSize()
        tempVc.didMoveToParentViewController(self)
        self.view.addSubview(tempVc.view)
    }
    
    ////////////////////////////////////////////////////////////////////////////
    /////////////////////// TABLEVIEW UTILITY METHODS //////////////////////////
    
    func setUpSideBar(){
        sideBar!.autoresizingMask = (UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin)
        sideBar!.backgroundColor = UIColor.grayColor()
        sideBar!.scrollEnabled = false
        sideBar!.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func setTableViewSize() -> CGRect {
        return CGRectMake(0, B3LabSideBarCostants().SIDEBAR_TOP_BORDER,
            B3LabSideBarCostants().SIDEBAR_WIDTH, self.view.frame.height)
    }
    
    ////////////////////////////////////////////////////////////////////////////
    ///////////////////// TABLEVIEW DELEGATES METHODS //////////////////////////
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: Debug code
        var cell: UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 120, 120))
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.replaceVisibleViewControllerWithViewControllerAtIndex(indexPath.row)
    }
    
}
