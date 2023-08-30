//
//  UIImageView+Extentions.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL, cornerRadius: CGFloat) {
        self.kf.setImage(
            with: url,
            options: [
                .cacheSerializer(FormatIndicatedCacheSerializer.png)
            ]
        )
    }
}
