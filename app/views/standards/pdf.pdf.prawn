# encoding: utf-8
        require 'prawn'
prawn_document(:filename=>'Hello.pdf') do |pdf|
        @all.each do |one|


        pdf.font("Courier")

                pdf.text one.code_with_name, size: 20
                pdf.move_down 20
                pdf.text one.content
                pdf.start_new_page if !@all.last.eql?(one)
            end
end