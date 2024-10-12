//
//  File.swift
//  
//
//  Created by gnksbm on 10/11/24.
//

#if canImport(SwiftUI)
import SwiftUI

public extension View {
    var toUIKitVC: UIViewController { UIHostingController(rootView: self) }
}
#endif
