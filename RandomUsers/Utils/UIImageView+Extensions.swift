//
//  UIImageView+Extensions.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import UIKit

enum ImageViewStyle {
    case profile
}

extension UIImageView {
    // MARK: - Public methods
    func applyStyle(for style: ImageViewStyle) {
        switch style {
        case .profile:
            self.layer.cornerRadius = self.bounds.height / 2
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.white.cgColor
            self.clipsToBounds = true
        }
    }
    
    func imageFromUrl(url: URL, placeholderImage: String? = nil) {
        let temporalImage = UIImage(named: placeholderImage ?? "")
        self.image = temporalImage
        downloadImageFromUrl(url: url) { image in
            self.image = image
        }
    }
    
    // MARK: - Private methods
    private func downloadImageFromUrl(url: URL, completion: @escaping (_ image: UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }
}
