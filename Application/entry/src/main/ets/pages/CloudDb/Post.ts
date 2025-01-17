import Long from "long";

export class Post {
    id?: Long = undefined;
    userId?: string = undefined;
    content?: string = undefined;
    name?: string = undefined;
    profilePicture?: string = undefined;
    insertDate?: Date = undefined;
    likes: string = '';
    likeCount: number = 0;

    constructor() {
        this.id = undefined;
        this.userId = "";
        this.content = "";
        this.name = undefined;
        this.profilePicture = undefined;
        this.insertDate = undefined;
        this.likes = "[]";
        this.likeCount = 0;
    }

    setId(id) {
        this.id = id;
    }

    getId() {
        return this.id;
    }

    setUserId(userId) {
        this.userId = userId;
    }

    getUserId() {
        return this.userId;
    }

    setContent(content) {
        this.content = content;
    }

    getContent() {
        return this.content;
    }

    setName(name) {
        this.name = name;
    }

    getName() {
        return this.name;
    }

    setProfilePicture(profilePicture) {
        this.profilePicture = profilePicture;
    }

    getProfilePicture() {
        return this.profilePicture;
    }

    setInsertDate(insertDate) {
        this.insertDate = insertDate;
    }

    getInsertDate() {
        return this.insertDate;
    }

    setLikes(likes) {
        this.likes = likes;
    }

    getLikes() {
        return this.likes;
    }

    setLikeCount(likeCount) {
        this.likeCount = likeCount;
    }

    getLikeCount() {
        return this.likeCount;
    }
}