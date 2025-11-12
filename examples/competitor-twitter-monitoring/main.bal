import ballerina/io;
import ballerinax/twitter;

configurable string bearerToken = ?;

type ListCreateResponseData record {
    string id;
    string name;
};

type ListMutateResponseData record {
    boolean isMember;
};

type TweetPublicMetrics record {
    int likeCount?;
    int retweetCount?;
    int replyCount?;
    int quoteCount?;
};

type Get2ListsIdTweetsResponseMeta record {
    int resultCount?;
    string? nextToken?;
    string? previousToken?;
};

public function main() returns error? {
    
    twitter:Client twitterClient = check new({
        auth: {
            token: bearerToken
        }
    });

    io:println("=== Social Media Management Tool: Competitor Analysis Workflow ===\n");

    io:println("Step 1: Creating private list for tech industry competitors...");
    
    twitter:ListCreateRequest listRequest = {
        name: "Tech Competitors 2024",
        description: "Private list for monitoring key technology industry competitors and market trends",
        'private: true
    };

    twitter:ListCreateResponse listResponse = check twitterClient->/lists.post(listRequest);
    
    if listResponse.data is ListCreateResponseData {
        ListCreateResponseData listData = <ListCreateResponseData>listResponse.data;
        io:println(string`✓ Successfully created list: ${listData.name} (ID: ${listData.id})`);
        
        string listId = listData.id;

        io:println("\nStep 2: Adding competitor accounts to the list...");
        
        string[] competitorUserIds = ["783214", "428333", "17874544"];
        string[] competitorNames = ["@Twitter", "@Tesla", "@SpaceX"];
        
        foreach int i in 0..<competitorUserIds.length() {
            twitter:ListAddUserRequest addUserRequest = {
                user_id: competitorUserIds[i]
            };
            
            twitter:ListMutateResponse mutateResponse = check twitterClient->/lists/[listId]/members.post(addUserRequest);
            
            if mutateResponse.data is ListMutateResponseData {
                ListMutateResponseData mutateData = <ListMutateResponseData>mutateResponse.data;
                if mutateData.isMember == true {
                    io:println(string`✓ Successfully added ${competitorNames[i]} to the list`);
                }
            }
        }

        io:println("\nStep 3: Retrieving recent tweets from competitor list for analysis...");
        
        twitter:ListsIdTweetsQueries tweetQueries = {
            tweetFields: ["created_at", "text", "author_id", "public_metrics", "context_annotations"],
            userFields: ["username", "name", "verified"],
            expansions: ["author_id"],
            maxResults: 10
        };
        
        twitter:Get2ListsIdTweetsResponse tweetsResponse = check twitterClient->/lists/[listId]/tweets(queries = tweetQueries);
        
        if tweetsResponse.data is twitter:Tweet[] {
            twitter:Tweet[] tweets = <twitter:Tweet[]>tweetsResponse.data;
            io:println(string`✓ Retrieved ${tweets.length()} recent tweets from competitor list`);
            
            io:println("\n=== COMPETITOR CONTENT ANALYSIS ===");
            foreach int index in 0..<tweets.length() {
                twitter:Tweet currentTweet = tweets[index];
                io:println(string`\nTweet ${index + 1}:`);
                
                anydata authorIdData = currentTweet["authorId"];
                string? authorIdValue = authorIdData is string ? authorIdData : ();
                io:println(string`- Author ID: ${authorIdValue ?: "Unknown"}`);
                
                anydata createdAtData = currentTweet["createdAt"];
                string? createdAtValue = createdAtData is string ? createdAtData : ();
                io:println(string`- Created: ${createdAtValue ?: "Unknown"}`);
                
                twitter:TweetText? tweetTextValue = currentTweet.text;
                string textDisplay = tweetTextValue is twitter:TweetText ? tweetTextValue.toString() : "No text available";
                io:println(string`- Text: ${textDisplay}`);
                
                anydata publicMetricsValue = currentTweet["publicMetrics"];
                if publicMetricsValue is TweetPublicMetrics {
                    TweetPublicMetrics metrics = <TweetPublicMetrics>publicMetricsValue;
                    io:println(string`- Engagement: ${metrics.likeCount ?: 0} likes, ${metrics.retweetCount ?: 0} retweets`);
                }
                
                anydata contextAnnotationsValue = currentTweet["contextAnnotations"];
                if contextAnnotationsValue is twitter:ContextAnnotation[] {
                    twitter:ContextAnnotation[] annotations = <twitter:ContextAnnotation[]>contextAnnotationsValue;
                    io:println(string`- Topics: ${annotations.length()} context annotations found`);
                }
            }
            
            if tweetsResponse.meta is Get2ListsIdTweetsResponseMeta {
                Get2ListsIdTweetsResponseMeta meta = <Get2ListsIdTweetsResponseMeta>tweetsResponse.meta;
                io:println(string`\n=== ANALYSIS SUMMARY ===`);
                io:println(string`- Total tweets analyzed: ${meta.resultCount ?: 0}`);
                io:println(string`- Data collection completed for competitor monitoring`);
                io:println(string`- List ID for future monitoring: ${listId}`);
            }
        }
        
    } else {
        io:println("❌ Failed to create competitor list");
        if listResponse.errors is twitter:Problem[] {
            twitter:Problem[] errors = <twitter:Problem[]>listResponse.errors;
            foreach twitter:Problem err in errors {
                io:println(string`Error: ${err.title} - ${err.detail ?: "No details provided"}`);
            }
        }
    }
    
    io:println("\n=== Competitor Analysis Workflow Complete ===");
}