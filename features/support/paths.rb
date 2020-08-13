# frozen_string_literal: true

module NavigationHelpers
    def path_to(page_name)
        case page_name
        when /search page/i
            search_representatives_path
        end
    end
end
