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
                adp?.fetchAd()
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

    func didFetchAd(withAdProvider adProvider: OEAInfeedAdProviderProtocol) {
        tableView.reloadData()
    }
}
