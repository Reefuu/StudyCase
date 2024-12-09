//
//  JobData.swift
//  StudyCase
//
//  Created by Rifqie Tilqa Reamizard on 09/12/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let job = try? JSONDecoder().decode(Job.self, from: jsonData)

import Foundation

// MARK: - JobElement
struct JobElement: Codable, Identifiable {
    let id = UUID()
    let jobVacancyCode, positionName, corporateID, corporateName: String
    let status: Status
    let descriptions: String
    let corporateLogo: String
    var applied: Bool? // Change to a Bool to track whether it's applied or not
    let salaryFrom, salaryTo: Int
    let postedDate: String?

    enum CodingKeys: String, CodingKey {
        case jobVacancyCode, positionName, id
        case corporateID = "corporateId"
        case corporateName, status, descriptions, corporateLogo, applied, salaryFrom, salaryTo, postedDate
    }
}

enum Status: String, Codable {
    case karyawanKontrak = "Karyawan Kontrak"
    case karyawanTetap = "Karyawan Tetap"
    case magang = "Magang"
}

typealias Job = [JobElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
