//
//  CaseStudy.swift
//  CaseStudies
//
//  Created by Appaji Tholeti on 26/01/2021.
//

import Foundation

struct CaseStudy: Decodable {
    let title: String
    let vertical: String?
    let teaser: String
    let client: String?
    let sections: [Section]
    let heroImage: URL
    let isEnterprise: Bool?

    enum CodingKeys: String, CodingKey {
        case isEnterprise = "is_enterprise", title, vertical, teaser, client, sections, heroImage = "hero_image"
    }

    struct Section: Decodable {
        let title: String?
        let body: [BodyElement]

        enum BodyElement: Decodable {
            case text(String)
            case image(URL)
        }

        enum CodingKeys: String, CodingKey {
            case title, body = "body_elements"
        }
    }
}

// MARK: - Parsing body elements
extension CaseStudy.Section.BodyElement {

    private enum ImageKeys: String, CodingKey {
        case imageURL = "image_url"
    }

    init(from decoder: Decoder) throws {
        if let text = try? decoder.singleValueContainer().decode(String.self) {
            self = .text(text)
        } else if let json = try? decoder.container(keyedBy: ImageKeys.self) {
            let url = try json.decode(URL.self, forKey: .imageURL)
            self = .image(url)
        } else {
            throw CaseStudy.Section.BodyElement.decodingError(for: decoder)
        }
    }

    private static func decodingError(for decoder: Decoder) -> DecodingError {
        let description = """
            Expected a String or a Dictionary containing a
            '\(ImageKeys.imageURL.stringValue)' key with value.
            """
        return .typeMismatch(self, .init(codingPath: decoder.codingPath, debugDescription: description))
    }
}
