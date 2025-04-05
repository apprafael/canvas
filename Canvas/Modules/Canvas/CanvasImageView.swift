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
        ZStack {
            if canvasImageModel.showRightSnapLine {
                Rectangle()
                    .frame(width: 1, height: 2000)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(x: 70)
            }

            if canvasImageModel.showLeftSnapLine {
                Rectangle()
                    .frame(width: 1, height: 2000)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(x: -70)
            }

            if canvasImageModel.showBottomSnapLine {
                Rectangle()
                    .frame(width: 2000, height: 1)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(y: 50)
            }

            if canvasImageModel.showTopSnapLine {
                Rectangle()
                    .frame(width: 2000, height: 1)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(y: -50)
            }

            canvasImageModel.image
                .resizable()
                .frame(width: 140, height: 100)
                .border(selectedImageID == canvasImageModel.id ? Color.yellow : Color.clear, width: 4)
                .position(canvasImageModel.position)
                .scaleEffect(scale)
                .onTapGesture {
                    selectedImageID = canvasImageModel.id
                    canvasImageModel.showRightSnapLine = false
                    canvasImageModel.showLeftSnapLine = false
                    canvasImageModel.showTopSnapLine = false
                    canvasImageModel.showBottomSnapLine = false

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
}
