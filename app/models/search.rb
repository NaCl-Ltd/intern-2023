class Search < ApplicationRecord
    #名前に含まれていたらtrueを返す
    def search(data)
        name.include?(data)
    end
end