//
//  Extension+UIImageView.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlString: String, defaultImage: UIImage? = nil) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image as? UIImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            self.image = defaultImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self?.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.image = defaultImage
                        }
                    }
            } catch {
                self?.image = defaultImage
                print(error)
            }

        }
    }
}
