//
//  CanvasImageModel.swift
//  Canvas
//
//  Created by Rafael Almeida on 04/04/25.
//

import SwiftUI

struct CanvasImageModel: Identifiable {
    var id = UUID()
    let image: Image
    var position: CGPoint = CGPoint(x: 100, y: 100)
    var showRightSnapLine = false
    var showLeftSnapLine = false
    var showTopSnapLine = false
    var showBottomSnapLine = false
    var height: CGFloat = 100
    var width: CGFloat = 140
}
