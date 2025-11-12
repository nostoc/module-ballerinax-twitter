# Competitor Twitter Monitoring

This example demonstrates how to create a comprehensive competitor analysis workflow using Twitter's API. The script creates a private list for monitoring tech industry competitors, adds competitor accounts to the list, and retrieves recent tweets for content analysis and engagement metrics tracking.

## Prerequisites

1. **Twitter Setup**
   > Refer the [Twitter setup guide](https://central.ballerina.io/ballerinax/twitter/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
bearerToken = "<Your Bearer Token>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following steps:
1. Create a private list called "Tech Competitors 2024"
2. Add competitor accounts (@Twitter, @Tesla, @SpaceX) to the list
3. Retrieve and analyze recent tweets from the competitor list
4. Display engagement metrics and content analysis for each tweet