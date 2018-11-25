/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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
