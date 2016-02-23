module FavouritesHelper
    def house_is_favourite?(title)
        unless session[:favourites].nil? 
            session[:favourites].each do |favourite| 
                if favourite.has_value? title ;  return true end
            end
        end
        return false
    end
end
