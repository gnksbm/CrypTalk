//
//  RequestProvider.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

import Moya

public protocol QueryProvider {
    associatedtype Query: Encodable
    
    var query: Query { get }
}

public extension QueryProvider {
    func toQuery() -> [String: String] {
        do {
            let data = try JSONEncoder().encode(query)
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            guard let dic = jsonObject as? [String: String] else { return [:] }
            return dic
        } catch {
            return [:]
        }
    }
}

public protocol HeaderProvider {
    associatedtype Header: Encodable
    
    var header: Header { get }
}

public extension HeaderProvider {
    func toHeader() -> [String: String] {
        do {
            let data = try JSONEncoder().encode(header)
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            guard let dic = jsonObject as? [String: String] else { return [:] }
            return dic
        } catch {
            return [:]
        }
    }
}

public protocol BodyProvider {
    associatedtype Body: Encodable
    
    var body: Body { get }
}

public protocol MultipartFormDataProvider {
    var key: String { get }
    var data: [Data] { get }
    
    func toMultipartFormData() -> [MultipartFormData]
}

public extension MultipartFormDataProvider {
    func imageToMultipartFormData() -> [MultipartFormData] {
        data.map {
            MultipartFormData(
                provider: .data($0),
                name: key,
                fileName: "image.gif",
                mimeType: "image/gif"
            )
        }
    }
}
