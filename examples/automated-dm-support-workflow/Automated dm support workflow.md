# Automated DM Support Workflow

This example demonstrates how to create an automated customer support system using Twitter's API that monitors brand mentions, identifies support requests, and initiates personalized DM conversations with users who need assistance.

## Prerequisites

1. **Twitter Setup**
   > Refer to the [Twitter setup guide](https://central.ballerina.io/ballerinax/twitter/latest#setup-guide) to obtain the necessary credentials and configure your Twitter app.

2. For this example, create a `Config.toml` file with your credentials:

```toml
bearerToken = "<Your Bearer Token>"
brandUsername = "techsupport"
supportUserId = "<Your Support User ID>"
```

## Run the Example

Execute the following command to run the example. The script will monitor mentions, identify support requests, and automatically create DM conversations with users needing assistance.

```shell
bal run
```

The automation system will:
1. Monitor mentions for your support account
2. Identify tweets containing support-related keywords
3. Create DM conversations with users who need help
4. Send contextual responses based on the type of issue
5. Log conversation history for quality assurance and human agent follow-up