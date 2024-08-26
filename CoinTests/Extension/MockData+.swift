//
//  MockData+.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

func fetchMockData<B: AnyObject, T: Decodable>(
    bundle: B.Type,
    name: String,
    dtoType: T.Type
) throws -> T {
    let url = url(bundle: bundle, name: name)
    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(
            dtoType,
            from: data
        )
    } catch {
        throw error
    }
}

func url<T: AnyObject>(bundle: T.Type, name: String) -> URL {
    Bundle(for: bundle).url(
        forResource: name,
        withExtension: "json"
    )!
}
