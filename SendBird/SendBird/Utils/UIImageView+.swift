//
//  UIImageView+.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadImage(at url: URL) {
      UIImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
      UIImageLoader.loader.cancel(for: self)
    }
}
