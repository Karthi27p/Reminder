//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation
struct Modules : Codable {
	let moduleID : Int?
	let title : String?
	let appTitle : String?
	let pageTitle : String?
	let trackingName : String?
	let type : String?
	let template : String?
	let typeName : String?
	let phoneContact : String?
	let emailContact : String?
	let mapping : String?
	let location : String?
	let loadURL : String?
	let useForDisplayAd : Bool?
	let section : Section?
	let listStart : Int?
	let listSize : Int?
	let wssListSize : Int?
	let items : [Items]?

	enum CodingKeys: String, CodingKey {

		case moduleID = "moduleID"
		case title = "title"
		case appTitle = "appTitle"
		case pageTitle = "pageTitle"
		case trackingName = "trackingName"
		case type = "type"
		case template = "template"
		case typeName = "typeName"
		case phoneContact = "phoneContact"
		case emailContact = "emailContact"
		case mapping = "mapping"
		case location = "location"
		case loadURL = "loadURL"
		case useForDisplayAd = "useForDisplayAd"
		case section = "section"
		case listStart = "listStart"
		case listSize = "listSize"
		case wssListSize = "wssListSize"
		case items = "items"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		moduleID = try values.decodeIfPresent(Int.self, forKey: .moduleID)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		appTitle = try values.decodeIfPresent(String.self, forKey: .appTitle)
		pageTitle = try values.decodeIfPresent(String.self, forKey: .pageTitle)
		trackingName = try values.decodeIfPresent(String.self, forKey: .trackingName)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		template = try values.decodeIfPresent(String.self, forKey: .template)
		typeName = try values.decodeIfPresent(String.self, forKey: .typeName)
		phoneContact = try values.decodeIfPresent(String.self, forKey: .phoneContact)
		emailContact = try values.decodeIfPresent(String.self, forKey: .emailContact)
		mapping = try values.decodeIfPresent(String.self, forKey: .mapping)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		loadURL = try values.decodeIfPresent(String.self, forKey: .loadURL)
		useForDisplayAd = try values.decodeIfPresent(Bool.self, forKey: .useForDisplayAd)
		section = try values.decodeIfPresent(Section.self, forKey: .section)
		listStart = try values.decodeIfPresent(Int.self, forKey: .listStart)
		listSize = try values.decodeIfPresent(Int.self, forKey: .listSize)
		wssListSize = try values.decodeIfPresent(Int.self, forKey: .wssListSize)
		items = try values.decodeIfPresent([Items].self, forKey: .items)
	}

}
