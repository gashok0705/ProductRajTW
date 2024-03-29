import Foundation
 
public class ProductList: NSObject, NSCoding {
    
	public var name : String?
	public var price : String?
	public var image : String?
    public var offerPrice: String?
    public var pID: Int?
    public var pCount: String = ""

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let ProductList = ProductList(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: ProductList Instance.
*/
	required public init?(dictionary: NSDictionary) {

        if let name_ = dictionary["name"] as? String {
            self.name = name_
        } else {
            self.name = ""
        }
        if let price_ = dictionary["price"] as? String {
            self.price = price_
        } else {
            self.price = ""
        }
        if let image_ = dictionary["image"] as? String {
            self.image = image_
        } else {
            self.image = ""
        }
        if let offerPrice_ = dictionary["offerPrice"] as? String {
            self.offerPrice = offerPrice_
        } else {
            self.offerPrice = ""
        }
        if let pID_ = dictionary["pid"] as? String {
            self.pID = Int(pID_)
        } else {
            self.pID = 0
        }
	}
    
    override init() {
        
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(image, forKey: "image")
        coder.encode(offerPrice, forKey: "offerPrice")
        coder.encode(pID, forKey: "pid")
        coder.encode(pCount, forKey: "pCount")
    }
    
    public required init?(coder: NSCoder) {
        
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.price = coder.decodeObject(forKey: "price") as? String ?? ""
        self.image = coder.decodeObject(forKey: "image") as? String ?? ""
        self.offerPrice = coder.decodeObject(forKey: "offerPrice") as? String ?? ""
        self.pID = coder.decodeObject(forKey: "pid") as? Int ?? 0
        self.pCount = coder.decodeObject(forKey: "pCount") as? String ?? ""
    }
		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.price, forKey: "price")
		dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.offerPrice, forKey: "offerPrice")

		return dictionary
	}

}
