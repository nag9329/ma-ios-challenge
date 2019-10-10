//
//  SortFilterApplyCell.swift
//  sd-ios-test
//
//  Created by Nagarjuna Ramagiri on 10/9/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import UIKit

/// Delegate methods to apply/clear the sort and filter values
protocol SortFilterApplyDelegate {
    func applyClicked()
    func clearAllClicked()
}

/// Tableviewcell class used to apply/clear the sort and filter logic
class SortFilterApplyCell: UITableViewCell {
    var delegate:SortFilterApplyDelegate?
    
    @IBAction func applyClicked(_ sender: Any) {
        delegate?.applyClicked()
    }
    
    @IBAction func clearAllClicked(_ sender: Any) {
        delegate?.clearAllClicked()
    }
}
