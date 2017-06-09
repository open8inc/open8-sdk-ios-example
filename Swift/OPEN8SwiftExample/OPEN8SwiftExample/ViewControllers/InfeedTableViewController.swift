//
//  InfeedTableViewController.swift
//  OPEN8SwiftExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

import UIKit
import OPEN8Ad

class InfeedTableViewController: UITableViewController, OEAInfeedAdProviderDelegate {
    let kOriginalContentCellIdentifier = "originalContentCellIdentifier"
    let kAdCellIdentifier = "adCellIdentifier"

    var item: MenuItem? = nil
    var adManager: OEAInfeedAdManagerProtocol? = nil
    var adProviders = [Int : OEAInfeedAdProviderProtocol]()
    var originalContents = Array<String>()

    var contents: Array<Either<String, OEAInfeedAdProviderProtocol>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adManager = OEA.sharedInstance().createAdManager()
        if let i = item {
            adProviders = createAdProviders(adIndexes: i.adRows)
            originalContents = i.contents
        }
        contents = mergeContents()
        configureTableView()
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
        return contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contents[indexPath.row] {
        case let .Left(original):
            let cell = tableView.dequeueReusableCell(withIdentifier: kOriginalContentCellIdentifier)
            cell?.textLabel?.text = original
            return cell!
        case let .Right(adProvider):
            let cell = tableView.dequeueReusableCell(withIdentifier: kAdCellIdentifier) as? OEAInfeedAdTableViewCell
            adManager?.bindAdProvider(adProvider, to: cell, on: tableView)
            return cell!
        }
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.allowsSelection = false
    }

    private func createAdProviders(adIndexes: Array<Int>) -> [Int : OEAInfeedAdProviderProtocol] {
        var providers = [Int : OEAInfeedAdProviderProtocol]()
        if let adm = adManager {
            for idx in adIndexes {
                let adp = adm.createAdProvider()
                adp?.delegate = self
                providers[idx] = adp
            }
        }
        return providers
    }
    
    private func mergeContents() -> Array<Either<String, OEAInfeedAdProviderProtocol>> {
        var res: Array<Either<String, OEAInfeedAdProviderProtocol>> = originalContents.map { Either.Left($0) }
        for (idx, ad) in adProviders {
            res.insert(Either.Right(ad), at: idx)
        }

        return res;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func didFetchAd(withAdProvider adProvider: OEAInfeedAdProviderProtocol) {
        tableView.reloadData()
    }
}
