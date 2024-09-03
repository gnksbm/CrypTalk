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
        public static let tableViewFooter = 20.f
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
        public static let clear = UIColor.clear
        public static let gray1 = UIColor(named: "Gray1")
        public static let gray2 = UIColor(named: "Gray2")
        public static let tint = UIColor(named: "BlackCandle")
        public static let red = UIColor(named: "WhiteCandle")
    }
    
    public enum Font {
        public static let heading = UIFont.systemFont(ofSize: 20)
        public static let title = UIFont.systemFont(ofSize: 19)
        public static let subtitle = UIFont.systemFont(ofSize: 18)
        public static let body1 = UIFont.systemFont(ofSize: 17)
        public static let body2 = UIFont.systemFont(ofSize: 16)
        public static let label1 = UIFont.systemFont(ofSize: 15)
        public static let label2 = UIFont.systemFont(ofSize: 14)
        public static let caption = UIFont.systemFont(ofSize: 13)
    }
    
    public enum StringLiteral {
        public static let postTab = "게시글"
        public static let coinTab = "순위"
        public static let coinTitle = "시가총액 상위"
        public static let portfolioTab = "포트폴리오"
    }
    
    public enum ImageLiteral {
        public static let postTab =
        UIImage(systemName: "bubble.left.and.bubble.right")
        public static let postTabSelected =
        UIImage(systemName: "bubble.left.and.bubble.right.fill")
        public static let coinTab = UIImage(systemName: "bitcoinsign.circle")
        public static let coinTabSelected =
        UIImage(systemName: "bitcoinsign.circle.fill")
        public static let portfolioTab = UIImage(systemName: "chart.pie")
        public static let portfolioTabSelected =
        UIImage(systemName: "chart.pie.fill")
        public static let profile = UIImage(systemName: "person.fill")
        public static let sendComment =
        UIImage(systemName: "arrow.up.message.fill")
        public static let addAsset =
        UIImage(systemName: "bag.fill.badge.plus")
        public static let bottomArrow =
        UIImage(systemName: "chevron.down")
        public static let chart =
        UIImage(systemName: "chart.bar.xaxis")
    }
}
#endif
