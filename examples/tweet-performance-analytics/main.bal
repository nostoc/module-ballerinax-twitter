import ballerina/io;
import ballerinax/twitter;

configurable string bearerToken = ?;
configurable string userId = ?;

public function main() returns error? {
    
    twitter:ConnectionConfig config = {
        auth: {
            token: bearerToken
        }
    };
    
    twitter:Client twitterClient = check new(config);
    
    io:println("=== Social Media Analytics Dashboard ===");
    io:println("Analyzing tweet performance and engagement patterns...\n");
    
    // Step 1: Retrieve recent tweets to identify top-performing content
    io:println("1. Fetching recent tweets...");
    twitter:Get2UsersIdTweetsResponse tweetsResponse = check twitterClient->/users/[userId]/tweets(
        queries = {
            "maxResults": 10,
            "tweetFields": ["public_metrics", "created_at", "text", "id"],
            exclude: ["replies", "retweets"]
        }
    );
    
    if tweetsResponse.data is () {
        io:println("No tweets found for analysis");
        return;
    }
    
    twitter:Tweet[] tweets = <twitter:Tweet[]>tweetsResponse.data;
    io:println(string`Found ${tweets.length()} recent tweets`);
    
    // Find the top-performing tweet based on engagement metrics
    twitter:Tweet? topTweet = ();
    int maxEngagement = 0;
    
    foreach twitter:Tweet tweet in tweets {
        anydata publicMetricsData = tweet["publicMetrics"];
        if publicMetricsData is map<anydata> {
            int likeCount = <int>publicMetricsData.get("like_count");
            int retweetCount = <int>publicMetricsData.get("retweet_count");
            int replyCount = <int>publicMetricsData.get("reply_count");
            int engagement = likeCount + retweetCount + replyCount;
            
            io:println(string`Tweet: ${tweet.text ?: "No text"}`);
            io:println(string`  Likes: ${likeCount}, Retweets: ${retweetCount}, Replies: ${replyCount}`);
            io:println(string`  Total Engagement: ${engagement}\n`);
            
            if engagement > maxEngagement {
                maxEngagement = engagement;
                topTweet = tweet;
            }
        }
    }
    
    if topTweet is () {
        io:println("No tweets with engagement metrics found");
        return;
    }
    
    io:println(string`Top performing tweet (${maxEngagement} total engagement):`);
    io:println(string`"${topTweet.text ?: "No text"}"\n`);
    
    // Step 2: Analyze audience demographics by getting users who liked the top tweet
    io:println("2. Analyzing audience demographics from top tweet likes...");
    string topTweetId = topTweet.id ?: "";
    twitter:Get2TweetsIdLikingUsersResponse likingUsersResponse = check twitterClient->/tweets/[topTweetId]/liking_users(
        queries = {
            "maxResults": 20,
            "userFields": ["public_metrics", "verified", "location", "created_at", "description"]
        }
    );
    
    if likingUsersResponse.data is twitter:User[] {
        twitter:User[] likingUsers = <twitter:User[]>likingUsersResponse.data;
        io:println(string`Found ${likingUsers.length()} users who liked the top tweet:`);
        
        int verifiedCount = 0;
        int locationCount = 0;
        
        foreach twitter:User user in likingUsers {
            if user.verified is true {
                verifiedCount += 1;
            }
            string userLocation = user.location ?: "";
            if userLocation != "" {
                locationCount += 1;
            }
            
            io:println(string`  @${user.username}: ${user.name}`);
            anydata userMetricsData = user["publicMetrics"];
            if userMetricsData is map<anydata> {
                int followersCount = <int>userMetricsData.get("followers_count");
                int followingCount = <int>userMetricsData.get("following_count");
                io:println(string`    Followers: ${followersCount}, Following: ${followingCount}`);
            }
            if userLocation != "" {
                io:println(string`    Location: ${userLocation}`);
            }
        }
        
        io:println(string`\nAudience Analysis Summary:`);
        io:println(string`  Verified users: ${verifiedCount}/${likingUsers.length()} (${(verifiedCount * 100) / likingUsers.length()}%)`);
        io:println(string`  Users with location: ${locationCount}/${likingUsers.length()} (${(locationCount * 100) / likingUsers.length()}%)\n`);
    } else {
        io:println("No liking users found for analysis\n");
    }
    
    // Step 3: Examine quote tweets to understand content discussion patterns
    io:println("3. Analyzing quote tweets for content discussion patterns...");
    string quoteTweetId = topTweet.id ?: "";
    twitter:Get2TweetsIdQuoteTweetsResponse quoteTweetsResponse = check twitterClient->/tweets/[quoteTweetId]/quote_tweets(
        queries = {
            "maxResults": 10,
            "tweetFields": ["public_metrics", "created_at", "text", "author_id"],
            "userFields": ["username", "name", "public_metrics"],
            expansions: ["author_id"]
        }
    );
    
    if quoteTweetsResponse.data is twitter:Tweet[] {
        twitter:Tweet[] quoteTweets = <twitter:Tweet[]>quoteTweetsResponse.data;
        io:println(string`Found ${quoteTweets.length()} quote tweets:`);
        
        foreach twitter:Tweet quoteTweet in quoteTweets {
            io:println(string`Quote Tweet: "${quoteTweet.text ?: "No text"}"`);
            anydata quoteMetricsData = quoteTweet["publicMetrics"];
            if quoteMetricsData is map<anydata> {
                int quoteLikeCount = <int>quoteMetricsData.get("like_count");
                int quoteRetweetCount = <int>quoteMetricsData.get("retweet_count");
                io:println(string`  Engagement: ${quoteLikeCount + quoteRetweetCount} total`);
            }
            io:println("");
        }
        
        io:println("Content Strategy Insights:");
        io:println("- Quote tweets show how your audience interprets and shares your content");
        io:println("- High engagement on quotes indicates viral potential");
        io:println("- Analyze quote tweet language for audience sentiment and discussion themes");
        
    } else {
        io:println("No quote tweets found - consider creating more shareable content");
    }
    
    io:println("\n=== Analytics Dashboard Complete ===");
    io:println("Use these insights to optimize your future content strategy!");
}