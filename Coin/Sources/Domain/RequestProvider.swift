//
//  RequestProvider.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

import Moya

protocol QueryProvider {
    associatedtype Query: Encodable
    
    var query: Query { get }
}

extension QueryProvider {
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

protocol HeaderProvider {
    associatedtype Header: Encodable
    
    var header: Header { get }
}

extension HeaderProvider {
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

protocol BodyProvider {
    associatedtype Body: Encodable
    
    var body: Body { get }
}

protocol MultipartFormDataProvider {
    var key: String { get }
    var data: [Data] { get }
    
    func toMultipartFormData() -> [MultipartFormData]
}

extension MultipartFormDataProvider {
    func imageToMultipartFormData() -> [MultipartFormData] {
        data.map {
            MultipartFormData(
                provider: .data($0),
                name: key
            )
        }
    }
}
