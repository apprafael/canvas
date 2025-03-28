//
//  CanvasView.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import SwiftUI

struct CanvasView: View {
    @State private var isSheetPresented = false
    @State private var selectedImages: [Image] = []
    @State private var position: CGPoint = CGPoint(x: 100, y: 100)

    var body: some View {
        setCanvasImage()
        Spacer()
        setTabView()
            .sheet(isPresented: $isSheetPresented) {
                ImagesView(selectedImages: $selectedImages)
            }
    }

    private func setCanvasImage() -> some View {
        ForEach(selectedImages.indices, id: \.self) { imageIdx in
            CanvasImageView(selectedImage: selectedImages[imageIdx])
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
