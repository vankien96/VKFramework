//
//  UITableViewExtension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forCellReuseIdentifier: typeName)
    }
    
    func registerHeaderFooter<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forHeaderFooterViewReuseIdentifier: typeName)
    }
    
    func dequeueCell<T>(indexPath : IndexPath) -> T {
        let typeName = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: typeName, for: indexPath) as? T else {
            fatalError("couldnt dequeue cell with identifier \(typeName)")
        }
        return cell
    }
    
    func reloadTableWithoutAnimation() {
        UIView.performWithoutAnimation {
            self.reloadData()
        }
    }
    
    func dismissKeyboardWhenScroll() {
        self.keyboardDismissMode = .onDrag
    }
}
