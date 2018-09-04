//
//  Countries.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import Foundation
struct Country: Decodable {
    let id:Int
    let image:String?
    let name:String?
    let created_at:String?
    let updated_at:String?
   
}
