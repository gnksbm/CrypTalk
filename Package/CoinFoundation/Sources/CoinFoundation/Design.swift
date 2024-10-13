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
        public static let symbolSize: CGFloat = 40
        public static let tableViewFooter: CGFloat = 20
        public static let coinChartHeight: CGFloat = 60
        public static let progressViewHeight: CGFloat = 15
    }
    
    public enum Padding {
        public static let regular: CGFloat = 20
        public static let medium: CGFloat = 12
        public static let small: CGFloat = 10
        public static let extraSmall: CGFloat = 5
    }
    
    public enum Radius {
        public static let regular: CGFloat = 12
        public static let medium: CGFloat = 18
        public static let large: CGFloat = 25
    }
    
    public enum Color {
        public static let colorKeys = [
            "background",
            "lightGray",
            "blackBackground",
            "whiteForeground",
            "orangeAccent",
            "deepPurple",
            "red",
            "blue",
            "lightPink",
            "softGreen",
            "darkText",
            "lightText"
        ]
        public static let allColor = [
            "background": background,
            "whiteForeground": foreground,
            "orangeAccent": orangeAccent,
            "red": red,
            "blue": blue,
            "lightPink": lightPink,
            "softGreen": softGreen,
            "darkText": darkText,
        ]
        
        public static let foreground = UIColor(hex: "282828")
        public static let background = UIColor(hex: "FFFFFF")
        public static let orangeAccent = UIColor(hex: "FFA500")
        public static let red = UIColor(hex: "FF6B6B")
        public static let blue = UIColor(hex: "4A90E2")
        public static let lightPink = UIColor(hex: "FFC0CB")
        public static let softGreen = UIColor(hex: "00FF7F")
        public static let darkText = UIColor(hex: "212121")
        public static let gray = UIColor(hex: "BDBDBF")
        public static let clear = UIColor.clear
        public static let teal = UIColor.orange
        public static let lightGray = UIColor(hex: "F2F2F2")
    }
    
    public enum Font {
        public static let heading = UIFont(name: "AppleSDGothicNeo-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        public static let title = UIFont(name: "AppleSDGothicNeo-Bold", size: 19) ?? UIFont.boldSystemFont(ofSize: 19)
        public static let body1 = UIFont(name: "AppleSDGothicNeo-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        public static let body2 = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        public static let label = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 14)
        public static let caption = UIFont(name: "NotoSansKR-Light", size: 13) ?? UIFont.systemFont(ofSize: 13)
        public static let caption2 = UIFont(name: "NotoSansKR-Light", size: 13) ?? UIFont.systemFont(ofSize: 12)
    }
    
    public enum StringLiteral {
        public static let postTab = "게시글"
        public static let coinTab = "순위"
        public static let coinTitle = "시가총액 상위"
        public static let portfolioTab = "포트폴리오"
        public static let emptyPostMessage = "등록된 게시글이 없습니다"
    }
    
    public enum ImageLiteral {
        public static let postTab = UIImage(systemName: "bubble.left.and.bubble.right")
        public static let postTabSelected = UIImage(systemName: "bubble.left.and.bubble.right.fill")
        public static let coinTab = UIImage(systemName: "bitcoinsign.circle")
        public static let coinTabSelected = UIImage(systemName: "bitcoinsign.circle.fill")
        public static let portfolioTab = UIImage(systemName: "chart.pie")
        public static let portfolioTabSelected = UIImage(systemName: "chart.pie.fill")
        public static let profile = UIImage(systemName: "person.fill")
        public static let sendComment = UIImage(systemName: "arrow.up.message.fill")
        public static let addAsset = UIImage(systemName: "bag.fill.badge.plus")
        public static let rightArrow = UIImage(systemName: "chevron.right")
        public static let bottomArrow = UIImage(systemName: "chevron.down")
        public static let chart = UIImage(systemName: "chart.bar.xaxis")
        public static let plus = UIImage(systemName: "plus")
        public static let heart = UIImage(systemName: "heart.fill")
        public static let person = UIImage(systemName: "person")
        public static let chat = UIImage(systemName: "bubble.fill")
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
#endif
