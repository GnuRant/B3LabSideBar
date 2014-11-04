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
    let controllers: [UIViewController]?
    let subviewContainer: UIViewController?
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
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
    
    ////////////////////////////////////////////////////////////////////////////
    ////////////////// SUBVIEWCONTROLLER UTILITY METHODS ///////////////////////
    
    func setSubviewControllerSize() -> CGRect {
        return CGRectMake(B3LabSideBarCostants().SIDEBAR_WIDTH, 0,
            self.view.frame.width - B3LabSideBarCostants().SIDEBAR_WIDTH,
            self.view.frame.height)
    }
    
    func loadViewControllerInSubviewContainer() -> Bool {
        return true
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
        //TODO: Set tablet variables as costants
        return CGRectMake(0, B3LabSideBarCostants().SIDEBAR_TOP_BORDER,
            B3LabSideBarCostants().SIDEBAR_WIDTH, self.view.frame.height)
    }
    
    ////////////////////////////////////////////////////////////////////////////
    ///////////////////// TABLEVIEW DELEGATES METHODS //////////////////////////
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: Debug code
        var cell: UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 120, 120))
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.sideBarIndex = indexPath.item
    }
    
}
