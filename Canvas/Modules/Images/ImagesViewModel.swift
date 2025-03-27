//
//  ImagesViewModel.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import Foundation

class ImagesViewModel: ObservableObject {
    @Published var images = [PhotoModel]()

    func fetchData() {
        let url = "https://api.pexels.com/v1/curated?per_page=10"
        let headers = ["Authorization": "API KEY"]

        NetworkManager.shared.request(urlString: url, headers: headers, responseType: PhotoResponseModel.self) { [weak self] result in
            switch result {
            case .success(let post):
                self?.images = post.photos
            case .failure(let error):
                print(error)
            }
        }
    }
}
