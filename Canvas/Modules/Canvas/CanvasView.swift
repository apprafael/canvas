//
//  CanvasView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct CanvasView: View {
    @State private var isSheetPresented = false
    @StateObject var viewModel = CanvasViewModel()

    var body: some View {
        VStack {
            setCanvasImage()
            Spacer()
            setTabView()
                .sheet(isPresented: $isSheetPresented) {
                    ImagesView(selectedImages: $viewModel.images)
                }
        }
        .background(Color.white)
        .onTapGesture {
            viewModel.selectedImageID = UUID()
        }
    }

    private func setCanvasImage() -> some View {
        ZStack {
            ForEach(viewModel.images.indices, id: \.self) { imageIdx in
                CanvasImageView(canvasImageModel: $viewModel.images[imageIdx], selectedImageID: $viewModel.selectedImageID)
                    .onChange(of: viewModel.images[imageIdx].position) { oldValue, newValue in
                        viewModel.snapToImagesIfNeeded()
                    }
            }
        }
    }

    private func setTabView() -> some View {
        HStack {
            Button {
                isSheetPresented = true
            } label: {
                Image(systemName: "plus")
                    .frame(height: 50)
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    CanvasView(viewModel: CanvasViewModel(images: [
        .init(image: Image(systemName: "heart")),
        .init(image: Image(systemName: "heart.fill"))
    ]))
}
