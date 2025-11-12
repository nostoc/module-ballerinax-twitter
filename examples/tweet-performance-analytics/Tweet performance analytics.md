# Tweet Performance Analytics

This example demonstrates how to analyze tweet performance and engagement patterns by retrieving recent tweets, identifying top-performing content, analyzing audience demographics, and examining quote tweet discussion patterns.

## Prerequisites

1. **Twitter Setup**
   > Refer the [Twitter setup guide](https://central.ballerina.io/ballerinax/twitter/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
bearerToken = "<Your Bearer Token>"
userId = "<Your User ID>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will:
1. Fetch your recent tweets and analyze their engagement metrics
2. Identify your top-performing tweet based on total engagement
3. Analyze audience demographics from users who liked your top tweet
4. Examine quote tweets to understand content discussion patterns
5. Provide content strategy insights based on the analysis