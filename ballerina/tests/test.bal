// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/os;
import ballerina/test;

public type ConnectionConfig record {
    AuthConfig auth;
};

public type AuthConfig record {
    string token;
};

public type Client client object {
    resource function delete tweets/[string id]() returns TweetDeleteResponse|error;
    resource function delete users/[string userId]/bookmarks/[string tweetId]() returns BookmarkMutationResponse|error;
    resource function delete users/[string userId]/likes/[string tweetId]() returns UsersLikesDeleteResponse|error;
    resource function delete users/[string userId]/retweets/[string tweetId]() returns UsersRetweetsDeleteResponse|error;
    resource function delete users/[string userId]/following/[string targetUserId]() returns UsersFollowingDeleteResponse|error;
    resource function get tweets(string[] ids) returns Get2TweetsResponse|error;
    resource function get tweets/[string id]() returns Get2TweetsIdResponse|error;
    resource function get tweets/sample/'stream() returns StreamingTweetResponse|error;
    resource function get tweets/search/'stream() returns FilteredStreamingTweetResponse|error;
    resource function get tweets/search/'stream/rules() returns RulesLookupResponse|error;
    resource function get tweets/search/all(string query) returns Get2TweetsSearchAllResponse|error;
    resource function get tweets/search/recent(string query) returns Get2TweetsSearchRecentResponse|error;
    resource function get users(string[] ids) returns Get2UsersResponse|error;
    resource function get users/'by(string[] usernames) returns Get2UsersByResponse|error;
    resource function get users/'by/username/[string username]() returns Get2UsersByUsernameUsernameResponse|error;
    resource function get users/[string userId]/bookmarks() returns Get2UsersIdBookmarksResponse|error;
    resource function get users/[string userId]/timelines/reverse_chronological() returns Get2UsersIdTimelinesReverseChronologicalResponse|error;
    resource function get users/[string userId]() returns Get2UsersIdResponse|error;
    resource function get users/[string userId]/followers() returns Get2UsersIdFollowersResponse|error;
    resource function get users/[string userId]/following() returns Get2UsersIdFollowingResponse|error;
    resource function get users/[string userId]/liked_tweets() returns Get2UsersIdLikedTweetsResponse|error;
    resource function get users/[string userId]/tweets() returns Get2UsersIdTweetsResponse|error;
    resource function get users/me() returns Get2UsersMeResponse|error;
    resource function get users/search(string query) returns Get2UsersSearchResponse|error;
    resource function post tweets(TweetCreateRequest payload) returns TweetCreateResponse|error;
    resource function post tweets/search/'stream/rules(AddRulesRequest payload) returns AddOrDeleteRulesResponse|error;
    resource function post users/[string userId]/bookmarks(BookmarkRequest payload) returns BookmarkMutationResponse|error;
    resource function post users/[string userId]/following(FollowRequest payload) returns UsersFollowingCreateResponse|error;
    resource function post users/[string userId]/likes(LikeRequest payload) returns UsersLikesCreateResponse|error;
    resource function post users/[string userId]/retweets(RetweetRequest payload) returns UsersRetweetsCreateResponse|error;
};

public type TweetDeleteResponse record {
    TweetDeleteData? data?;
    ErrorDetail[]? errors?;
};

public type TweetDeleteData record {
    boolean deleted;
};

public type BookmarkMutationResponse record {
    BookmarkMutationData? data?;
    ErrorDetail[]? errors?;
};

public type BookmarkMutationData record {
    boolean bookmarked;
};

public type UsersLikesDeleteResponse record {
    UsersLikesDeleteData? data?;
    ErrorDetail[]? errors?;
};

public type UsersLikesDeleteData record {
    boolean liked;
};

public type UsersRetweetsDeleteResponse record {
    UsersRetweetsDeleteData? data?;
    ErrorDetail[]? errors?;
};

public type UsersRetweetsDeleteData record {
    boolean retweeted;
};

public type UsersFollowingDeleteResponse record {
    UsersFollowingDeleteData? data?;
    ErrorDetail[]? errors?;
};

public type UsersFollowingDeleteData record {
    boolean following;
};

public type Get2TweetsResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2TweetsIdResponse record {
    Tweet? data?;
    ErrorDetail[]? errors?;
};

public type StreamingTweetResponse record {
    Tweet? data?;
    ErrorDetail[]? errors?;
};

public type FilteredStreamingTweetResponse record {
    Tweet? data?;
    ErrorDetail[]? errors?;
};

public type RulesLookupResponse record {
    Rule[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2TweetsSearchAllResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2TweetsSearchRecentResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersResponse record {
    User[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersByResponse record {
    User[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersByUsernameUsernameResponse record {
    User? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdBookmarksResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdTimelinesReverseChronologicalResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdResponse record {
    User? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdFollowersResponse record {
    User[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdFollowingResponse record {
    User[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdLikedTweetsResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersIdTweetsResponse record {
    Tweet[]? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersMeResponse record {
    User? data?;
    ErrorDetail[]? errors?;
};

public type Get2UsersSearchResponse record {
    User[]? data?;
    ErrorDetail[]? errors?;
};

public type TweetCreateResponse record {
    TweetCreateData? data?;
    ErrorDetail[]? errors?;
};

public type TweetCreateData record {
    string id;
    string text;
};

public type AddOrDeleteRulesResponse record {
    RulesData? data?;
    ErrorDetail[]? errors?;
};

public type RulesData record {
    Rule[]? add?;
    Rule[]? delete?;
};

public type UsersFollowingCreateResponse record {
    UsersFollowingCreateData? data?;
    ErrorDetail[]? errors?;
};

public type UsersFollowingCreateData record {
    boolean following;
    boolean pending_follow;
};

public type UsersLikesCreateResponse record {
    UsersLikesCreateData? data?;
    ErrorDetail[]? errors?;
};

public type UsersLikesCreateData record {
    boolean liked;
};

public type UsersRetweetsCreateResponse record {
    UsersRetweetsCreateData? data?;
    ErrorDetail[]? errors?;
};

public type UsersRetweetsCreateData record {
    boolean retweeted;
};

public type Tweet record {
    string id;
    string text;
    string? author_id?;
};

public type User record {
    string id;
    string name;
    string username;
};

public type Rule record {
    string id;
    string value;
    string? tag?;
};

public type ErrorDetail record {
    string title;
    string detail;
    string 'type;
};

public type TweetCreateRequest record {
    string text;
};

public type AddRulesRequest record {
    RuleToAdd[] add;
};

public type RuleToAdd record {
    string value;
    string? tag?;
};

public type BookmarkRequest record {
    string tweetId;
};

public type FollowRequest record {
    string targetUserId;
};

public type LikeRequest record {
    string tweetId;
};

public type RetweetRequest record {
    string tweetId;
};

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("TWITTER_TOKEN") : "test_token";
configurable string serviceUrl = isLiveServer ? "https://api.twitter.com/2" : "http://localhost:9090/2";

ConnectionConfig config = {auth: {token: token}};
final Client twitterClient = check new Client(config, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeleteTweetById() returns error? {
    TweetDeleteResponse response = check twitterClient->/tweets/["1234567890123456789"].delete();
    test:assertTrue(response?.data !is (), "Expected tweet delete data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testRemoveBookmarkedPost() returns error? {
    BookmarkMutationResponse response = check twitterClient->/users/["123456789012345678"]/bookmarks/["1234567890123456789"].delete();
    test:assertTrue(response?.data !is (), "Expected bookmark mutation data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testUnlikePost() returns error? {
    UsersLikesDeleteResponse response = check twitterClient->/users/["123456789012345678"]/likes/["1234567890123456789"].delete();
    test:assertTrue(response?.data !is (), "Expected unlike data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testUnretweetPost() returns error? {
    UsersRetweetsDeleteResponse response = check twitterClient->/users/["123456789012345678"]/retweets/["1234567890123456789"].delete();
    test:assertTrue(response?.data !is (), "Expected unretweet data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testUnfollowUser() returns error? {
    UsersFollowingDeleteResponse response = check twitterClient->/users/["123456789012345678"]/following/["987654321098765432"].delete();
    test:assertTrue(response?.data !is (), "Expected unfollow data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetTweetsByIds() returns error? {
    Get2TweetsResponse response = check twitterClient->/tweets(ids = ["1234567890123456789"]);
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty tweets array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetTweetById() returns error? {
    Get2TweetsIdResponse response = check twitterClient->/tweets/["1234567890123456789"]();
    test:assertTrue(response?.data !is (), "Expected tweet data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSampleStream() returns error? {
    StreamingTweetResponse response = check twitterClient->/tweets/sample/'stream();
    test:assertTrue(response?.data !is (), "Expected streaming tweet data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetFilteredStream() returns error? {
    FilteredStreamingTweetResponse response = check twitterClient->/tweets/search/'stream();
    test:assertTrue(response?.data !is (), "Expected filtered streaming tweet data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetStreamRules() returns error? {
    RulesLookupResponse response = check twitterClient->/tweets/search/'stream/rules();
    Rule[]? rulesData = response.data;
    if rulesData is Rule[] {
        test:assertTrue(rulesData.length() > 0, "Expected a non-empty rules array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testSearchAllTweets() returns error? {
    Get2TweetsSearchAllResponse response = check twitterClient->/tweets/search/all(query = "test");
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty search results array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testSearchRecentTweets() returns error? {
    Get2TweetsSearchRecentResponse response = check twitterClient->/tweets/search/recent(query = "test");
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty recent search results array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUsersByIds() returns error? {
    Get2UsersResponse response = check twitterClient->/users(ids = ["123456789012345678"]);
    User[]? usersData = response.data;
    if usersData is User[] {
        test:assertTrue(usersData.length() > 0, "Expected a non-empty users array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUsersByUsernames() returns error? {
    Get2UsersByResponse response = check twitterClient->/users/'by(usernames = ["testuser"]);
    User[]? usersData = response.data;
    if usersData is User[] {
        test:assertTrue(usersData.length() > 0, "Expected a non-empty users array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserByUsername() returns error? {
    Get2UsersByUsernameUsernameResponse response = check twitterClient->/users/'by/username/["testuser"]();
    test:assertTrue(response?.data !is (), "Expected user data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserBookmarks() returns error? {
    Get2UsersIdBookmarksResponse response = check twitterClient->/users/["123456789012345678"]/bookmarks();
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty bookmarks array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserTimeline() returns error? {
    Get2UsersIdTimelinesReverseChronologicalResponse response = check twitterClient->/users/["123456789012345678"]/timelines/reverse_chronological();
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty timeline array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserById() returns error? {
    Get2UsersIdResponse response = check twitterClient->/users/["123456789012345678"]();
    test:assertTrue(response?.data !is (), "Expected user data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserFollowers() returns error? {
    Get2UsersIdFollowersResponse response = check twitterClient->/users/["123456789012345678"]/followers();
    User[]? usersData = response.data;
    if usersData is User[] {
        test:assertTrue(usersData.length() > 0, "Expected a non-empty followers array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserFollowing() returns error? {
    Get2UsersIdFollowingResponse response = check twitterClient->/users/["123456789012345678"]/following();
    User[]? usersData = response.data;
    if usersData is User[] {
        test:assertTrue(usersData.length() > 0, "Expected a non-empty following array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserLikedTweets() returns error? {
    Get2UsersIdLikedTweetsResponse response = check twitterClient->/users/["123456789012345678"]/liked_tweets();
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty liked tweets array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetUserTweets() returns error? {
    Get2UsersIdTweetsResponse response = check twitterClient->/users/["123456789012345678"]/tweets();
    Tweet[]? tweetsData = response.data;
    if tweetsData is Tweet[] {
        test:assertTrue(tweetsData.length() > 0, "Expected a non-empty user tweets array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetCurrentUser() returns error? {
    Get2UsersMeResponse response = check twitterClient->/users/me();
    test:assertTrue(response?.data !is (), "Expected current user data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testSearchUsers() returns error? {
    Get2UsersSearchResponse response = check twitterClient->/users/search(query = "testquery");
    User[]? usersData = response.data;
    if usersData is User[] {
        test:assertTrue(usersData.length() > 0, "Expected a non-empty user search results array");
    }
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateTweet() returns error? {
    TweetCreateResponse response = check twitterClient->/tweets.post({text: "Test tweet"});
    test:assertTrue(response?.data !is (), "Expected tweet creation data to be present");
    test:assertTrue(response["errors"] is (), "Expected no errors in response");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testAddStreamRules() returns error? {
    AddOrDeleteRulesResponse response = check twitterClient->/tweets/search/'stream/rules.post({
        add: [
            {
                value: "from:TwitterDev",
                tag: "developer_tweets"
            }
        ]
    });
    test:assertTrue(response?.data !is (), "Expected rules data to be present");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testAddBookmark() returns error? {
    BookmarkMutationResponse response = check twitterClient->/users/["123456789012345678"]/bookmarks.post({
        tweetId: "1234567890123456789"
    });
    test:assertTrue(response?.data !is (), "Expected bookmark data to be present");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testFollowUser() returns error? {
    UsersFollowingCreateResponse response = check twitterClient->/users/["123456789012345678"]/following.post({
        targetUserId: "987654321098765432"
    });
    test:assertTrue(response?.data !is (), "Expected follow data to be present");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testLikePost() returns error? {
    UsersLikesCreateResponse response = check twitterClient->/users/["123456789012345678"]/likes.post({
        tweetId: "1234567890123456789"
    });
    test:assertTrue(response?.data !is (), "Expected like data to be present");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testRetweetPost() returns error? {
    UsersRetweetsCreateResponse response = check twitterClient->/users/["123456789012345678"]/retweets.post({
        tweetId: "1234567890123456789"
    });
    test:assertTrue(response?.data !is (), "Expected retweet data to be present");
}