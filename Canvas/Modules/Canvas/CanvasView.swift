//
//  CanvasView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct CanvasView: View {
    @State private var isSheetPresented = false
    @State private var images: [Image] = []
    @State private var selectedImage: Image = Image(systemName: "")

    var body: some View {
        VStack {
            setCanvasImage()
            Spacer()
            setTabView()
                .sheet(isPresented: $isSheetPresented) {
                    ImagesView(selectedImages: $images)
                }
        }
        .background(Color.white)
        .onTapGesture {
            selectedImage = Image(systemName: "")
        }
    }

    private func setCanvasImage() -> some View {
        ForEach(images.indices, id: \.self) { imageIdx in
            CanvasImageView(image: images[imageIdx], selectedImage: $selectedImage)
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
