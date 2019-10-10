//
//  SortFilterViewController.swift
//  sd-ios-test
//
//  Created by Nagarjuna Ramagiri on 10/8/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import UIKit

/// Delegate methods to apply the sort and filter values
protocol SortFilterVCDelegate {
    func applyClicked(sortSelected:Bool,minScore:String,maxScore:String)
}

class SortFilterViewController: UITableViewController {
    var delegate:SortFilterVCDelegate?
    var sortSelected:Bool = UserDefaults.standard.bool(forKey: "sortSelected")
    var minScore:String = UserDefaults.standard.string(forKey: "minScore") ?? ""
    var maxScore:String = UserDefaults.standard.string(forKey: "maxScore") ?? ""
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Sort"
        } else if(section == 1) {
            return "Filter"
        } else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell:SortByScoreCell = self.tableView.dequeueReusableCell(withIdentifier: "SortByScore") as! SortByScoreCell
            cell.sortByLabel.text = "Sort By Score (High to Low)"
            cell.accessoryType = sortSelected ? .checkmark : .none
            return cell
        } else if (indexPath.section == 1) {
            let cell:FilterByScoreCell = self.tableView.dequeueReusableCell(withIdentifier: "FilterByScore") as! FilterByScoreCell
            cell.minScoreTextField.text = minScore
            cell.maxScoreTextField.text = maxScore
            return cell
        } else {
            let cell:SortFilterApplyCell = self.tableView.dequeueReusableCell(withIdentifier: "SortFilterApply") as! SortFilterApplyCell
            cell.delegate = self
            return cell
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 0) {
            sortSelected = !sortSelected
            if let cell:SortByScoreCell = tableView.cellForRow(at: indexPath) as? SortByScoreCell {
                cell.accessoryType = sortSelected ? .checkmark : .none
            }
        }
    }
}

// MARK: - SortFilterApplyDelegate

extension SortFilterViewController:SortFilterApplyDelegate {
    func applyClicked() {
        var minScore:String = ""
        var maxScore:String = ""
        if let filterByScoreCell:FilterByScoreCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as? FilterByScoreCell {
            minScore = filterByScoreCell.minScoreTextField.text ?? ""
            maxScore = filterByScoreCell.maxScoreTextField.text ?? ""
        }
        delegate?.applyClicked(sortSelected: sortSelected, minScore: minScore, maxScore: maxScore)
        dismiss(animated: true, completion: nil)
    }
    
    func clearAllClicked() {
        sortSelected = false
        minScore = ""
        maxScore = ""
        tableView.reloadData()
    }
}
