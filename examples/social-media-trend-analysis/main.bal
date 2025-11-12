import ballerina/io;
import ballerinax/twitter;

configurable string bearerToken = ?;

type TrendingTopicAnalysis record {
    string keyword;
    int tweetCount;
    string[] popularTweetIds;
    int totalEngagement;
};

type InfluencePattern record {
    string tweetId;
    int retweetCount;
    string[] influentialRetweeters;
    record {string userId; string username; int followerCount;}[] topRetweeters;
};

public function main() returns error? {
    twitter:ConnectionConfig config = {
        auth: {
            token: bearerToken
        }
    };

    twitter:Client twitterClient = check new (config);

    io:println("=== Social Media Monitoring System ===");
    io:println("Starting trending topic analysis and engagement pattern tracking...\n");

    string[] keywords = ["#sustainability", "#AI", "#blockchain"];
    TrendingTopicAnalysis[] trendingAnalysis = [];

    foreach string keyword in keywords {
        io:println(string `Analyzing trending topic: ${keyword}`);

        twitter:Get2TweetsSearchRecentResponse searchResponse = check twitterClient->/tweets/search/recent(
            query = keyword,
            'tweet\.fields = ["public_metrics", "author_id", "created_at", "text"],
            max_results = 10
        );

        if searchResponse.data is twitter:Tweet[] {
            twitter:Tweet[] tweets = <twitter:Tweet[]>searchResponse.data;
            io:println(string `Found ${tweets.length()} recent tweets for ${keyword}`);

            string[] popularTweetIds = [];
            int totalEngagement = 0;

            foreach twitter:Tweet tweet in tweets {
                map<anydata> tweetMap = <map<anydata>>tweet;
                if tweetMap.hasKey("public_metrics") {
                    map<anydata> metricsMap = <map<anydata>>tweetMap["public_metrics"];
                    int retweetCount = <int>(metricsMap["retweet_count"] ?: 0);
                    int likeCount = <int>(metricsMap["like_count"] ?: 0);
                    int replyCount = <int>(metricsMap["reply_count"] ?: 0);
                    int engagement = retweetCount + likeCount + replyCount;
                    totalEngagement += engagement;

                    if retweetCount > 5 {
                        string tweetId = tweet.id ?: "";
                        popularTweetIds.push(tweetId);
                    }

                    string tweetText = tweet.text ?: "No text";
                    io:println(string `  Tweet: ${tweetText}`);
                    io:println(string `  Engagement - Retweets: ${retweetCount}, Likes: ${likeCount}, Replies: ${replyCount}`);
                }
            }

            TrendingTopicAnalysis analysis = {
                keyword: keyword,
                tweetCount: tweets.length(),
                popularTweetIds: popularTweetIds,
                totalEngagement: totalEngagement
            };
            trendingAnalysis.push(analysis);

            io:println(string `Total engagement for ${keyword}: ${totalEngagement}\n`);
        }
    }

    io:println("=== Analyzing Influence Patterns ===");
    InfluencePattern[] influencePatterns = [];

    foreach TrendingTopicAnalysis analysis in trendingAnalysis {
        foreach string tweetId in analysis.popularTweetIds {
            io:println(string `Analyzing retweet patterns for tweet: ${tweetId}`);

            twitter:Get2TweetsIdRetweetedByResponse retweetersResponse = check twitterClient->/tweets/[tweetId]/retweeted_by(
                'user\.fields = ["public_metrics", "username", "verified"],
                max_results = 20
            );

            if retweetersResponse.data is twitter:User[] {
                twitter:User[] retweeters = <twitter:User[]>retweetersResponse.data;
                io:println(string `Found ${retweeters.length()} users who retweeted this content`);

                string[] influentialRetweeters = [];
                record {string userId; string username; int followerCount;}[] topRetweeters = [];

                foreach twitter:User user in retweeters {
                    map<anydata> userMap = <map<anydata>>user;
                    if userMap.hasKey("public_metrics") {
                        map<anydata> userMetricsMap = <map<anydata>>userMap["public_metrics"];
                        int followerCount = <int>(userMetricsMap["followers_count"] ?: 0);

                        if followerCount > 1000 {
                            influentialRetweeters.push(user.id);
                            string username = user.username is string ? user.username : "unknown";
                            topRetweeters.push({
                                userId: user.id,
                                username: username,
                                followerCount: followerCount
                            });
                        }

                        string displayUsername = user.username is string ? user.username : "unknown";
                        boolean isVerified = user.verified ?: false;
                        io:println(string `  Retweeter: @${displayUsername} - Followers: ${followerCount}, Verified: ${isVerified}`);
                    }
                }

                twitter:Get2TweetsIdRetweetsResponse retweetsResponse = check twitterClient->/tweets/[tweetId]/retweets(
                    'tweet\.fields = ["public_metrics", "author_id"],
                    max_results = 10
                );

                int retweetCount = 0;
                if retweetsResponse.data is twitter:Tweet[] {
                    retweetCount = (<twitter:Tweet[]>retweetsResponse.data).length();
                }

                InfluencePattern pattern = {
                    tweetId: tweetId,
                    retweetCount: retweetCount,
                    influentialRetweeters: influentialRetweeters,
                    topRetweeters: topRetweeters
                };
                influencePatterns.push(pattern);

                io:println(string `Influential retweeters (>1000 followers): ${influentialRetweeters.length()}\n`);
            }
        }
    }

    io:println("=== Brand Monitoring Summary ===");
    foreach TrendingTopicAnalysis analysis in trendingAnalysis {
        io:println(string `Keyword: ${analysis.keyword}`);
        io:println(string `  Total tweets analyzed: ${analysis.tweetCount}`);
        io:println(string `  Popular tweets (>5 retweets): ${analysis.popularTweetIds.length()}`);
        io:println(string `  Total engagement: ${analysis.totalEngagement}`);
    }

    io:println("\n=== Influence Analysis Summary ===");
    foreach InfluencePattern pattern in influencePatterns {
        io:println(string `Tweet ID: ${pattern.tweetId}`);
        io:println(string `  Total retweets: ${pattern.retweetCount}`);
        io:println(string `  Influential retweeters: ${pattern.influentialRetweeters.length()}`);
        io:println(string `  Top retweeters by follower count: ${pattern.topRetweeters.length()}`);
    }

    io:println("\nSocial media monitoring analysis completed successfully!");
}