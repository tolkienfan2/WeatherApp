//
//  AdVC.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-10-14.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdVC: UIViewController, GADBannerViewDelegate {

    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.adUnitID = ADMOB_AD_UNIT_ID
        bannerView.rootViewController = self

        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.delegate = self
        
        bannerView.load(GADRequest())
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        view.addSubview(bannerView)
    }
}
