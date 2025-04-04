//
//  CanvasImageView.swift
//  Canvas
//
//  Created by Rafael Almeida on 28/03/25.
//

import SwiftUI

struct CanvasImageView: View {
    @Binding var canvasImageModel: CanvasImageModel
    @State private var scale: CGFloat = 1.0
    @Binding var selectedImageID: UUID

    var body: some View {
        canvasImageModel.image
            .resizable()
            .frame(width: 140, height: 100)
            .border(selectedImageID == canvasImageModel.id ? Color.yellow : Color.clear, width: 4)
            .position(canvasImageModel.position)
            .scaleEffect(scale)
            .onTapGesture {
                selectedImageID = canvasImageModel.id
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        guard selectedImageID == canvasImageModel.id else { return }
                        canvasImageModel.position = value.location
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        guard selectedImageID == canvasImageModel.id else { return }
                        scale = value
                    }
            )
    }
}
