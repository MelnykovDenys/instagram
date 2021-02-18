//
//  ImageLoader.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import Kingfisher

class ImageLoader {
    
    static let shared = ImageLoader()
    
    func downloadImage(with urlString: String, completionHandler: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(Images.imagePlaceholder())
            return
        }
        //Don`t need set Queue cause pod does it
        ImageDownloader.default.downloadImage(with: url) { result in
            switch result {
            case .success(let result):
                completionHandler(result.image)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completionHandler(Images.imagePlaceholder())
            }
        }
    }
}
