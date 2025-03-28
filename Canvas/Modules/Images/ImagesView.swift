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
                    AsyncImage(url:  URL(string: image.src.original)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 300)
                            .onTapGesture {
                                selectedImages.append(image)
                                dismiss()
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 300)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchData()
        }
    }
}
