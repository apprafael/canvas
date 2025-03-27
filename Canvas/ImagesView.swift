//
//  ImagesView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct ImagesView: View {
    @State var images = [PhotoModel]()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(images) { image in
                    AsyncImage(url:  URL(string: image.src.original)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 300)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 300)
                    }

                }
            }
        }
        .padding()
        .onAppear {
            fetchData()
        }
    }

    private func fetchData() {
        let url = "https://api.pexels.com/v1/curated?per_page=10"
        let headers = ["Authorization": "API KEY"]

        NetworkManager.shared.request(urlString: url, headers: headers, responseType: PhotoResponseModel.self) { result in
            switch result {
            case .success(let post):
                images = post.photos
            case .failure(let error):
                print("Erro: \(error)")
            }
        }
    }
}

#Preview {
    ImagesView()
}
