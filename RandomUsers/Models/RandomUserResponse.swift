//
//  RandomUserResponse.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let registered: Registration
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
}

struct Registration: Codable {
    let date: Date
    let age: Int
}

struct ID: Codable {
    let name: String
    let value: String?
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
