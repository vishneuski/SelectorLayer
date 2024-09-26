public with sharing class ChatterService {

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