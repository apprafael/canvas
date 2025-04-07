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
                .background(.white)
            Spacer()
            setTabView()
                .sheet(isPresented: $isSheetPresented) {
                    ImagesView(selectedImages: $viewModel.images)
                }
        }
        .background(Color.black)
        .onTapGesture {
            viewModel.selectedImageID = UUID()
        }
    }

    private func setCanvasImage() -> some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    ForEach(viewModel.images.indices, id: \.self) { imageIdx in
                        CanvasImageView(canvasImageModel: $viewModel.images[imageIdx], selectedImageID: $viewModel.selectedImageID)
                            .onChange(of: viewModel.images[imageIdx].position) { oldValue, newValue in
                                viewModel.snapToImagesIfNeeded()
                                viewModel.snapToBorderIfNeeded()
                            }
                    }
                }
            }
            .border(.black, width: 4)
            .onAppear {
                viewModel.canvasSize = proxy.size
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
                    .foregroundStyle(.black)
                    .background {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    }
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
