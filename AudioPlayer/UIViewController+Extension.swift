//
//  UIViewController+Extension.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let name = String(describing: T.self)
            return T.init(nibName: name, bundle: nil)
        }
        return instantiateFromNib()
    }
}
