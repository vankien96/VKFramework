//
//  UICollectionViewExtension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forCellWithReuseIdentifier: typeName)
    }
}
