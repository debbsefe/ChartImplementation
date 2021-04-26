import 'dart:convert';

CryptoAssetsData cryptoAssetsDataFromJson(String str) =>
    CryptoAssetsData.fromJson(json.decode(str));

String cryptoAssetsDataToJson(CryptoAssetsData data) =>
    json.encode(data.toJson());

class CryptoAssetsData {
  CryptoAssetsData({
    this.config,
    this.data,
  });

  Config config;
  List<Datum> data;

  factory CryptoAssetsData.fromJson(Map<String, dynamic> json) =>
      CryptoAssetsData(
        config: Config.fromJson(json["config"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "config": config.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Config {
  Config({
    this.data,
    this.configDataPoints,
    this.interval,
    this.symbol,
    this.timeSeriesIndicators,
    this.dataPoints,
  });

  String data;
  String configDataPoints;
  String interval;
  String symbol;
  String timeSeriesIndicators;
  int dataPoints;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        data: json["data"],
        configDataPoints: json["data_points\t"],
        interval: json["interval"],
        symbol: json["symbol"],
        timeSeriesIndicators: json["time_series_indicators"],
        dataPoints: json["data_points"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "data_points\t": configDataPoints,
        "interval": interval,
        "symbol": symbol,
        "time_series_indicators": timeSeriesIndicators,
        "data_points": dataPoints,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.symbol,
    this.price,
    this.priceBtc,
    this.marketCap,
    this.percentChange24H,
    this.percentChange7D,
    this.percentChange30D,
    this.volume24H,
    this.maxSupply,
    this.timeSeries,
    this.socialDominanceCalc24HPrevious,
    this.socialContributorsCalc24HPrevious,
    this.urlSharesCalc24HPrevious,
    this.tweetSpamCalc24HPrevious,
    this.newsCalc24HPrevious,
    this.averageSentimentCalc24HPrevious,
    this.socialScoreCalc24HPrevious,
    this.socialVolumeCalc24HPrevious,
    this.altRank30DCalc24HPrevious,
    this.altRankCalc24HPrevious,
    this.assetId,
    this.time,
    this.open,
    this.high,
    this.low,
    this.volume,
    this.urlShares,
    this.uniqueUrlShares,
    this.redditPosts,
    this.redditPostsScore,
    this.redditComments,
    this.redditCommentsScore,
    this.tweets,
    this.tweetSpam,
    this.tweetFollowers,
    this.tweetQuotes,
    this.tweetRetweets,
    this.tweetReplies,
    this.tweetFavorites,
    this.tweetSentiment1,
    this.tweetSentiment2,
    this.tweetSentiment3,
    this.tweetSentiment4,
    this.tweetSentiment5,
    this.tweetSentimentImpact1,
    this.tweetSentimentImpact2,
    this.tweetSentimentImpact3,
    this.tweetSentimentImpact4,
    this.tweetSentimentImpact5,
    this.socialScore,
    this.averageSentiment,
    this.sentimentAbsolute,
    this.sentimentRelative,
    this.priceScore,
    this.socialImpactScore,
    this.correlationRank,
    this.galaxyScore,
    this.volatility,
    this.altRank,
    this.altRank30D,
    this.marketCapRank,
    this.percentChange24HRank,
    this.volume24HRank,
    this.socialVolume24HRank,
    this.socialScore24HRank,
    this.socialContributors,
    this.socialVolume,
    this.socialVolumeGlobal,
    this.socialDominance,
    this.marketCapGlobal,
    this.marketDominance,
    this.news,
    this.tags,
    this.close,
    this.medium,
    this.youtube,
  });

  int id;
  String name;
  String symbol;
  double price;
  double priceBtc;
  int marketCap;
  double percentChange24H;
  double percentChange7D;
  double percentChange30D;
  double volume24H;
  String maxSupply;
  List<TimeSery> timeSeries;
  int socialDominanceCalc24HPrevious;
  int socialContributorsCalc24HPrevious;
  int urlSharesCalc24HPrevious;
  int tweetSpamCalc24HPrevious;
  int newsCalc24HPrevious;
  double averageSentimentCalc24HPrevious;
  int socialScoreCalc24HPrevious;
  int socialVolumeCalc24HPrevious;
  int altRank30DCalc24HPrevious;
  int altRankCalc24HPrevious;
  int assetId;
  int time;
  double open;
  double high;
  double low;
  int volume;
  int urlShares;
  int uniqueUrlShares;
  int redditPosts;
  int redditPostsScore;
  int redditComments;
  int redditCommentsScore;
  int tweets;
  int tweetSpam;
  int tweetFollowers;
  int tweetQuotes;
  int tweetRetweets;
  int tweetReplies;
  int tweetFavorites;
  int tweetSentiment1;
  int tweetSentiment2;
  int tweetSentiment3;
  int tweetSentiment4;
  int tweetSentiment5;
  int tweetSentimentImpact1;
  int tweetSentimentImpact2;
  int tweetSentimentImpact3;
  int tweetSentimentImpact4;
  int tweetSentimentImpact5;
  int socialScore;
  double averageSentiment;
  int sentimentAbsolute;
  int sentimentRelative;
  double priceScore;
  double socialImpactScore;
  double correlationRank;
  double galaxyScore;
  double volatility;
  int altRank;
  int altRank30D;
  int marketCapRank;
  int percentChange24HRank;
  int volume24HRank;
  int socialVolume24HRank;
  int socialScore24HRank;
  int socialContributors;
  int socialVolume;
  int socialVolumeGlobal;
  double socialDominance;
  int marketCapGlobal;
  double marketDominance;
  int news;
  String tags;
  double close;
  int medium;
  int youtube;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        price: json["price"].toDouble(),
        priceBtc: json["price_btc"].toDouble(),
        marketCap: json["market_cap"],
        percentChange24H: json["percent_change_24h"].toDouble(),
        percentChange7D: json["percent_change_7d"].toDouble(),
        percentChange30D: json["percent_change_30d"].toDouble(),
        volume24H: json["volume_24h"].toDouble(),
        maxSupply: json["max_supply"],
        timeSeries: List<TimeSery>.from(
            json["timeSeries"].map((x) => TimeSery.fromJson(x))),
        socialDominanceCalc24HPrevious:
            json["social_dominance_calc_24h_previous"] == null
                ? null
                : json["social_dominance_calc_24h_previous"],
        socialContributorsCalc24HPrevious:
            json["social_contributors_calc_24h_previous"] == null
                ? null
                : json["social_contributors_calc_24h_previous"],
        urlSharesCalc24HPrevious: json["url_shares_calc_24h_previous"] == null
            ? null
            : json["url_shares_calc_24h_previous"],
        tweetSpamCalc24HPrevious: json["tweet_spam_calc_24h_previous"] == null
            ? null
            : json["tweet_spam_calc_24h_previous"],
        newsCalc24HPrevious: json["news_calc_24h_previous"] == null
            ? null
            : json["news_calc_24h_previous"],
        averageSentimentCalc24HPrevious:
            json["average_sentiment_calc_24h_previous"] == null
                ? null
                : json["average_sentiment_calc_24h_previous"].toDouble(),
        socialScoreCalc24HPrevious:
            json["social_score_calc_24h_previous"] == null
                ? null
                : json["social_score_calc_24h_previous"],
        socialVolumeCalc24HPrevious:
            json["social_volume_calc_24h_previous"] == null
                ? null
                : json["social_volume_calc_24h_previous"],
        altRank30DCalc24HPrevious:
            json["alt_rank_30d_calc_24h_previous"] == null
                ? null
                : json["alt_rank_30d_calc_24h_previous"],
        altRankCalc24HPrevious: json["alt_rank_calc_24h_previous"] == null
            ? null
            : json["alt_rank_calc_24h_previous"],
        assetId: json["asset_id"],
        time: json["time"],
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        volume: json["volume"],
        urlShares: json["url_shares"],
        uniqueUrlShares: json["unique_url_shares"],
        redditPosts: json["reddit_posts"],
        redditPostsScore: json["reddit_posts_score"],
        redditComments: json["reddit_comments"],
        redditCommentsScore: json["reddit_comments_score"],
        tweets: json["tweets"],
        tweetSpam: json["tweet_spam"],
        tweetFollowers: json["tweet_followers"],
        tweetQuotes: json["tweet_quotes"],
        tweetRetweets: json["tweet_retweets"],
        tweetReplies: json["tweet_replies"],
        tweetFavorites: json["tweet_favorites"],
        tweetSentiment1: json["tweet_sentiment1"],
        tweetSentiment2: json["tweet_sentiment2"],
        tweetSentiment3: json["tweet_sentiment3"],
        tweetSentiment4: json["tweet_sentiment4"],
        tweetSentiment5: json["tweet_sentiment5"],
        tweetSentimentImpact1: json["tweet_sentiment_impact1"],
        tweetSentimentImpact2: json["tweet_sentiment_impact2"],
        tweetSentimentImpact3: json["tweet_sentiment_impact3"],
        tweetSentimentImpact4: json["tweet_sentiment_impact4"],
        tweetSentimentImpact5: json["tweet_sentiment_impact5"],
        socialScore: json["social_score"],
        averageSentiment: json["average_sentiment"].toDouble(),
        sentimentAbsolute: json["sentiment_absolute"],
        sentimentRelative: json["sentiment_relative"],
        priceScore: json["price_score"].toDouble(),
        socialImpactScore: json["social_impact_score"].toDouble(),
        correlationRank: json["correlation_rank"].toDouble(),
        galaxyScore: json["galaxy_score"].toDouble(),
        volatility: json["volatility"].toDouble(),
        altRank: json["alt_rank"],
        altRank30D: json["alt_rank_30d"],
        marketCapRank: json["market_cap_rank"],
        percentChange24HRank: json["percent_change_24h_rank"],
        volume24HRank: json["volume_24h_rank"],
        socialVolume24HRank: json["social_volume_24h_rank"],
        socialScore24HRank: json["social_score_24h_rank"],
        socialContributors: json["social_contributors"],
        socialVolume: json["social_volume"],
        socialVolumeGlobal: json["social_volume_global"],
        socialDominance: json["social_dominance"].toDouble(),
        marketCapGlobal: json["market_cap_global"],
        marketDominance: json["market_dominance"].toDouble(),
        news: json["news"],
        tags: json["tags"],
        close: json["close"].toDouble(),
        medium: json["medium"] == null ? null : json["medium"],
        youtube: json["youtube"] == null ? null : json["youtube"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "price": price,
        "price_btc": priceBtc,
        "market_cap": marketCap,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "percent_change_30d": percentChange30D,
        "volume_24h": volume24H,
        "max_supply": maxSupply,
        "timeSeries": List<dynamic>.from(timeSeries.map((x) => x.toJson())),
        "social_dominance_calc_24h_previous":
            socialDominanceCalc24HPrevious == null
                ? null
                : socialDominanceCalc24HPrevious,
        "social_contributors_calc_24h_previous":
            socialContributorsCalc24HPrevious == null
                ? null
                : socialContributorsCalc24HPrevious,
        "url_shares_calc_24h_previous":
            urlSharesCalc24HPrevious == null ? null : urlSharesCalc24HPrevious,
        "tweet_spam_calc_24h_previous":
            tweetSpamCalc24HPrevious == null ? null : tweetSpamCalc24HPrevious,
        "news_calc_24h_previous":
            newsCalc24HPrevious == null ? null : newsCalc24HPrevious,
        "average_sentiment_calc_24h_previous":
            averageSentimentCalc24HPrevious == null
                ? null
                : averageSentimentCalc24HPrevious,
        "social_score_calc_24h_previous": socialScoreCalc24HPrevious == null
            ? null
            : socialScoreCalc24HPrevious,
        "social_volume_calc_24h_previous": socialVolumeCalc24HPrevious == null
            ? null
            : socialVolumeCalc24HPrevious,
        "alt_rank_30d_calc_24h_previous": altRank30DCalc24HPrevious == null
            ? null
            : altRank30DCalc24HPrevious,
        "alt_rank_calc_24h_previous":
            altRankCalc24HPrevious == null ? null : altRankCalc24HPrevious,
        "asset_id": assetId,
        "time": time,
        "open": open,
        "high": high,
        "low": low,
        "volume": volume,
        "url_shares": urlShares,
        "unique_url_shares": uniqueUrlShares,
        "reddit_posts": redditPosts,
        "reddit_posts_score": redditPostsScore,
        "reddit_comments": redditComments,
        "reddit_comments_score": redditCommentsScore,
        "tweets": tweets,
        "tweet_spam": tweetSpam,
        "tweet_followers": tweetFollowers,
        "tweet_quotes": tweetQuotes,
        "tweet_retweets": tweetRetweets,
        "tweet_replies": tweetReplies,
        "tweet_favorites": tweetFavorites,
        "tweet_sentiment1": tweetSentiment1,
        "tweet_sentiment2": tweetSentiment2,
        "tweet_sentiment3": tweetSentiment3,
        "tweet_sentiment4": tweetSentiment4,
        "tweet_sentiment5": tweetSentiment5,
        "tweet_sentiment_impact1": tweetSentimentImpact1,
        "tweet_sentiment_impact2": tweetSentimentImpact2,
        "tweet_sentiment_impact3": tweetSentimentImpact3,
        "tweet_sentiment_impact4": tweetSentimentImpact4,
        "tweet_sentiment_impact5": tweetSentimentImpact5,
        "social_score": socialScore,
        "average_sentiment": averageSentiment,
        "sentiment_absolute": sentimentAbsolute,
        "sentiment_relative": sentimentRelative,
        "price_score": priceScore,
        "social_impact_score": socialImpactScore,
        "correlation_rank": correlationRank,
        "galaxy_score": galaxyScore,
        "volatility": volatility,
        "alt_rank": altRank,
        "alt_rank_30d": altRank30D,
        "market_cap_rank": marketCapRank,
        "percent_change_24h_rank": percentChange24HRank,
        "volume_24h_rank": volume24HRank,
        "social_volume_24h_rank": socialVolume24HRank,
        "social_score_24h_rank": socialScore24HRank,
        "social_contributors": socialContributors,
        "social_volume": socialVolume,
        "social_volume_global": socialVolumeGlobal,
        "social_dominance": socialDominance,
        "market_cap_global": marketCapGlobal,
        "market_dominance": marketDominance,
        "news": news,
        "tags": tags,
        "close": close,
        "medium": medium == null ? null : medium,
        "youtube": youtube == null ? null : youtube,
      };
}

class TimeSery {
  TimeSery({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.time,
  });

  double open;
  double high;
  double low;
  double close;
  int volume;
  int time;

  factory TimeSery.fromJson(Map<String, dynamic> json) => TimeSery(
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toDouble(),
        volume: json["volume"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "time": time,
      };
}
