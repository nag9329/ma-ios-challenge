//
//  ViewController.swift
//  sd-ios-test
//
//  Created by Fritz Ammon on 9/25/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import UIKit

struct DealSummary {
    var price: Double
    var title: String
    var extra: String
    var voteCount: Int
    var commentCount: Int
}

class DealCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    func configure(dealSummary: DealSummary) {
        priceLabel.text = "\(dealSummary.price)"
        nameLabel.text = "\(dealSummary.title)"
        extraLabel.text = "\(dealSummary.extra)"
        votesLabel.text = "\(dealSummary.voteCount)"
        commentsLabel.text = "\(dealSummary.commentCount)"
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var deals: [DealSummary] = [
        DealSummary(price: 45, title: "2 for 1 alligator paws at Super Doughnut Shop", extra: "free shipping!", voteCount: 54, commentCount: 2),
        DealSummary(price: 32, title: "FREE couch at local dealerships", extra: "pickup only", voteCount: 15, commentCount: 11)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as? DealCell
        else { return UITableViewCell() }
        cell.configure(dealSummary: deals[indexPath.row])
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DealTableViewCell", bundle: nil), forCellReuseIdentifier: "DealCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
}

