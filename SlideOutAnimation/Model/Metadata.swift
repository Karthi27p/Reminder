//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation
struct Metadata : Codable {
	let dateGenerated : String?
	let location : String?
	let wssPath : String?

	enum CodingKeys: String, CodingKey {

		case dateGenerated = "dateGenerated"
		case location = "location"
		case wssPath = "wssPath"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dateGenerated = try values.decodeIfPresent(String.self, forKey: .dateGenerated)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		wssPath = try values.decodeIfPresent(String.self, forKey: .wssPath)
	}

}
