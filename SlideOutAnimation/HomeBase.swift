//
//  HomeBase.swift
//  SlideOutAnimation
//
//  Created by TRINGAPPS on 25/11/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import Foundation

struct HomeBase: Decodable {
    let modules: [Modules]?

    enum CodingKeys : String, CodingKey {
      case modules =  "modules"
    }

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    modules = try values.decodeIfPresent([Modules].self, forKey: .modules)
}
}
