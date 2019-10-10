//
//  ViewController.swift
//  sd-ios-test
//
//  Created by Fritz Ammon on 9/25/19.
//  Copyright © 2019 Slickdeals, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deals: [DealSummary] = []
    var filteredDeals: [DealSummary] = []
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DealTableViewCell", bundle: nil), forCellReuseIdentifier: "DealCell")
        tableView.tableFooterView = UIView()
        fetchDeals()
    }
    
    // MARK: - Helper Methods
    
    /**
     Fetch the deals dynamically
     
     Calling this method will fetch all the deals from the URL provided.
     
     - Parameter None
     */
    private func fetchDeals() {
        let baseURL = URL(string: "https://slickdeas-api-test.s3-us-west-2.amazonaws.com/get_deals_frontpage.json")!
        NetworkRequest.shared.fetchDeals(url: baseURL) { (result: Result<[DealSummary], NetworkRequest.NetworkRequestError>) in
            switch result {
            case .success(let dealSummaries):
                self.deals = dealSummaries
                self.filteredDeals = self.deals
                self.applySortFilter()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /**
     Applies the sort and filter
     
     Calling this method will apply the sort logic and fetch logic to the deals and updates the filtered deals array
     
     - Parameter None
     */
    func applySortFilter() {
        let sortSelected:Bool = UserDefaults.standard.bool(forKey: "sortSelected")
        let minScore:String = UserDefaults.standard.string(forKey: "minScore") ?? ""
        let maxScore:String = UserDefaults.standard.string(forKey: "maxScore") ?? ""
        if(minScore != "" && maxScore != "") {
            self.filteredDeals = self.deals.filter {
                $0.score >= Int(minScore) ?? 0 && $0.score <= Int(maxScore) ?? 0
            }
        } else if (minScore != "" && maxScore == "") {
            self.filteredDeals = self.deals.filter {
                $0.score >= Int(minScore) ?? 0
            }
        } else if (minScore == "" && maxScore != "") {
            self.filteredDeals = self.deals.filter {
                $0.score <= Int(maxScore) ?? 0
            }
        } else if (minScore == "" && maxScore == "") {
            self.filteredDeals = self.deals
        }
        if(sortSelected) {
            self.filteredDeals.sort{$0.score > $1.score}
        }
        //        print("sortSelected: ",sortSelected, "minScore: ",minScore, "maxScore: ",maxScore, "filteredCount: ",self.filteredDeals.count)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - IBOutlet Methods
    
    @IBAction func sortFilterDeals(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SortFilterVC") as? SortFilterViewController
        {
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDeals.count > 0 ? filteredDeals.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as? DealTableViewCell
            else { return UITableViewCell() }
        cell.configure(dealSummary: filteredDeals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(filteredDeals.count) deals found"
    }
}

// MARK: - SortFilter ViewController Delegate

extension ViewController:SortFilterVCDelegate {
    func applyClicked(sortSelected:Bool,minScore:String,maxScore:String) {
        UserDefaults.standard.set(sortSelected, forKey: "sortSelected")
        UserDefaults.standard.set(minScore, forKey: "minScore")
        UserDefaults.standard.set(maxScore, forKey: "maxScore")
        self.applySortFilter()
    }
}
