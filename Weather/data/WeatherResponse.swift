
import Foundation

struct WeatherResponse : Decodable, Equatable {
    
	let coord : Coord?
	let weather : [Weather]?
	let base : String?
	let main : Main?
	let visibility : Int?
	let wind : Wind?
	let clouds : Clouds?
	let dt : Int?
	let sys : Sys?
    let timezone : Int?
	let id : Int?
	let name : String?
	let cod : Int?
    var uuid : String?
    var favoriteLocation: FavoriteLocationEntity?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decode(Coord.self, forKey: .coord)
        weather = try values.decode([Weather].self, forKey: .weather)
        base = try values.decode(String.self, forKey: .base)
        main = try values.decode(Main.self, forKey: .main)
        visibility = try values.decode(Int.self, forKey: .visibility)
        wind = try values.decode(Wind.self, forKey: .wind)
        clouds = try values.decode(Clouds.self, forKey: .clouds)
        dt = try values.decode(Int.self, forKey: .dt)
        sys = try values.decode(Sys.self, forKey: .sys)
        timezone = try values.decode(Int.self, forKey: .timezone)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        cod = try values.decode(Int.self, forKey: .cod)
    }
    
    init (resultModel: WeatherResponse) {
        self.coord = resultModel.coord
        self.weather = resultModel.weather
        self.base = resultModel.base
        self.main = resultModel.main
        self.visibility = resultModel.visibility
        self.wind = resultModel.wind
        self.clouds = resultModel.clouds
        self.dt = resultModel.dt
        self.sys = resultModel.sys
        self.timezone = resultModel.timezone
        self.id = resultModel.id
        self.name = resultModel.name
        self.cod = resultModel.cod
        self.uuid = resultModel.uuid
        self.favoriteLocation = resultModel.favoriteLocation
    }
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.uuid == rhs.uuid
    }

}
