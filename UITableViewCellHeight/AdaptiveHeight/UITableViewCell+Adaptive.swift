//
//  UITableViewCell+Adaptive.swift
//  UITableViewCellHeight
//
//  Created by SnoHo on 2017/6/27.
//  Copyright © 2017年 SnoHo. All rights reserved.
//

import UIKit

extension UITableView {
    
    fileprivate struct AssociatedKeys {
        static var templateCellsByIdentifiers = "templateCellsByIdentifiers"
    }
    
    var templateCellsByIdentifiers: [String: UITableViewCell]? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.templateCellsByIdentifiers, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.templateCellsByIdentifiers) as? [String: UITableViewCell]
        }
        
    }
    
     func templateCellForResuse(_ indentifier: String) -> UITableViewCell {
        assert(indentifier.characters.count>0, "需要一个正确的identifier - \(indentifier)")
        if templateCellsByIdentifiers == nil {
            templateCellsByIdentifiers = [:]
        }
        var tempCell = templateCellsByIdentifiers![indentifier]
        if tempCell == nil {
            tempCell = dequeueReusableCell(withIdentifier: indentifier)
            templateCellsByIdentifiers?[indentifier] = tempCell
        }
        
        return tempCell!
    }

    func heightForCellWidth(_ identifier: String, configuration: ((_ cell: UITableViewCell) -> ())?)->CGFloat{
        let cell = templateCellForResuse(identifier)
        cell.contentView.bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: rowHeight)
        cell.prepareForReuse()
        configuration?(cell)
        
        let tempWidthConstraint = NSLayoutConstraint(item: cell.contentView,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: self.frame.size.width)
        cell.contentView.addConstraint(tempWidthConstraint)
        
        var fittingSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        cell.contentView.removeConstraint(tempWidthConstraint)
        if self.separatorStyle != .none {
            fittingSize.height += 1.0 / UIScreen.main.scale
        }
        
        return fittingSize.height
    }
    
}



