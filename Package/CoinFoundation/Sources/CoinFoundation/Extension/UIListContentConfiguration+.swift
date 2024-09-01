//
//  UIListContentConfiguration+.swift
//
//
//  Created by gnksbm on 9/2/24.
//

#if canImport(UIKit)
import UIKit

import Kingfisher

public extension UICollectionViewCell {
    func setImage(
        with resource: Resource?,
        config: UIListContentConfiguration
    ) {
        var copy = config
        if let url = resource?.downloadURL {
            setImage(url: url) { [weak self] data in
                copy.image = UIImage(data: data)
                self?.contentConfiguration = copy
            }
        }
    }
    
    private func setImage(url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(
            with: url
        ) { data, response, error in
            if let data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        .resume()
    }
}
#endif
