public with sharing class ChatterService {

    public static void postFeed(Id userId, String postBody) {
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        mentionSegmentInput.id = userId; //USER ID OR GROUP ID
        messageBodyInput.messageSegments.add(mentionSegmentInput);

        textSegmentInput.text = postBody;
        messageBodyInput.messageSegments.add(textSegmentInput);

        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
        mentionSegmentInput.id = userId; //USER ID OR GROUP ID 
        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(null, feedItemInput);
    }

    public static void createPost(Id parentId, String postBody) {
        FeedItem post = new FeedItem();
        post.ParentId = parentId;
        post.Body = postBody;
        insert post;
    }

    public static void createLinkedPost(Id parentId, String postBody) {
        FeedItem post = new FeedItem();
        post.ParentId = parentId;
        post.Body = postBody;
        post.LinkUrl = 'http://www.infallibletechie.com';
        insert post;    
    }
}