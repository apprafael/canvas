//
//  PhotoResponseModel.swift
//  Canvas
//
//  Created by Rafael Almeida on 27/03/25.
//

import Foundation

struct PhotoResponseModel: Decodable {
    let page: Int
    let perPage: Int
    let photos: [PhotoModel]
    let totalResults: Int
    let nextPage: String

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

struct PhotoModel: Decodable, Identifiable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
    let src: ImageSourceModel
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographerUrl = "photographer_url"
        case photographerId = "photographer_id"
        case avgColor = "avg_color"
        case src
        case liked
        case alt
    }
}

struct ImageSourceModel: Decodable {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
