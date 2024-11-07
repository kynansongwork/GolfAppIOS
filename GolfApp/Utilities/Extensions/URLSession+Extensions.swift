//
//  URLSession+Extensions.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
