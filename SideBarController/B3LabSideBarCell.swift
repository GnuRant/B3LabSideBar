//
//  B3LabSideBarCell.swift
//  SideBarController
//
//  Created by Luca D'incà on 05/11/14.
//  Copyright (c) 2014 B3LAB. All rights reserved.
//

import Foundation
import UIKit

class B3LabSideBarCell: UITableViewCell {
    
    private let CELL_SIZE = CGSize(width: 90, height: 90)
    private let CELL_BACKGROUND_COLOR = UIColor(red: 0.208, green: 0.208, blue: 0.208, alpha: 1)
    private let ICON_VIEW_SIZE = CGSize(width: 50, height: 50)
    private let TITLE_LABEL_SIZE = CGSize(width: 80, height: 25)
    private let TITLE_TEXT_COLOR = UIColor.whiteColor()

    private let kIconView = "icon"
    private let kTitleLabel = "title"
    
    private var iconView: UIImageView?
    private var titleLabel: UILabel?
    
    var title: String? {
        didSet {
            self.titleLabel?.text = title
        }
    }
    
    var icon: UIImage? {
        didSet {
            iconView?.image = icon
        }
    }
    
    //MARK: Init methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = CELL_BACKGROUND_COLOR
        configureIconView()
        configureTitleLabel()
        autolayoutViews()
    }
    
    private func configureIconView() {
        iconView = UIImageView()
        iconView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        if iconView != nil {
            self.contentView.addSubview(iconView!)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        if titleLabel != nil {
            self.contentView.addSubview(titleLabel!)
        }
    }
    
    //MARK: Autolayout methods
    private func autolayoutViews() {
        var viewDictionary = [NSObject: AnyObject]()
        viewDictionary[kIconView] = iconView!
        viewDictionary[kTitleLabel] = titleLabel!
        
        let vCostraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=15)-[icon]-[title]",
            options: nil,
            metrics: nil,
            views: viewDictionary)
        
        let vIconCostraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[icon(==40)]",
            options: nil,
            metrics: nil,
            views: viewDictionary)
        
        let hIconCostraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[icon(==40)]",
            options: nil,
            metrics: nil,
            views: viewDictionary)
        
        let vCenteringIcon = NSLayoutConstraint(item: self.contentView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        let vCenteringTitle = NSLayoutConstraint(item: self.contentView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: titleLabel,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        self.contentView.addConstraints(vCostraint)
        self.contentView.addConstraints(vIconCostraint)
        self.contentView.addConstraints(hIconCostraints)
        self.contentView.addConstraint(vCenteringIcon)
        self.contentView.addConstraint(vCenteringTitle)
    }
    
    
}
 