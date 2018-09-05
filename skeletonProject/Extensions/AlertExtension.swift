//
//  AlertExtension.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
extension UIAlertController
{
    static func showAlert(message:String) -> UIAlertController
    {
        let uiAlert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok!",style:.cancel, handler: nil)
        uiAlert.addAction(action)
        return uiAlert
    }
}
