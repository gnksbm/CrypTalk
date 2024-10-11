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
/*
 ReadCryptoCurrencyWithIDDTO
   - id : "the-open-network"
   - symbol : "ton"
   - name : "Toncoin"
   - webSlug : "toncoin"
   ▿ assetPlatformID : Optional<String>
     - some : "the-open-network"
   ▿ platforms : Optional<Platforms>
     ▿ some : Platforms
       - empty : nil
   - blockTimeInMinutes : 0
   - hashingAlgorithm : nil
   ▿ categories : 11 elements
     - 0 : "BNB Chain Ecosystem"
     - 1 : "Layer 1 (L1)"
     - 2 : "Ethereum Ecosystem"
     - 3 : "Animoca Brands Portfolio"
     - 4 : "Alleged SEC Securities"
     - 5 : "DWF Labs Portfolio"
     - 6 : "TON Ecosystem"
     - 7 : "Proof of Stake (PoS)"
     - 8 : "Pantera Capital Portfolio"
     - 9 : "GMCI Layer 1 Index"
     - 10 : "GMCI 30 Index"
   - previewListing : false
   - publicNotice : nil
   - additionalNotices : 0 elements
   ▿ links : Links
     ▿ homepage : 3 elements
       - 0 : "https://ton.org/"
       - 1 : "https://blog.ton.org/"
       - 2 : "https://jobs.ton.org/jobs"
     - whitepaper : "https://ton.org/whitepaper.pdf"
     ▿ blockchainSite : 10 elements
       - 0 : "https://tonviewer.com/"
       - 1 : "https://platform.arkhamintelligence.com/explorer/token/the-open-network"
       - 2 : "https://tonmoon.org/explorer/"
       - 3 : "https://youton.org/"
       - 4 : "https://3xpl.com/ton"
       - 5 : "https://tonapi.io/"
       - 6 : "https://etherscan.io/token/0x582d872a1b094fc48f5de31d3b73f2d9be47def1"
       - 7 : "https://ethplorer.io/address/0x582d872a1b094fc48f5de31d3b73f2d9be47def1"
       - 8 : "https://bscscan.com/token/0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - 9 : "https://binplorer.com/address/0x76a797a59ba2c17726896976b7b3747bfd1d220f"
     ▿ officialForumURL : 3 elements
       - 0 : "https://www.linkedin.com/company/ton-blockchain/"
       - 1 : ""
       - 2 : ""
     ▿ chatURL : 3 elements
       - 0 : ""
       - 1 : ""
       - 2 : ""
     ▿ announcementURL : 2 elements
       - 0 : ""
       - 1 : ""
     - twitterScreenName : "ton_blockchain"
     - facebookUsername : ""
     - telegramChannelIdentifier : "toncoin"
     - subredditURL : "https://www.reddit.com"
     ▿ reposURL : ReposURL
       ▿ github : 2 elements
         - 0 : "https://github.com/ton-blockchain/ton"
         - 1 : "https://github.com/ton-blockchain"
   ▿ image : Image
     - thumb : "https://coin-images.coingecko.com/coins/images/17980/thumb/photo_2024-09-10_17.09.00.jpeg?1725963446"
     - small : "https://coin-images.coingecko.com/coins/images/17980/small/photo_2024-09-10_17.09.00.jpeg?1725963446"
     - large : "https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446"
   - countryOrigin : ""
   - genesisDate : nil
   - sentimentVotesUpPercentage : 40.63
   - sentimentVotesDownPercentage : 59.38
   - watchlistPortfolioUsers : 186386
   - marketCapRank : 11
   ▿ marketData : MarketData
     ▿ currentPrice : 62 elements
       ▿ 0 : 2 elements
         - key : "php"
         - value : 295.46
       ▿ 1 : 2 elements
         - key : "twd"
         - value : 165.99
       ▿ 2 : 2 elements
         - key : "bits"
         - value : 85.13
       ▿ 3 : 2 elements
         - key : "kwd"
         - value : 1.58
       ▿ 4 : 2 elements
         - key : "link"
         - value : 0.48671347
       ▿ 5 : 2 elements
         - key : "sats"
         - value : 8512.72
       ▿ 6 : 2 elements
         - key : "yfi"
         - value : 0.00105698
       ▿ 7 : 2 elements
         - key : "sgd"
         - value : 6.74
       ▿ 8 : 2 elements
         - key : "eos"
         - value : 11.095279
       ▿ 9 : 2 elements
         - key : "sar"
         - value : 19.36
       ▿ 10 : 2 elements
         - key : "thb"
         - value : 171.93
       ▿ 11 : 2 elements
         - key : "xdr"
         - value : 3.84
       ▿ 12 : 2 elements
         - key : "krw"
         - value : 6956.94
       ▿ 13 : 2 elements
         - key : "bch"
         - value : 0.01600931
       ▿ 14 : 2 elements
         - key : "ngn"
         - value : 8353.41
       ▿ 15 : 2 elements
         - key : "gel"
         - value : 14.05
       ▿ 16 : 2 elements
         - key : "clp"
         - value : 4795.68
       ▿ 17 : 2 elements
         - key : "lkr"
         - value : 1510.3
       ▿ 18 : 2 elements
         - key : "nzd"
         - value : 8.46
       ▿ 19 : 2 elements
         - key : "bhd"
         - value : 1.94
       ▿ 20 : 2 elements
         - key : "huf"
         - value : 1892.4
       ▿ 21 : 2 elements
         - key : "chf"
         - value : 4.42
       ▿ 22 : 2 elements
         - key : "hkd"
         - value : 40.07
       ▿ 23 : 2 elements
         - key : "myr"
         - value : 22.11
       ▿ 24 : 2 elements
         - key : "ars"
         - value : 5025.93
       ▿ 25 : 2 elements
         - key : "xag"
         - value : 0.16546
       ▿ 26 : 2 elements
         - key : "mxn"
         - value : 100.22      ▿ 27 : 2 elements
         - key : "cny"
         - value : 36.48
       ▿ 28 : 2 elements
         - key : "pln"
         - value : 20.29
       ▿ 29 : 2 elements
         - key : "bdt"
         - value : 616.23
       ▿ 30 : 2 elements
         - key : "rub"
         - value : 499.8
       ▿ 31 : 2 elements
         - key : "pkr"
         - value : 1432.32
       ▿ 32 : 2 elements
         - key : "ils"
         - value : 19.41
       ▿ 33 : 2 elements
         - key : "cad"
         - value : 7.09
       ▿ 34 : 2 elements
         - key : "aed"
         - value : 18.94
       ▿ 35 : 2 elements
         - key : "eth"
         - value : 0.00214462
       ▿ 36 : 2 elements
         - key : "xlm"
         - value : 57.062
       ▿ 37 : 2 elements
         - key : "brl"
         - value : 28.79
       ▿ 38 : 2 elements
         - key : "dot"
         - value : 1.265132
       ▿ 39 : 2 elements
         - key : "gbp"
         - value : 3.95
       ▿ 40 : 2 elements
         - key : "zar"
         - value : 90.24
       ▿ 41 : 2 elements
         - key : "aud"
         - value : 7.66
       ▿ 42 : 2 elements
         - key : "xrp"
         - value : 9.659701
       ▿ 43 : 2 elements
         - key : "vef"
         - value : 0.516284
       ▿ 44 : 2 elements
         - key : "czk"
         - value : 119.53
       ▿ 45 : 2 elements
         - key : "usd"
         - value : 5.16
       ▿ 46 : 2 elements
         - key : "sek"
         - value : 53.62
       ▿ 47 : 2 elements
         - key : "vnd"
         - value : 127992.0
       ▿ 48 : 2 elements
         - key : "ltc"
         - value : 0.07971339
       ▿ 49 : 2 elements
         - key : "mmk"
         - value : 10817.58
       ▿ 50 : 2 elements
         - key : "dkk"
         - value : 35.18
       ▿ 51 : 2 elements
         - key : "eur"
         - value : 4.72
       ▿ 52 : 2 elements
         - key : "xau"
         - value : 0.00194949
       ▿ 53 : 2 elements
         - key : "idr"
         - value : 80560.0
       ▿ 54 : 2 elements
         - key : "jpy"
         - value : 767.11
       ▿ 55 : 2 elements
         - key : "uah"
         - value : 212.6
       ▿ 56 : 2 elements
         - key : "nok"
         - value : 55.39
       ▿ 57 : 2 elements
         - key : "btc"
         - value : 8.513e-05
       ▿ 58 : 2 elements
         - key : "bmd"
         - value : 5.16
       ▿ 59 : 2 elements
         - key : "inr"
         - value : 433.5
       ▿ 60 : 2 elements
         - key : "try"
         - value : 176.83
       ▿ 61 : 2 elements
         - key : "bnb"
         - value : 0.00920205
     - totalValueLocked : nil
     - mcapToTvlRatio : nil
     - fdvToTvlRatio : nil
     - roi : nil
     ▿ ath : 62 elements
       ▿ 0 : 2 elements
         - key : "mxn"
         - value : 152.4
       ▿ 1 : 2 elements
         - key : "bdt"
         - value : 969.73
       ▿ 2 : 2 elements
         - key : "uah"
         - value : 335.77
       ▿ 3 : 2 elements
         - key : "sats"
         - value : 16834.38
       ▿ 4 : 2 elements
         - key : "ltc"
         - value : 0.12201458
       ▿ 5 : 2 elements
         - key : "link"
         - value : 0.69334005
       ▿ 6 : 2 elements
         - key : "eur"
         - value : 7.7
       ▿ 7 : 2 elements
         - key : "inr"
         - value : 689.6
       ▿ 8 : 2 elements
         - key : "try"
         - value : 270.28
       ▿ 9 : 2 elements
         - key : "eos"
         - value : 15.538445
       ▿ 10 : 2 elements
         - key : "thb"
         - value : 302.34
       ▿ 11 : 2 elements
         - key : "zar"
         - value : 151.48
       ▿ 12 : 2 elements
         - key : "sek"
         - value : 87.75
       ▿ 13 : 2 elements
         - key : "xlm"
         - value : 87.636
       ▿ 14 : 2 elements
         - key : "bnb"
         - value : 0.01501474
       ▿ 15 : 2 elements
         - key : "nzd"
         - value : 13.43
       ▿ 16 : 2 elements
         - key : "btc"
         - value : 0.00016834
       ▿ 17 : 2 elements
         - key : "usd"
         - value : 8.25
       ▿ 18 : 2 elements
         - key : "vef"
         - value : 0.826434
       ▿ 19 : 2 elements
         - key : "idr"
         - value : 136073.0
       ▿ 20 : 2 elements
         - key : "mmk"
         - value : 23932.0
       ▿ 21 : 2 elements
         - key : "bmd"
         - value : 8.25
       ▿ 22 : 2 elements
         - key : "sar"
         - value : 30.97
       ▿ 23 : 2 elements
         - key : "myr"
         - value : 38.95
       ▿ 24 : 2 elements
         - key : "kwd"
         - value : 2.53
       ▿ 25 : 2 elements
         - key : "pkr"
         - value : 2298.63
       ▿ 26 : 2 elements
         - key : "sgd"
         - value : 11.17
       ▿ 27 : 2 elements
         - key : "dkk"
         - value : 57.49
       ▿ 28 : 2 elements
         - key : "chf"
         - value : 7.35
       ▿ 29 : 2 elements
         - key : "cny"
         - value : 59.88
       ▿ 30 : 2 elements
         - key : "ils"
         - value : 30.74
       ▿ 31 : 2 elements
         - key : "vnd"
         - value : 210096.0
       ▿ 32 : 2 elements
         - key : "ngn"
         - value : 12343.28
       ▿ 33 : 2 elements
         - key : "cad"
         - value : 11.35
       ▿ 34 : 2 elements
         - key : "huf"
         - value : 3070.92
       ▿ 35 : 2 elements
         - key : "rub"
         - value : 737.11
       ▿ 36 : 2 elements
         - key : "gbp"
         - value : 6.51
       ▿ 37 : 2 elements
         - key : "brl"
         - value : 46.01
       ▿ 38 : 2 elements
         - key : "nok"
         - value : 88.17
       ▿ 39 : 2 elements
         - key : "ars"
         - value : 7446.49
       ▿ 40 : 2 elements
         - key : "xag"
         - value : 0.279041
       ▿ 41 : 2 elements
         - key : "gel"
         - value : 23.69
       ▿ 42 : 2 elements
         - key : "clp"
         - value : 7693.44
       ▿ 43 : 2 elements
         - key : "bhd"
         - value : 3.11
       ▿ 44 : 2 elements
         - key : "bits"
         - value : 168.34
       ▿ 45 : 2 elements
         - key : "xdr"
         - value : 6.25
       ▿ 46 : 2 elements
         - key : "krw"
         - value : 11416.97
       ▿ 47 : 2 elements
         - key : "lkr"
         - value : 2509.59
       ▿ 48 : 2 elements
         - key : "czk"
         - value : 190.64
       ▿ 49 : 2 elements
         - key : "xrp"
         - value : 17.619142
       ▿ 50 : 2 elements
         - key : "twd"
         - value : 266.97
       ▿ 51 : 2 elements
         - key : "jpy"
         - value : 1308.93
       ▿ 52 : 2 elements
         - key : "xau"
         - value : 0.00353775
       ▿ 53 : 2 elements
         - key : "yfi"
         - value : 0.00142455
       ▿ 54 : 2 elements
         - key : "bch"
         - value : 0.02746681
       ▿ 55 : 2 elements
         - key : "dot"
         - value : 1.610262
       ▿ 56 : 2 elements
         - key : "hkd"
         - value : 64.47
       ▿ 57 : 2 elements
         - key : "aed"
         - value : 30.32
       ▿ 58 : 2 elements
         - key : "eth"
         - value : 0.00266997
       ▿ 59 : 2 elements
         - key : "aud"
         - value : 12.48
       ▿ 60 : 2 elements
         - key : "php"
         - value : 484.49
       ▿ 61 : 2 elements
         - key : "pln"
         - value : 33.78
     ▿ athChangePercentage : 62 elements
       ▿ 0 : 2 elements
         - key : "pln"
         - value : -40.00978
       ▿ 1 : 2 elements
         - key : "bhd"
         - value : -37.48618
       ▿ 2 : 2 elements
         - key : "rub"
         - value : -32.2447
       ▿ 3 : 2 elements
         - key : "php"
         - value : -39.11505
       ▿ 4 : 2 elements
         - key : "bits"
         - value : -49.48601
       ▿ 5 : 2 elements
         - key : "clp"
         - value : -37.72211
       ▿ 6 : 2 elements
         - key : "eos"
         - value : -28.6621
       ▿ 7 : 2 elements
         - key : "bnb"
         - value : -38.82233
       ▿ 8 : 2 elements
         - key : "dkk"
         - value : -38.87067
       ▿ 9 : 2 elements
         - key : "xag"
         - value : -40.89145
       ▿ 10 : 2 elements
         - key : "brl"
         - value : -37.48363
       ▿ 11 : 2 elements
         - key : "xlm"
         - value : -34.91138
       ▿ 12 : 2 elements
         - key : "thb"
         - value : -43.19089
       ▿ 13 : 2 elements
         - key : "xau"
         - value : -44.94339
       ▿ 14 : 2 elements
         - key : "usd"
         - value : -37.58552
       ▿ 15 : 2 elements
         - key : "vnd"
         - value : -39.13483
       ▿ 16 : 2 elements
         - key : "mxn"
         - value : -34.26065
       ▿ 17 : 2 elements
         - key : "nzd"
         - value : -37.08423
       ▿ 18 : 2 elements
         - key : "aed"
         - value : -37.5856
       ▿ 19 : 2 elements
         - key : "pkr"
         - value : -37.74494
       ▿ 20 : 2 elements
         - key : "ngn"
         - value : -32.38577
       ▿ 21 : 2 elements
         - key : "eur"
         - value : -38.80053
       ▿ 22 : 2 elements
         - key : "bdt"
         - value : -36.51149
       ▿ 23 : 2 elements
         - key : "aud"
         - value : -38.75339
       ▿ 24 : 2 elements
         - key : "cny"
         - value : -39.15463
       ▿ 25 : 2 elements
         - key : "chf"
         - value : -39.9521
       ▿ 26 : 2 elements
         - key : "krw"
         - value : -39.16522
       ▿ 27 : 2 elements
         - key : "link"
         - value : -29.88969
       ▿ 28 : 2 elements
         - key : "vef"
         - value : -37.58552
       ▿ 29 : 2 elements
         - key : "kwd"
         - value : -37.54232
       ▿ 30 : 2 elements
         - key : "huf"
         - value : -38.47957
       ▿ 31 : 2 elements
         - key : "lkr"
         - value : -39.87339
       ▿ 32 : 2 elements
         - key : "hkd"
         - value : -37.90153
       ▿ 33 : 2 elements
         - key : "nok"
         - value : -37.28114
       ▿ 34 : 2 elements
         - key : "yfi"
         - value : -25.82067
       ▿ 35 : 2 elements
         - key : "xdr"
         - value : -38.71228
       ▿ 36 : 2 elements
         - key : "ars"
         - value : -32.56816
       ▿ 37 : 2 elements
         - key : "sats"
         - value : -49.48601
       ▿ 38 : 2 elements
         - key : "bmd"
         - value : -37.58552
       ▿ 39 : 2 elements
         - key : "sgd"
         - value : -39.78252
       ▿ 40 : 2 elements
         - key : "czk"
         - value : -37.38907
       ▿ 41 : 2 elements
         - key : "gel"
         - value : -40.73886
       ▿ 42 : 2 elements
         - key : "cad"
         - value : -37.57762
       ▿ 43 : 2 elements
         - key : "xrp"
         - value : -45.21958
       ▿ 44 : 2 elements
         - key : "dot"
         - value : -21.66553
       ▿ 45 : 2 elements
         - key : "ils"
         - value : -36.89537
       ▿ 46 : 2 elements
         - key : "sar"
         - value : -37.53267
       ▿ 47 : 2 elements
         - key : "gbp"
         - value : -39.40225
       ▿ 48 : 2 elements
         - key : "myr"
         - value : -43.30523
       ▿ 49 : 2 elements
         - key : "twd"
         - value : -37.9122
       ▿ 50 : 2 elements
         - key : "idr"
         - value : -40.88616
       ▿ 51 : 2 elements
         - key : "try"
         - value : -34.64323
       ▿ 52 : 2 elements
         - key : "bch"
         - value : -41.78698
       ▿ 53 : 2 elements
         - key : "inr"
         - value : -37.25877
       ▿ 54 : 2 elements
         - key : "eth"
         - value : -19.7688
       ▿ 55 : 2 elements
         - key : "zar"
         - value : -40.43884
       ▿ 56 : 2 elements
         - key : "sek"
         - value : -39.00471
       ▿ 57 : 2 elements
         - key : "btc"
         - value : -49.48601
       ▿ 58 : 2 elements
         - key : "jpy"
         - value : -41.47921
       ▿ 59 : 2 elements
         - key : "mmk"
         - value : -54.84005
       ▿ 60 : 2 elements
         - key : "uah"
         - value : -36.74203
       ▿ 61 : 2 elements
         - key : "ltc"
         - value : -34.71724
     ▿ athDate : 62 elements
       ▿ 0 : 2 elements
         - key : "uah"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 1 : 2 elements
         - key : "thb"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 2 : 2 elements
         - key : "clp"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 3 : 2 elements
         - key : "myr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 4 : 2 elements
         - key : "eth"
         - value : "2024-08-18T22:50:22.380Z"
       ▿ 5 : 2 elements
         - key : "nok"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 6 : 2 elements
         - key : "krw"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 7 : 2 elements
         - key : "sar"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 8 : 2 elements
         - key : "try"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 9 : 2 elements
         - key : "xlm"
         - value : "2024-07-03T21:51:31.162Z"
       ▿ 10 : 2 elements
         - key : "eos"
         - value : "2024-07-06T08:36:05.215Z"
       ▿ 11 : 2 elements
         - key : "ltc"
         - value : "2024-07-06T08:36:05.215Z"
       ▿ 12 : 2 elements
         - key : "idr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 13 : 2 elements
         - key : "zar"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 14 : 2 elements
         - key : "dot"
         - value : "2024-08-14T19:25:35.077Z"
       ▿ 15 : 2 elements
         - key : "czk"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 16 : 2 elements
         - key : "cny"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 17 : 2 elements
         - key : "kwd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 18 : 2 elements
         - key : "gel"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 19 : 2 elements
         - key : "chf"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 20 : 2 elements
         - key : "bhd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 21 : 2 elements
         - key : "mxn"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 22 : 2 elements
         - key : "php"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 23 : 2 elements
         - key : "gbp"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 24 : 2 elements
         - key : "ngn"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 25 : 2 elements
         - key : "pkr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 26 : 2 elements
         - key : "hkd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 27 : 2 elements
         - key : "btc"
         - value : "2022-12-18T14:10:00.817Z"
       ▿ 28 : 2 elements
         - key : "inr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 29 : 2 elements
         - key : "vnd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 30 : 2 elements
         - key : "sgd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 31 : 2 elements
         - key : "vef"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 32 : 2 elements
         - key : "dkk"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 33 : 2 elements
         - key : "jpy"
         - value : "2024-07-03T00:26:06.921Z"
       ▿ 34 : 2 elements
         - key : "usd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 35 : 2 elements
         - key : "ars"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 36 : 2 elements
         - key : "ils"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 37 : 2 elements
         - key : "aud"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 38 : 2 elements
         - key : "sats"
         - value : "2022-12-18T14:10:00.817Z"
       ▿ 39 : 2 elements
         - key : "huf"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 40 : 2 elements
         - key : "twd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 41 : 2 elements
         - key : "xrp"
         - value : "2024-07-06T08:36:05.215Z"
       ▿ 42 : 2 elements
         - key : "cad"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 43 : 2 elements
         - key : "sek"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 44 : 2 elements
         - key : "rub"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 45 : 2 elements
         - key : "pln"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 46 : 2 elements
         - key : "link"
         - value : "2024-08-19T03:15:31.420Z"
       ▿ 47 : 2 elements
         - key : "eur"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 48 : 2 elements
         - key : "xag"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 49 : 2 elements
         - key : "mmk"
         - value : "2024-07-20T17:17:06.389Z"
       ▿ 50 : 2 elements
         - key : "aed"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 51 : 2 elements
         - key : "brl"
         - value : "2024-07-03T00:26:06.921Z"
       ▿ 52 : 2 elements
         - key : "bch"
         - value : "2022-12-18T14:10:00.817Z"
       ▿ 53 : 2 elements
         - key : "bits"
         - value : "2022-12-18T14:10:00.817Z"
       ▿ 54 : 2 elements
         - key : "bdt"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 55 : 2 elements
         - key : "xdr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 56 : 2 elements
         - key : "nzd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 57 : 2 elements
         - key : "bmd"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 58 : 2 elements
         - key : "bnb"
         - value : "2024-07-06T08:36:05.215Z"
       ▿ 59 : 2 elements
         - key : "lkr"
         - value : "2024-06-15T00:36:51.509Z"
       ▿ 60 : 2 elements
         - key : "yfi"
         - value : "2024-08-14T10:35:20.071Z"
       ▿ 61 : 2 elements
         - key : "xau"
         - value : "2024-06-15T00:36:51.509Z"
     ▿ atl : 62 elements
       ▿ 0 : 2 elements
         - key : "sats"
         - value : 1014.64
       ▿ 1 : 2 elements
         - key : "huf"
         - value : 156.82
       ▿ 2 : 2 elements
         - key : "brl"
         - value : 2.77
       ▿ 3 : 2 elements
         - key : "clp"
         - value : 409.78
       ▿ 4 : 2 elements
         - key : "aud"
         - value : 0.71559
       ▿ 5 : 2 elements
         - key : "eth"
         - value : 0.00016037
       ▿ 6 : 2 elements
         - key : "ars"
         - value : 51.1
       ▿ 7 : 2 elements
         - key : "xlm"
         - value : 1.549493
       ▿ 8 : 2 elements
         - key : "chf"
         - value : 0.481832
       ▿ 9 : 2 elements
         - key : "sek"
         - value : 4.5
       ▿ 10 : 2 elements
         - key : "idr"
         - value : 7413.53
       ▿ 11 : 2 elements
         - key : "jpy"
         - value : 56.86
       ▿ 12 : 2 elements
         - key : "dkk"
         - value : 3.29
       ▿ 13 : 2 elements
         - key : "hkd"
         - value : 4.04
       ▿ 14 : 2 elements
         - key : "thb"
         - value : 17.31
       ▿ 15 : 2 elements
         - key : "uah"
         - value : 13.88
       ▿ 16 : 2 elements
         - key : "bdt"
         - value : 44.27
       ▿ 17 : 2 elements
         - key : "aed"
         - value : 1.91
       ▿ 18 : 2 elements
         - key : "vnd"
         - value : 11811.76
       ▿ 19 : 2 elements
         - key : "eos"
         - value : 0.10574021
       ▿ 20 : 2 elements
         - key : "xrp"
         - value : 0.4709888
       ▿ 21 : 2 elements
         - key : "inr"
         - value : 38.25
       ▿ 22 : 2 elements
         - key : "yfi"
         - value : 1.43e-05
       ▿ 23 : 2 elements
         - key : "xag"
         - value : 0.02231533
       ▿ 24 : 2 elements
         - key : "xdr"
         - value : 0.366438
       ▿ 25 : 2 elements
         - key : "link"
         - value : 0.02087333
       ▿ 26 : 2 elements
         - key : "zar"
         - value : 7.68
       ▿ 27 : 2 elements
         - key : "gbp"
         - value : 0.380291
       ▿ 28 : 2 elements
         - key : "pkr"
         - value : 87.62
       ▿ 29 : 2 elements
         - key : "ils"
         - value : 1.67
       ▿ 30 : 2 elements
         - key : "krw"
         - value : 616.42
       ▿ 31 : 2 elements
         - key : "mxn"
         - value : 10.44
       ▿ 32 : 2 elements
         - key : "lkr"
         - value : 103.63
       ▿ 33 : 2 elements
         - key : "sar"
         - value : 1.95
       ▿ 34 : 2 elements
         - key : "ngn"
         - value : 213.9
       ▿ 35 : 2 elements
         - key : "nok"
         - value : 4.53
       ▿ 36 : 2 elements
         - key : "bits"
         - value : 10.15
       ▿ 37 : 2 elements
         - key : "dot"
         - value : 0.01423498
       ▿ 38 : 2 elements
         - key : "usd"
         - value : 0.519364
       ▿ 39 : 2 elements
         - key : "rub"
         - value : 38.16
       ▿ 40 : 2 elements
         - key : "bnb"
         - value : 0.00110744
       ▿ 41 : 2 elements
         - key : "try"
         - value : 4.49
       ▿ 42 : 2 elements
         - key : "bch"
         - value : 0.0007924
       ▿ 43 : 2 elements
         - key : "php"
         - value : 26.1
       ▿ 44 : 2 elements
         - key : "bhd"
         - value : 0.195816
       ▿ 45 : 2 elements
         - key : "btc"
         - value : 1.015e-05
       ▿ 46 : 2 elements
         - key : "vef"
         - value : 0.052004
       ▿ 47 : 2 elements
         - key : "czk"
         - value : 11.28
       ▿ 48 : 2 elements
         - key : "xau"
         - value : 0.00029452
       ▿ 49 : 2 elements
         - key : "cny"
         - value : 3.36
       ▿ 50 : 2 elements
         - key : "ltc"
         - value : 0.00300657
       ▿ 51 : 2 elements
         - key : "sgd"
         - value : 0.702047
       ▿ 52 : 2 elements
         - key : "mmk"
         - value : 881.26
       ▿ 53 : 2 elements
         - key : "gel"
         - value : 5.32
       ▿ 54 : 2 elements
         - key : "nzd"
         - value : 0.740499
       ▿ 55 : 2 elements
         - key : "myr"
         - value : 2.18
       ▿ 56 : 2 elements
         - key : "eur"
         - value : 0.44288
       ▿ 57 : 2 elements
         - key : "twd"
         - value : 14.43
       ▿ 58 : 2 elements
         - key : "pln"
         - value : 2.04
       ▿ 59 : 2 elements
         - key : "bmd"
         - value : 0.519364
       ▿ 60 : 2 elements
         - key : "cad"
         - value : 0.66502
       ▿ 61 : 2 elements
         - key : "kwd"
         - value : 0.156347
     ▿ atlChangePercentage : 62 elements
       ▿ 0 : 2 elements
         - key : "czk"
         - value : 958.38958
       ▿ 1 : 2 elements
         - key : "jpy"
         - value : 1247.06187
       ▿ 2 : 2 elements
         - key : "krw"
         - value : 1026.74224
       ▿ 3 : 2 elements
         - key : "nok"
         - value : 1121.9643
       ▿ 4 : 2 elements
         - key : "brl"
         - value : 939.91222
       ▿ 5 : 2 elements
         - key : "zar"
         - value : 1074.50904
       ▿ 6 : 2 elements
         - key : "usd"
         - value : 891.87625
       ▿ 7 : 2 elements
         - key : "idr"
         - value : 985.01676
       ▿ 8 : 2 elements
         - key : "bits"
         - value : 738.09838
       ▿ 9 : 2 elements
         - key : "sek"
         - value : 1088.11712
       ▿ 10 : 2 elements
         - key : "xag"
         - value : 639.12068
       ▿ 11 : 2 elements
         - key : "aud"
         - value : 968.56383
       ▿ 12 : 2 elements
         - key : "sats"
         - value : 738.09838
       ▿ 13 : 2 elements
         - key : "huf"
         - value : 1104.74962
       ▿ 14 : 2 elements
         - key : "pln"
         - value : 893.40121
       ▿ 15 : 2 elements
         - key : "yfi"
         - value : 7287.36775
       ▿ 16 : 2 elements
         - key : "bhd"
         - value : 891.74735
       ▿ 17 : 2 elements
         - key : "twd"
         - value : 1048.88501
       ▿ 18 : 2 elements
         - key : "nzd"
         - value : 1041.00195
       ▿ 19 : 2 elements
         - key : "chf"
         - value : 816.50305
       ▿ 20 : 2 elements
         - key : "lkr"
         - value : 1356.12994
       ▿ 21 : 2 elements
         - key : "vef"
         - value : 891.87625
       ▿ 22 : 2 elements
         - key : "hkd"
         - value : 889.89316
       ▿ 23 : 2 elements
         - key : "vnd"
         - value : 982.6089
       ▿ 24 : 2 elements
         - key : "cad"
         - value : 965.52352
       ▿ 25 : 2 elements
         - key : "inr"
         - value : 1031.01627
       ▿ 26 : 2 elements
         - key : "clp"
         - value : 1069.24485
       ▿ 27 : 2 elements
         - key : "dkk"
         - value : 967.17275
       ▿ 28 : 2 elements
         - key : "gel"
         - value : 163.89843
       ▿ 29 : 2 elements
         - key : "php"
         - value : 1030.23513
       ▿ 30 : 2 elements
         - key : "xdr"
         - value : 945.98337
       ▿ 31 : 2 elements
         - key : "xlm"
         - value : 3581.29055
       ▿ 32 : 2 elements
         - key : "cny"
         - value : 984.92361
       ▿ 33 : 2 elements
         - key : "sar"
         - value : 893.1934
       ▿ 34 : 2 elements
         - key : "eur"
         - value : 963.66598
       ▿ 35 : 2 elements
         - key : "myr"
         - value : 914.23339
       ▿ 36 : 2 elements
         - key : "pkr"
         - value : 1533.26595
       ▿ 37 : 2 elements
         - key : "bnb"
         - value : 729.45171
       ▿ 38 : 2 elements
         - key : "eth"
         - value : 1235.73118
       ▿ 39 : 2 elements
         - key : "gbp"
         - value : 937.8597
       ▿ 40 : 2 elements
         - key : "btc"
         - value : 738.09838
       ▿ 41 : 2 elements
         - key : "link"
         - value : 2228.82262
       ▿ 42 : 2 elements
         - key : "rub"
         - value : 1208.7536
       ▿ 43 : 2 elements
         - key : "dot"
         - value : 8761.2048
       ▿ 44 : 2 elements
         - key : "xau"
         - value : 561.33246
       ▿ 45 : 2 elements
         - key : "bdt"
         - value : 1290.76196
       ▿ 46 : 2 elements
         - key : "ngn"
         - value : 3801.73316
       ▿ 47 : 2 elements
         - key : "sgd"
         - value : 858.27595
       ▿ 48 : 2 elements
         - key : "aed"
         - value : 891.8209
       ▿ 49 : 2 elements
         - key : "uah"
         - value : 1430.72772
       ▿ 50 : 2 elements
         - key : "thb"
         - value : 892.33758
       ▿ 51 : 2 elements
         - key : "ltc"
         - value : 2549.34395
       ▿ 52 : 2 elements
         - key : "ils"
         - value : 1062.932
       ▿ 53 : 2 elements
         - key : "ars"
         - value : 9727.29561
       ▿ 54 : 2 elements
         - key : "xrp"
         - value : 1949.27151
       ▿ 55 : 2 elements
         - key : "try"
         - value : 3833.4225
       ▿ 56 : 2 elements
         - key : "bch"
         - value : 1917.83295
       ▿ 57 : 2 elements
         - key : "mmk"
         - value : 1126.39012
       ▿ 58 : 2 elements
         - key : "kwd"
         - value : 909.95194
       ▿ 59 : 2 elements
         - key : "bmd"
         - value : 891.87625
       ▿ 60 : 2 elements
         - key : "mxn"
         - value : 859.50338
       ▿ 61 : 2 elements
         - key : "eos"
         - value : 10383.05079
     ▿ atlDate : 62 elements
       ▿ 0 : 2 elements
         - key : "ils"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 1 : 2 elements
         - key : "sar"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 2 : 2 elements
         - key : "xdr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 3 : 2 elements
         - key : "thb"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 4 : 2 elements
         - key : "eos"
         - value : "2021-08-29T07:23:57.101Z"
       ▿ 5 : 2 elements
         - key : "eth"
         - value : "2021-10-21T09:24:28.275Z"
       ▿ 6 : 2 elements
         - key : "pln"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 7 : 2 elements
         - key : "sats"
         - value : "2021-10-19T11:57:44.931Z"
       ▿ 8 : 2 elements
         - key : "lkr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 9 : 2 elements
         - key : "php"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 10 : 2 elements
         - key : "cny"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 11 : 2 elements
         - key : "bnb"
         - value : "2021-08-29T07:35:41.250Z"
       ▿ 12 : 2 elements
         - key : "dkk"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 13 : 2 elements
         - key : "rub"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 14 : 2 elements
         - key : "ars"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 15 : 2 elements
         - key : "kwd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 16 : 2 elements
         - key : "xrp"
         - value : "2021-08-29T07:23:57.101Z"
       ▿ 17 : 2 elements
         - key : "uah"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 18 : 2 elements
         - key : "aed"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 19 : 2 elements
         - key : "hkd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 20 : 2 elements
         - key : "inr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 21 : 2 elements
         - key : "aud"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 22 : 2 elements
         - key : "btc"
         - value : "2021-10-19T11:57:44.931Z"
       ▿ 23 : 2 elements
         - key : "gel"
         - value : "2023-12-13T04:35:18.998Z"
       ▿ 24 : 2 elements
         - key : "sek"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 25 : 2 elements
         - key : "myr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 26 : 2 elements
         - key : "gbp"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 27 : 2 elements
         - key : "huf"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 28 : 2 elements
         - key : "mxn"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 29 : 2 elements
         - key : "mmk"
         - value : "2021-08-30T04:52:38.375Z"
       ▿ 30 : 2 elements
         - key : "clp"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 31 : 2 elements
         - key : "dot"
         - value : "2021-11-03T19:11:30.146Z"
       ▿ 32 : 2 elements
         - key : "ltc"
         - value : "2021-08-29T07:45:09.076Z"
       ▿ 33 : 2 elements
         - key : "vef"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 34 : 2 elements
         - key : "brl"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 35 : 2 elements
         - key : "zar"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 36 : 2 elements
         - key : "xag"
         - value : "2021-08-30T04:52:38.375Z"
       ▿ 37 : 2 elements
         - key : "cad"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 38 : 2 elements
         - key : "yfi"
         - value : "2021-08-29T07:23:57.101Z"
       ▿ 39 : 2 elements
         - key : "eur"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 40 : 2 elements
         - key : "bits"
         - value : "2021-10-19T11:57:44.931Z"
       ▿ 41 : 2 elements
         - key : "pkr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 42 : 2 elements
         - key : "czk"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 43 : 2 elements
         - key : "bmd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 44 : 2 elements
         - key : "usd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 45 : 2 elements
         - key : "try"
         - value : "2021-08-30T04:52:38.375Z"
       ▿ 46 : 2 elements
         - key : "nzd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 47 : 2 elements
         - key : "link"
         - value : "2021-08-29T07:23:57.101Z"
       ▿ 48 : 2 elements
         - key : "chf"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 49 : 2 elements
         - key : "bch"
         - value : "2021-08-29T07:23:57.101Z"
       ▿ 50 : 2 elements
         - key : "bdt"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 51 : 2 elements
         - key : "idr"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 52 : 2 elements
         - key : "ngn"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 53 : 2 elements
         - key : "bhd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 54 : 2 elements
         - key : "sgd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 55 : 2 elements
         - key : "xau"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 56 : 2 elements
         - key : "jpy"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 57 : 2 elements
         - key : "krw"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 58 : 2 elements
         - key : "nok"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 59 : 2 elements
         - key : "twd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 60 : 2 elements
         - key : "vnd"
         - value : "2021-09-21T00:33:11.092Z"
       ▿ 61 : 2 elements
         - key : "xlm"
         - value : "2021-08-29T07:18:38.078Z"
     ▿ marketCap : 62 elements
       ▿ 0 : 2 elements
         - key : "sek"
         - value : 136033020981.0
       ▿ 1 : 2 elements
         - key : "lkr"
         - value : 3831477188074.0
       ▿ 2 : 2 elements
         - key : "ltc"
         - value : 202229214.0
       ▿ 3 : 2 elements
         - key : "brl"
         - value : 73031472567.0
       ▿ 4 : 2 elements
         - key : "bch"
         - value : 40615964.0
       ▿ 5 : 2 elements
         - key : "kwd"
         - value : 4009484352.0
       ▿ 6 : 2 elements
         - key : "hkd"
         - value : 101646475474.0
       ▿ 7 : 2 elements
         - key : "xrp"
         - value : 24505996059.0
       ▿ 8 : 2 elements
         - key : "sats"
         - value : 21595191709591.0
       ▿ 9 : 2 elements
         - key : "pln"
         - value : 51474120664.0
       ▿ 10 : 2 elements
         - key : "uah"
         - value : 539330989265.0
       ▿ 11 : 2 elements
         - key : "mmk"
         - value : 27443048689978.0
       ▿ 12 : 2 elements
         - key : "krw"
         - value : 17648998049892.0
       ▿ 13 : 2 elements
         - key : "ngn"
         - value : 21191710558697.0
       ▿ 14 : 2 elements
         - key : "bnb"
         - value : 23344121.0
       ▿ 15 : 2 elements
         - key : "idr"
         - value : 204372828701045.0
       ▿ 16 : 2 elements
         - key : "vef"
         - value : 1309758086.0
       ▿ 17 : 2 elements
         - key : "clp"
         - value : 12166113039114.0
       ▿ 18 : 2 elements
         - key : "xlm"
         - value : 144752076622.0
       ▿ 19 : 2 elements
         - key : "sar"
         - value : 49119603883.0
       ▿ 20 : 2 elements
         - key : "pkr"
         - value : 3633635580302.0
       ▿ 21 : 2 elements
         - key : "czk"
         - value : 303233915506.0
       ▿ 22 : 2 elements
         - key : "vnd"
         - value : 324700953931194.0
       ▿ 23 : 2 elements
         - key : "myr"
         - value : 56096050671.0
       ▿ 24 : 2 elements
         - key : "gel"
         - value : 35644569914.0
       ▿ 25 : 2 elements
         - key : "xau"
         - value : 4945635.0
       ▿ 26 : 2 elements
         - key : "cny"
         - value : 92552924362.0
       ▿ 27 : 2 elements
         - key : "eth"
         - value : 5441093.0
       ▿ 28 : 2 elements
         - key : "bhd"
         - value : 4931128665.0
       ▿ 29 : 2 elements
         - key : "xdr"
         - value : 9732458772.0
       ▿ 30 : 2 elements
         - key : "zar"
         - value : 228935602222.0
       ▿ 31 : 2 elements
         - key : "xag"
         - value : 419755164.0
       ▿ 32 : 2 elements
         - key : "eur"
         - value : 11962814725.0
       ▿ 33 : 2 elements
         - key : "php"
         - value : 749556226976.0
       ▿ 34 : 2 elements
         - key : "aed"
         - value : 48044825266.0
       ▿ 35 : 2 elements
         - key : "dot"
         - value : 3209889134.0
       ▿ 36 : 2 elements
         - key : "ars"
         - value : 12750234013890.0
       ▿ 37 : 2 elements
         - key : "yfi"
         - value : 2681359.0
       ▿ 38 : 2 elements
         - key : "rub"
         - value : 1267936201363.0
       ▿ 39 : 2 elements
         - key : "bits"
         - value : 215951917096.0
       ▿ 40 : 2 elements
         - key : "cad"
         - value : 17996021169.0
       ▿ 41 : 2 elements
         - key : "nok"
         - value : 140516715459.0
       ▿ 42 : 2 elements
         - key : "inr"
         - value : 1099753347989.0
       ▿ 43 : 2 elements
         - key : "nzd"
         - value : 21473322282.0
       ▿ 44 : 2 elements
         - key : "ils"
         - value : 49231298922.0
       ▿ 45 : 2 elements
         - key : "huf"
         - value : 4800803313702.0
       ▿ 46 : 2 elements
         - key : "dkk"
         - value : 89249241736.0
       ▿ 47 : 2 elements
         - key : "bmd"
         - value : 13080576115.0
       ▿ 48 : 2 elements
         - key : "gbp"
         - value : 10025005857.0
       ▿ 49 : 2 elements
         - key : "eos"
         - value : 28145343342.0
       ▿ 50 : 2 elements
         - key : "jpy"
         - value : 1946075792135.0
       ▿ 51 : 2 elements
         - key : "link"
         - value : 1234743753.0
       ▿ 52 : 2 elements
         - key : "twd"
         - value : 421109501008.0
       ▿ 53 : 2 elements
         - key : "thb"
         - value : 436158729990.0
       ▿ 54 : 2 elements
         - key : "chf"
         - value : 11220060372.0
       ▿ 55 : 2 elements
         - key : "sgd"
         - value : 17087941414.0
       ▿ 56 : 2 elements
         - key : "bdt"
         - value : 1563302111094.0
       ▿ 57 : 2 elements
         - key : "aud"
         - value : 19425728139.0
       ▿ 58 : 2 elements
         - key : "mxn"
         - value : 254255869618.0
       ▿ 59 : 2 elements
         - key : "usd"
         - value : 13080576115.0
       ▿ 60 : 2 elements
         - key : "btc"
         - value : 215952.0
       ▿ 61 : 2 elements
         - key : "try"
         - value : 448609960347.0
     - marketCapRank : 11
     ▿ fullyDilutedValuation : 62 elements
       ▿ 0 : 2 elements
         - key : "usd"
         - value : 26363042523.0
       ▿ 1 : 2 elements
         - key : "cny"
         - value : 186534343676.0
       ▿ 2 : 2 elements
         - key : "xlm"
         - value : 291738308592.0
       ▿ 3 : 2 elements
         - key : "eur"
         - value : 24110267813.0
       ▿ 4 : 2 elements
         - key : "bits"
         - value : 435236913354.0
       ▿ 5 : 2 elements
         - key : "lkr"
         - value : 7722090766075.0
       ▿ 6 : 2 elements
         - key : "clp"
         - value : 24520002220243.0
       ▿ 7 : 2 elements
         - key : "nok"
         - value : 283202216184.0
       ▿ 8 : 2 elements
         - key : "ltc"
         - value : 407579705.0
       ▿ 9 : 2 elements
         - key : "dkk"
         - value : 179875988204.0
       ▿ 10 : 2 elements
         - key : "aed"
         - value : 96831191557.0
       ▿ 11 : 2 elements
         - key : "zar"
         - value : 461404678449.0
       ▿ 12 : 2 elements
         - key : "inr"
         - value : 2216480682673.0
       ▿ 13 : 2 elements
         - key : "aud"
         - value : 39151279916.0
       ▿ 14 : 2 elements
         - key : "chf"
         - value : 22613295170.0
       ▿ 15 : 2 elements
         - key : "myr"
         - value : 113057907860.0
       ▿ 16 : 2 elements
         - key : "ngn"
         - value : 42710501561132.0
       ▿ 17 : 2 elements
         - key : "try"
         - value : 904143927346.0
       ▿ 18 : 2 elements
         - key : "dot"
         - value : 6469320846.0
       ▿ 19 : 2 elements
         - key : "mmk"
         - value : 55309663213312.0
       ▿ 20 : 2 elements
         - key : "czk"
         - value : 611148051769.0
       ▿ 21 : 2 elements
         - key : "sar"
         - value : 98997337309.0
       ▿ 22 : 2 elements
         - key : "xrp"
         - value : 49390226430.0
       ▿ 23 : 2 elements
         - key : "nzd"
         - value : 43278071504.0
       ▿ 24 : 2 elements
         - key : "vef"
         - value : 2639731448.0
       ▿ 25 : 2 elements
         - key : "ils"
         - value : 99222451329.0
       ▿ 26 : 2 elements
         - key : "xau"
         - value : 9967603.0
       ▿ 27 : 2 elements
         - key : "yfi"
         - value : 5404103.0
       ▿ 28 : 2 elements
         - key : "kwd"
         - value : 8080852520.0
       ▿ 29 : 2 elements
         - key : "pkr"
         - value : 7323353992364.0
       ▿ 30 : 2 elements
         - key : "php"
         - value : 1510681372971.0
       ▿ 31 : 2 elements
         - key : "twd"
         - value : 848718556739.0
       ▿ 32 : 2 elements
         - key : "ars"
         - value : 25697259701934.0
       ▿ 33 : 2 elements
         - key : "huf"
         - value : 9675703943606.0
       ▿ 34 : 2 elements
         - key : "mxn"
         - value : 512436015306.0
       ▿ 35 : 2 elements
         - key : "uah"
         - value : 1086986206006.0
       ▿ 36 : 2 elements
         - key : "eth"
         - value : 10966167.0
       ▿ 37 : 2 elements        - key : "bmd"
         - value : 26363042523.0
       ▿ 38 : 2 elements
         - key : "thb"
         - value : 879049289888.0
       ▿ 39 : 2 elements
         - key : "gbp"
         - value : 20204741242.0
       ▿ 40 : 2 elements
         - key : "sats"
         - value : 43523691335380.0
       ▿ 41 : 2 elements
         - key : "jpy"
         - value : 3922188014406.0
       ▿ 42 : 2 elements
         - key : "btc"
         - value : 435237.0
       ▿ 43 : 2 elements
         - key : "eos"
         - value : 56725091983.0
       ▿ 44 : 2 elements
         - key : "pln"
         - value : 103742711326.0
       ▿ 45 : 2 elements
         - key : "bhd"
         - value : 9938366133.0
       ▿ 46 : 2 elements
         - key : "bch"
         - value : 81858809.0
       ▿ 47 : 2 elements
         - key : "krw"
         - value : 35570397050982.0
       ▿ 48 : 2 elements
         - key : "sgd"
         - value : 34439624230.0
       ▿ 49 : 2 elements
         - key : "sek"
         - value : 274165624283.0
       ▿ 50 : 2 elements
         - key : "brl"
         - value : 147190139015.0
       ▿ 51 : 2 elements
         - key : "bdt"
         - value : 3150732786363.0
       ▿ 52 : 2 elements
         - key : "xdr"
         - value : 19615131796.0
       ▿ 53 : 2 elements
         - key : "idr"
         - value : 411900020770460.0
       ▿ 54 : 2 elements
         - key : "cad"
         - value : 36269799368.0
       ▿ 55 : 2 elements
         - key : "hkd"
         - value : 204861799023.0
       ▿ 56 : 2 elements
         - key : "gel"
         - value : 71839290875.0
       ▿ 57 : 2 elements
         - key : "bnb"
         - value : 47048543.0
       ▿ 58 : 2 elements
         - key : "link"
         - value : 2488544982.0
       ▿ 59 : 2 elements
         - key : "rub"
         - value : 2555442183761.0
       ▿ 60 : 2 elements
         - key : "vnd"
         - value : 654413458572259.0
       ▿ 61 : 2 elements
         - key : "xag"
         - value : 845988980.0
     - marketCapFdvRatio : 0.5
     ▿ totalVolume : 62 elements
       ▿ 0 : 2 elements
         - key : "xau"
         - value : 81466.0
       ▿ 1 : 2 elements
         - key : "jpy"
         - value : 32056500457.0
       ▿ 2 : 2 elements
         - key : "vnd"
         - value : 5348597582887.0
       ▿ 3 : 2 elements
         - key : "cny"
         - value : 1524566964.0
       ▿ 4 : 2 elements
         - key : "cad"
         - value : 296437304.0
       ▿ 5 : 2 elements
         - key : "huf"
         - value : 79080657721.0
       ▿ 6 : 2 elements
         - key : "eos"
         - value : 463656837.0
       ▿ 7 : 2 elements
         - key : "bnb"
         - value : 384541.0
       ▿ 8 : 2 elements
         - key : "czk"
         - value : 4994984363.0
       ▿ 9 : 2 elements
         - key : "xdr"
         - value : 160316762.0
       ▿ 10 : 2 elements
         - key : "bch"
         - value : 669007.0
       ▿ 11 : 2 elements
         - key : "bhd"
         - value : 81227426.0
       ▿ 12 : 2 elements
         - key : "dot"
         - value : 52868165.0
       ▿ 13 : 2 elements
         - key : "zar"
         - value : 3771114294.0
       ▿ 14 : 2 elements
         - key : "kwd"
         - value : 66045751.0
       ▿ 15 : 2 elements
         - key : "php"
         - value : 12346975195.0
       ▿ 16 : 2 elements
         - key : "ars"
         - value : 210026703039.0
       ▿ 17 : 2 elements
         - key : "ltc"
         - value : 3331116.0
       ▿ 18 : 2 elements
         - key : "aud"
         - value : 319987981.0
       ▿ 19 : 2 elements
         - key : "sek"
         - value : 2240787649.0
       ▿ 20 : 2 elements
         - key : "link"
         - value : 20339104.0
       ▿ 21 : 2 elements
         - key : "sgd"
         - value : 281479069.0
       ▿ 22 : 2 elements
         - key : "dkk"
         - value : 1470147447.0
       ▿ 23 : 2 elements
         - key : "pkr"
         - value : 59854626993.0
       ▿ 24 : 2 elements
         - key : "vef"
         - value : 21574833.0
       ▿ 25 : 2 elements
         - key : "lkr"
         - value : 63113549187.0
       ▿ 26 : 2 elements
         - key : "nzd"
         - value : 353716730.0
       ▿ 27 : 2 elements
         - key : "nok"
         - value : 2314644769.0
       ▿ 28 : 2 elements
         - key : "gel"
         - value : 587150910.0
       ▿ 29 : 2 elements
         - key : "inr"
         - value : 18115555337.0
       ▿ 30 : 2 elements
         - key : "aed"
         - value : 791412631.0
       ▿ 31 : 2 elements
         - key : "usd"
         - value : 215468224.0
       ▿ 32 : 2 elements
         - key : "ils"
         - value : 810956676.0
       ▿ 33 : 2 elements
         - key : "sar"
         - value : 809116793.0
       ▿ 34 : 2 elements
         - key : "bmd"
         - value : 215468224.0
       ▿ 35 : 2 elements
         - key : "thb"
         - value : 7184572453.0
       ▿ 36 : 2 elements
         - key : "uah"
         - value : 8884065139.0
       ▿ 37 : 2 elements
         - key : "eur"
         - value : 197056033.0
       ▿ 38 : 2 elements
         - key : "myr"
         - value : 924035478.0
       ▿ 39 : 2 elements
         - key : "gbp"
         - value : 165135709.0
       ▿ 40 : 2 elements
         - key : "eth"
         - value : 89621.0
       ▿ 41 : 2 elements
         - key : "brl"
         - value : 1203002187.0
       ▿ 42 : 2 elements
         - key : "twd"
         - value : 6936675830.0
       ▿ 43 : 2 elements
         - key : "pln"
         - value : 847901289.0
       ▿ 44 : 2 elements
         - key : "idr"
         - value : 3366506948513.0
       ▿ 45 : 2 elements
         - key : "bdt"
         - value : 25751306830.0
       ▿ 46 : 2 elements
         - key : "btc"
         - value : 3557.0
       ▿ 47 : 2 elements
         - key : "bits"
         - value : 3557351885.0
       ▿ 48 : 2 elements
         - key : "xlm"
         - value : 2384527246.0
       ▿ 49 : 2 elements
         - key : "ngn"
         - value : 349077914614.0
       ▿ 50 : 2 elements
         - key : "mmk"
         - value : 452052333426.0
       ▿ 51 : 2 elements
         - key : "clp"
         - value : 200404840227.0
       ▿ 52 : 2 elements        - key : "hkd"
         - value : 1674359396.0
       ▿ 53 : 2 elements
         - key : "krw"
         - value : 290721007029.0
       ▿ 54 : 2 elements
         - key : "sats"
         - value : 355735188532.0
       ▿ 55 : 2 elements
         - key : "mxn"
         - value : 4188199367.0
       ▿ 56 : 2 elements
         - key : "xag"
         - value : 6914367.0
       ▿ 57 : 2 elements
         - key : "yfi"
         - value : 44170.0
       ▿ 58 : 2 elements
         - key : "rub"
         - value : 20885927250.0
       ▿ 59 : 2 elements
         - key : "try"
         - value : 7389673854.0
       ▿ 60 : 2 elements
         - key : "chf"
         - value : 184821101.0
       ▿ 61 : 2 elements
         - key : "xrp"
         - value : 403665951.0
     ▿ high24H : 62 elements
       ▿ 0 : 2 elements
         - key : "cad"
         - value : 7.13
       ▿ 1 : 2 elements
         - key : "eur"
         - value : 4.74
       ▿ 2 : 2 elements
         - key : "xag"
         - value : 0.167697
       ▿ 3 : 2 elements
         - key : "php"
         - value : 296.42
       ▿ 4 : 2 elements
         - key : "mxn"
         - value : 100.83
       ▿ 5 : 2 elements
         - key : "idr"
         - value : 80891.0
       ▿ 6 : 2 elements
         - key : "dkk"
         - value : 35.35
       ▿ 7 : 2 elements
         - key : "uah"
         - value : 213.72
       ▿ 8 : 2 elements
         - key : "xrp"
         - value : 9.718966
       ▿ 9 : 2 elements
         - key : "link"
         - value : 0.48865425
       ▿ 10 : 2 elements
         - key : "nok"
         - value : 55.63
       ▿ 11 : 2 elements
         - key : "yfi"
         - value : 0.00106029
       ▿ 12 : 2 elements
         - key : "sgd"
         - value : 6.77
       ▿ 13 : 2 elements
         - key : "try"
         - value : 177.67
       ▿ 14 : 2 elements
         - key : "eth"
         - value : 0.0021565
       ▿ 15 : 2 elements
         - key : "clp"
         - value : 4821.12
       ▿ 16 : 2 elements
         - key : "bdt"
         - value : 619.5
       ▿ 17 : 2 elements
         - key : "ngn"
         - value : 8418.84
       ▿ 18 : 2 elements
         - key : "pkr"
         - value : 1439.92
       ▿ 19 : 2 elements
         - key : "bch"
         - value : 0.01600942
       ▿ 20 : 2 elements
         - key : "brl"
         - value : 28.94
       ▿ 21 : 2 elements
         - key : "bmd"
         - value : 5.18
       ▿ 22 : 2 elements
         - key : "krw"
         - value : 6981.51
       ▿ 23 : 2 elements
         - key : "btc"
         - value : 8.553e-05
       ▿ 24 : 2 elements
         - key : "xau"
         - value : 0.00196126
       ▿ 25 : 2 elements
         - key : "aed"
         - value : 19.04
       ▿ 26 : 2 elements
         - key : "twd"
         - value : 166.75
       ▿ 27 : 2 elements
         - key : "huf"
         - value : 1900.73
       ▿ 28 : 2 elements
         - key : "eos"
         - value : 11.14895
       ▿ 29 : 2 elements
         - key : "dot"
         - value : 1.265075
       ▿ 30 : 2 elements
         - key : "rub"
         - value : 500.74
       ▿ 31 : 2 elements
         - key : "gel"
         - value : 14.13
       ▿ 32 : 2 elements
         - key : "xlm"
         - value : 57.249
       ▿ 33 : 2 elements
         - key : "sats"
         - value : 8552.85
       ▿ 34 : 2 elements
         - key : "usd"
         - value : 5.18
       ▿ 35 : 2 elements
         - key : "gbp"
         - value : 3.97
       ▿ 36 : 2 elements
         - key : "kwd"
         - value : 1.59
       ▿ 37 : 2 elements
         - key : "vef"
         - value : 0.519024
       ▿ 38 : 2 elements
         - key : "lkr"
         - value : 1518.32
       ▿ 39 : 2 elements
         - key : "bnb"
         - value : 0.00920504
       ▿ 40 : 2 elements
         - key : "sar"
         - value : 19.46
       ▿ 41 : 2 elements
         - key : "zar"
         - value : 90.68
       ▿ 42 : 2 elements
         - key : "hkd"
         - value : 40.28
       ▿ 43 : 2 elements
         - key : "xdr"
         - value : 3.86
       ▿ 44 : 2 elements
         - key : "jpy"
         - value : 770.86
       ▿ 45 : 2 elements
         - key : "czk"
         - value : 120.08
       ▿ 46 : 2 elements
         - key : "ltc"
         - value : 0.07988623
       ▿ 47 : 2 elements
         - key : "bhd"
         - value : 1.95
       ▿ 48 : 2 elements
         - key : "cny"
         - value : 36.66
       ▿ 49 : 2 elements
         - key : "chf"
         - value : 4.44
       ▿ 50 : 2 elements
         - key : "sek"
         - value : 53.85
       ▿ 51 : 2 elements
         - key : "ils"
         - value : 19.53
       ▿ 52 : 2 elements
         - key : "nzd"
         - value : 8.5
       ▿ 53 : 2 elements
         - key : "mmk"
         - value : 10874.99
       ▿ 54 : 2 elements
         - key : "thb"
         - value : 172.69
       ▿ 55 : 2 elements
         - key : "ars"
         - value : 5052.6
       ▿ 56 : 2 elements
         - key : "inr"
         - value : 435.25
       ▿ 57 : 2 elements
         - key : "aud"
         - value : 7.68
       ▿ 58 : 2 elements
         - key : "myr"
         - value : 22.22
       ▿ 59 : 2 elements
         - key : "pln"
         - value : 20.38
       ▿ 60 : 2 elements
         - key : "bits"
         - value : 85.53
       ▿ 61 : 2 elements
         - key : "vnd"
         - value : 128679.0
     ▿ low24H : 62 elements
       ▿ 0 : 2 elements
         - key : "ltc"
         - value : 0.07765196
       ▿ 1 : 2 elements
         - key : "eos"
         - value : 10.893552
       ▿ 2 : 2 elements
         - key : "dkk"
         - value : 34.08
       ▿ 3 : 2 elements
         - key : "eur"
         - value : 4.57
       ▿ 4 : 2 elements
         - key : "btc"
         - value : 8.229e-05
       ▿ 5 : 2 elements
         - key : "php"
         - value : 286.59
       ▿ 6 : 2 elements
         - key : "zar"
         - value : 87.48
       ▿ 7 : 2 elements
         - key : "pkr"
         - value : 1385.24
       ▿ 8 : 2 elements
         - key : "xlm"
         - value : 55.943
       ▿ 9 : 2 elements
         - key : "thb"
         - value : 167.07
       ▿ 10 : 2 elements
         - key : "xdr"
         - value : 3.71
       ▿ 11 : 2 elements
         - key : "xau"
         - value : 0.00190066
       ▿ 12 : 2 elements
         - key : "mmk"
         - value : 10467.22
       ▿ 13 : 2 elements
         - key : "dot"
         - value : 1.24627
       ▿ 14 : 2 elements
         - key : "vnd"
         - value : 123954.0
       ▿ 15 : 2 elements
         - key : "sgd"
         - value : 6.52
       ▿ 16 : 2 elements
         - key : "czk"
         - value : 115.78
       ▿ 17 : 2 elements
         - key : "pln"
         - value : 19.64
       ▿ 18 : 2 elements
         - key : "ils"
         - value : 18.8
       ▿ 19 : 2 elements
         - key : "idr"
         - value : 78203.0
       ▿ 20 : 2 elements
         - key : "huf"
         - value : 1830.71
       ▿ 21 : 2 elements
         - key : "twd"
         - value : 161.08
       ▿ 22 : 2 elements
         - key : "lkr"
         - value : 1461.75
       ▿ 23 : 2 elements
         - key : "kwd"
         - value : 1.53
       ▿ 24 : 2 elements
         - key : "uah"
         - value : 205.76
       ▿ 25 : 2 elements
         - key : "sar"
         - value : 18.73
       ▿ 26 : 2 elements
         - key : "nzd"
         - value : 8.2
       ▿ 27 : 2 elements
         - key : "vef"
         - value : 0.499563
       ▿ 28 : 2 elements
         - key : "mxn"
         - value : 97.39
       ▿ 29 : 2 elements
         - key : "bhd"
         - value : 1.88
       ▿ 30 : 2 elements
         - key : "bits"
         - value : 82.29
       ▿ 31 : 2 elements
         - key : "bmd"
         - value : 4.99
       ▿ 32 : 2 elements
         - key : "clp"
         - value : 4636.56
       ▿ 33 : 2 elements
         - key : "gel"
         - value : 13.58
       ▿ 34 : 2 elements
         - key : "gbp"
         - value : 3.82
       ▿ 35 : 2 elements
         - key : "inr"
         - value : 418.89
       ▿ 36 : 2 elements
         - key : "rub"
         - value : 481.94
       ▿ 37 : 2 elements
         - key : "ngn"
         - value : 8083.86
       ▿ 38 : 2 elements
         - key : "jpy"
         - value : 742.16
       ▿ 39 : 2 elements
         - key : "hkd"
         - value : 38.77
       ▿ 40 : 2 elements
         - key : "usd"
         - value : 4.99
       ▿ 41 : 2 elements
         - key : "bnb"
         - value : 0.00887718
       ▿ 42 : 2 elements
         - key : "eth"
         - value : 0.00209841
       ▿ 43 : 2 elements
         - key : "chf"
         - value : 4.27
       ▿ 44 : 2 elements
         - key : "try"
         - value : 170.63
       ▿ 45 : 2 elements
         - key : "link"
         - value : 0.47502724
       ▿ 46 : 2 elements
         - key : "xag"
         - value : 0.160709
       ▿ 47 : 2 elements
         - key : "bdt"
         - value : 596.42
       ▿ 48 : 2 elements
         - key : "cny"
         - value : 35.32
       ▿ 49 : 2 elements
         - key : "xrp"
         - value : 9.328017
       ▿ 50 : 2 elements
         - key : "ars"
         - value : 4863.12
       ▿ 51 : 2 elements
         - key : "sats"
         - value : 8229.19
       ▿ 52 : 2 elements
         - key : "myr"
         - value : 21.41
       ▿ 53 : 2 elements
         - key : "aed"
         - value : 18.33
       ▿ 54 : 2 elements
         - key : "bch"
         - value : 0.01553123
       ▿ 55 : 2 elements
         - key : "brl"
         - value : 27.83
       ▿ 56 : 2 elements
         - key : "aud"
         - value : 7.41
       ▿ 57 : 2 elements
         - key : "yfi"
         - value : 0.00103103
       ▿ 58 : 2 elements
         - key : "cad"
         - value : 6.86
       ▿ 59 : 2 elements
         - key : "sek"
         - value : 51.88
       ▿ 60 : 2 elements
         - key : "nok"
         - value : 53.61
       ▿ 61 : 2 elements
         - key : "krw"
         - value : 6742.24
     - priceChange24H : 0.04391078
     - priceChangePercentage24H : 0.85894
     - priceChangePercentage7D : -3.74711
     - priceChangePercentage14D : -11.16335
     - priceChangePercentage30D : -2.20122
     - priceChangePercentage60D : -15.22587
     - priceChangePercentage200D : -4.44544
     - priceChangePercentage1Y : 161.22535
     - marketCapChange24H : 110350102.0
     - marketCapChangePercentage24H : 0.8508
     ▿ priceChange24HInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "ltc"
         - value : 0.00099729
       ▿ 1 : 2 elements
         - key : "pkr"
         - value : 9.14
       ▿ 2 : 2 elements
         - key : "pln"
         - value : 0.211828
       ▿ 3 : 2 elements
         - key : "bmd"
         - value : 0.04391078
       ▿ 4 : 2 elements
         - key : "usd"
         - value : 0.04391078
       ▿ 5 : 2 elements
         - key : "xag"
         - value : -0.00203291826514368
       ▿ 6 : 2 elements
         - key : "jpy"
         - value : 4.56
       ▿ 7 : 2 elements
         - key : "uah"
         - value : 1.56
       ▿ 8 : 2 elements
         - key : "dot"
         - value : 0.0075542
       ▿ 9 : 2 elements
         - key : "bits"
         - value : 1.28
       ▿ 10 : 2 elements
         - key : "myr"
         - value : 0.152526
       ▿ 11 : 2 elements
         - key : "chf"
         - value : 0.02411772
       ▿ 12 : 2 elements
         - key : "zar"
         - value : 0.060486
       ▿ 13 : 2 elements
         - key : "lkr"
         - value : 9.47
       ▿ 14 : 2 elements
         - key : "ngn"
         - value : 61.94
       ▿ 15 : 2 elements
         - key : "brl"
         - value : 0.172569
       ▿ 16 : 2 elements
         - key : "twd"
         - value : 1.089
       ▿ 17 : 2 elements
         - key : "mmk"
         - value : 92.12
       ▿ 18 : 2 elements
         - key : "xau"
         - value : -5.891585612745e-06
       ▿ 19 : 2 elements
         - key : "aed"
         - value : 0.161182
       ▿ 20 : 2 elements
         - key : "gel"
         - value : 0.145218
       ▿ 21 : 2 elements
         - key : "idr"
         - value : 419.85
       ▿ 22 : 2 elements
         - key : "hkd"
         - value : 0.34
       ▿ 23 : 2 elements
         - key : "try"
         - value : 1.75
       ▿ 24 : 2 elements
         - key : "thb"
         - value : 0.403373
       ▿ 25 : 2 elements
         - key : "huf"
         - value : 27.46
       ▿ 26 : 2 elements
         - key : "cny"
         - value : 0.343413
       ▿ 27 : 2 elements
         - key : "cad"
         - value : 0.08355
       ▿ 28 : 2 elements
         - key : "sgd"
         - value : 0.052215
       ▿ 29 : 2 elements
         - key : "rub"
         - value : 3.91
       ▿ 30 : 2 elements
         - key : "link"
         - value : 0.00816573
       ▿ 31 : 2 elements
         - key : "kwd"
         - value : 0.01363855
       ▿ 32 : 2 elements
         - key : "eur"
         - value : 0.04171264
       ▿ 33 : 2 elements
         - key : "nzd"
         - value : 0.058839
       ▿ 34 : 2 elements
         - key : "krw"
         - value : 53.83
       ▿ 35 : 2 elements
         - key : "yfi"
         - value : 2.109e-05
       ▿ 36 : 2 elements
         - key : "vnd"
         - value : 932.3
       ▿ 37 : 2 elements
         - key : "eos"
         - value : 0.0414424
       ▿ 38 : 2 elements
         - key : "php"
         - value : 2.68
       ▿ 39 : 2 elements
         - key : "xdr"
         - value : 0.02440486
       ▿ 40 : 2 elements
         - key : "gbp"
         - value : 0.04085653
       ▿ 41 : 2 elements
         - key : "bnb"
         - value : 0.00025903
       ▿ 42 : 2 elements
         - key : "bhd"
         - value : 0.01667111
       ▿ 43 : 2 elements
         - key : "eth"
         - value : 1.787e-05
       ▿ 44 : 2 elements
         - key : "vef"
         - value : 0.00439679
       ▿ 45 : 2 elements
         - key : "ars"
         - value : 42.58
       ▿ 46 : 2 elements
         - key : "mxn"
         - value : 0.696808
       ▿ 47 : 2 elements
         - key : "sar"
         - value : 0.166216
       ▿ 48 : 2 elements
         - key : "aud"
         - value : 0.05694
       ▿ 49 : 2 elements
         - key : "sek"
         - value : 0.465004
       ▿ 50 : 2 elements
         - key : "xrp"
         - value : -0.02475282645386301
       ▿ 51 : 2 elements
         - key : "nok"
         - value : 0.281031
       ▿ 52 : 2 elements
         - key : "xlm"
         - value : 0.23148142
       ▿ 53 : 2 elements
         - key : "inr"
         - value : 4.25
       ▿ 54 : 2 elements
         - key : "ils"
         - value : 0.191467
       ▿ 55 : 2 elements
         - key : "czk"
         - value : 1.069
       ▿ 56 : 2 elements
         - key : "clp"
         - value : 17.89
       ▿ 57 : 2 elements
         - key : "dkk"
         - value : 0.318668
       ▿ 58 : 2 elements
         - key : "sats"
         - value : 127.93
       ▿ 59 : 2 elements
         - key : "btc"
         - value : 1.28e-06
       ▿ 60 : 2 elements
         - key : "bdt"
         - value : 3.91
       ▿ 61 : 2 elements
         - key : "bch"
         - value : 0.00018268
     ▿ priceChangePercentage1HInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "dkk"
         - value : -0.03234
       ▿ 1 : 2 elements
         - key : "bhd"
         - value : -0.01387
       ▿ 2 : 2 elements
         - key : "bch"
         - value : 0.35991
       ▿ 3 : 2 elements
         - key : "ils"
         - value : 0.12465
       ▿ 4 : 2 elements
         - key : "aud"
         - value : 0.07408
       ▿ 5 : 2 elements
         - key : "huf"
         - value : 0.05227
       ▿ 6 : 2 elements
         - key : "xlm"
         - value : 0.25494
       ▿ 7 : 2 elements
         - key : "thb"
         - value : -0.08328
       ▿ 8 : 2 elements
         - key : "sgd"
         - value : -0.00811
       ▿ 9 : 2 elements
         - key : "eur"
         - value : -0.02997
       ▿ 10 : 2 elements
         - key : "uah"
         - value : -0.03084
       ▿ 11 : 2 elements
         - key : "yfi"
         - value : 0.14083
       ▿ 12 : 2 elements
         - key : "ltc"
         - value : 0.40542
       ▿ 13 : 2 elements
         - key : "mmk"
         - value : -0.03084
       ▿ 14 : 2 elements
         - key : "myr"
         - value : 0.00414
       ▿ 15 : 2 elements
         - key : "usd"
         - value : -0.03084
       ▿ 16 : 2 elements
         - key : "inr"
         - value : 0.07574
       ▿ 17 : 2 elements
         - key : "bdt"
         - value : -0.03084
       ▿ 18 : 2 elements
         - key : "xag"
         - value : 0.42742
       ▿ 19 : 2 elements
         - key : "ars"
         - value : -0.03175
       ▿ 20 : 2 elements
         - key : "sek"
         - value : 0.03787
       ▿ 21 : 2 elements
         - key : "vef"
         - value : -0.03084
       ▿ 22 : 2 elements
         - key : "eos"
         - value : 0.2315
       ▿ 23 : 2 elements
         - key : "ngn"
         - value : -0.03084
       ▿ 24 : 2 elements
         - key : "twd"
         - value : 0.03596
       ▿ 25 : 2 elements
         - key : "krw"
         - value : 0.07275
       ▿ 26 : 2 elements
         - key : "chf"
         - value : 0.01452
       ▿ 27 : 2 elements
         - key : "rub"
         - value : 0.31393
       ▿ 28 : 2 elements
         - key : "bits"
         - value : 0.12227
       ▿ 29 : 2 elements
         - key : "cny"
         - value : 0.02429
       ▿ 30 : 2 elements
         - key : "mxn"
         - value : -0.07759
       ▿ 31 : 2 elements
         - key : "bmd"
         - value : -0.03084
       ▿ 32 : 2 elements
         - key : "sats"
         - value : 0.12227
       ▿ 33 : 2 elements
         - key : "xau"
         - value : -0.04142
       ▿ 34 : 2 elements
         - key : "brl"
         - value : -0.03084
       ▿ 35 : 2 elements
         - key : "nzd"
         - value : 0.11797
       ▿ 36 : 2 elements
         - key : "vnd"
         - value : -0.03084
       ▿ 37 : 2 elements
         - key : "cad"
         - value : -0.01216
       ▿ 38 : 2 elements
         - key : "jpy"
         - value : 0.00411
       ▿ 39 : 2 elements
         - key : "nok"
         - value : 0.0242
       ▿ 40 : 2 elements
         - key : "lkr"
         - value : -0.03084
       ▿ 41 : 2 elements
         - key : "try"
         - value : -0.01743
       ▿ 42 : 2 elements
         - key : "eth"
         - value : 0.06705
       ▿ 43 : 2 elements
         - key : "gbp"
         - value : -0.03958
       ▿ 44 : 2 elements
         - key : "xdr"
         - value : -0.03084
       ▿ 45 : 2 elements
         - key : "xrp"
         - value : 0.00196
       ▿ 46 : 2 elements
         - key : "pkr"
         - value : -0.03084
       ▿ 47 : 2 elements
         - key : "clp"
         - value : -0.03084
       ▿ 48 : 2 elements
         - key : "idr"
         - value : -0.03918
       ▿ 49 : 2 elements
         - key : "php"
         - value : -0.03085
       ▿ 50 : 2 elements
         - key : "pln"
         - value : -0.01516
       ▿ 51 : 2 elements
         - key : "sar"
         - value : -0.03233
       ▿ 52 : 2 elements
         - key : "kwd"
         - value : -0.0204
       ▿ 53 : 2 elements
         - key : "btc"
         - value : 0.12227
       ▿ 54 : 2 elements
         - key : "dot"
         - value : 0.45321
       ▿ 55 : 2 elements
         - key : "link"
         - value : 0.42017
       ▿ 56 : 2 elements
         - key : "hkd"
         - value : -0.03676
       ▿ 57 : 2 elements
         - key : "bnb"
         - value : 0.37586
       ▿ 58 : 2 elements
         - key : "czk"
         - value : 0.00157
       ▿ 59 : 2 elements
         - key : "aed"
         - value : -0.03125
       ▿ 60 : 2 elements
         - key : "zar"
         - value : -0.06427
       ▿ 61 : 2 elements
         - key : "gel"
         - value : -0.03084
     ▿ priceChangePercentage24HInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "dot"
         - value : 0.60069
       ▿ 1 : 2 elements
         - key : "nok"
         - value : 0.50996
       ▿ 2 : 2 elements
         - key : "huf"
         - value : 1.47234
       ▿ 3 : 2 elements
         - key : "bnb"
         - value : 2.8964
       ▿ 4 : 2 elements
         - key : "uah"
         - value : 0.73696
       ▿ 5 : 2 elements
         - key : "vnd"
         - value : 0.73375
       ▿ 6 : 2 elements
         - key : "eos"
         - value : 0.37491
       ▿ 7 : 2 elements
         - key : "eur"
         - value : 0.89247
       ▿ 8 : 2 elements
         - key : "bdt"
         - value : 0.63841
       ▿ 9 : 2 elements
         - key : "ars"
         - value : 0.85448
       ▿ 10 : 2 elements
         - key : "gbp"
         - value : 1.0447
       ▿ 11 : 2 elements
         - key : "ngn"
         - value : 0.747
       ▿ 12 : 2 elements
         - key : "brl"
         - value : 0.60307
       ▿ 13 : 2 elements
         - key : "xag"
         - value : -1.21373
       ▿ 14 : 2 elements
         - key : "sgd"
         - value : 0.78125
       ▿ 15 : 2 elements
         - key : "rub"
         - value : 0.78765
       ▿ 16 : 2 elements
         - key : "hkd"
         - value : 0.85583
       ▿ 17 : 2 elements
         - key : "jpy"
         - value : 0.59743
       ▿ 18 : 2 elements
         - key : "chf"
         - value : 0.5483
       ▿ 19 : 2 elements
         - key : "sats"
         - value : 1.52569
       ▿ 20 : 2 elements
         - key : "php"
         - value : 0.9144
       ▿ 21 : 2 elements
         - key : "sar"
         - value : 0.86589
       ▿ 22 : 2 elements
         - key : "xlm"
         - value : 0.40732
       ▿ 23 : 2 elements
         - key : "zar"
         - value : 0.06707
       ▿ 24 : 2 elements
         - key : "twd"
         - value : 0.66038
       ▿ 25 : 2 elements
         - key : "aed"
         - value : 0.85839
       ▿ 26 : 2 elements
         - key : "clp"
         - value : 0.37444
       ▿ 27 : 2 elements
         - key : "inr"
         - value : 0.98919
       ▿ 28 : 2 elements
         - key : "mmk"
         - value : 0.85894
       ▿ 29 : 2 elements
         - key : "aud"
         - value : 0.74917
       ▿ 30 : 2 elements
         - key : "bch"
         - value : 1.15427
       ▿ 31 : 2 elements
         - key : "vef"
         - value : 0.85894
       ▿ 32 : 2 elements
         - key : "yfi"
         - value : 2.03587
       ▿ 33 : 2 elements
         - key : "xdr"
         - value : 0.64022
       ▿ 34 : 2 elements
         - key : "idr"
         - value : 0.52389
       ▿ 35 : 2 elements
         - key : "czk"
         - value : 0.90246
       ▿ 36 : 2 elements
         - key : "ils"
         - value : 0.99646
       ▿ 37 : 2 elements
         - key : "try"
         - value : 0.99908
       ▿ 38 : 2 elements
         - key : "mxn"
         - value : 0.70012
       ▿ 39 : 2 elements
         - key : "pkr"
         - value : 0.64254
       ▿ 40 : 2 elements
         - key : "usd"
         - value : 0.85894
       ▿ 41 : 2 elements
         - key : "cny"
         - value : 0.95025
       ▿ 42 : 2 elements
         - key : "ltc"
         - value : 1.26695
       ▿ 43 : 2 elements
         - key : "bhd"
         - value : 0.86509
       ▿ 44 : 2 elements
         - key : "sek"
         - value : 0.87478
       ▿ 45 : 2 elements
         - key : "eth"
         - value : 0.84016
       ▿ 46 : 2 elements
         - key : "myr"
         - value : 0.69457
       ▿ 47 : 2 elements
         - key : "kwd"
         - value : 0.87045
       ▿ 48 : 2 elements
         - key : "xau"
         - value : -0.3013
       ▿ 49 : 2 elements
         - key : "link"
         - value : 1.70636
       ▿ 50 : 2 elements
         - key : "xrp"
         - value : -0.25559
       ▿ 51 : 2 elements
         - key : "nzd"
         - value : 0.7
       ▿ 52 : 2 elements
         - key : "pln"
         - value : 1.055
       ▿ 53 : 2 elements
         - key : "thb"
         - value : 0.23517
       ▿ 54 : 2 elements
         - key : "btc"
         - value : 1.52569
       ▿ 55 : 2 elements
         - key : "gel"
         - value : 1.04434
       ▿ 56 : 2 elements
         - key : "cad"
         - value : 1.19183
       ▿ 57 : 2 elements
         - key : "dkk"
         - value : 0.91409
       ▿ 58 : 2 elements
         - key : "bmd"
         - value : 0.85894
       ▿ 59 : 2 elements
         - key : "bits"
         - value : 1.52569
       ▿ 60 : 2 elements
         - key : "lkr"
         - value : 0.63125
       ▿ 61 : 2 elements
         - key : "krw"
         - value : 0.77975
     ▿ priceChangePercentage7DInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "chf"
         - value : -2.93701
       ▿ 1 : 2 elements
         - key : "vef"
         - value : -3.74711
       ▿ 2 : 2 elements
         - key : "czk"
         - value : -2.77664
       ▿ 3 : 2 elements
         - key : "myr"
         - value : -2.41595
       ▿ 4 : 2 elements
         - key : "gbp"
         - value : -3.06283
       ▿ 5 : 2 elements
         - key : "btc"
         - value : -2.72685
       ▿ 6 : 2 elements
         - key : "bdt"
         - value : -3.81514
       ▿ 7 : 2 elements
         - key : "krw"
         - value : -2.57392
       ▿ 8 : 2 elements
         - key : "nok"
         - value : -2.45488
       ▿ 9 : 2 elements
         - key : "xlm"
         - value : -2.9581
       ▿ 10 : 2 elements
         - key : "bits"
         - value : -2.72685
       ▿ 11 : 2 elements
         - key : "yfi"
         - value : -2.19536
       ▿ 12 : 2 elements
         - key : "xrp"
         - value : -4.73182
       ▿ 13 : 2 elements
         - key : "php"
         - value : -2.05495
       ▿ 14 : 2 elements
         - key : "dot"
         - value : -1.67965
       ▿ 15 : 2 elements
         - key : "pln"
         - value : -2.93102
       ▿ 16 : 2 elements
         - key : "link"
         - value : -0.85852
       ▿ 17 : 2 elements
         - key : "jpy"
         - value : -1.92377
       ▿ 18 : 2 elements
         - key : "ars"
         - value : -3.45126
       ▿ 19 : 2 elements
         - key : "try"
         - value : -3.5793
       ▿ 20 : 2 elements
         - key : "bnb"
         - value : -5.64484
       ▿ 21 : 2 elements
         - key : "nzd"
         - value : -1.82398
       ▿ 22 : 2 elements
         - key : "bhd"
         - value : -3.74736
       ▿ 23 : 2 elements
         - key : "mxn"
         - value : -3.27572
       ▿ 24 : 2 elements
         - key : "bch"
         - value : -3.77055
       ▿ 25 : 2 elements
         - key : "rub"
         - value : -1.52792
       ▿ 26 : 2 elements
         - key : "sgd"
         - value : -2.96532
       ▿ 27 : 2 elements
         - key : "bmd"
         - value : -3.74711
       ▿ 28 : 2 elements
         - key : "aed"
         - value : -3.74868
       ▿ 29 : 2 elements
         - key : "usd"
         - value : -3.74711
       ▿ 30 : 2 elements
         - key : "kwd"
         - value : -3.55738
       ▿ 31 : 2 elements
         - key : "eur"
         - value : -2.86577
       ▿ 32 : 2 elements
         - key : "xag"
         - value : -0.38175
       ▿ 33 : 2 elements
         - key : "clp"
         - value : -1.92293
       ▿ 34 : 2 elements
         - key : "idr"
         - value : -2.79933
       ▿ 35 : 2 elements
         - key : "ngn"
         - value : -5.92465
       ▿ 36 : 2 elements
         - key : "vnd"
         - value : -3.46039
       ▿ 37 : 2 elements
         - key : "mmk"
         - value : -3.74711
       ▿ 38 : 2 elements
         - key : "aud"
         - value : -2.10936
       ▿ 39 : 2 elements
         - key : "twd"
         - value : -3.29891
       ▿ 40 : 2 elements
         - key : "eos"
         - value : -2.40783
       ▿ 41 : 2 elements
         - key : "sek"
         - value : -2.73703
       ▿ 42 : 2 elements
         - key : "huf"
         - value : -2.94706
       ▿ 43 : 2 elements
         - key : "uah"
         - value : -3.7178
       ▿ 44 : 2 elements
         - key : "inr"
         - value : -3.61022
       ▿ 45 : 2 elements
         - key : "cad"
         - value : -2.28095
       ▿ 46 : 2 elements
         - key : "dkk"
         - value : -2.85405
       ▿ 47 : 2 elements
         - key : "pkr"
         - value : -3.77211
       ▿ 48 : 2 elements
         - key : "zar"
         - value : -3.38913
       ▿ 49 : 2 elements
         - key : "lkr"
         - value : -4.14111
       ▿ 50 : 2 elements
         - key : "cny"
         - value : -3.39074
       ▿ 51 : 2 elements
         - key : "sats"
         - value : -2.72685
       ▿ 52 : 2 elements
         - key : "ltc"
         - value : -4.05457
       ▿ 53 : 2 elements
         - key : "gel"
         - value : -3.92339
       ▿ 54 : 2 elements
         - key : "thb"
         - value : -2.47185
       ▿ 55 : 2 elements
         - key : "hkd"
         - value : -3.68588
       ▿ 56 : 2 elements
         - key : "xdr"
         - value : -3.04343
       ▿ 57 : 2 elements
         - key : "brl"
         - value : -1.90403
       ▿ 58 : 2 elements
         - key : "xau"
         - value : -2.91515
       ▿ 59 : 2 elements
         - key : "sar"
         - value : -3.73798
       ▿ 60 : 2 elements
         - key : "ils"
         - value : -4.78309
       ▿ 61 : 2 elements
         - key : "eth"
         - value : -4.57631
     ▿ priceChangePercentage14DInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "eos"
         - value : 3.74397
       ▿ 1 : 2 elements
         - key : "brl"
         - value : -8.79635
       ▿ 2 : 2 elements
         - key : "nzd"
         - value : -8.13085
       ▿ 3 : 2 elements
         - key : "clp"
         - value : -8.79117
       ▿ 4 : 2 elements
         - key : "pln"
         - value : -8.79218
       ▿ 5 : 2 elements
         - key : "sar"
         - value : -11.06615
       ▿ 6 : 2 elements
         - key : "zar"
         - value : -9.77676
       ▿ 7 : 2 elements
         - key : "bnb"
         - value : -4.27249
       ▿ 8 : 2 elements
         - key : "krw"
         - value : -9.30109
       ▿ 9 : 2 elements
         - key : "sek"
         - value : -8.97121
       ▿ 10 : 2 elements
         - key : "dkk"
         - value : -9.27366
       ▿ 11 : 2 elements
         - key : "usd"
         - value : -11.16335
       ▿ 12 : 2 elements
         - key : "bits"
         - value : -4.28011
       ▿ 13 : 2 elements
         - key : "inr"
         - value : -10.75716
       ▿ 14 : 2 elements
         - key : "aud"
         - value : -9.32871
       ▿ 15 : 2 elements
         - key : "mmk"
         - value : -11.16335
       ▿ 16 : 2 elements
         - key : "xlm"
         - value : -3.19159
       ▿ 17 : 2 elements
         - key : "vef"
         - value : -11.16335
       ▿ 18 : 2 elements
         - key : "sats"
         - value : -4.28011
       ▿ 19 : 2 elements
         - key : "ars"
         - value : -10.47853
       ▿ 20 : 2 elements
         - key : "myr"
         - value : -7.754
       ▿ 21 : 2 elements
         - key : "sgd"
         - value : -9.75365
       ▿ 22 : 2 elements
         - key : "thb"
         - value : -8.74401
       ▿ 23 : 2 elements
         - key : "lkr"
         - value : -13.07091
       ▿ 24 : 2 elements
         - key : "ngn"
         - value : -12.88828
       ▿ 25 : 2 elements
         - key : "xrp"
         - value : -1.74664
       ▿ 26 : 2 elements
         - key : "eth"
         - value : -2.1565
       ▿ 27 : 2 elements
         - key : "rub"
         - value : -6.85708
       ▿ 28 : 2 elements
         - key : "ltc"
         - value : -4.67423
       ▿ 29 : 2 elements
         - key : "bhd"
         - value : -11.15321
       ▿ 30 : 2 elements
         - key : "php"
         - value : -9.11902
       ▿ 31 : 2 elements
         - key : "mxn"
         - value : -12.04415
       ▿ 32 : 2 elements
         - key : "xag"
         - value : -9.80879
       ▿ 33 : 2 elements
         - key : "nok"
         - value : -9.68896
       ▿ 34 : 2 elements
         - key : "xdr"
         - value : -10.53714
       ▿ 35 : 2 elements
         - key : "uah"
         - value : -10.91187
       ▿ 36 : 2 elements
         - key : "cad"
         - value : -9.42436
       ▿ 37 : 2 elements
         - key : "chf"
         - value : -10.24007
       ▿ 38 : 2 elements
         - key : "bdt"
         - value : -11.033
       ▿ 39 : 2 elements
         - key : "link"
         - value : 6.49257
       ▿ 40 : 2 elements
         - key : "eur"
         - value : -9.30987
       ▿ 41 : 2 elements
         - key : "hkd"
         - value : -11.26901
       ▿ 42 : 2 elements
         - key : "dot"
         - value : 7.66179
       ▿ 43 : 2 elements
         - key : "ils"
         - value : -9.83386
       ▿ 44 : 2 elements
         - key : "twd"
         - value : -9.85287
       ▿ 45 : 2 elements
         - key : "bch"
         - value : -0.40893
       ▿ 46 : 2 elements
         - key : "gbp"
         - value : -8.90293
       ▿ 47 : 2 elements
         - key : "bmd"
         - value : -11.16335
       ▿ 48 : 2 elements
         - key : "jpy"
         - value : -9.64586
       ▿ 49 : 2 elements
         - key : "pkr"
         - value : -11.01468
       ▿ 50 : 2 elements
         - key : "xau"
         - value : -10.52915
       ▿ 51 : 2 elements
         - key : "gel"
         - value : -11.16335
       ▿ 52 : 2 elements
         - key : "try"
         - value : -10.85562
       ▿ 53 : 2 elements
         - key : "huf"
         - value : -8.09644
       ▿ 54 : 2 elements
         - key : "btc"
         - value : -4.28011
       ▿ 55 : 2 elements
         - key : "yfi"
         - value : -1.2742
       ▿ 56 : 2 elements
         - key : "cny"
         - value : -10.39336
       ▿ 57 : 2 elements
         - key : "kwd"
         - value : -10.83113
       ▿ 58 : 2 elements
         - key : "idr"
         - value : -8.39051
       ▿ 59 : 2 elements
         - key : "vnd"
         - value : -10.36947
       ▿ 60 : 2 elements
         - key : "czk"
         - value : -8.5722
       ▿ 61 : 2 elements
         - key : "aed"
         - value : -11.16371
     ▿ priceChangePercentage30DInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "cad"
         - value : -1.06124
       ▿ 1 : 2 elements
         - key : "inr"
         - value : -2.06696
       ▿ 2 : 2 elements
         - key : "bmd"
         - value : -2.20122
       ▿ 3 : 2 elements
         - key : "huf"
         - value : -0.11824
       ▿ 4 : 2 elements
         - key : "bch"
         - value : -2.57476
       ▿ 5 : 2 elements
         - key : "gel"
         - value : -1.11256
       ▿ 6 : 2 elements
         - key : "sar"
         - value : -2.12538
       ▿ 7 : 2 elements
         - key : "krw"
         - value : -1.42815
       ▿ 8 : 2 elements
         - key : "uah"
         - value : -2.27184
       ▿ 9 : 2 elements
         - key : "nzd"
         - value : -1.33018
       ▿ 10 : 2 elements
         - key : "myr"
         - value : -3.0938
       ▿ 11 : 2 elements
         - key : "brl"
         - value : -3.60148
       ▿ 12 : 2 elements
         - key : "btc"
         - value : -9.21186
       ▿ 13 : 2 elements
         - key : "xrp"
         - value : -2.73847
       ▿ 14 : 2 elements
         - key : "dkk"
         - value : -1.22397
       ▿ 15 : 2 elements
         - key : "kwd"
         - value : -1.85221
       ▿ 16 : 2 elements
         - key : "php"
         - value : 0.08059
       ▿ 17 : 2 elements
         - key : "hkd"
         - value : -2.52208
       ▿ 18 : 2 elements
         - key : "xdr"
         - value : -2.00498
       ▿ 19 : 2 elements
         - key : "twd"
         - value : -1.96981
       ▿ 20 : 2 elements
         - key : "bdt"
         - value : -2.36863
       ▿ 21 : 2 elements
         - key : "ils"
         - value : -2.13271
       ▿ 22 : 2 elements
         - key : "chf"
         - value : -0.5507
       ▿ 23 : 2 elements
         - key : "mxn"
         - value : -5.62691
       ▿ 24 : 2 elements
         - key : "mmk"
         - value : -2.20122
       ▿ 25 : 2 elements
         - key : "link"
         - value : -4.384
       ▿ 26 : 2 elements
         - key : "usd"
         - value : -2.20122
       ▿ 27 : 2 elements
         - key : "idr"
         - value : -0.78809
       ▿ 28 : 2 elements
         - key : "zar"
         - value : -4.37615
       ▿ 29 : 2 elements
         - key : "try"
         - value : -1.52651
       ▿ 30 : 2 elements
         - key : "vef"
         - value : -2.20122
       ▿ 31 : 2 elements
         - key : "clp"
         - value : -4.29118
       ▿ 32 : 2 elements
         - key : "vnd"
         - value : -1.232
       ▿ 33 : 2 elements
         - key : "bhd"
         - value : -2.18981
       ▿ 34 : 2 elements
         - key : "bnb"
         - value : -11.18649
       ▿ 35 : 2 elements
         - key : "cny"
         - value : -2.70587
       ▿ 36 : 2 elements
         - key : "yfi"
         - value : -3.36043
       ▿ 37 : 2 elements
         - key : "sats"
         - value : -9.21186
       ▿ 38 : 2 elements
         - key : "sek"
         - value : -1.71554
       ▿ 39 : 2 elements
         - key : "aud"
         - value : -3.31593
       ▿ 40 : 2 elements
         - key : "eur"
         - value : -1.20457
       ▿ 41 : 2 elements
         - key : "rub"
         - value : 4.17798
       ▿ 42 : 2 elements
         - key : "jpy"
         - value : 3.04774
       ▿ 43 : 2 elements
         - key : "xau"
         - value : -6.73744
       ▿ 44 : 2 elements
         - key : "dot"
         - value : -1.16376
       ▿ 45 : 2 elements
         - key : "nok"
         - value : -2.84733
       ▿ 46 : 2 elements
         - key : "ngn"
         - value : -3.76993
       ▿ 47 : 2 elements
         - key : "ltc"
         - value : -7.2353
       ▿ 48 : 2 elements
         - key : "gbp"
         - value : -1.81072
       ▿ 49 : 2 elements
         - key : "xlm"
         - value : -0.43283
       ▿ 50 : 2 elements
         - key : "eth"
         - value : -5.42753
       ▿ 51 : 2 elements
         - key : "xag"
         - value : -10.23635
       ▿ 52 : 2 elements
         - key : "ars"
         - value : -0.43932
       ▿ 53 : 2 elements
         - key : "bits"
         - value : -9.21186
       ▿ 54 : 2 elements
         - key : "czk"
         - value : -0.10415
       ▿ 55 : 2 elements
         - key : "pkr"
         - value : -2.6822
       ▿ 56 : 2 elements
         - key : "aed"
         - value : -2.20056
       ▿ 57 : 2 elements
         - key : "thb"
         - value : -2.96152
       ▿ 58 : 2 elements
         - key : "eos"
         - value : 0.52567
       ▿ 59 : 2 elements
         - key : "sgd"
         - value : -1.82977
       ▿ 60 : 2 elements
         - key : "lkr"
         - value : -4.81243
       ▿ 61 : 2 elements
         - key : "pln"
         - value : -0.62143
     ▿ priceChangePercentage60DInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "lkr"
         - value : -17.2154
       ▿ 1 : 2 elements
         - key : "eos"
         - value : -13.9701
       ▿ 2 : 2 elements
         - key : "jpy"
         - value : -14.30404
       ▿ 3 : 2 elements
         - key : "hkd"
         - value : -15.53283
       ▿ 4 : 2 elements
         - key : "sek"
         - value : -16.10821
       ▿ 5 : 2 elements
         - key : "uah"
         - value : -15.0299
       ▿ 6 : 2 elements
         - key : "cny"
         - value : -16.45968
       ▿ 7 : 2 elements
         - key : "link"
         - value : -19.50041
       ▿ 8 : 2 elements
         - key : "vef"
         - value : -15.22587
       ▿ 9 : 2 elements
         - key : "sar"
         - value : -15.19072
       ▿ 10 : 2 elements
         - key : "xdr"
         - value : -16.18908
       ▿ 11 : 2 elements
         - key : "bdt"
         - value : -13.79546
       ▿ 12 : 2 elements
         - key : "mxn"
         - value : -12.50676
       ▿ 13 : 2 elements
         - key : "bch"
         - value : -10.89426
       ▿ 14 : 2 elements
         - key : "clp"
         - value : -15.6331
       ▿ 15 : 2 elements
         - key : "usd"
         - value : -15.22587
       ▿ 16 : 2 elements
         - key : "brl"
         - value : -14.06534
       ▿ 17 : 2 elements
         - key : "bnb"
         - value : -23.51609
       ▿ 18 : 2 elements
         - key : "eur"
         - value : -15.33353
       ▿ 19 : 2 elements
         - key : "nok"
         - value : -15.65194
       ▿ 20 : 2 elements
         - key : "sgd"
         - value : -16.36929
       ▿ 21 : 2 elements
         - key : "idr"
         - value : -17.18378
       ▿ 22 : 2 elements
         - key : "vnd"
         - value : -16.14126
       ▿ 23 : 2 elements
         - key : "bhd"
         - value : -15.21237
       ▿ 24 : 2 elements
         - key : "xag"
         - value : -24.90244
       ▿ 25 : 2 elements
         - key : "huf"
         - value : -13.81404
       ▿ 26 : 2 elements
         - key : "ngn"
         - value : -13.62156
       ▿ 27 : 2 elements
         - key : "aud"
         - value : -17.13102
       ▿ 28 : 2 elements
         - key : "xau"
         - value : -21.94371
       ▿ 29 : 2 elements
         - key : "rub"
         - value : -7.6707
       ▿ 30 : 2 elements
         - key : "xrp"
         - value : -10.70296
       ▿ 31 : 2 elements
         - key : "pln"
         - value : -15.67857
       ▿ 32 : 2 elements
         - key : "ars"
         - value : -11.78734
       ▿ 33 : 2 elements
         - key : "bits"
         - value : -18.17027
       ▿ 34 : 2 elements
         - key : "zar"
         - value : -18.87781
       ▿ 35 : 2 elements
         - key : "bmd"
         - value : -15.22587
       ▿ 36 : 2 elements
         - key : "nzd"
         - value : -16.32903
       ▿ 37 : 2 elements
         - key : "pkr"
         - value : -15.46426
       ▿ 38 : 2 elements
         - key : "try"
         - value : -13.35278
       ▿ 39 : 2 elements
         - key : "twd"
         - value : -15.87289
       ▿ 40 : 2 elements
         - key : "inr"
         - value : -15.10848
       ▿ 41 : 2 elements
         - key : "czk"
         - value : -14.99265
       ▿ 42 : 2 elements
         - key : "gel"
         - value : -14.12286
       ▿ 43 : 2 elements
         - key : "php"
         - value : -15.25101
       ▿ 44 : 2 elements
         - key : "yfi"
         - value : -13.76628
       ▿ 45 : 2 elements
         - key : "eth"
         - value : -10.13097
       ▿ 46 : 2 elements
         - key : "kwd"
         - value : -15.11288      ▿ 47 : 2 elements
         - key : "myr"
         - value : -18.3025
       ▿ 48 : 2 elements
         - key : "sats"
         - value : -18.17027
       ▿ 49 : 2 elements
         - key : "dkk"
         - value : -15.35953
       ▿ 50 : 2 elements
         - key : "btc"
         - value : -18.17027
       ▿ 51 : 2 elements
         - key : "ltc"
         - value : -20.5159
       ▿ 52 : 2 elements
         - key : "xlm"
         - value : -6.78633
       ▿ 53 : 2 elements
         - key : "cad"
         - value : -15.06956
       ▿ 54 : 2 elements
         - key : "ils"
         - value : -15.01017
       ▿ 55 : 2 elements
         - key : "chf"
         - value : -16.16946
       ▿ 56 : 2 elements
         - key : "mmk"
         - value : -15.22587
       ▿ 57 : 2 elements
         - key : "aed"
         - value : -15.22679
       ▿ 58 : 2 elements
         - key : "thb"
         - value : -19.81325
       ▿ 59 : 2 elements
         - key : "gbp"
         - value : -17.02237
       ▿ 60 : 2 elements
         - key : "krw"
         - value : -16.57898
       ▿ 61 : 2 elements
         - key : "dot"
         - value : -6.03966
     ▿ priceChangePercentage200DInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "twd"
         - value : -3.44672
       ▿ 1 : 2 elements
         - key : "rub"
         - value : 0.5329
       ▿ 2 : 2 elements
         - key : "bhd"
         - value : -4.45127
       ▿ 3 : 2 elements
         - key : "bmd"
         - value : -4.44544
       ▿ 4 : 2 elements
         - key : "ars"
         - value : 9.05411
       ▿ 5 : 2 elements
         - key : "try"
         - value : 2.18291
       ▿ 6 : 2 elements
         - key : "nzd"
         - value : -5.92385
       ▿ 7 : 2 elements
         - key : "ils"
         - value : -1.25214
       ▿ 8 : 2 elements
         - key : "pkr"
         - value : -4.88606
       ▿ 9 : 2 elements
         - key : "mxn"
         - value : 10.89709
       ▿ 10 : 2 elements
         - key : "bits"
         - value : 6.22632
       ▿ 11 : 2 elements
         - key : "dot"
         - value : 121.94144
       ▿ 12 : 2 elements
         - key : "btc"
         - value : 6.22632
       ▿ 13 : 2 elements
         - key : "bdt"
         - value : 4.06027
       ▿ 14 : 2 elements
         - key : "hkd"
         - value : -5.05394
       ▿ 15 : 2 elements
         - key : "yfi"
         - value : 74.80812
       ▿ 16 : 2 elements
         - key : "bch"
         - value : 45.35662
       ▿ 17 : 2 elements
         - key : "eth"
         - value : 38.50599
       ▿ 18 : 2 elements
         - key : "idr"
         - value : -5.54269
       ▿ 19 : 2 elements
         - key : "sats"
         - value : 6.22632
       ▿ 20 : 2 elements
         - key : "lkr"
         - value : -7.74351
       ▿ 21 : 2 elements
         - key : "bnb"
         - value : -0.05763
       ▿ 22 : 2 elements
         - key : "uah"
         - value : 0.98597
       ▿ 23 : 2 elements
         - key : "cad"
         - value : -3.32628
       ▿ 24 : 2 elements
         - key : "pln"
         - value : -5.79774
       ▿ 25 : 2 elements
         - key : "xlm"
         - value : 43.43813
       ▿ 26 : 2 elements
         - key : "xrp"
         - value : 13.53791
       ▿ 27 : 2 elements
         - key : "czk"
         - value : -5.49061
       ▿ 28 : 2 elements
         - key : "sgd"
         - value : -7.29116
       ▿ 29 : 2 elements
         - key : "nok"
         - value : -4.39173
       ▿ 30 : 2 elements
         - key : "aed"
         - value : -4.43009
       ▿ 31 : 2 elements
         - key : "usd"
         - value : -4.44544
       ▿ 32 : 2 elements
         - key : "ngn"
         - value : 6.84523
       ▿ 33 : 2 elements
         - key : "huf"
         - value : -4.56011
       ▿ 34 : 2 elements
         - key : "brl"
         - value : 6.65098
       ▿ 35 : 2 elements
         - key : "krw"
         - value : -3.87403
       ▿ 36 : 2 elements
         - key : "php"
         - value : -2.98608
       ▿ 37 : 2 elements
         - key : "vef"
         - value : -4.44544
       ▿ 38 : 2 elements
         - key : "cny"
         - value : -6.172
       ▿ 39 : 2 elements
         - key : "gbp"
         - value : -7.62538
       ▿ 40 : 2 elements
         - key : "gel"
         - value : -3.56068
       ▿ 41 : 2 elements
         - key : "sar"
         - value : -4.32427
       ▿ 42 : 2 elements
         - key : "dkk"
         - value : -5.39489
       ▿ 43 : 2 elements
         - key : "zar"
         - value : -11.74876
       ▿ 44 : 2 elements
         - key : "eos"
         - value : 116.19086
       ▿ 45 : 2 elements
         - key : "vnd"
         - value : -4.20823
       ▿ 46 : 2 elements
         - key : "chf"
         - value : -8.63643
       ▿ 47 : 2 elements
         - key : "sek"
         - value : -5.80712
       ▿ 48 : 2 elements
         - key : "xag"
         - value : -24.28896
       ▿ 49 : 2 elements
         - key : "link"
         - value : 70.54921
       ▿ 50 : 2 elements
         - key : "kwd"
         - value : -4.80136
       ▿ 51 : 2 elements
         - key : "aud"
         - value : -7.39619
       ▿ 52 : 2 elements
         - key : "inr"
         - value : -3.76133
       ▿ 53 : 2 elements
         - key : "mmk"
         - value : -4.5296
       ▿ 54 : 2 elements
         - key : "xdr"
         - value : -5.40696
       ▿ 55 : 2 elements
         - key : "eur"
         - value : -5.42301
       ▿ 56 : 2 elements
         - key : "thb"
         - value : -12.38358
       ▿ 57 : 2 elements
         - key : "ltc"
         - value : 33.08137
       ▿ 58 : 2 elements
         - key : "xau"
         - value : -21.60354
       ▿ 59 : 2 elements
         - key : "jpy"
         - value : -5.9873
       ▿ 60 : 2 elements
         - key : "myr"
         - value : -13.32789
       ▿ 61 : 2 elements
         - key : "clp"
         - value : -9.52056
     ▿ priceChangePercentage1YInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "gel"
         - value : 164.62419
       ▿ 1 : 2 elements
         - key : "bmd"
         - value : 161.22535
       ▿ 2 : 2 elements
         - key : "kwd"
         - value : 159.00726
       ▿ 3 : 2 elements
         - key : "bhd"
         - value : 161.22258
       ▿ 4 : 2 elements
         - key : "rub"
         - value : 152.6445
       ▿ 5 : 2 elements
         - key : "bdt"
         - value : 183.66046
       ▿ 6 : 2 elements
         - key : "gbp"
         - value : 145.99185
       ▿ 7 : 2 elements
         - key : "sats"
         - value : 16.90152
       ▿ 8 : 2 elements
         - key : "xau"
         - value : 83.63924
       ▿ 9 : 2 elements
         - key : "inr"
         - value : 163.87495
       ▿ 10 : 2 elements
         - key : "pkr"
         - value : 162.39434
       ▿ 11 : 2 elements
         - key : "czk"
         - value : 161.3189
       ▿ 12 : 2 elements
         - key : "hkd"
         - value : 159.64592
       ▿ 13 : 2 elements
         - key : "vef"
         - value : 161.22535
       ▿ 14 : 2 elements
         - key : "ltc"
         - value : 153.19403
       ▿ 15 : 2 elements
         - key : "xdr"
         - value : 155.45827
       ▿ 16 : 2 elements
         - key : "yfi"
         - value : 171.31809
       ▿ 17 : 2 elements
         - key : "jpy"
         - value : 160.96597
       ▿ 18 : 2 elements
         - key : "lkr"
         - value : 136.56336
       ▿ 19 : 2 elements
         - key : "aed"
         - value : 161.21931
       ▿ 20 : 2 elements
         - key : "eth"
         - value : 69.10732
       ▿ 21 : 2 elements
         - key : "aud"
         - value : 148.90307
       ▿ 22 : 2 elements
         - key : "mxn"
         - value : 183.15069
       ▿ 23 : 2 elements
         - key : "eur"
         - value : 153.34479
       ▿ 24 : 2 elements
         - key : "ars"
         - value : 627.34999
       ▿ 25 : 2 elements
         - key : "mmk"
         - value : 161.42514
       ▿ 26 : 2 elements
         - key : "sgd"
         - value : 150.33513
       ▿ 27 : 2 elements
         - key : "ils"
         - value : 149.54663
       ▿ 28 : 2 elements
         - key : "chf"
         - value : 147.54407
       ▿ 29 : 2 elements
         - key : "sar"
         - value : 161.52559
       ▿ 30 : 2 elements
         - key : "xag"
         - value : 83.00713
       ▿ 31 : 2 elements
         - key : "uah"
         - value : 195.78376
       ▿ 32 : 2 elements
         - key : "pln"
         - value : 140.24013
       ▿ 33 : 2 elements
         - key : "zar"
         - value : 140.13164
       ▿ 34 : 2 elements
         - key : "vnd"
         - value : 165.40783
       ▿ 35 : 2 elements
         - key : "btc"
         - value : 16.90152
       ▿ 36 : 2 elements
         - key : "thb"
         - value : 139.09685
       ▿ 37 : 2 elements
         - key : "cny"
         - value : 153.38279
       ▿ 38 : 2 elements
         - key : "xlm"
         - value : 199.83079
       ▿ 39 : 2 elements
         - key : "twd"
         - value : 162.30492
       ▿ 40 : 2 elements
         - key : "nzd"
         - value : 158.25224
       ▿ 41 : 2 elements
         - key : "eos"
         - value : 200.96693
       ▿ 42 : 2 elements
         - key : "bnb"
         - value : -3.89603
       ▿ 43 : 2 elements
         - key : "link"
         - value : 77.91585
       ▿ 44 : 2 elements
         - key : "brl"
         - value : 188.65799
       ▿ 45 : 2 elements
         - key : "usd"
         - value : 161.22535
       ▿ 46 : 2 elements
         - key : "bits"
         - value : 16.90152
       ▿ 47 : 2 elements
         - key : "nok"
         - value : 159.85515
       ▿ 48 : 2 elements
         - key : "sek"
         - value : 149.65776
       ▿ 49 : 2 elements
         - key : "php"
         - value : 163.93363
       ▿ 50 : 2 elements
         - key : "try"
         - value : 223.10604
       ▿ 51 : 2 elements
         - key : "krw"
         - value : 163.20571
       ▿ 52 : 2 elements
         - key : "dot"
         - value : 141.08869
       ▿ 53 : 2 elements
         - key : "xrp"
         - value : 138.88669
       ▿ 54 : 2 elements
         - key : "clp"
         - value : 161.47556
       ▿ 55 : 2 elements
         - key : "dkk"
         - value : 153.47463
       ▿ 56 : 2 elements
         - key : "idr"
         - value : 160.04699
       ▿ 57 : 2 elements
         - key : "huf"
         - value : 162.20965
       ▿ 58 : 2 elements
         - key : "cad"
         - value : 164.34127
       ▿ 59 : 2 elements
         - key : "ngn"
         - value : 458.3821
       ▿ 60 : 2 elements
         - key : "myr"
         - value : 136.98778
       ▿ 61 : 2 elements
         - key : "bch"
         - value : 72.96569
     ▿ marketCapChange24HInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "bnb"
         - value : 658949.0
       ▿ 1 : 2 elements
         - key : "xrp"
         - value : -60898046.12659073
       ▿ 2 : 2 elements
         - key : "cny"
         - value : 875475832.0
       ▿ 3 : 2 elements
         - key : "vnd"
         - value : 2339134225143.0
       ▿ 4 : 2 elements
         - key : "nzd"
         - value : 157624834.0
       ▿ 5 : 2 elements
         - key : "eos"
         - value : 103970971.0
       ▿ 6 : 2 elements
         - key : "cad"
         - value : 212868538.0
       ▿ 7 : 2 elements
         - key : "zar"
         - value : 212138622.0
       ▿ 8 : 2 elements
         - key : "chf"
         - value : 66145899.0
       ▿ 9 : 2 elements
         - key : "sek"
         - value : 1179311331.0
       ▿ 10 : 2 elements
         - key : "xdr"
         - value : 61131924.0
       ▿ 11 : 2 elements
         - key : "rub"
         - value : 9829492109.0
       ▿ 12 : 2 elements
         - key : "kwd"
         - value : 34278692.0
       ▿ 13 : 2 elements
         - key : "pkr"
         - value : 22907253055.0
       ▿ 14 : 2 elements
         - key : "czk"
         - value : 2675737106.0
       ▿ 15 : 2 elements
         - key : "xag"
         - value : -5353850.637879014
       ▿ 16 : 2 elements
         - key : "nok"
         - value : 758029497.0
       ▿ 17 : 2 elements
         - key : "mxn"
         - value : 1765154269.0
       ▿ 18 : 2 elements
         - key : "aud"
         - value : 149663583.0
       ▿ 19 : 2 elements
         - key : "ils"
         - value : 459941705.0
       ▿ 20 : 2 elements
         - key : "twd"
         - value : 2709478130.0
       ▿ 21 : 2 elements
         - key : "bhd"
         - value : 41898207.0
       ▿ 22 : 2 elements
         - key : "try"
         - value : 4403130651.0
       ▿ 23 : 2 elements
         - key : "sar"
         - value : 417741136.0
       ▿ 24 : 2 elements
         - key : "inr"
         - value : 10684325869.0
       ▿ 25 : 2 elements
         - key : "huf"
         - value : 69604333794.0
       ▿ 26 : 2 elements
         - key : "thb"
         - value : 1273536879.0
       ▿ 27 : 2 elements
         - key : "ltc"
         - value : 2564029.0
       ▿ 28 : 2 elements
         - key : "sgd"
         - value : 135012950.0
       ▿ 29 : 2 elements
         - key : "jpy"
         - value : 11916778362.0
       ▿ 30 : 2 elements
         - key : "aed"
         - value : 405055417.0
       ▿ 31 : 2 elements
         - key : "ars"
         - value : 107506207476.0
       ▿ 32 : 2 elements
         - key : "gbp"
         - value : 103327706.0
       ▿ 33 : 2 elements
         - key : "sats"
         - value : 321184901483.0
       ▿ 34 : 2 elements
         - key : "bch"
         - value : 470398.0
       ▿ 35 : 2 elements
         - key : "eur"
         - value : 106095585.0
       ▿ 36 : 2 elements
         - key : "lkr"
         - value : 23727249588.0
       ▿ 37 : 2 elements
         - key : "dot"
         - value : 19856253.0
       ▿ 38 : 2 elements
         - key : "clp"
         - value : 44406487949.0
       ▿ 39 : 2 elements
         - key : "uah"
         - value : 3902381020.0
       ▿ 40 : 2 elements
         - key : "idr"
         - value : 1065832965964.0
       ▿ 41 : 2 elements
         - key : "myr"
         - value : 388929944.0
       ▿ 42 : 2 elements
         - key : "bmd"
         - value : 110350102.0
       ▿ 43 : 2 elements
         - key : "eth"
         - value : 46311.0
       ▿ 44 : 2 elements
         - key : "pln"
         - value : 543052203.0
       ▿ 45 : 2 elements
         - key : "php"
         - value : 6770890417.0
       ▿ 46 : 2 elements
         - key : "xau"
         - value : -13790.29723817762
       ▿ 47 : 2 elements
         - key : "bdt"
         - value : 9791565317.0
       ▿ 48 : 2 elements
         - key : "brl"
         - value : 431929481.0
       ▿ 49 : 2 elements
         - key : "yfi"
         - value : 54100.0
       ▿ 50 : 2 elements
         - key : "xlm"
         - value : 632816291.0
       ▿ 51 : 2 elements
         - key : "btc"
         - value : 3212.0
       ▿ 52 : 2 elements
         - key : "gel"
         - value : 365555158.0
       ▿ 53 : 2 elements
         - key : "ngn"
         - value : 155430690068.0
       ▿ 54 : 2 elements
         - key : "dkk"
         - value : 804725802.0
       ▿ 55 : 2 elements
         - key : "usd"
         - value : 110350102.0
       ▿ 56 : 2 elements
         - key : "vef"
         - value : 11049356.0
       ▿ 57 : 2 elements
         - key : "mmk"
         - value : 231514514181.0
       ▿ 58 : 2 elements
         - key : "hkd"
         - value : 849699945.0
       ▿ 59 : 2 elements
         - key : "krw"
         - value : 139895373506.0
       ▿ 60 : 2 elements
         - key : "bits"
         - value : 3211849015.0
       ▿ 61 : 2 elements
         - key : "link"
         - value : 20397861.0
     ▿ marketCapChangePercentage24HInCurrency : 62 elements
       ▿ 0 : 2 elements
         - key : "inr"
         - value : 0.98105
       ▿ 1 : 2 elements
         - key : "nzd"
         - value : 0.73948
       ▿ 2 : 2 elements
         - key : "dkk"
         - value : 0.90987
       ▿ 3 : 2 elements
         - key : "pkr"
         - value : 0.63442
       ▿ 4 : 2 elements
         - key : "eth"
         - value : 0.85844
       ▿ 5 : 2 elements
         - key : "usd"
         - value : 0.8508
       ▿ 6 : 2 elements
         - key : "lkr"
         - value : 0.62313
       ▿ 7 : 2 elements
         - key : "ngn"
         - value : 0.73887
       ▿ 8 : 2 elements
         - key : "ils"
         - value : 0.94306
       ▿ 9 : 2 elements
         - key : "vef"
         - value : 0.8508
       ▿ 10 : 2 elements
         - key : "jpy"
         - value : 0.61612
       ▿ 11 : 2 elements
         - key : "huf"
         - value : 1.47118
       ▿ 12 : 2 elements
         - key : "xau"
         - value : -0.27806
       ▿ 13 : 2 elements
         - key : "bnb"
         - value : 2.90475
       ▿ 14 : 2 elements
         - key : "xag"
         - value : -1.25941
       ▿ 15 : 2 elements
         - key : "yfi"
         - value : 2.05918
       ▿ 16 : 2 elements
         - key : "cad"
         - value : 1.19702
       ▿ 17 : 2 elements
         - key : "btc"
         - value : 1.50975
       ▿ 18 : 2 elements
         - key : "bdt"
         - value : 0.63029
       ▿ 19 : 2 elements
         - key : "try"
         - value : 0.99123
       ▿ 20 : 2 elements
         - key : "bhd"
         - value : 0.85695
       ▿ 21 : 2 elements
         - key : "eos"
         - value : 0.37078
       ▿ 22 : 2 elements
         - key : "dot"
         - value : 0.62245
       ▿ 23 : 2 elements
         - key : "sgd"
         - value : 0.7964
       ▿ 24 : 2 elements
         - key : "ars"
         - value : 0.85034
       ▿ 25 : 2 elements
         - key : "mmk"
         - value : 0.8508
       ▿ 26 : 2 elements
         - key : "xlm"
         - value : 0.43909
       ▿ 27 : 2 elements
         - key : "bits"
         - value : 1.50975
       ▿ 28 : 2 elements
         - key : "aed"
         - value : 0.85025
       ▿ 29 : 2 elements
         - key : "twd"
         - value : 0.64758
       ▿ 30 : 2 elements
         - key : "mxn"
         - value : 0.6991
       ▿ 31 : 2 elements
         - key : "gel"
         - value : 1.03618
       ▿ 32 : 2 elements
         - key : "gbp"
         - value : 1.04143
       ▿ 33 : 2 elements
         - key : "krw"
         - value : 0.79899
       ▿ 34 : 2 elements
         - key : "sats"
         - value : 1.50975
       ▿ 35 : 2 elements
         - key : "cny"
         - value : 0.95495
       ▿ 36 : 2 elements
         - key : "zar"
         - value : 0.09275
       ▿ 37 : 2 elements
         - key : "uah"
         - value : 0.72883
       ▿ 38 : 2 elements
         - key : "bmd"
         - value : 0.8508
       ▿ 39 : 2 elements
         - key : "ltc"
         - value : 1.28416
       ▿ 40 : 2 elements
         - key : "sar"
         - value : 0.85775
       ▿ 41 : 2 elements
         - key : "pln"
         - value : 1.06625
       ▿ 42 : 2 elements
         - key : "czk"
         - value : 0.89026
       ▿ 43 : 2 elements
         - key : "thb"
         - value : 0.29284
       ▿ 44 : 2 elements
         - key : "idr"
         - value : 0.52425
       ▿ 45 : 2 elements
         - key : "chf"
         - value : 0.59303
       ▿ 46 : 2 elements
         - key : "rub"
         - value : 0.78129
       ▿ 47 : 2 elements
         - key : "brl"
         - value : 0.59495
       ▿ 48 : 2 elements
         - key : "aud"
         - value : 0.77642
       ▿ 49 : 2 elements
         - key : "eur"
         - value : 0.89481
       ▿ 50 : 2 elements
         - key : "php"
         - value : 0.91155
       ▿ 51 : 2 elements
         - key : "myr"
         - value : 0.69817
       ▿ 52 : 2 elements
         - key : "nok"
         - value : 0.54238
       ▿ 53 : 2 elements
         - key : "kwd"
         - value : 0.86231
       ▿ 54 : 2 elements
         - key : "hkd"
         - value : 0.84298
       ▿ 55 : 2 elements
         - key : "link"
         - value : 1.67974
       ▿ 56 : 2 elements
         - key : "xdr"
         - value : 0.63209
       ▿ 57 : 2 elements
         - key : "bch"
         - value : 1.17173
       ▿ 58 : 2 elements
         - key : "xrp"
         - value : -0.24789
       ▿ 59 : 2 elements
         - key : "clp"
         - value : 0.36634
       ▿ 60 : 2 elements
         - key : "vnd"
         - value : 0.72562
       ▿ 61 : 2 elements
         - key : "sek"
         - value : 0.87451
     - totalSupply : 5112950469.3307
     - circulatingSupply : 2536897542.44458
     - maxSupply : nil
     - lastUpdated : "2024-10-11T06:19:48.412Z"
   ▿ communityData : CommunityData
     - facebookLikes : nil
     - twitterFollowers : 2505392
     - redditAveragePosts48H : 0
     - redditAverageComments48H : 0
     - redditSubscribers : 0
     - redditAccountsActive48H : 0
     ▿ telegramChannelUserCount : Optional<Int>
       - some : 10973808
   ▿ developerData : DeveloperData
     - forks : 906
     - stars : 2963
     - subscribers : 173
     - totalIssues : 556
     - closedIssues : 455
     - pullRequestsMerged : 493
     - pullRequestContributors : 41
     ▿ codeAdditionsDeletions4_Weeks : CodeAdditionsDeletions4_Weeks
       ▿ additions : Optional<Int>
         - some : 0
       ▿ deletions : Optional<Int>
         - some : 0
     - commitCount4_Weeks : 1
     ▿ last4WeeksCommitActivitySeries : 28 elements
       - 0 : 0
       - 1 : 0
       - 2 : 0
       - 3 : 0
       - 4 : 0
       - 5 : 0
       - 6 : 0
       - 7 : 0
       - 8 : 0
       - 9 : 0
       - 10 : 0
       - 11 : 0
       - 12 : 0
       - 13 : 0
       - 14 : 0
       - 15 : 1
       - 16 : 0
       - 17 : 0
       - 18 : 0
       - 19 : 0
       - 20 : 0
       - 21 : 0
       - 22 : 0
       - 23 : 0
       - 24 : 0
       - 25 : 0
       - 26 : 0
       - 27 : 0
   - lastUpdated : "2024-10-11T06:19:48.412Z"
   ▿ tickers : 100 elements
     ▿ 0 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bybit"
         - identifier : "bybit_spot"
         - hasTradingIncentive : false
       - last : 5.164
       - volume : 2939931.59
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.519e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214638
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 14905366.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 14906805.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 246.078
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 6200.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.019361
       - timestamp : "2024-10-11T06:19:14+00:00"
       - lastTradedAt : "2024-10-11T06:19:14+00:00"
       - lastFetchAt : "2024-10-11T06:19:14+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bybit.com/trade/spot/TON/USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 1 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "OKX"
         - identifier : "okex"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 2565751.1201
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 214.752
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 5411.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 13004012.0
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 13007859.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.019369
       - timestamp : "2024-10-11T06:18:37+00:00"
       - lastTradedAt : "2024-10-11T06:18:37+00:00"
       - lastFetchAt : "2024-10-11T06:18:37+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.okx.com/trade-spot/ton-usdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 2 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "MEXC"
         - identifier : "mxc"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 1469242.1
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.0021457
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 7577532.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 125.092
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 7578127.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 3153.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.019376
       - timestamp : "2024-10-11T06:16:04+00:00"
       - lastTradedAt : "2024-10-11T06:16:04+00:00"
       - lastFetchAt : "2024-10-11T06:16:04+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.mexc.com/exchange/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 3 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Azbit"
         - identifier : "azbit"
         - hasTradingIncentive : false
       - last : 5.156
       - volume : 810133.223
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214287
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.504e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 1714.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 4120172.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 4120808.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 68.017
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.011937
       - timestamp : "2024-10-11T06:14:19+00:00"
       - lastTradedAt : "2024-10-11T06:14:19+00:00"
       - lastFetchAt : "2024-10-11T06:14:19+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://azbit.com/exchange/TON_USDT?referralCode=OH5QDS1"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 4 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "WhiteBIT"
         - identifier : "whitebit"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 5119395.78
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214535
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 26405406.0
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 26401913.0
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 10983.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 435.88
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.077444
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://whitebit.com/trade/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 5 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "KuCoin"
         - identifier : "kucoin"
         - hasTradingIncentive : false
       - last : 5.1613
       - volume : 299753.2221
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214546
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 1546495.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 25.521994
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 643.108
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 1545886.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.011937
       - timestamp : "2024-10-11T06:18:02+00:00"
       - lastTradedAt : "2024-10-11T06:18:02+00:00"
       - lastFetchAt : "2024-10-11T06:18:02+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.kucoin.com/trade/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 6 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "LBank"
         - identifier : "lbank"
         - hasTradingIncentive : false
       - last : 5.157
       - volume : 1153980.006
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214383
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.507e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5945821.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 2474.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5946870.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 98.165
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.058128
       - timestamp : "2024-10-11T06:16:15+00:00"
       - lastTradedAt : "2024-10-11T06:16:15+00:00"
       - lastFetchAt : "2024-10-11T06:16:15+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.lbank.com/trade/ton_usdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 7 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "BTSE"
         - identifier : "btse"
         - hasTradingIncentive : false
       - last : 5.1590189462
       - volume : 230054.3440672947
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.509e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214412
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 19.575681
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 1185807.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 1185990.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 493.264
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.020147
       - timestamp : "2024-10-11T06:14:16+00:00"
       - lastTradedAt : "2024-10-11T06:14:16+00:00"
       - lastFetchAt : "2024-10-11T06:14:16+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.btse.com/en/trading/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 8 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Biconomy.com"
         - identifier : "biconomy"
         - hasTradingIncentive : false
       - last : 5.164
       - volume : 486187.54
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.519e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.0021465
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 40.796103
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 1028.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 2471090.0
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 2471438.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.077429
       - timestamp : "2024-10-11T06:19:04+00:00"
       - lastTradedAt : "2024-10-11T06:19:04+00:00"
       - lastFetchAt : "2024-10-11T06:19:04+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.biconomy.com/exchange/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 9 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "Bybit"
         - identifier : "bybit_spot"
         - hasTradingIncentive : false
       - last : 5.152
       - volume : 87296.62
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.507e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214337
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 441695.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 183.758
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 441760.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 7.293172
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.038745
       - timestamp : "2024-10-11T06:19:21+00:00"
       - lastTradedAt : "2024-10-11T06:19:21+00:00"
       - lastFetchAt : "2024-10-11T06:19:21+00:00"
       - isAnomaly : false
       - isStale : false      ▿ tradeURL : Optional<String>
         - some : "https://www.bybit.com/trade/spot/TON/USDC"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 10 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Hotcoin"
         - identifier : "hotcoin_global"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 464201.9796
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214564
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 996.008
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 2394283.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 2394095.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 39.52249
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.212889
       - timestamp : "2024-10-11T06:15:41+00:00"
       - lastTradedAt : "2024-10-11T06:15:41+00:00"
       - lastFetchAt : "2024-10-11T06:15:41+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.hotcoin.com/currencyExchange/ton_usdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 11 : Ticker
       - base : "EQCXE6MUTQJKFNGFAROTKOT1LZBDIIX1KCIXRV7NW2ID_SDS"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.194199068858487
       - volume : 5507261.02259501
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.507e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214397
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5598869.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 92.421
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 2329.0
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5598429.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.602717
       - timestamp : "2024-10-11T06:15:52+00:00"
       - lastTradedAt : "2024-10-11T06:15:52+00:00"
       - lastFetchAt : "2024-10-11T06:15:52+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqcxe6mutqjkfngfarotkot1lzbdiix1kcixrv7nw2id_sds&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "tether"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 12 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "CoinEx"
         - identifier : "coinex"
         - hasTradingIncentive : false
       - last : 5.155
       - volume : 358917.5083201
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.503e-05
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214249
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 756.851
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 1819719.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 1819439.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 30.035875
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.193618
       - timestamp : "2024-10-11T06:14:58+00:00"
       - lastTradedAt : "2024-10-11T06:14:58+00:00"
       - lastFetchAt : "2024-10-11T06:14:58+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.coinex.com/trading?currency=USDT&dest=TON#limit"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 13 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "EXMO"
         - identifier : "exmo"
         - hasTradingIncentive : false
       - last : 5.165475
       - volume : 51383.39968283
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214721
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.522e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 265226.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 110.331
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 265179.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 4.378726
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.038235
       - timestamp : "2024-10-11T06:18:36+00:00"
       - lastTradedAt : "2024-10-11T06:18:36+00:00"
       - lastFetchAt : "2024-10-11T06:18:36+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://exmo.com/en/trade/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 14 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Dex-Trade"
         - identifier : "dextrade"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 71394.71
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214587
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.515e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 6.079192
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 368231.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 368214.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 153.204
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.096824
       - timestamp : "2024-10-11T06:16:34+00:00"
       - lastTradedAt : "2024-10-11T06:16:34+00:00"
       - lastFetchAt : "2024-10-11T06:16:34+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dex-trade.com/spot/trading/TONUSDT?interface=classic"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 15 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Phemex"
         - identifier : "phemex"
         - hasTradingIncentive : false
       - last : 5.155
       - volume : 83383.9954
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214264
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.504e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 178.662
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 429509.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 429503.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 7.09091
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.290023
       - timestamp : "2024-10-11T06:19:22+00:00"
       - lastTradedAt : "2024-10-11T06:19:22+00:00"
       - lastFetchAt : "2024-10-11T06:19:22+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://phemex.com/spot/trade/TONUSDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"    ▿ 16 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "CoinW"
         - identifier : "coinw"
         - hasTradingIncentive : false
       - last : 5.157
       - volume : 33395.48
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.506e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214332
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 71.577
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 172068.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 172095.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 2.840561
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.135554
       - timestamp : "2024-10-11T06:14:34+00:00"
       - lastTradedAt : "2024-10-11T06:14:34+00:00"
       - lastFetchAt : "2024-10-11T06:14:34+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.coinw.com/front/market"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 17 : Ticker
       - base : "TON"
       - target : "BTC"
       ▿ market : Market
         - name : "EXMO"
         - identifier : "exmo"
         - hasTradingIncentive : false
       - last : 8.523e-05
       - volume : 171426.5941989
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.523e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214754
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 14.610689
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 368.146
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 884991.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.701919
       - timestamp : "2024-10-11T06:18:36+00:00"
       - lastTradedAt : "2024-10-11T06:18:36+00:00"
       - lastFetchAt : "2024-10-11T06:18:36+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://exmo.com/en/trade/TON_BTC"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "bitcoin"
     ▿ 18 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "EXMO"
         - identifier : "exmo"
         - hasTradingIncentive : false
       - last : 5.1576
       - volume : 77406.2240415
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.515e-05
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.0021456
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 399170.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 166.083
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 399248.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 6.59136
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.376798
       - timestamp : "2024-10-11T06:18:40+00:00"
       - lastTradedAt : "2024-10-11T06:18:40+00:00"
       - lastFetchAt : "2024-10-11T06:18:40+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://exmo.com/en/trade/TON_USDC"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 19 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "Bitget"
         - identifier : "bitget"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 42626.43
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214701
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.521e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 216882.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 3.581303
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 90.238
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 216925.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.232288
       - timestamp : "2024-10-11T06:18:48+00:00"
       - lastTradedAt : "2024-10-11T06:18:48+00:00"
       - lastFetchAt : "2024-10-11T06:18:48+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bitget.com/spot/TONUSDC"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 20 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Tapbit"
         - identifier : "tapbit"
         - hasTradingIncentive : false
       - last : 5.1614
       - volume : 13290.92
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.515e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214565
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 67597.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 1.115961
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 67589.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 28.12218
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.143266
       - timestamp : "2024-10-11T06:17:14+00:00"
       - lastTradedAt : "2024-10-11T06:17:14+00:00"
       - lastFetchAt : "2024-10-11T06:17:14+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.tapbit.com/spot/exchange/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 21 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "PancakeSwap V3 (BSC)"
         - identifier : "pancakeswap-v3-bsc"
         - hasTradingIncentive : false
       - last : 0.0091390818925656
       - volume : 32996.119181225
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.002132
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.12
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.461e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 2.748836
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 69.267
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 166499.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.61424
       - timestamp : "2024-10-11T06:17:53+00:00"
       - lastTradedAt : "2024-10-11T06:17:53+00:00"
       - lastFetchAt : "2024-10-11T06:17:53+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 22 : Ticker
       - base : "EQAQXLWJVGBBFFE8F3OS8S87LIGDOVS455ISWFARDMJETTON"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.179865595677141
       - volume : 130283.077226517
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 1.990016
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 50.143
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 120538.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.60304
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqaqxlwjvgbbffe8f3os8s87ligdovs455iswfardmjetton&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "jetton"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 23 : Ticker
       - base : "TON"
       - target : "KRW"
       ▿ market : Market
         - name : "Coinone"
         - identifier : "coinone"
         - hasTradingIncentive : false
       - last : 7000.0
       - volume : 9037.06263171
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.0021583
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.565e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.19
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.7740507
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 19.504688
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 46885.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.285714
       - timestamp : "2024-10-11T06:16:20+00:00"
       - lastTradedAt : "2024-10-11T06:16:20+00:00"
       - lastFetchAt : "2024-10-11T06:18:15+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://coinone.co.kr/exchange/trade/ton/krw"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 24 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "PancakeSwap V3 (BSC)"
         - identifier : "pancakeswap-v3-bsc"
         - hasTradingIncentive : false
       - last : 0.00913970187421012
       - volume : 15849.644072421
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.13
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.461e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00213214
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 32.807299
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 78860.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 1.301952
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.604886
       - timestamp : "2024-10-11T06:13:50+00:00"
       - lastTradedAt : "2024-10-11T06:13:50+00:00"
       - lastFetchAt : "2024-10-11T06:17:52+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 25 : Ticker
       - base : "TON"
       - target : "TRY"
       ▿ market : Market
         - name : "Bitci TR"
         - identifier : "bitci"
         - hasTradingIncentive : false
       - last : 175.93
       - volume : 26484.25453901
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.13
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00213382
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.469e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 2.224435
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 134738.0
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 56.047
       - trustScore : "green"
       - bidAskSpreadPercentage : 1.012886
       - timestamp : "2024-10-11T06:19:02+00:00"
       - lastTradedAt : "2024-10-11T06:19:02+00:00"
       - lastFetchAt : "2024-10-11T06:19:02+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bitci.com.tr/exchange/advanced/TON_TRY"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 26 : Ticker
       - base : "0X582D872A1B094FC48F5DE31D3B73F2D9BE47DEF1"
       - target : "0XDAC17F958D2EE523A2206206994597C13D831EC7"
       ▿ market : Market
         - name : "Uniswap V3 (Ethereum)"
         - identifier : "uniswap_v3"
         - hasTradingIncentive : false
       - last : 5.153638785349
       - volume : 14661.826244271
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.002151
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.17
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.535e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 31.07494
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 74690.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 74388.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 1.233065
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.603436
       - timestamp : "2024-10-11T06:16:34+00:00"
       - lastTradedAt : "2024-10-11T06:16:34+00:00"
       - lastFetchAt : "2024-10-11T06:16:34+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://app.uniswap.org/explore/tokens/ethereum/0x582d872a1b094fc48f5de31d3b73f2d9be47def1"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 27 : Ticker
       - base : "EQBTDMYGCKK3ECQ1X-J0CLZRNPYYAV7CB33AD036QN-HE2C7"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.00281787072469788
       - volume : 4446235.16466088
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 63824.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 1.053702
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 26.550187
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.603764
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqbtdmygckk3ecq1x-j0clzrnpyyav7cb33ad036qn-he2c7&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "ton-cat"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 28 : Ticker
       - base : "EQD4P32U10SNNOIAVOQ6CYPTQR82EWAJO20EPIGRWRAUP54_"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.988202582043741
       - volume : 10204.60904
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.85521985
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 21.549015
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 51802.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.603253
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqd4p32u10snnoiavoq6cyptqr82ewajo20epigrwraup54_&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "tonhydra"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 29 : Ticker
       - base : "EQAVLWFDXGF2LXM67Y4YZC17WYKD9A0GUWPKMS1GOSM__NOT"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.00141772161575201
       - volume : 5647132.27963305
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 17.447121
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 41941.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.69242719
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.603883
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqavlwfdxgf2lxm67y4yzc17wykd9a0guwpkms1gosm__not&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "notcoin"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 30 : Ticker
       - base : "EQB02DJ0CDUD4IQDRBBV4AYG3HTEPHBRK1TGERTCNATESCK0"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.00425666028385539
       - volume : 1796502.62411402
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 40324.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.66573105
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 16.774457
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.603627
       - timestamp : "2024-10-11T06:02:51+00:00"
       - lastTradedAt : "2024-10-11T06:02:51+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqb02dj0cdud4iqdrbbv4ayg3htephbrk1tgertcnatesck0&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "povel-durev"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 31 : Ticker
       - base : "EQDDCHA_K-Z97LKL599O0GDAT0PY2ZUUONS4WUF85TQ6NXIO"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.0147534982232267
       - volume : 574842.287817297
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214577
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.69696647
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 17.561497
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 42216.0
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.605083
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqddcha_k-z97lkl599o0gdat0py2zuuons4wuf85tq6nxio&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "du-rove-s-wall"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 32 : Ticker
       - base : "EQCVXJY4EG8HYHBFSZ7EEPXRRSUQSFE_JPPTRAYBMCG_DOGS"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.000127056056717027
       - volume : 35761723.3934699
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 23733.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.39181435
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 9.872565
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.604779
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqcvxjy4eg8hyhbfsz7eepxrrsuqsfe_jpptraybmcg_dogs&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "dogs-2"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 33 : Ticker
       - base : "EQBZ_CAFPYDR5KUTS0ANXH0ZTDHKPEZONMLJA2SNGLLM4CKO"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.0569886454949536
       - volume : 76283.260523172
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214586
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 24586.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 10.228013
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.40590245
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.626768
       - timestamp : "2024-10-11T06:06:20+00:00"
       - lastTradedAt : "2024-10-11T06:06:20+00:00"
       - lastFetchAt : "2024-10-11T06:18:28+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqbz_cafpydr5kuts0anxh0ztdhkpezonmlja2sngllm4cko&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "resistance-dog"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 34 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "PancakeSwap (v2)"
         - identifier : "pancakeswap_new"
         - hasTradingIncentive : false
       - last : 5.13574068952667
       - volume : 3715.701880027
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.12
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.459e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.0021311
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 7.891731
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 18973.43
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.31324888
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.607067
       - timestamp : "2024-10-11T05:55:58+00:00"
       - lastTradedAt : "2024-10-11T05:55:58+00:00"
       - lastFetchAt : "2024-10-11T06:19:36+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x55d398326f99059ff775485246999027b3197955"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 35 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "Biswap"
         - identifier : "biswap"
         - hasTradingIncentive : false
       - last : 5.11669733274834
       - volume : 3248.345163306
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00212031
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.1
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.413e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 7.12915
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 17137.09
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.28288244
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.607235
       - timestamp : "2024-10-11T06:04:53+00:00"
       - lastTradedAt : "2024-10-11T06:04:53+00:00"
       - lastFetchAt : "2024-10-11T06:16:27+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://exchange.biswap.org/#/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x55d398326f99059ff775485246999027b3197955"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 36 : Ticker
       - base : "EQC47093OX5XHB0XUK2LCR2RHS8RJ-VUL61U4W2UH5ORMG_O"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.000608134530804997
       - volume : 5298249.54172156
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214577
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.27755522
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 6.993572
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 16811.93
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.614223
       - timestamp : "2024-10-11T05:30:59+00:00"
       - lastTradedAt : "2024-10-11T05:30:59+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqc47093ox5xhb0xuk2lcr2rhs8rj-vul61u4w2uh5ormg_o&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "gram-2"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 37 : Ticker
       - base : "TON"
       - target : "BTC"
       ▿ market : Market
         - name : "CoinEx"
         - identifier : "coinex"
         - hasTradingIncentive : false
       - last : 8.512e-05
       - volume : 3310.50738101
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214487
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.512e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 6.987774
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 16800.93
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.27731225
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.678918
       - timestamp : "2024-10-11T06:14:58+00:00"
       - lastTradedAt : "2024-10-11T06:14:58+00:00"
       - lastFetchAt : "2024-10-11T06:14:58+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.coinex.com/trading?currency=BTC&dest=TON#limit"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "bitcoin"
     ▿ 38 : Ticker
       - base : "EQCF9OYXO37XCGX1DSHZEWEAVGJE6KUCP0ZTKO6VCSRANDOM"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.0515807302362092
       - volume : 52314.05408953
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.22470342
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 5.661863
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 13610.62
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.606587
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqcf9oyxo37xcgx1dshzeweavgje6kucp0ztko6vcsrandom&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "random-tg"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 39 : Ticker
       - base : "EQBWY-WJ-WCQH0MFJHOWJMULJ0OIRKEJJT75ULYRJNPCNN5Z"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.000170341241310114
       - volume : 15173998.5817745
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.22269439
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 5.611241
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 13488.93
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.608066
       - timestamp : "2024-10-11T06:06:50+00:00"
       - lastTradedAt : "2024-10-11T06:06:50+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqbwy-wj-wcqh0mfjhowjmulj0oirkejjt75ulyrjnpcnn5z&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "mittens-2"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 40 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "Uniswap V3 (BSC)"
         - identifier : "uniswap-bsc"
         - hasTradingIncentive : false
       - last : 5.14746240446808
       - volume : 2472.017098754
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214069
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.495e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 5.167455
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 12423.52
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.20505929
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.616197
       - timestamp : "2024-10-11T06:09:20+00:00"
       - lastTradedAt : "2024-10-11T06:09:20+00:00"
       - lastFetchAt : "2024-10-11T06:15:01+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://app.uniswap.org/explore/tokens/bnb/0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 41 : Ticker
       - base : "EQAJ8UWD7EBQSMPSWARDF_I-8R8-XHWH3GSNKHY-URDRPCUO"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.000762714251572327
       - volume : 2979893.81729035
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214577
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.19571126
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 11854.52
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 4.931346
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.613516
       - timestamp : "2024-10-11T06:18:55+00:00"
       - lastTradedAt : "2024-10-11T06:18:55+00:00"
       - lastFetchAt : "2024-10-11T06:18:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqaj8uwd7ebqsmpswardf_i-8r8-xhwh3gsnkhy-urdrpcuo&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "hamster-kombat"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 42 : Ticker
       - base : "EQAM2KWDP9LN0YVXVFSBI0RYJBXWM70RAKPNIHBUETATRWA1"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.0344971575962162
       - volume : 61029.088015697
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214586
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 12288.44
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.20287758
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 5.112151
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.63685
       - timestamp : "2024-10-11T06:01:06+00:00"
       - lastTradedAt : "2024-10-11T06:01:06+00:00"
       - lastFetchAt : "2024-10-11T06:18:28+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqam2kwdp9ln0yvxvfsbi0ryjbxwm70rakpnihbuetatrwa1&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "arbuz"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 43 : Ticker
       - base : "0X0E09FABB73BD3ADE0A17ECC321FD13A19E81CE82"
       - target : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       ▿ market : Market
         - name : "PancakeSwap V3 (BSC)"
         - identifier : "pancakeswap-v3-bsc"
         - hasTradingIncentive : false
       - last : 0.352030841650609
       - volume : 5987.41838903016
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00213214
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.461e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.13
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.18497024
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 11203.77
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 4.66098
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.613806
       - timestamp : "2024-10-11T06:09:44+00:00"
       - lastTradedAt : "2024-10-11T06:09:44+00:00"
       - lastFetchAt : "2024-10-11T06:17:53+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82&outputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - tokenInfoURL : nil
       - coinID : "pancakeswap-token"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 44 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "PancakeSwap V3 (BSC)"
         - identifier : "pancakeswap-v3-bsc"
         - hasTradingIncentive : false
       - last : 5.11784550268711
       - volume : 2275.901591177
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.12
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00213022
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.454e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.18638624
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 11289.69
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 4.696383
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.624536
       - timestamp : "2024-10-11T06:06:27+00:00"
       - lastTradedAt : "2024-10-11T06:06:27+00:00"
       - lastFetchAt : "2024-10-11T06:18:34+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x55d398326f99059ff775485246999027b3197955"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 45 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "CoinEx"
         - identifier : "coinex"
         - hasTradingIncentive : false
       - last : 5.1725
       - volume : 2068.31825015
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00215173
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.538e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.17
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.17
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 10563.47
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.17437143
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 10552.33
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 4.394476
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.842903
       - timestamp : "2024-10-11T06:16:22+00:00"
       - lastTradedAt : "2024-10-11T06:16:22+00:00"
       - lastFetchAt : "2024-10-11T06:16:22+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.coinex.com/trading?currency=USDC&dest=TON#limit"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 46 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "Uniswap V3 (BSC)"
         - identifier : "uniswap-bsc"
         - hasTradingIncentive : false
       - last : 0.00915473730895737
       - volume : 1399.049538915
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00213564
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.476e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.13
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 6907.33
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.11403602
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 2.873371
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.613233
       - timestamp : "2024-10-11T06:14:53+00:00"
       - lastTradedAt : "2024-10-11T06:14:53+00:00"
       - lastFetchAt : "2024-10-11T06:18:50+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://app.uniswap.org/explore/tokens/bnb/0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 47 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "Uniswap V3 (BSC)"
         - identifier : "uniswap-bsc"
         - hasTradingIncentive : false
       - last : 0.00909642373572474
       - volume : 1263.611350929
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.0021218
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.42e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.1
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 6367.04
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 2.648314
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.10509262
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.630404
       - timestamp : "2024-10-11T06:09:20+00:00"
       - lastTradedAt : "2024-10-11T06:09:20+00:00"
       - lastFetchAt : "2024-10-11T06:15:01+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://app.uniswap.org/explore/tokens/bnb/0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 48 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "Biswap V3"
         - identifier : "biswap-v3-1"
         - hasTradingIncentive : false
       - last : 0.00912052012964674
       - volume : 952.390902706
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00212753
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.11
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.442e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 1.957709
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 4706.1
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.07768363
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.610876
       - timestamp : "2024-10-11T06:07:42+00:00"
       - lastTradedAt : "2024-10-11T06:07:42+00:00"
       - lastFetchAt : "2024-10-11T06:15:48+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://biswap.org/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 49 : Ticker
       - base : "0X0E09FABB73BD3ADE0A17ECC321FD13A19E81CE82"
       - target : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       ▿ market : Market
         - name : "SquadSwap V2"
         - identifier : "squadswap"
         - hasTradingIncentive : false
       - last : 0.352265638276643
       - volume : 3904.55809880406
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.1
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.0021228
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.425e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 2.138843
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5141.85
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.08488867
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.630166
       - timestamp : "2024-10-11T06:07:36+00:00"
       - lastTradedAt : "2024-10-11T06:07:36+00:00"
       - lastFetchAt : "2024-10-11T06:19:29+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://squadswap.com/swap?inputCurrency=0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82&outputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f"
       - tokenInfoURL : nil
       - coinID : "pancakeswap-token"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 50 : Ticker
       - base : "EQD0VDSA_NEDR9UVBGN9EIKRX-SUESDXGEFG69XQMAVFLQIW"
       - target : "EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9C"
       ▿ market : Market
         - name : "DeDust"
         - identifier : "dedust"
         - hasTradingIncentive : false
       - last : 0.0145050694378712
       - volume : 23521.185821137
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214586
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.73538172
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 1767.69
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.02918389
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.62825
       - timestamp : "2024-10-11T06:12:13+00:00"
       - lastTradedAt : "2024-10-11T06:12:13+00:00"
       - lastFetchAt : "2024-10-11T06:18:28+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://dedust.io/swap?inputCurrency=eqd0vdsa_nedr9uvbgn9eikrx-suesdxgefg69xqmavflqiw&outputCurrency=eqaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaam9c"
       - tokenInfoURL : nil
       - coinID : "huebel-bolt"
       ▿ targetCoinID : Optional<String>
         - some : "the-open-network"
     ▿ 51 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "THENA FUSION"
         - identifier : "thena-fusion"
         - hasTradingIncentive : false
       - last : 5.13076367872458
       - volume : 249.086388364
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00213482
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.13
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.472e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.50872646
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 1222.86
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.020189
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.706989
       - timestamp : "2024-10-11T06:18:01+00:00"
       - lastTradedAt : "2024-10-11T06:18:01+00:00"
       - lastFetchAt : "2024-10-11T06:18:01+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.thena.fi/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x55d398326f99059ff775485246999027b3197955"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 52 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X8AC76A51CC950D9822D68B83FE1AD97B32CD580D"
       ▿ market : Market
         - name : "Nomiswap"
         - identifier : "nomiswap"
         - hasTradingIncentive : false
       - last : 5.12248668664575
       - volume : 183.099575165
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.11
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00212467
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.11
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.432e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.01511108
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.38077235
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 915.5
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 915.36
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.635594
       - timestamp : "2024-10-11T06:09:06+00:00"
       - lastTradedAt : "2024-10-11T06:09:06+00:00"
       - lastFetchAt : "2024-10-11T06:14:56+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://nomiswap.io/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 53 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0X55D398326F99059FF775485246999027B3197955"
       ▿ market : Market
         - name : "PancakeSwap V3 (BSC)"
         - identifier : "pancakeswap-v3-bsc"
         - hasTradingIncentive : false
       - last : 5.1440075502214
       - volume : 188.599199996
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.462e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.13
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00213213
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 911.26
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.01504441
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.37907472
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.639451
       - timestamp : "2024-10-11T06:12:19+00:00"
       - lastTradedAt : "2024-10-11T06:12:19+00:00"
       - lastFetchAt : "2024-10-11T06:18:31+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0x55d398326f99059ff775485246999027b3197955"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "binance-bridged-usdt-bnb-smart-chain"
     ▿ 54 : Ticker
       - base : "0X76A797A59BA2C17726896976B7B3747BFD1D220F"
       - target : "0XBB4CDB9CBD36B01BD1CBAEBF2DE08D9173BC095C"
       ▿ market : Market
         - name : "PancakeSwap (v2)"
         - identifier : "pancakeswap_new"
         - hasTradingIncentive : false
       - last : 0.00913717397329469
       - volume : 212.353344263
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.444e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00212796
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.12
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.01738618
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 1053.26
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.43814985
       - trustScore : "green"
       - bidAskSpreadPercentage : 0.717136
       - timestamp : "2024-10-11T06:15:37+00:00"
       - lastTradedAt : "2024-10-11T06:15:37+00:00"
       - lastFetchAt : "2024-10-11T06:15:37+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pancakeswap.finance/swap?inputCurrency=0x76a797a59ba2c17726896976b7b3747bfd1d220f&outputCurrency=0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "wbnb"
     ▿ 55 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Binance"
         - identifier : "binance"
         - hasTradingIncentive : false
       - last : 5.156
       - volume : 4174455.93
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.503e-05
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214166
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 349.233
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 8796.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 21160735.0
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 21159083.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019399
       - timestamp : "2024-10-11T06:10:21+00:00"
       - lastTradedAt : "2024-10-11T06:10:21+00:00"
       - lastFetchAt : "2024-10-11T06:10:21+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.binance.com/en/trade/TON_USDT?ref=37754157"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 56 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bit2Me"
         - identifier : "bit2me"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 464245.47
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214549
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 38.835546
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 978.726
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 2352253.0
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 2352668.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019372
       - timestamp : "2024-10-11T06:16:09+00:00"
       - lastTradedAt : "2024-10-11T06:16:09+00:00"
       - lastFetchAt : "2024-10-11T06:16:09+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pro.bit2me.com/exchange/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 57 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Gate.io"
         - identifier : "gate"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 464277.29
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.516e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214586
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 2352751.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 38.843046
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 2352495.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 978.775
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019372
       - timestamp : "2024-10-11T06:18:22+00:00"
       - lastTradedAt : "2024-10-11T06:18:22+00:00"
       - lastFetchAt : "2024-10-11T06:18:22+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.gate.io/trade/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 58 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "BloFin"
         - identifier : "blofin_spot"
         - hasTradingIncentive : false
       - last : 5.155
       - volume : 1254266.6111
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.499e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214013
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 2641.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 6356323.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 104.883
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 6358677.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.058219
       - timestamp : "2024-10-11T05:59:18+00:00"
       - lastTradedAt : "2024-10-11T05:59:18+00:00"
       - lastFetchAt : "2024-10-11T05:59:18+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://blofin.com/spot/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 59 : Ticker
       - base : "TONCOIN"
       - target : "USDT"
       ▿ market : Market
         - name : "HitBTC"
         - identifier : "hitbtc"
         - hasTradingIncentive : false
       - last : 5.16106
       - volume : 414041.66
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214551
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 2099512.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 873.459
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 2099265.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 34.661115
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.024404
       - timestamp : "2024-10-11T06:17:17+00:00"
       - lastTradedAt : "2024-10-11T06:17:17+00:00"
       - lastFetchAt : "2024-10-11T06:17:17+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://hitbtc.com/TONCOIN-to-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 60 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "DigiFinex"
         - identifier : "digifinex"
         - hasTradingIncentive : false
       - last : 5.1641
       - volume : 125014.013
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214619
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.519e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 268.304
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 644896.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 10.649862
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 645060.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.011936
       - timestamp : "2024-10-11T06:19:44+00:00"
       - lastTradedAt : "2024-10-11T06:19:44+00:00"
       - lastFetchAt : "2024-10-11T06:19:44+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.digifinex.com/en-ww/trade/USDT/TON"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 61 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Pionex"
         - identifier : "pionex"
         - hasTradingIncentive : false
       - last : 5.16
       - volume : 137920.8914
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214453
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.511e-05
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 699445.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 11.54667
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 290.951
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 699553.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019372
       - timestamp : "2024-10-11T06:14:25+00:00"
       - lastTradedAt : "2024-10-11T06:14:25+00:00"
       - lastFetchAt : "2024-10-11T06:14:25+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.pionex.com/en/trade/TON_USDT/Bot"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 62 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Websea"
         - identifier : "websea"
         - hasTradingIncentive : false
       - last : 5.16
       - volume : 0.0
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214503
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 1953447.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 812.602
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 1953309.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 32.248406
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.038737
       - timestamp : "2024-10-11T06:18:11+00:00"
       - lastTradedAt : "2024-10-11T06:18:11+00:00"
       - lastFetchAt : "2024-10-11T06:18:11+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.websea.com/en/trade/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 63 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "WEEX"
         - identifier : "weex"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 194352.8
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214549
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 987458.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 16.302875
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 987633.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 410.862
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019395
       - timestamp : "2024-10-11T06:16:25+00:00"
       - lastTradedAt : "2024-10-11T06:16:25+00:00"
       - lastFetchAt : "2024-10-11T06:16:25+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.weex.com/trade/ton_usdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 64 : Ticker
       - base : "TON"
       - target : "BTC"
       ▿ market : Market
         - name : "Binance"
         - identifier : "binance"
         - hasTradingIncentive : false
       - last : 8.494e-05
       - volume : 98408.36
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.494e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00213915
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 499351.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.236529
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 207.431
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.011766
       - timestamp : "2024-10-11T06:00:05+00:00"
       - lastTradedAt : "2024-10-11T06:00:05+00:00"
       - lastFetchAt : "2024-10-11T06:00:05+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.binance.com/en/trade/TON_BTC?ref=37754157"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "bitcoin"
     ▿ 65 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Nominex"
         - identifier : "nominex"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 30177.774448750242
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214522
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.512e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 155622.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 155610.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 2.56886
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 64.738
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019372
       - timestamp : "2024-10-11T06:15:37+00:00"
       - lastTradedAt : "2024-10-11T06:15:37+00:00"
       - lastFetchAt : "2024-10-11T06:15:37+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://nominex.io/en/markets/TON/USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 66 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "TokoCrypto"
         - identifier : "toko_crypto"
         - hasTradingIncentive : false
       - last : 5.154
       - volume : 18054.406796662784
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.502e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214102
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 92970.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 38.654863
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 1.534997
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 92983.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019387
       - timestamp : "2024-10-11T05:56:10+00:00"
       - lastTradedAt : "2024-10-11T05:56:10+00:00"
       - lastFetchAt : "2024-10-11T05:56:10+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.tokocrypto.com/trade/TONUSDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 67 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "OrangeX"
         - identifier : "orangex"
         - hasTradingIncentive : false
       - last : 5.158
       - volume : 110434.89
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.507e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.0021437
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 560035.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 9.243817
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 559949.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 232.924
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019369
       - timestamp : "2024-10-11T06:14:31+00:00"
       - lastTradedAt : "2024-10-11T06:14:31+00:00"
       - lastFetchAt : "2024-10-11T06:14:31+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.orangex.com/spot/TON-USDT-SPOT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 68 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "OKX"
         - identifier : "okex"
         - hasTradingIncentive : false
       - last : 5.154
       - volume : 86612.3641
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.0021441
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.509e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 7.255248
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 439461.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 439375.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 182.811
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.01938
       - timestamp : "2024-10-11T06:18:38+00:00"
       - lastTradedAt : "2024-10-11T06:18:38+00:00"
       - lastFetchAt : "2024-10-11T06:18:38+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.okx.com/trade-spot/ton-usdc"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 69 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "bitcastle"
         - identifier : "bitcastle"
         - hasTradingIncentive : false
       - last : 5.1615
       - volume : 180192.8
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214555
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 916287.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 381.221
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 916332.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 15.127846
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.030996
       - timestamp : "2024-10-11T06:17:01+00:00"
       - lastTradedAt : "2024-10-11T06:17:01+00:00"
       - lastFetchAt : "2024-10-11T06:17:01+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://bitcastle.io/en/exchange/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 70 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Toobit"
         - identifier : "toobit"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 94469.3111
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214536
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 7.915125
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 479536.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 479424.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 199.45
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.038737
       - timestamp : "2024-10-11T06:18:00+00:00"
       - lastTradedAt : "2024-10-11T06:18:00+00:00"
       - lastFetchAt : "2024-10-11T06:18:00+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.toobit.com/en-US/spot/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 71 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "SecondBTC"
         - identifier : "secondbtc"
         - hasTradingIncentive : false
       - last : 5.155
       - volume : 56034.159
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.502e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214205
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 120.028
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 4.764213
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 288601.0
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 288572.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019357
       - timestamp : "2024-10-11T06:11:56+00:00"
       - lastTradedAt : "2024-10-11T06:11:56+00:00"
       - lastFetchAt : "2024-10-11T06:11:56+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://secondbtc.com/exchange/USDT-TON"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 72 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "WOO X"
         - identifier : "wootrade"
         - hasTradingIncentive : false
       - last : 5.163
       - volume : 31.94
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214608
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.518e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 164.8
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.00272052
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 164.79
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.0685458
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.019365
       - timestamp : "2024-10-11T06:19:06+00:00"
       - lastTradedAt : "2024-10-11T06:19:06+00:00"
       - lastFetchAt : "2024-10-11T06:19:06+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://x.woo.network/spot"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 73 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "BitMart"
         - identifier : "bitmart"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 47856.8
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214525
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 246909.0
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 246810.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 4.074668
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 102.665
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.077414
       - timestamp : "2024-10-11T06:19:04+00:00"
       - lastTradedAt : "2024-10-11T06:19:04+00:00"
       - lastFetchAt : "2024-10-11T06:19:04+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bitmart.com/trade/en?symbol=TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 74 : Ticker
       - base : "TONCOIN"
       - target : "USDT"
       ▿ market : Market
         - name : "BingX"
         - identifier : "bingx"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 106653.818559
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214535
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 225.284
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 541564.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 541602.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.940908
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.058106
       - timestamp : "2024-10-11T06:18:52+00:00"
       - lastTradedAt : "2024-10-11T06:18:52+00:00"
       - lastFetchAt : "2024-10-11T06:18:52+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://bingx.com/en-us/spot/TONCOINUSDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 75 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "CEX.IO"
         - identifier : "cex"
         - hasTradingIncentive : false
       - last : 5.164
       - volume : 194.19876285
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214671
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.518e-05
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 977.44
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.01613672
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.40666773
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 977.39
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.096824
       - timestamp : "2024-10-11T06:16:39+00:00"
       - lastTradedAt : "2024-10-11T06:16:39+00:00"
       - lastFetchAt : "2024-10-11T06:16:39+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://trade.cex.io/spot/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 76 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bitunix"
         - identifier : "bitunix"
         - hasTradingIncentive : false
       - last : 5.156
       - volume : 255065.67
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.505e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.002143
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 21.696914
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 1314212.0
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 546.711
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 1314366.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.096918
       - timestamp : "2024-10-11T06:13:43+00:00"
       - lastTradedAt : "2024-10-11T06:13:43+00:00"
       - lastFetchAt : "2024-10-11T06:13:43+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bitunix.com/spot-trade/TONUSDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 77 : Ticker
       - base : "TON"
       - target : "USDC"
       ▿ market : Market
         - name : "Binance"
         - identifier : "binance"
         - hasTradingIncentive : false
       - last : 5.157
       - volume : 36442.42
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214422
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 3.048926
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 76.796
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 184705.0
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 184681.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.01941
       - timestamp : "2024-10-11T06:04:08+00:00"
       - lastTradedAt : "2024-10-11T06:04:08+00:00"
       - lastFetchAt : "2024-10-11T06:04:08+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.binance.com/en/trade/TON_USDC?ref=37754157"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "usd-coin"
     ▿ 78 : Ticker
       - base : "TON"
       - target : "USD"
       ▿ market : Market
         - name : "Crypto.com Exchange"
         - identifier : "crypto_com"
         - hasTradingIncentive : false
       - last : 5.159
       - volume : 19006.42
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214598
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.517e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 40.78732
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 98054.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 1.618811
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.017437
       - timestamp : "2024-10-11T06:19:15+00:00"
       - lastTradedAt : "2024-10-11T06:19:15+00:00"
       - lastFetchAt : "2024-10-11T06:19:15+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://crypto.com/exchange/trade/spot/TON_USD"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 79 : Ticker
       - base : "TON"
       - target : "EUR"
       ▿ market : Market
         - name : "Bitvavo"
         - identifier : "bitvavo"
         - hasTradingIncentive : false
       - last : 4.7095
       - volume : 22121.38856573
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.501e-05
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214249
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 47.394833
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 113915.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 1.880644
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.044499
       - timestamp : "2024-10-11T06:11:40+00:00"
       - lastTradedAt : "2024-10-11T06:11:40+00:00"
       - lastFetchAt : "2024-10-11T06:16:58+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://account.bitvavo.com/markets/TON-EUR"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 80 : Ticker
       - base : "TON"
       - target : "TRY"
       ▿ market : Market
         - name : "Binance"
         - identifier : "binance"
         - hasTradingIncentive : false
       - last : 176.8
       - volume : 33551.48
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214307
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.51e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 2.806718
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 70.682
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 170053.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.056657
       - timestamp : "2024-10-11T06:07:06+00:00"
       - lastTradedAt : "2024-10-11T06:07:06+00:00"
       - lastFetchAt : "2024-10-11T06:07:06+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.binance.com/en/trade/TON_TRY?ref=37754157"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 81 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "PointPay"
         - identifier : "pointpay"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 41071.27033752
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.514e-05
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214545
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 208180.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 3.436972
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 208217.0
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 86.606
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.079968
       - timestamp : "2024-10-11T06:18:17+00:00"
       - lastTradedAt : "2024-10-11T06:18:17+00:00"
       - lastFetchAt : "2024-10-11T06:18:17+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://exchange.pointpay.io/trade-classic/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 82 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "XT.COM"
         - identifier : "xt"
         - hasTradingIncentive : false
       - last : 5.156
       - volume : 108984.38
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214287
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.504e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 229.859
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 552581.0
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 552667.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 9.122188
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.251694
       - timestamp : "2024-10-11T06:14:07+00:00"
       - lastTradedAt : "2024-10-11T06:14:07+00:00"
       - lastFetchAt : "2024-10-11T06:14:07+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.xt.com/en/trade/ton_usdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 83 : Ticker
       - base : "TONCOIN"
       - target : "USDT"
       ▿ market : Market
         - name : "QMall"
         - identifier : "qmall"
         - hasTradingIncentive : false
       - last : 5.161
       - volume : 451272.94568779
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214546
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 951.298
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 37.747832
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 2286473.0
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 2286370.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.860665
       - timestamp : "2024-10-11T06:16:45+00:00"
       - lastTradedAt : "2024-10-11T06:16:45+00:00"
       - lastFetchAt : "2024-10-11T06:16:45+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://qmall.io/trade/TONCOIN_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 84 : Ticker
       - base : "TON"
       - target : "FDUSD"
       ▿ market : Market
         - name : "Binance"
         - identifier : "binance"
         - hasTradingIncentive : false
       - last : 5.163
       - volume : 57347.94
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214244
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.504e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 290244.0
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 4.791885
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 120.723
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.135397
       - timestamp : "2024-10-11T06:18:13+00:00"
       - lastTradedAt : "2024-10-11T06:18:13+00:00"
       - lastFetchAt : "2024-10-11T06:19:39+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.binance.com/en/trade/TON_FDUSD?ref=37754157"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "first-digital-usd"
     ▿ 85 : Ticker
       - base : "TON"
       - target : "BTC"
       ▿ market : Market
         - name : "TokoCrypto"
         - identifier : "toko_crypto"
         - hasTradingIncentive : false
       - last : 8.497e-05
       - volume : 39.574320348
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.497e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00213952
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.08467023
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 203.67
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.00336263
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.011756
       - timestamp : "2024-10-11T05:29:06+00:00"
       - lastTradedAt : "2024-10-11T05:29:06+00:00"
       - lastFetchAt : "2024-10-11T05:54:55+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.tokocrypto.com/trade/TONBTC"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "bitcoin"
     ▿ 86 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Trubit"
         - identifier : "trubit"
         - hasTradingIncentive : false
       - last : 5.1627
       - volume : 250280.0887
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214619
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.517e-05
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 1269952.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 1269803.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 20.965813
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 528.338
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 1.016668
       - timestamp : "2024-10-11T06:17:12+00:00"
       - lastTradedAt : "2024-10-11T06:17:12+00:00"
       - lastFetchAt : "2024-10-11T06:17:12+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.trubit.com/pro/crypto-spot-trading/TON/USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 87 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Cryptology"
         - identifier : "cryptology"
         - hasTradingIncentive : false
       - last : 5.152
       - volume : 97794.75
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214172
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.498e-05
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.15
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 209.449
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 503416.0
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 503394.0
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.310999
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.406111
       - timestamp : "2024-10-11T06:16:34+00:00"
       - lastTradedAt : "2024-10-11T06:16:34+00:00"
       - lastFetchAt : "2024-10-11T06:16:34+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://cryptology.com/app/next/trading/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 88 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bitazza"
         - identifier : "bitazza"
         - hasTradingIncentive : false
       - last : 5.177
       - volume : 54924.24
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.17
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.539e-05
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.17
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00215187
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 279239.0
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 116.162
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 4.609405
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 279217.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.598918
       - timestamp : "2024-10-11T06:15:56+00:00"
       - lastTradedAt : "2024-10-11T06:15:56+00:00"
       - lastFetchAt : "2024-10-11T06:15:56+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://trade.bitazza.com/gl/exchange"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 89 : Ticker
       - base : "TON"
       - target : "USD"
       ▿ market : Market
         - name : "CEX.IO"
         - identifier : "cex"
         - hasTradingIncentive : false
       - last : 5.169
       - volume : 223.10101951
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.17
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00215059
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.534e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 1127.53
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.4691154
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.01861467
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.619075
       - timestamp : "2024-10-11T06:16:40+00:00"
       - lastTradedAt : "2024-10-11T06:16:40+00:00"
       - lastFetchAt : "2024-10-11T06:16:40+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://trade.cex.io/spot/TON-USD"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 90 : Ticker
       - base : "TON"
       - target : "EUR"
       ▿ market : Market
         - name : "OKX"
         - identifier : "okex"
         - hasTradingIncentive : false
       - last : 4.721
       - volume : 627.0994
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214738
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.522e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 1.329505
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 3196.01
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.05276431
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.105887
       - timestamp : "2024-10-11T05:23:27+00:00"
       - lastTradedAt : "2024-10-11T05:23:27+00:00"
       - lastFetchAt : "2024-10-11T06:18:40+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.okx.com/trade-spot/ton-eur"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 91 : Ticker
       - base : "TON"
       - target : "USD"
       ▿ market : Market
         - name : "HashKey Exchange"
         - identifier : "hashkey_exchange"
         - hasTradingIncentive : false
       - last : 5.152
       - volume : 2445.81
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.506e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214351
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 5.175869
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 0.20538035
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 12440.36
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.058162
       - timestamp : "2024-10-11T06:16:47+00:00"
       - lastTradedAt : "2024-10-11T06:16:47+00:00"
       - lastFetchAt : "2024-10-11T06:16:47+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://pro.hashkey.com/en-US/spot/TON_USD"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 92 : Ticker
       - base : "TONCOIN"
       - target : "USDT"
       ▿ market : Market
         - name : "BIT"
         - identifier : "bit_com"
         - hasTradingIncentive : false
       - last : 5.1613
       - volume : 79855.11728919459
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.0021451
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.513e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 411856.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 411792.0
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 171.297
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 6.798
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.761641
       - timestamp : "2024-10-11T06:14:36+00:00"
       - lastTradedAt : "2024-10-11T06:14:36+00:00"
       - lastFetchAt : "2024-10-11T06:14:36+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bit.com/spot?pair=TONCOIN-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 93 : Ticker
       - base : "TON"
       - target : "EUR"
       ▿ market : Market
         - name : "Bybit"
         - identifier : "bybit_spot"
         - hasTradingIncentive : false
       - last : 4.723
       - volume : 1060.57
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214818
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.526e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.08898951
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5390.25
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 2.242167
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.295671
       - timestamp : "2024-10-11T06:14:59+00:00"
       - lastTradedAt : "2024-10-11T06:14:59+00:00"
       - lastFetchAt : "2024-10-11T06:19:20+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bybit.com/trade/spot/TON/EUR"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 94 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "AscendEX (BitMax)"
         - identifier : "bitmax"
         - hasTradingIncentive : false
       - last : 5.174
       - volume : 28250.5
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.17
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.536e-05
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00215075
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.17
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 146061.0
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 146026.0
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 2.411389
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 60.76
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.289687
       - timestamp : "2024-10-11T06:18:32+00:00"
       - lastTradedAt : "2024-10-11T06:18:32+00:00"
       - lastFetchAt : "2024-10-11T06:18:32+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://ascendex.com/en/cashtrade-spottrading/usdt/ton"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 95 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "HashKey Global"
         - identifier : "hashkey-global"
         - hasTradingIncentive : false
       - last : 5.159
       - volume : 2394.31
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 5.15
         ▿ 1 : 2 elements
           - key : "btc"
           - value : 8.51e-05
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "eth"
           - value : 0.00214448
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 5.051488
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 12141.7
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 12144.71
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 0.20045738
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.077444
       - timestamp : "2024-10-11T06:15:27+00:00"
       - lastTradedAt : "2024-10-11T06:15:27+00:00"
       - lastFetchAt : "2024-10-11T06:15:27+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://global.hashkey.com/en-US/spot/TON_USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 96 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bittime"
         - identifier : "bittime"
         - hasTradingIncentive : false
       - last : 5.1632
       - volume : 762.756
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.517e-05
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 0.00214604
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "usd_v2"
           - value : 3838.77
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 1.596495
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 3838.03
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 0.06336338
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.044537
       - timestamp : "2024-10-11T06:19:14+00:00"
       - lastTradedAt : "2024-10-11T06:19:14+00:00"
       - lastFetchAt : "2024-10-11T06:19:14+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bittime.com/en/trade/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 97 : Ticker
       - base : "TON"
       - target : "IDR"
       ▿ market : Market
         - name : "Bittime"
         - identifier : "bittime"
         - hasTradingIncentive : false
       - last : 80571.0
       - volume : 535.51
       ▿ convertedLast : 3 elements
         ▿ 0 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214507
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 3 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 1.135388
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 2729.51
         ▿ 2 : 2 elements
           - key : "btc"
           - value : 0.04506249
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.05211
       - timestamp : "2024-10-11T06:19:12+00:00"
       - lastTradedAt : "2024-10-11T06:19:12+00:00"
       - lastFetchAt : "2024-10-11T06:19:12+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bittime.com/en/trade/TON-IDR"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       - targetCoinID : nil
     ▿ 98 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Fairdesk"
         - identifier : "fairdesk"
         - hasTradingIncentive : false
       - last : 5.162
       - volume : 20806.2
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "eth"
           - value : 0.00214564
         ▿ 1 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 2 : 2 elements
           - key : "usd_v2"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "btc"
           - value : 8.514e-05
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 1.771455
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 44.642515
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 107315.0
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 107307.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.503681
       - timestamp : "2024-10-11T06:15:53+00:00"
       - lastTradedAt : "2024-10-11T06:15:53+00:00"
       - lastFetchAt : "2024-10-11T06:15:53+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.fairdesk.com/spot/tonusdt"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
     ▿ 99 : Ticker
       - base : "TON"
       - target : "USDT"
       ▿ market : Market
         - name : "Bitlo"
         - identifier : "bitlo"
         - hasTradingIncentive : false
       - last : 5.16
       - volume : 4542.9447
       ▿ convertedLast : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 8.512e-05
         ▿ 1 : 2 elements
           - key : "eth"
           - value : 0.00214504
         ▿ 2 : 2 elements
           - key : "usd"
           - value : 5.16
         ▿ 3 : 2 elements
           - key : "usd_v2"
           - value : 5.16
       ▿ convertedVolume : 4 elements
         ▿ 0 : 2 elements
           - key : "btc"
           - value : 0.38107226
         ▿ 1 : 2 elements
           - key : "usd_v2"
           - value : 23081.0
         ▿ 2 : 2 elements
           - key : "eth"
           - value : 9.603548
         ▿ 3 : 2 elements
           - key : "usd"
           - value : 23082.0
       - trustScore : "yellow"
       - bidAskSpreadPercentage : 0.193424
       - timestamp : "2024-10-11T06:16:48+00:00"
       - lastTradedAt : "2024-10-11T06:16:48+00:00"
       - lastFetchAt : "2024-10-11T06:16:48+00:00"
       - isAnomaly : false
       - isStale : false
       ▿ tradeURL : Optional<String>
         - some : "https://www.bitlo.com/kolay-alis-satis/TON-USDT"
       - tokenInfoURL : nil
       - coinID : "the-open-network"
       ▿ targetCoinID : Optional<String>
         - some : "tether"
 */
