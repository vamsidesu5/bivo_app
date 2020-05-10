//
//  Study.swift
//  bivo
//
//  Created by vamsi on 5/8/20.
//  Copyright © 2020 com.vamsi. All rights reserved.
//

import Foundation
@objc class OrderModel: NSObject, Decodable{
    var university : String;
    var research_type : String;
    var price : String;
    var audience: [String: String];
    var bio: String;
    var serverAddress: String;
    var query: [String];
    //audience, bioo, price, query, research_typee, serverAddress, university
    init(university : String, research_type : String,
         price : String, audience: [String: String], bio: String, serverAddress: String, query: [String]){
        self.university = university;
        self.research_type = research_type;
        self.price = price;
        self.audience = audience;
        self.bio = bio;
        self.serverAddress = serverAddress;
        self.query = query;
    }
    override init() {
        self.university = "";
        self.research_type = "";
        self.price = "";
        self.audience = ["":""];
        self.bio = "";
        self.serverAddress = "";
        self.query = [""];
    }
    
}

@objc class OrderModels: NSObject, Decodable{
    var orders: [OrderModel];
    //audience, bioo, price, query, research_typee, serverAddress, university
    init(orders: [OrderModel]){
        self.orders = orders;
    }
    
}

