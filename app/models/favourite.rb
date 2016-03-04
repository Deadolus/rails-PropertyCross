class Favourite
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    validates :title, presence: true#, uniqueness: true

    def initialize(session)
        @session = session
    end
    def create_favourite(favourite)
        if !@session[:favourites].nil? && (@session[:favourites].count == 4)
            return false
        else
            (@session[:favourites] ||= []) << favourite
            return true
        end
    end
    def delete_favourite_with_id(id)
        if !id.nil?
            m_id = id.to_i
            if !@session[:favourites][m_id].nil? && id.to_i < @session[:favourites].count then
                @session[:favourites].delete_at(m_id)
                return true
            end
            return false
        end
    end
    def delete_favourite_with_title(title)
        if title
        @session[:favourites].each do |favourite| 
            if title == favourite["title"] 
                @session[:favourites].delete favourite
                return true
            end
        end
        end
        return false
    end

end
