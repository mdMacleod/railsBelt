module ErrorsHelper

    def show_errors(object, field_name)
        puts "HERE:LRHEKJRH:ELK"
        if object.errors.any?
            if !object.errors.messages[field_name].blank?
                puts "HERES THE PUTS"
                puts object.errors.full_messages
                object.errors.messages[field_name].join(", ")
            end
        end
    end
end