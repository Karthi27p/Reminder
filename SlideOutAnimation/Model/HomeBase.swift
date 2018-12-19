//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//


import Foundation
struct HomeBase : Codable {
	let metadata : Metadata?
	let modules : [Modules]?

	enum CodingKeys: String, CodingKey {

		case metadata = "metadata"
		case modules = "modules"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		metadata = try values.decodeIfPresent(Metadata.self, forKey: .metadata)
		modules = try values.decodeIfPresent([Modules].self, forKey: .modules)
	}

}
