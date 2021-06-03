//
//  BGBitbucket.swift
//  BitGallery
//
//  Created by Khagesh Patel on 2/6/21.
//

import Foundation

// MARK: - Welcome
struct BGRepository: Codable {
    var pagelen: Int?
    var values: [BGValue]?
    var next: String?
}

// MARK: - Value
struct BGValue: Codable {
    let website: String?
    let hasWiki: Bool?
    let links: ValueLinks?
    let uuid: String?
    let fullName, name: String?
    let language, createdOn: String?
    let hasIssues: Bool?
    let updatedOn: String?
    let size: Int?
    let type: ValueType?
    let slug: String?
    let isPrivate: Bool?
    let valueDescription: String?

    enum CodingKeys: String, CodingKey {
        case website
        case hasWiki = "has_wiki"
        case links
        case uuid
        case fullName = "full_name"
        case name, language
        case createdOn = "created_on"
        case hasIssues = "has_issues"
        case updatedOn = "updated_on"
        case size, type, slug
        case isPrivate = "is_private"
        case valueDescription = "description"
    }
}
enum ForkPolicy: String, Codable {
    case allowForks = "allow_forks"
}

// MARK: - ValueLinks
struct ValueLinks: Codable {
    let clone: [Clone]?
    let avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case clone
        case avatar
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let href: String?
}

// MARK: - Clone
struct Clone: Codable {
    let href: String?
    let name: CloneName?
}

enum CloneName: String, Codable {
    case https = "https"
    case ssh = "ssh"
}

// MARK: - Mainbranch
struct Mainbranch: Codable {
    let type: MainbranchType?
    let name: MainbranchName?
}

enum MainbranchName: String, Codable {
    case master = "master"
}

enum MainbranchType: String, Codable {
    case branch = "branch"
}

// MARK: - Owner
struct Owner: Codable {
    let displayName, uuid: String?
    let links: OwnerLinks?
    let type: OwnerType?
    let nickname: String?
    let accountID: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case displayName
        case uuid, links, type, nickname
        case accountID
        case username
    }
}

// MARK: - OwnerLinks
struct OwnerLinks: Codable {
    let linksSelf, html, avatar: Avatar?

    enum CodingKeys: String, CodingKey {
        case linksSelf
        case html, avatar
    }
}

enum OwnerType: String, Codable {
    case team = "team"
    case user = "user"
}

// MARK: - Project
struct Project: Codable {
    let links: OwnerLinks?
    let type: ProjectType?
    let name: String?
    let key: Key?
    let uuid, slug: String?
}

enum Key: String, Codable {
    case proj = "PROJ"
}

enum ProjectType: String, Codable {
    case project = "project"
    case workspace = "workspace"
}

enum SCM: String, Codable {
    case git = "git"
}

enum ValueType: String, Codable {
    case repository = "repository"
}
