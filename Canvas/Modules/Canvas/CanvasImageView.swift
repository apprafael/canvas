//
//  CanvasImageView.swift
//  Canvas
//
//  Created by Rafael Almeida on 28/03/25.
//

import SwiftUI

struct CanvasImageView: View {
    @State var selectedImage: Image
    @State var isSelected = false
    @State var position: CGPoint = CGPoint(x: 100, y: 100)
    @State private var scale: CGFloat = 1.0

    var body: some View {
        selectedImage
            .resizable()
            .frame(width: 140, height: 100)
            .border(isSelected ? Color.yellow : Color.clear, width: 4)
            .position(position)
            .scaleEffect(scale)
            .onTapGesture {
                isSelected = true
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        guard isSelected else { return }
                        position = value.location
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        guard isSelected else { return }
                        scale = value
                    }
            )
    }
}
