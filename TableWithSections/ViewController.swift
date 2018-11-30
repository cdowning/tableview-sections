//
//  ViewController.swift
//  TableWithSections
//
//  Created by Caitlin on 11/2/18.
//  Copyright © 2018 Caitlin. All rights reserved.
//

import UIKit


let SubCategories = [
    ["title": "Church", "amount": "100", "category": "giving"],
    ["title": "Charity", "amount": "15", "category": "giving"],
    ["title": "Emergency Fund", "amount": "650", "category": "savings"],
    ["title": "Christmas", "amount": "600", "category": "savings"],
    ["title": "Vacation", "amount": "0", "category": "savings"],
    ["title": "Roth IRA", "amount": "0", "category": "retirement"],
    ["title": "Mortgage", "amount": "0", "category": "housing"],
    ["title": "Electricity", "amount": "150", "category": "housing"],
    ["title": "Water", "amount": "65", "category": "housing"],
    ["title": "Auto Gas & Oil", "amount": "350", "category": "transportation"],
    ["title": "Car Maintenance", "amount": "0", "category": "transportation"],
    ["title": "Groceries", "amount": "800", "category": "food"],
    ["title": "Restaurants", "amount": "250", "category": "food"],
    ["title": "Childcare", "amount": "1200", "category": "lifestyle"],
    ["title": "Auto Insurance", "amount": "203", "category": "insurance"],
    ["title": "Rogue", "amount": "700", "category": "debt"]
]


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // The magic enum to end our pain and suffering!
    // For the most part the order of our cases do not matter.
    // What is important is that our first case is set to 0, and that our last case is always `total`.
    enum TableSection: Int {
        case giving = 0, savings, retirement, housing, transportation, food, lifestyle, insurance, debt, total
    }
    
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 25
    let SectionFooterHeight: CGFloat = 35
    
    let tableCellReuseIndentifier = "Cell"
    
    // Data variable to track our sorted data.
    var data = [TableSection: [[String: String]]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // When generating sorted table data we can easily use our TableSection to make look up simple and easy to read.
    func sortData() {
        data[.giving] = SubCategories.filter({ $0["category"] == "giving" })
        data[.savings] = SubCategories.filter({ $0["category"] == "savings" })
        data[.retirement] = SubCategories.filter({ $0["category"] == "retirement" })
        data[.housing] = SubCategories.filter({ $0["category"] == "housing" })
        data[.transportation] = SubCategories.filter({ $0["category"] == "transportation" })
        data[.food] = SubCategories.filter({ $0["category"] == "food" })
        data[.lifestyle] = SubCategories.filter({ $0["category"] == "lifestyle" })
        data[.insurance] = SubCategories.filter({ $0["category"] == "insurance" })
        data[.debt] = SubCategories.filter({ $0["category"] == "debt" })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Using Swift's optional lookup we first check if there is a valid section of table.
        // Then we check that for the section there is data that goes with.
        if let tableSection = TableSection(rawValue: section), let SubCategories = data[tableSection] {
            return SubCategories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // If we wanted to always show a section header regardless of whether or not there were rows in it,
        // then uncomment this line below:
        //return SectionHeaderHeight
        // First check if there is a valid section of table.
        // Then we check that for the section there is more than 1 row.
        if let tableSection = TableSection(rawValue: section), let SubCategories = data[tableSection], SubCategories.count > 0 {
            return SectionHeaderHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0) // #ffffff
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red:0.19, green:0.52, blue:0.72, alpha:1.0) // #3185b7
        
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .giving:
                label.text = "GIVING"
                //label.text = "Giving".uppercased()
            case .savings:
                label.text = "SAVINGS"
            case .retirement:
                label.text = "RETIREMENT"
            case .housing:
                label.text = "HOUSING"
            case .transportation:
                label.text = "TRANSPORTATION"
            case .food:
                label.text = "FOOD"
            case .lifestyle:
                label.text = "LIFESTYLE"
            case .insurance:
                label.text = "INSURANCE"
            case .debt:
                label.text = "DEBT"
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableCellReuseIndentifier, for: indexPath)
        // Similar to above, first check if there is a valid section of table.
        // Then we check that for the section there is a row.
        if let tableSection = TableSection(rawValue: indexPath.section), let subcategory = data[tableSection]?[indexPath.row] {
            
//            if cell.textLabel != nil {
//                cell.textLabel?.text = subcategory["title"]!
//            }
            if let textLabel = cell.textLabel {
                textLabel.text = subcategory["title"]!
            }
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.text = "$\(subcategory["amount"]!)"
            }
        }
        return cell
    }


}

