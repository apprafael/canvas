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
                    .offset(x: canvasImageModel.width/2)
            }

            if canvasImageModel.showLeftSnapLine {
                Rectangle()
                    .frame(width: 1, height: 2000)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(x: -canvasImageModel.width/2)
            }

            if canvasImageModel.showBottomSnapLine {
                Rectangle()
                    .frame(width: 2000, height: 1)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(y: canvasImageModel.height/2)
            }

            if canvasImageModel.showTopSnapLine {
                Rectangle()
                    .frame(width: 2000, height: 1)
                    .foregroundStyle(.yellow)
                    .position(canvasImageModel.position)
                    .offset(y: -canvasImageModel.height/2)
            }

            canvasImageModel.image
                .resizable()
                .frame(width: canvasImageModel.width, height: canvasImageModel.height)
                .border(selectedImageID == canvasImageModel.id ? Color.yellow : Color.clear, width: 4)
                .position(canvasImageModel.position)
                .onTapGesture {
                    selectedImageID = canvasImageModel.id
                    canvasImageModel.showRightSnapLine = false
                    canvasImageModel.showLeftSnapLine = false
                    canvasImageModel.showTopSnapLine = false
                    canvasImageModel.showBottomSnapLine = false

                }
                .cornerRadius(10)
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
                            canvasImageModel.height = 100 * value
                            canvasImageModel.width = 140 * value
                            selectedImageID = canvasImageModel.id
                        }
                )
        }
    }
}
