//
//  DeclarativeBuilder.swift
//  
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

@resultBuilder
public enum DeclarativeBuilder<T> {
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
