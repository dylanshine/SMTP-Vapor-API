import Vapor
import Smtp

extension Attachment: Codable, Content {
    
    enum CodingKeys: String, CodingKey {
        case name
        case contentType
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let name = try container.decode(String.self, forKey: .name)
        let contentType = try container.decode(String.self, forKey: .contentType)
        let data = try container.decode(Data.self, forKey: .data)
        
        self.init(name: name, contentType: contentType, data: data)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(contentType, forKey: .contentType)
        try container.encode(data, forKey: .data)
    }
}

extension EmailAddress: Codable, Content {
    enum CodingKeys: String, CodingKey {
        case address
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let address = try container.decode(String.self, forKey: .address)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        
        self.init(address: address, name: name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

extension Email: Codable, Content {
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case cc
        case bcc
        case subject
        case body
        case isBodyHtml
        case replyTo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let from = try container.decode(EmailAddress.self, forKey: .from)
        let to = try container.decode([EmailAddress].self, forKey: .to)
        let cc = try container.decodeIfPresent([EmailAddress].self, forKey: .cc)
        let bcc = try container.decodeIfPresent([EmailAddress].self, forKey: .bcc)
        let subject = try container.decode(String.self, forKey: .subject)
        let body = try container.decode(String.self, forKey: .body)
        let isBodyHtml = try container.decode(Bool.self, forKey: .isBodyHtml)
        let replyTo = try container.decodeIfPresent(EmailAddress.self, forKey: .replyTo)
  
        self.init(from: from,
                  to: to,
                  cc: cc,
                  bcc: bcc,
                  subject: subject,
                  body: body,
                  isBodyHtml: isBodyHtml,
                  replyTo: replyTo)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encodeIfPresent(cc, forKey: .cc)
        try container.encodeIfPresent(bcc, forKey: .bcc)
        try container.encode(subject, forKey: .subject)
        try container.encode(body, forKey: .body)
        try container.encode(isBodyHtml, forKey: .isBodyHtml)
        try container.encodeIfPresent(replyTo, forKey: .replyTo)
    }
}
