//
//  ImagesView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct ImagesView: View {
    @StateObject var viewModel = ImagesViewModel()
    @Binding var selectedImages: [Image]
    @Environment(\.dismiss) var dismiss

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.images) { image in
                    setImage(image: image)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchData()
        }
    }

    private func setImage(image: PhotoModel) -> some View {
        AsyncImage(url:  URL(string: image.src.tiny)) { image in
            image
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedImages.append(image)
                    dismiss()
                }

        } placeholder: {
            ProgressView()
        }
    }
}
