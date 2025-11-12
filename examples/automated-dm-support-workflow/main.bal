import ballerina/io;
import ballerinax/twitter;

configurable string bearerToken = ?;
configurable string brandUsername = "techsupport";
configurable string supportUserId = "1234567890";

public function main() returns error? {
    twitter:ConnectionConfig config = {
        auth: {
            token: bearerToken
        }
    };

    twitter:Client twitterClient = check new (config);

    io:println("=== Automated DM Support System ===");
    
    io:println("\n1. Monitoring mentions for support requests...");
    twitter:Get2UsersIdMentionsResponse mentionsResponse = check twitterClient->/users/[supportUserId]/mentions(tweet\.fields=["id", "text", "author_id", "created_at", "public_metrics"], user\.fields=["id", "username", "name"], expansions=["author_id"], max_results=10);

    twitter:Tweet[]? mentionsData = mentionsResponse.data;
    if mentionsData is twitter:Tweet[] {
        int mentionsCount = mentionsData.length();
        io:println(string `Found ${mentionsCount} recent mentions`);
        
        foreach twitter:Tweet mention in mentionsData {
            string mentionText = mention.text ?: "No text";
            io:println(string `Processing mention: ${mentionText}`);
            
            string? authorId = mention.author_id;
            if authorId is string && isSupportRequest(mentionText) {
                io:println(string `Identified support request from user: ${authorId}`);
                
                io:println("\n2. Creating DM conversation...");
                twitter:CreateDmConversationRequest conversationRequest = {
                    conversation_type: "Group",
                    participant_ids: [authorId],
                    message: {
                        text: string `Hi! I noticed you mentioned ${brandUsername}. I'm here to help with any questions or issues you might have. How can I assist you today?`
                    }
                };
                
                twitter:CreateDmEventResponse conversationResponse = check twitterClient->/dm_conversations.post(conversationRequest);
                
                twitter:CreateDmEventResponse_data? conversationData = conversationResponse.data;
                if conversationData is twitter:CreateDmEventResponse_data {
                    string? dmConversationId = conversationData.dm_conversation_id;
                    io:println(string `Created DM conversation: ${dmConversationId ?: "unknown"}`);
                    
                    io:println("\n3. Sending contextual response...");
                    string contextualResponse = generateContextualResponse(mentionText);
                    
                    twitter:CreateMessageRequest followupMessage = {
                        text: contextualResponse
                    };
                    
                    twitter:CreateDmEventResponse messageResponse = check twitterClient->/dm_conversations/with/[authorId]/messages.post(followupMessage);
                    
                    twitter:CreateDmEventResponse_data? messageData = messageResponse.data;
                    if messageData is twitter:CreateDmEventResponse_data {
                        twitter:DmEventId? dmEventIdObj = messageData.dm_event_id;
                        string dmEventIdStr = dmEventIdObj is twitter:DmEventId ? dmEventIdObj.toString() : "unknown";
                        io:println(string `Sent contextual response. Message ID: ${dmEventIdStr}`);
                        
                        io:println("\n4. Retrieving conversation history for QA tracking...");
                        twitter:Get2DmConversationsWithParticipantIdDmEventsResponse historyResponse = check twitterClient->/dm_conversations/with/[authorId]/dm_events(dm_event\.fields=["id", "text", "created_at", "sender_id", "event_type"], user\.fields=["id", "username", "name"], max_results=10);
                        
                        twitter:DmEvent[]? historyData = historyResponse.data;
                        if historyData is twitter:DmEvent[] {
                            int historyCount = historyData.length();
                            io:println(string `Retrieved ${historyCount} conversation events for QA tracking`);
                            
                            foreach twitter:DmEvent event in historyData {
                                string eventId = event.id ?: "unknown";
                                string eventText = event.text ?: "No text";
                                string eventTime = event.created_at ?: "unknown time";
                                io:println(string `Event ${eventId}: ${eventText} (${eventTime})`);
                            }
                            
                            io:println("\n5. Logging conversation for human agent follow-up...");
                            logConversationForFollowup(authorId, mentionText, contextualResponse, historyData);
                        }
                    }
                }
            }
        }
    } else {
        io:println("No mentions found or error retrieving mentions");
    }
    
    io:println("\n=== Support automation cycle completed ===");
}

function isSupportRequest(string mentionText) returns boolean {
    string[] supportKeywords = ["help", "issue", "problem", "bug", "support", "error", "broken", "not working", "trouble"];
    string lowerText = mentionText.toLowerAscii();
    
    foreach string keyword in supportKeywords {
        if lowerText.includes(keyword) {
            return true;
        }
    }
    return false;
}

function generateContextualResponse(string originalMention) returns string {
    string lowerMention = originalMention.toLowerAscii();
    
    if lowerMention.includes("login") || lowerMention.includes("password") {
        return "I can help you with login issues! Please try resetting your password using our secure reset link: https://example.com/reset. If you continue having trouble, I'll connect you with a specialist.";
    } else if lowerMention.includes("billing") || lowerMention.includes("payment") {
        return "For billing inquiries, I can provide general information. For account-specific billing questions, I'll need to connect you with our billing team. Is this regarding a recent charge or subscription?";
    } else if lowerMention.includes("bug") || lowerMention.includes("error") {
        return "Thanks for reporting this issue! To help our technical team investigate, could you provide more details about when this occurred and what you were trying to do? In the meantime, you might find our troubleshooting guide helpful: https://example.com/troubleshoot";
    } else {
        return "I'm here to help! Could you provide a bit more detail about what you're experiencing? This will help me direct you to the right resources or connect you with the appropriate specialist.";
    }
}

function logConversationForFollowup(string userId, string originalMention, string automatedResponse, twitter:DmEvent[] conversationHistory) {
    int historyLength = conversationHistory.length();
    io:println(string `[QA LOG] User: ${userId}`);
    io:println(string `[QA LOG] Original mention: ${originalMention}`);
    io:println(string `[QA LOG] Automated response: ${automatedResponse}`);
    io:println(string `[QA LOG] Conversation events: ${historyLength}`);
    io:println("[QA LOG] Status: Ready for human agent review");
    io:println("[QA LOG] Priority: Standard (automated classification)");
    io:println("---");
}