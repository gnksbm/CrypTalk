//
//  ReadCryptoCurrencyWithIDDTO.swift
//  
//
//  Created by gnksbm on 8/28/24.
//

import Foundation

import Domain

struct ReadCryptoCurrencyWithIDDTO: Codable {
    let id, symbol, name, webSlug: String
    let assetPlatformID: String?
    let platforms: Platforms?
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String?
    let categories: [String]
    let previewListing: Bool
    let publicNotice: String?
    let additionalNotices: [String]
    let links: Links
    let image: Image
    let countryOrigin: String
    let genesisDate: String?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double
    let watchlistPortfolioUsers, marketCapRank: Int
    let marketData: MarketData
    let communityData: CommunityData
    let developerData: DeveloperData
    let lastUpdated: String
    let tickers: [Ticker]

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case assetPlatformID = "asset_platform_id"
        case platforms
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case communityData = "community_data"
        case developerData = "developer_data"
        case lastUpdated = "last_updated"
        case tickers
    }
}

extension ReadCryptoCurrencyWithIDDTO {
    func toResponse() throws -> CryptoCurrencyResponse {
        guard let price = marketData.currentPrice["krw"] else {
            throw CryptoCurrencyWithIDDTOError.failureParseCryptoCurrency
        }
        return CryptoCurrencyResponse(
            id: id,
            imageURL: URL(string: image.small),
            marketCapRank: marketCapRank,
            symbol: symbol,
            name: name,
            price: price,
            rate: marketData.priceChangePercentage24H
        )
    }
    
    enum CryptoCurrencyWithIDDTOError: Error {
        case failureParseCryptoCurrency
    }
}

extension ReadCryptoCurrencyWithIDDTO {
    struct CommunityData: Codable {
        let facebookLikes: Int?
        let twitterFollowers, redditAveragePosts48H: Int
        let redditAverageComments48H, redditSubscribers: Int
        let redditAccountsActive48H: Int
        let telegramChannelUserCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case facebookLikes = "facebook_likes"
            case twitterFollowers = "twitter_followers"
            case redditAveragePosts48H = "reddit_average_posts_48h"
            case redditAverageComments48H = "reddit_average_comments_48h"
            case redditSubscribers = "reddit_subscribers"
            case redditAccountsActive48H = "reddit_accounts_active_48h"
            case telegramChannelUserCount = "telegram_channel_user_count"
        }
    }
    
    struct DeveloperData: Codable {
        let forks, stars, subscribers, totalIssues: Int
        let closedIssues, pullRequestsMerged, pullRequestContributors: Int
        let codeAdditionsDeletions4_Weeks: CodeAdditionsDeletions4_Weeks
        let commitCount4_Weeks: Int
        let last4WeeksCommitActivitySeries: [Int]
        
        enum CodingKeys: String, CodingKey {
            case forks, stars, subscribers
            case totalIssues = "total_issues"
            case closedIssues = "closed_issues"
            case pullRequestsMerged = "pull_requests_merged"
            case pullRequestContributors = "pull_request_contributors"
            case codeAdditionsDeletions4_Weeks = "code_additions_deletions_4_weeks"
            case commitCount4_Weeks = "commit_count_4_weeks"
            case last4WeeksCommitActivitySeries = "last_4_weeks_commit_activity_series"
        }
    }
    
    struct CodeAdditionsDeletions4_Weeks: Codable {
        let additions, deletions: Int?
    }
    
    struct Image: Codable {
        let thumb, small, large: String
    }
    
    struct Links: Codable {
        let homepage: [String]
        let whitepaper: String
        let blockchainSite, officialForumURL: [String]
        let chatURL, announcementURL: [String]
        let twitterScreenName, facebookUsername: String
//        let bitcointalkThreadIdentifier: String?
        let telegramChannelIdentifier: String
        let subredditURL: String
        let reposURL: ReposURL
        
        enum CodingKeys: String, CodingKey {
            case homepage, whitepaper
            case blockchainSite = "blockchain_site"
            case officialForumURL = "official_forum_url"
            case chatURL = "chat_url"
            case announcementURL = "announcement_url"
            case twitterScreenName = "twitter_screen_name"
            case facebookUsername = "facebook_username"
//            case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
            case telegramChannelIdentifier = "telegram_channel_identifier"
            case subredditURL = "subreddit_url"
            case reposURL = "repos_url"
        }
    }
    
    struct ReposURL: Codable {
        let github: [String]
    }
    
    struct MarketData: Codable {
        let currentPrice: [String: Double]
        let totalValueLocked, mcapToTvlRatio, fdvToTvlRatio: Double?
        let roi: Roi?
        let ath, athChangePercentage: [String: Double]
        let athDate: [String: String]
        let atl, atlChangePercentage: [String: Double]
        let atlDate: [String: String]
        let marketCap: [String: Double]
        let marketCapRank: Int
        let fullyDilutedValuation: [String: Double]
        let marketCapFdvRatio: Double
        let totalVolume, high24H, low24H: [String: Double]
        let priceChange24H, priceChangePercentage24H: Double
        let priceChangePercentage7D, priceChangePercentage14D: Double
        let priceChangePercentage30D, priceChangePercentage60D: Double
        let priceChangePercentage200D, priceChangePercentage1Y: Double
        let marketCapChange24H: Double
        let marketCapChangePercentage24H: Double
        let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]
        let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]
        let priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]
        let totalSupply, circulatingSupply: Double
        let maxSupply: Double?
        let lastUpdated: String
        
        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case totalValueLocked = "total_value_locked"
            case mcapToTvlRatio = "mcap_to_tvl_ratio"
            case fdvToTvlRatio = "fdv_to_tvl_ratio"
            case roi, ath
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case atl
            case atlChangePercentage = "atl_change_percentage"
            case atlDate = "atl_date"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case marketCapFdvRatio = "market_cap_fdv_ratio"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case priceChangePercentage7D = "price_change_percentage_7d"
            case priceChangePercentage14D = "price_change_percentage_14d"
            case priceChangePercentage30D = "price_change_percentage_30d"
            case priceChangePercentage60D = "price_change_percentage_60d"
            case priceChangePercentage200D = "price_change_percentage_200d"
            case priceChangePercentage1Y = "price_change_percentage_1y"
            case marketCapChange24H = "market_cap_change_24h"
            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
            case priceChange24HInCurrency = "price_change_24h_in_currency"
            case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
            case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
            case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
            case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
            case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
            case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
            case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
            case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
            case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
            case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
            case totalSupply = "total_supply"
            case maxSupply = "max_supply"
            case circulatingSupply = "circulating_supply"
            case lastUpdated = "last_updated"
        }
    }
    
    struct Roi: Codable {
        let times: Double
        let currency: String
        let percentage: Double
    }
    
    struct Platforms: Codable {
        let empty: String?
        
        enum CodingKeys: String, CodingKey {
            case empty = ""
        }
    }
    
    struct Ticker: Codable {
        let base, target: String
        let market: Market
        let last: Double
        let volume: Double
        let convertedLast, convertedVolume: [String: Double]
        let trustScore: String
        let bidAskSpreadPercentage: Double
        let timestamp, lastTradedAt, lastFetchAt: String
        let isAnomaly, isStale: Bool
        let tradeURL: String?
        let tokenInfoURL: String?
        let coinID: String
        let targetCoinID: String?
        
        enum CodingKeys: String, CodingKey {
            case base, target, market, last, volume
            case convertedLast = "converted_last"
            case convertedVolume = "converted_volume"
            case trustScore = "trust_score"
            case bidAskSpreadPercentage = "bid_ask_spread_percentage"
            case timestamp
            case lastTradedAt = "last_traded_at"
            case lastFetchAt = "last_fetch_at"
            case isAnomaly = "is_anomaly"
            case isStale = "is_stale"
            case tradeURL = "trade_url"
            case tokenInfoURL = "token_info_url"
            case coinID = "coin_id"
            case targetCoinID = "target_coin_id"
        }
    }
    
    struct Market: Codable {
        let name, identifier: String
        let hasTradingIncentive: Bool
        
        enum CodingKeys: String, CodingKey {
            case name, identifier
            case hasTradingIncentive = "has_trading_incentive"
        }
    }
}
