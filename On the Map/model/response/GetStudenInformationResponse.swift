//
//  GetStudenInformationResponse.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import Foundation

class GetStudentInformationResponse: Decodable {
    let results : [StudentInformation]
}
