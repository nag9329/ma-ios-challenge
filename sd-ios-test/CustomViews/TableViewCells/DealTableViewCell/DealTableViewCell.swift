//
//  DealTableViewCell.swift
//  sd-ios-test
//
//  Created by Nagarjuna Ramagiri on 10/7/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import UIKit
import SDWebImage

/// Tableviewcell class used in the tableview to present the deals in the application
class DealTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dealImage: UIImageView!
    
    /**
    Configure the tableviewcell with dealSummary

    Calling this method will set all the values from the `dealSummary` to the tableviewcell.

    - Parameter dealSummary: An object with all deal related information.
    */
  func configure(dealSummary: DealSummary) {
        priceLabel.text = dealSummary.price
        nameLabel.text = dealSummary.title
        extraLabel.text = dealSummary.extra
        dealImage.sd_setImage(with: URL(string: dealSummary.image), placeholderImage: UIImage(named: "Logo"))
//      votesLabel.text = "\(dealSummary.voteCount)"
//      commentsLabel.text = "\(dealSummary.commentCount)"
  }
}
