//
//  ImageView.swift
//  Canvas
//
//  Created by Rafael Almeida on 28/03/25.
//

import SwiftUI

struct ImageView: View {
    @State var selectedImage: Image
    @State var position: CGPoint = CGPoint(x: 100, y: 100)

    var body: some View {
        selectedImage
            .resizable()
            .frame(width: 100, height: 100)
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.location
                    }
            )
    }
}
