//
//  UserDefaultsWrapper.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T: Codable> {
    private let key: UserDefaultsKey
    private var defaultValue: T
    
    public var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key.rawValue)
            else {
                return defaultValue
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                Logger.error(error)
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key.rawValue)
            } catch {
                Logger.error(error)
            }
        }
    }
    
    public init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public func removeValue() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

extension UserDefaultsWrapper {
    public enum UserDefaultsKey: String {
        case accessToken, refreshToken, latestViewedID
    }
}
