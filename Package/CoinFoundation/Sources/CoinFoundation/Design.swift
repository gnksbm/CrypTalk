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
    }
    
    public enum Padding {
        public static let small: CGFloat = 10
        public static let regular: CGFloat = 20
        public static let medium: CGFloat = 12
    }
    
    public enum Radius {
        public static let regular: CGFloat = 12
    }
    
    public enum Layout {
        // 미니멀한 레이아웃을 위한 설정
        public static let profileImageSize: CGFloat = 80
        public static let buttonHeight: CGFloat = 48
        public static let cardCornerRadius: CGFloat = 12
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
            "lightGray": lightGray,
            "blackBackground": blackBackground,
            "whiteForeground": whiteForeground,
            "orangeAccent": orangeAccent,
            "deepPurple": deepPurple,
            "red": red,
            "blue": blue,
            "lightPink": lightPink,
            "softGreen": softGreen,
            "darkText": darkText,
            "lightText": lightText
        ]
        
        public static let background = UIColor(hex: "282828") // 다크 모드 배경색
        public static let lightGray = UIColor(hex: "F5F5F5") // 라이트 모드 배경색
        public static let blackBackground = UIColor(hex: "0C0C0C") // 검은색 배경
        public static let whiteForeground = UIColor(hex: "FFFFFF") // 카드 배경 색상
        public static let orangeAccent = UIColor(hex: "FFA500") // CTA 버튼용 오렌지색
        public static let deepPurple = UIColor(hex: "9400D3") // 특별 이벤트 강조 색상
        public static let red = UIColor(hex: "FF6B6B")
        public static let blue = UIColor(hex: "4A90E2")
        public static let lightPink = UIColor(hex: "FFC0CB") // 부드러운 핑크, 세부 텍스트용
        public static let softGreen = UIColor(hex: "00FF7F") // 긍정적인 피드백용
        public static let darkText = UIColor(hex: "212121") // 검은 텍스트
        public static let lightText = UIColor(hex: "FFFFFF") // 흰색 텍스트
    }
    
    public enum Font {
        public static let heading = UIFont(name: "AppleSDGothicNeo-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        public static let title = UIFont(name: "AppleSDGothicNeo-Bold", size: 19) ?? UIFont.boldSystemFont(ofSize: 19)
        public static let body1 = UIFont(name: "AppleSDGothicNeo-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        public static let body2 = UIFont(name: "SpoqaHanSansNeo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        public static let caption = UIFont(name: "NotoSansKR-Light", size: 13) ?? UIFont.systemFont(ofSize: 13)
    }
    
    public enum Button {
        public static let actionButtonHeight: CGFloat = 48
        public static let actionButtonRadius: CGFloat = 24
        public static let actionButtonColor = Design.Color.orangeAccent
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
        public static let bottomArrow = UIImage(systemName: "chevron.down")
        public static let chart = UIImage(systemName: "chart.bar.xaxis")
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
