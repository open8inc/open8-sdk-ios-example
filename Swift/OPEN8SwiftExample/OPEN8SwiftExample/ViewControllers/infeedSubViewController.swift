//
//  MenuTableViewController.swift
//  OPEN8SwiftExample
//
//  Copyright (c) 2018-present, OPEN8, Inc. All rights reserved.
//

import UIKit
import OPEN8Ad

class infeedSubViewController: UIViewController, OEAInfeedAdProviderDelegate{
    
    var scrolleView = UIScrollView()
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
        bindAd()
    }
    
    private func bindAd() {
        
        let viewX = view.frame.width
        let viewY = view.frame.height
        scrolleView.frame = CGRect(x:0, y:0, width:viewX, height:viewY)
        
        scrolleView.backgroundColor = .white
        scrolleView.contentSize = CGSize(width: viewX, height: viewY)
        view.addSubview(scrolleView)
        
        let subView:OEAInfeedAdSubView = OEAInfeedAdSubView()
        subView.frame = CGRect(x:0, y:0, width:viewX, height:viewY/3)
        subView.backgroundColor = .white
        scrolleView.addSubview(subView)
        
        adManager?.bindAdProvider(adProviders[0], to: subView, on: scrolleView)
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
    
}
