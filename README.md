
# Ballerina twitter connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twitter/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-twitter.svg)](https://github.com/ballerina-platform/module-ballerinax-twitter/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/twitter.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%twitter)

## Overview

[Twitter](https://twitter.com/) is a real-time social networking platform that enables users to share short messages, engage with content, and connect with audiences worldwide, serving as a powerful tool for communication, marketing, and information dissemination.

The `ballerinax/twitter` package offers APIs to connect and interact with [Twitter API](https://developer.twitter.com/en/docs/twitter-api) endpoints, specifically based on [Twitter API v2](https://developer.twitter.com/en/docs/twitter-api/getting-started/about-twitter-api).
## Setup guide

To use the Twitter connector, you must have access to the Twitter API through a [Twitter Developer account](https://developer.twitter.com/) and obtain API credentials. If you do not have a Twitter account, you can sign up for one [here](https://twitter.com/i/flow/signup).

### Step 1: Create a Twitter Developer Account

1. Navigate to the [Twitter website](https://twitter.com/) and sign up for an account or log in if you already have one.

2. Apply for a Twitter Developer account at [developer.twitter.com](https://developer.twitter.com/). Note that API access requires approval and may have usage limits based on your access level (Free, Basic, or Pro plans).

### Step 2: Generate API Keys and Access Tokens

1. Log in to your Twitter Developer account at [developer.twitter.com](https://developer.twitter.com/).

2. Navigate to the Developer Portal and select your App (or create a new App if you haven't already).

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

The `Twitter` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples), covering the following use cases:

1. [Social media trend analysis](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/social-media-trend-analysis) - Demonstrates how to analyze trending topics and hashtags on Twitter using the Ballerina connector.
2. [Automated dm support workflow](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/automated-dm-support-workflow) - Illustrates creating automated direct message workflows for customer support scenarios.
3. [Tweet performance analytics](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/tweet-performance-analytics) - Shows how to analyze tweet engagement metrics and performance data.
4. [Competitor twitter monitoring](https://github.com/ballerina-platform/module-ballerinax-twitter/tree/main/examples/competitor-twitter-monitoring) - Demonstrates monitoring competitor Twitter activity and extracting insights.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`twitter` package](https://central.ballerina.io/ballerinax/twitter/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
