class Favourite
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    validates :title, presence: true#, uniqueness: true

    def initialize(session)
        @session = session
    end
    def create_favourite(favourite)
        (@session[:favourites] ||= []) << favourite
    end
    def delete_favourite_with_id(id)
        if !id.nil? && id.to_i < @session[:favourites].count then
        m_id = id.to_i
            @session[:favourites].delete_at(m_id)
            return true
        end
        return false
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
