//
//  CollectionViewController.swift
//  OPEN8SwiftExample
//
//  Created by Kazuya Maeda on 2018/04/25.
//  Copyright © 2018 OPEN8. All rights reserved.
//

import UIKit
import OPEN8Ad

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let kOriginalContentCellIdentifier = "originalContentCollectionCellIdentifier"
    let kAdCellIdentifier = "adCollectionCellIdentifier"
    let kDefaultCellHeight: CGFloat = 120
    
    var item: MenuItem? = nil
    var adManager: OEAInfeedAdManagerProtocol? = nil
    var adProviders = [Int : OEAInfeedAdProviderProtocol]()
    var originalContents = Array<String>()
    var contents: Array<Either<String, OEAInfeedAdProviderProtocol>> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareContents()

        if #available(iOS 10.0, *) {
            self.collectionView?.refreshControl = UIRefreshControl()
            self.collectionView?.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.row] {
        case let .Left(original):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kOriginalContentCellIdentifier, for: indexPath)
            if let label = cell.contentView.viewWithTag(1) as? UILabel {
                label.text = "\(indexPath.row) \(original)"
            }

            return cell
        case let .Right(adProvider):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdCellIdentifier, for: indexPath) as? OEAInfeedAdCollectionViewCell
            adManager?.bindAdProvider(adProvider, to: cell, on: collectionView)

            return cell!
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if case let .Right(adProvider) = contents[indexPath.row] {
            return CGSize(width: UIScreen.main.bounds.width, height: adProvider.height(byWidth: UIScreen.main.bounds.width))
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: kDefaultCellHeight)
        }
    }

    // MARK: Private methods
    private func prepareContents() {
        adManager = OEA.sharedInstance().createAdManager()

        if let item = item {
            adProviders = createAdProviders(adIndexes: item.adRows)
            originalContents = item.contents
        }

        contents = mergeContents()
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

    @objc @available(iOS 10.0, *)
    private func refresh(sender: UIRefreshControl) {
        self.prepareContents()
        self.collectionView?.reloadData()
        self.collectionView?.refreshControl?.endRefreshing()
    }
 }

extension CollectionViewController: OEAInfeedAdProviderDelegate {
    func didFetchAd(withAdProvider adProvider: OEAInfeedAdProviderProtocol) {
        collectionView?.reloadData()
    }
}
