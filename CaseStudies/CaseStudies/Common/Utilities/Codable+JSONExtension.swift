//
//  Codable+JSONExtension.swift
//  TheCaseStudyDB
//
//  Created by Appaji Tholeti on 27/01/2021.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

public extension Decodable {

    static var decoder: JSONDecoder { return JSONDecoder() }

    init?(jsonData: Data?) {
        guard let data = jsonData,
              let anInstance = try? Self.decoder.decode(Self.self, from: data)
        else { return nil }
        self = anInstance
    }

}

extension Encodable where Self: Codable {

    static var encoder: JSONEncoder { return JSONEncoder() }

    func jsonData() -> Data? {
        return try? Self.encoder.encode(self)
    }

}
