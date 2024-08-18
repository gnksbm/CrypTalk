//
//  RequestProvider.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

protocol HeaderProvider {
    associatedtype Header: Encodable
    
    var header: Header { get }
    
    func toHeader() -> [String: String]
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

protocol ParameterProvider {
    associatedtype Parameter: Encodable
    
    var parameter: Parameter { get }
}
