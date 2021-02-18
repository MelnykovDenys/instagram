//
//  ImageLoader.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import Kingfisher

class ImageLoader {
    //Don`t need set Queue couse
    static let shared = ImageLoader()
    
    func downloadImage(with urlString: String, completionHandler: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(Images.imagePlaceholder())
            return
        }
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
