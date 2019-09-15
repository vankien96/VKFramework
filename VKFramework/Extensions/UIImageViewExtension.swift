//
//  UIImageViewExtension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(url: URL?, placeHolder: UIImage?) {
        let size = CGSize(width: 1024, height: 1024)
        let resizingProcessor = ResizingImageProcessor(referenceSize: size, mode: self.contentMode == .scaleAspectFit ? .aspectFit : .aspectFill)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(ImageTransition.fade(1)), .processor(resizingProcessor)], progressBlock: nil, completionHandler: nil)
    }
    
    func setImage(url: URL?, placeHolderImageName: String) {
        self.setImage(url: url, placeHolder: UIImage(named: placeHolderImageName))
    }
    
    func setImageAndForceReload(url: URL?, placeHolder: UIImage?) {
        let size = CGSize(width: 1024, height: 1024)
        let resizingProcessor = ResizingImageProcessor(referenceSize: size, mode: self.contentMode == .scaleAspectFit ? .aspectFit : .aspectFill)
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(ImageTransition.fade(1)), .cacheMemoryOnly, .forceRefresh, .processor(resizingProcessor)], progressBlock: nil, completionHandler: nil)
    }
    
    class func getImage(url: URL?, completion: @escaping ((UIImage?) -> Void)) {
        guard let url = url else { return }
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { (image, error, cache, url) in
            completion(image)
        }
    }
}
