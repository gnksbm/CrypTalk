//
//  Design.swift
//
//
//  Created by gnksbm on 8/28/24.
//

#if canImport(UIKit)
import UIKit

public enum Design {
    public enum Dimension {
        public static let symbolSize = 40.f
    }
    
    public enum Padding {
        public static let small = 10.f
        public static let regular = 20.f
    }
    
    public enum Radius {
        public static let regular = 12.f
    }
    
    public enum Color {
        public static let foreground = UIColor.black
        public static let background = UIColor.white
        public static let secondary = UIColor.gray
        public static let tint = UIColor.blue
        public static let red = UIColor.red
    }
    
    public enum StringLiteral {
        public static let postTab = "게시글"
        public static let portfolioTab = "포트폴리오"
    }
    
    public enum ImageLiteral {
        public static let postTab = UIImage(systemName: "bitcoinsign.circle")
        public static let postTabSelected =
        UIImage(systemName: "bitcoinsign.circle.fill")
        public static let portfolioTab = UIImage(systemName: "chart.pie")
        public static let portfolioTabSelected =
        UIImage(systemName: "chart.pie.fill")
        public static let profile = UIImage(systemName: "person.fill")
        public static let sendComment =
        UIImage(systemName: "arrow.up.message.fill")
        public static let addAsset =
        UIImage(systemName: "bag.fill.badge.plus")
    }
}
#endif
