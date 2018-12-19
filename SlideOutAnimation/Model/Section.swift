//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation
struct Section : Codable {
	let path : String?
	let adUnitLevel2 : String?
	let feature : Bool?
	let featureName : String?
	let featureCategoryID : Int?
	let sponsored : Bool?
	let sponsorName : String?
	let sponsor : [String]?
	let adSensitive : Bool?

	enum CodingKeys: String, CodingKey {

		case path = "path"
		case adUnitLevel2 = "adUnitLevel2"
		case feature = "feature"
		case featureName = "featureName"
		case featureCategoryID = "featureCategoryID"
		case sponsored = "sponsored"
		case sponsorName = "sponsorName"
		case sponsor = "sponsor"
		case adSensitive = "adSensitive"
    }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		path = try values.decodeIfPresent(String.self, forKey: .path)
		adUnitLevel2 = try values.decodeIfPresent(String.self, forKey: .adUnitLevel2)
		feature = try values.decodeIfPresent(Bool.self, forKey: .feature)
		featureName = try values.decodeIfPresent(String.self, forKey: .featureName)
		featureCategoryID = try values.decodeIfPresent(Int.self, forKey: .featureCategoryID)
		sponsored = try values.decodeIfPresent(Bool.self, forKey: .sponsored)
		sponsorName = try values.decodeIfPresent(String.self, forKey: .sponsorName)
		sponsor = try values.decodeIfPresent([String].self, forKey: .sponsor)
		adSensitive = try values.decodeIfPresent(Bool.self, forKey: .adSensitive)

}
}
