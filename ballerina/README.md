## Overview

[Twitter](https://twitter.com/) is a social media platform that enables users to share short messages, engage with content, and connect with audiences worldwide, serving as a powerful tool for real-time communication and information sharing.

The `ballerinax/twitter` package offers APIs to connect and interact with [Twitter API](https://developer.twitter.com/en/docs/twitter-api) endpoints, specifically based on [Twitter API v2](https://developer.twitter.com/en/docs/twitter-api/getting-started/about-twitter-api).
## Setup guide

To use the Twitter connector, you must have access to the Twitter API through a [Twitter Developer account](https://developer.twitter.com/) and obtain API credentials. If you do not have a Twitter account, you can sign up for one [here](https://twitter.com/i/flow/signup).

### Step 1: Create a Twitter Developer Account

1. Navigate to the [Twitter website](https://twitter.com/) and sign up for an account or log in if you already have one.

2. Apply for a Twitter Developer account at [developer.twitter.com](https://developer.twitter.com/). Note that API access requires approval and may have different access levels depending on your use case and Twitter's current API access policies.

### Step 2: Generate API Keys and Access Tokens

1. Log in to your Twitter Developer account at [developer.twitter.com](https://developer.twitter.com/).

2. Navigate to the Developer Portal and select your App from the dashboard.

3. Go to the "Keys and tokens" tab within your App settings.

4. Generate your API Key, API Key Secret, Access Token, and Access Token Secret as needed for your integration.

> **Tip:** You must copy and store these keys somewhere safe. They won't be visible again in your account settings for security reasons.
## Quickstart

To use the `twitter` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/oauth2;
import ballerinax/twitter;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file with your credentials:

```toml
clientId = "<Your_Client_Id>"
clientSecret = "<Your_Client_Secret>"
refreshToken = "<Your_Refresh_Token>"
```

2. Create a `twitter:ConnectionConfig` and initialize the client:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

final twitter:Client twitterClient = check new({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a new tweet

```ballerina
public function main() returns error? {
    twitter:TweetCreateRequest newTweet = {
        text: "Hello from Ballerina! 🎉"
    };

    twitter:TweetCreateResponse response = check twitterClient->/tweets.post(newTweet);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `twitter` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples), covering the following use cases:

1. [Social media trend analysis](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/social-media-trend-analysis) - Demonstrates how to analyze trending topics and hashtags using the Twitter API.
2. [Automated dm support workflow](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/automated-dm-support-workflow) - Illustrates creating automated direct message responses for customer support scenarios.
3. [Tweet performance analytics](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/tweet-performance-analytics) - Shows how to track and analyze tweet engagement metrics and performance data.
4. [Competitor twitter monitoring](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/competitor-twitter-monitoring) - Demonstrates monitoring competitor Twitter activity and extracting insights.