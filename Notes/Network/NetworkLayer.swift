//
//  NetworkLayer.swift
//  Notes
//
//  Created by nimik on 05/08/2018.
//  Copyright © 2018 nimik. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer{
    
    static let shared = NetworkLayer()
    
    static let allNotesURL = "https://private-anon-ab903ba032-note10.apiary-mock.com/notes"
    
    func getAllNotes(completion: @escaping ([NoteModel]?, Error?) -> Void){
        Alamofire.request(NetworkLayer.allNotesURL, method: .get).response { (jsonResponse) in
            if let jsonValue =  jsonResponse.data {
                let jsonDecoder = JSONDecoder()
                let detail = try? jsonDecoder.decode([NoteModel].self, from: jsonValue)
                completion(detail, nil)
            }
            else{
                completion(nil, "error" as? Error)
            }
        }
        
    }
    
    
    func getNote(id: Int, completion: @escaping (NoteModel?) -> Void){
        let noteURL = "https://private-anon-ab903ba032-note10.apiary-mock.com/notes/\(id)"
        
        Alamofire.request(noteURL, method: .get).response { (jsonResponse) in
            if let jsonValue =  jsonResponse.data {
                let jsonDecoder = JSONDecoder()
                let info = try? jsonDecoder.decode(NoteModel.self, from: jsonValue)
                completion(info)
            }
        }
    }
    
    func postNote(note: NoteModel, completion: @escaping(NoteModel?, Error?)-> Void){
        let encoder = JSONEncoder()
        let dataJSON = try? encoder.encode(note.title)
        
        let url = URL(string: NetworkLayer.allNotesURL)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = dataJSON
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print (value)
                
                if let itemDetail = try? JSONSerialization.data(withJSONObject: value, options: []){
                    let decoder = JSONDecoder()
                    let detail = try? decoder.decode(NoteModel.self, from: itemDetail)
                    completion(detail, nil)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
        
    }

    func putNote(note: NoteModel, completion: @escaping(NoteModel?, Error?) -> Void){
        let noteURL = "https://private-anon-ab903ba032-note10.apiary-mock.com/notes/\(note.id)"
        let encoder = JSONEncoder()
        let dataJSON = try? encoder.encode(note.title)
        
        let url = URL(string: noteURL)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = dataJSON
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print (value)
                if let itemDetail = try? JSONSerialization.data(withJSONObject: value, options: []){
                    let decoder = JSONDecoder()
                    let detail = try? decoder.decode(NoteModel.self, from: itemDetail)
                    completion(detail, nil)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func deletePost(id: Int, completion: @escaping(NoteModel?) -> Void){
        let noteURL = "https://private-anon-ab903ba032-note10.apiary-mock.com/notes/\(id)"
        Alamofire.request(noteURL, method: .delete).response { (jsonResponse) in
            if let jsonValue =  jsonResponse.data {
                let jsonDecoder = JSONDecoder()
                let detail = try? jsonDecoder.decode(NoteModel.self, from: jsonValue)
                completion(detail)
            }
        }
        
    }
    
    
    
    
}
