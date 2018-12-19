//
//  NewsViewController.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation
struct Items : Codable {
	let no_pre_roll : Bool?
	let typeName : String?
	let sponsorName : String?
	let caption : String?
	let leadImageURL : String?
	let realContentTitle : String?
	let title : String?
	let displayTimestamp : String?
	let updatedMessage : String?
	let thumbnailImageURL : String?
	let feature : Bool?
	let dartPixel : String?
	let nationalLinkTitle : String?
	let comscoreDisplayDate : String?
	let credit : String?
	let fullsizeLeadImageURL : String?
	let headline : String?
	let byline : String?
	let featureId : String?
	let summary : String?
	let featureNamePretty : String?
	let featureName : String?
	let usingPlaceholderImg : String?
	let sponsorID : String?
	let contentID : Int?
	let commentoff : Bool?
	let leadCaption : String?
	let sponsored : Bool?
	let tags : String?
	let leadItem : Bool?
	let sensitiveCategory : Bool?
	let fullsizeImageURL : String?
	let leadCredit : String?
	let headlineTag : String?
	let contentDomain : String?
	let subtitle : String?
	let displayDate : String?
	let shareURL : String?
	let location : String?
	let adSensitiveContentFilter : String?
	let extID : String?
	let contentBody : String?

	enum CodingKeys: String, CodingKey {

		case no_pre_roll = "no_pre_roll"
		case typeName = "typeName"
		case sponsorName = "sponsorName"
		case caption = "caption"
		case leadImageURL = "leadImageURL"
		case realContentTitle = "realContentTitle"
		case title = "title"
		case displayTimestamp = "displayTimestamp"
		case updatedMessage = "updatedMessage"
		case thumbnailImageURL = "thumbnailImageURL"
		case feature = "feature"
		case dartPixel = "dartPixel"
		case nationalLinkTitle = "nationalLinkTitle"
		case comscoreDisplayDate = "comscoreDisplayDate"
		case credit = "credit"
		case fullsizeLeadImageURL = "fullsizeLeadImageURL"
		case headline = "headline"
		case byline = "byline"
		case featureId = "featureId"
		case summary = "summary"
		case featureNamePretty = "featureNamePretty"
		case featureName = "featureName"
		case usingPlaceholderImg = "usingPlaceholderImg"
		case sponsorID = "sponsorID"
		case contentID = "contentID"
		case commentoff = "commentoff"
		case leadCaption = "leadCaption"
		case sponsored = "sponsored"
		case tags = "tags"
		case leadItem = "leadItem"
		case sensitiveCategory = "sensitiveCategory"
		case fullsizeImageURL = "fullsizeImageURL"
		case leadCredit = "leadCredit"
		case headlineTag = "headlineTag"
		case contentDomain = "contentDomain"
		case subtitle = "subtitle"
		case displayDate = "displayDate"
		case shareURL = "shareURL"
		case location = "location"
		case adSensitiveContentFilter = "adSensitiveContentFilter"
		case extID = "extID"
		case contentBody = "contentBody"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		no_pre_roll = try values.decodeIfPresent(Bool.self, forKey: .no_pre_roll)
		typeName = try values.decodeIfPresent(String.self, forKey: .typeName)
		sponsorName = try values.decodeIfPresent(String.self, forKey: .sponsorName)
		caption = try values.decodeIfPresent(String.self, forKey: .caption)
		leadImageURL = try values.decodeIfPresent(String.self, forKey: .leadImageURL)
		realContentTitle = try values.decodeIfPresent(String.self, forKey: .realContentTitle)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		displayTimestamp = try values.decodeIfPresent(String.self, forKey: .displayTimestamp)
		updatedMessage = try values.decodeIfPresent(String.self, forKey: .updatedMessage)
		thumbnailImageURL = try values.decodeIfPresent(String.self, forKey: .thumbnailImageURL)
		feature = try values.decodeIfPresent(Bool.self, forKey: .feature)
		dartPixel = try values.decodeIfPresent(String.self, forKey: .dartPixel)
		nationalLinkTitle = try values.decodeIfPresent(String.self, forKey: .nationalLinkTitle)
		comscoreDisplayDate = try values.decodeIfPresent(String.self, forKey: .comscoreDisplayDate)
		credit = try values.decodeIfPresent(String.self, forKey: .credit)
		fullsizeLeadImageURL = try values.decodeIfPresent(String.self, forKey: .fullsizeLeadImageURL)
		headline = try values.decodeIfPresent(String.self, forKey: .headline)
		byline = try values.decodeIfPresent(String.self, forKey: .byline)
		featureId = try values.decodeIfPresent(String.self, forKey: .featureId)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		featureNamePretty = try values.decodeIfPresent(String.self, forKey: .featureNamePretty)
		featureName = try values.decodeIfPresent(String.self, forKey: .featureName)
		usingPlaceholderImg = try values.decodeIfPresent(String.self, forKey: .usingPlaceholderImg)
		sponsorID = try values.decodeIfPresent(String.self, forKey: .sponsorID)
		contentID = try values.decodeIfPresent(Int.self, forKey: .contentID)
		commentoff = try values.decodeIfPresent(Bool.self, forKey: .commentoff)
		leadCaption = try values.decodeIfPresent(String.self, forKey: .leadCaption)
		sponsored = try values.decodeIfPresent(Bool.self, forKey: .sponsored)
		tags = try values.decodeIfPresent(String.self, forKey: .tags)
		leadItem = try values.decodeIfPresent(Bool.self, forKey: .leadItem)
		sensitiveCategory = try values.decodeIfPresent(Bool.self, forKey: .sensitiveCategory)
		fullsizeImageURL = try values.decodeIfPresent(String.self, forKey: .fullsizeImageURL)
		leadCredit = try values.decodeIfPresent(String.self, forKey: .leadCredit)
		headlineTag = try values.decodeIfPresent(String.self, forKey: .headlineTag)
		contentDomain = try values.decodeIfPresent(String.self, forKey: .contentDomain)
		subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
		displayDate = try values.decodeIfPresent(String.self, forKey: .displayDate)
		shareURL = try values.decodeIfPresent(String.self, forKey: .shareURL)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		adSensitiveContentFilter = try values.decodeIfPresent(String.self, forKey: .adSensitiveContentFilter)
		extID = try values.decodeIfPresent(String.self, forKey: .extID)
		contentBody = try values.decodeIfPresent(String.self, forKey: .contentBody)
	}

}
