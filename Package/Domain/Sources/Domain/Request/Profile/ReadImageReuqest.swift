//
//  ReadImageReuqest.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

public struct ReadImageReuqest {
    public var accessToken: String
    public let additionalPath: String
}

extension ReadImageReuqest: AccessTokenProvider { }
