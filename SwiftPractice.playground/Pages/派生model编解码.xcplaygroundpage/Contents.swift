//: [Previous](@previous)

import Foundation
//默认Codable中的默认encode方法并不能正确处理派生类对象
func encode<T>(of model: T) throws where T: Codable {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let data = try encoder.encode(model)
    print(String(data: data, encoding: .utf8)!)
}

class Point2D : Codable {
    var x = 0.0
    var y = 0.0
    
    //基类中的CodingKeys被修饰成了private。因为派生类中，也要定义它自己的CodingKeys
    private enum CodingKeys : String, CodingKey {
        case x
        case y
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }

}

class Point3D : Point2D {
    var z = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case z
        case point_2d
    }
    
    override func encode(to encoder: Encoder) throws {
       
        var container =
            encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: container.superEncoder(forKey: .point_2d))
        try container.encode(z, forKey: .z)
    }
}













//: [Next](@next)
