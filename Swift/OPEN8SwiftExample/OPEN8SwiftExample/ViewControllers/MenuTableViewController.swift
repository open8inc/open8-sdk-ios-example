//
//  MenuTableViewController.swift
//  OPEN8SwiftExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

import UIKit

private let kMenuItemCellIdentifier = "menuItem"
private let kInfeedSegueIdentifier = "toInfeedViewController"

class MenuTableViewController: UITableViewController {
    let menuItems = [
        MenuItem(
            title: "infeed(ad on the top)",
            segueIdentifier: kInfeedSegueIdentifier,
            adRows: [0],
            contents: ["foo", "bar", "baz"]
        ),
        MenuItem(
            title: "infeed(ad on the middle)",
            segueIdentifier: kInfeedSegueIdentifier,
            adRows: [15],
            contents: [
                "foo", "bar", "baz", "foo", "bar", "baz",
                "foo", "bar", "baz", "foo", "bar", "baz",
                "foo", "bar", "baz", "foo", "bar", "baz",
                "foo", "bar", "baz", "foo", "bar", "baz",
                "foo", "bar", "baz", "foo", "bar", "baz"
            ]
        ),
        MenuItem(
            title: "infeed without cell separator",
            segueIdentifier: kInfeedSegueIdentifier,
            adRows: [0],
            contents: ["foo", "bar", "baz"],
            separatorStyle: .none
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMenuItemCellIdentifier, for: indexPath)

        cell.textLabel?.text = menuItems[indexPath.row].title

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: menuItems[indexPath.row].segueIdentifier, sender: menuItems[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kInfeedSegueIdentifier {
            if let menuItem = sender as? MenuItem, let vc = segue.destination as? InfeedTableViewController {
                vc.item = menuItem
            }
        }
    }
}
