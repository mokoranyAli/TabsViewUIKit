//
//  UIImage+App.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/26/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit

// MARK: - UIImage+Constants
//
extension UIImage {
    
    static var chatIcon: UIImage {
        return UIImage(named: "chat") ?? .add
    }
    static var statusIcon: UIImage {
        return UIImage(named: "status") ?? .add
    }
    static var callIcon: UIImage {
        return UIImage(named: "call") ?? .add
    }
}



