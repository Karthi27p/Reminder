//
//  BannerAdService.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 16/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerAdService: UIViewController, GADBannerViewDelegate {
    
    var bannerView : GADBannerView!
    var interstitial: GADInterstitial!
    
    func setBannerAdView(sender: UIViewController) {
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = sender
        bannerView.delegate = sender as? GADBannerViewDelegate
        bannerView.load(GADRequest())
        addBannerViewToView(senderView: sender.view, sender: sender)
    }
    
    func addBannerViewToView(senderView: UIView, sender: UIViewController) {

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        senderView.addSubview(bannerView)
        positionBannerAtBottomOfSafeArea(bannerView, senderView: senderView)
    }
    
    func positionBannerAtBottomOfSafeArea(_ bannerView: UIView, senderView: UIView) {
        
        let guide: UILayoutGuide = senderView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [bannerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
             bannerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)]
        )
    }

}
