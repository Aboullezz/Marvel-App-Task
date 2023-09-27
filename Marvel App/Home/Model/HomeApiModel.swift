//
//  HomeApiModel.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 24/09/2023.
//

import Foundation

protocol MarvelModelProtocol{
    var thumbnail: MarvelThumbnail? {get}
    var title: String? {get}
    var startYear: Int? {get}
    var rating: String? {get}
    var creators: MarvelCreators? {get}
    var characters: MarvelCharacters? {get}
    var comics: MarvelComics? {get}
    var modified: String? {get}
}

struct MarvelApiResponse: Codable {
    let data: MarvelData?
}

struct MarvelData: Codable {
    let results: [MarvelSeries]?
}

struct MarvelSeries: Codable, MarvelModelProtocol {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [MarvelURL]?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let modified: String?
    let thumbnail: MarvelThumbnail?
    let creators: MarvelCreators?
    let characters: MarvelCharacters?
    let stories: MarvelStories?
    let comics: MarvelComics?
    let events: MarvelEvents?
    let next: Next?
}

struct Next: Codable {
    let resourceURI: String?
    let name: String?
}
struct MarvelURL: Codable {
    let type: String
    let url: String
}

struct MarvelThumbnail: Codable {
    let path: String
    let `extension`: String
}

struct MarvelCreators: Codable {
    let available: Int
    let collectionURI: String
    let items: [MarvelCreator]
}

struct MarvelCreator: Codable {
    let resourceURI: String
    let name: String
    let role: String
}

struct MarvelCharacters: Codable {
    let available: Int
    let collectionURI: String
    let items: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    let resourceURI: String
    let name: String
}

struct MarvelStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [MarvelStory]
}

struct MarvelStory: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

struct MarvelComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [MarvelComic]
}

struct MarvelComic: Codable {
    let resourceURI: String
    let name: String
}

struct MarvelEvents: Codable {
    let available: Int
    let collectionURI: String
    let items: [MarvelEvent]
}

struct MarvelEvent: Codable {
    let resourceURI: String
    let name: String
}

