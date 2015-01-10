require 'pdf/writer'
require 'pdf/simpletable'

#Initialize a new PDF object
pdf = PDF::Writer.new
#Like most word processors, you can choose your font
pdf.select_font("Times-Roman") #Courier, Helvetica, Symbol, Times-Roman, ZapfDingbats
pdf.text("Review: Wicked Cool Ruby Scripts\n\n", :font_size => 25, :justification => :center)

#Create a table within the PDF document
PDF::SimpleTable.new do |table|
  table.column_order = %w(question response)
  
  table.columns["question"] = PDF::SimpleTable::Column.new("question") do |col|
    col.heading = "Question"
    col.width = 100
  end
  
  table.columns["response"] = PDF::SimpleTable::Column.new("response") do |col|
    col.heading = "Response"
  end
  #Attributes for the table
  table.show_lines    = :all
  table.show_headings = false
  table.shade_rows    = :none
  table.orientation   = :center
  table.position      = :center
  table.width	    = 400
  
  #Data Hash --- add questions as needed
  data = [
    {"question" => "Reviewer:"},
    {"question" => "Title:", "response" => "Wicked Cool Ruby Scripts"},
    {"question" => "Author:", "response" => "Steven Pugh"},
    {"question" => "Publisher & Year:", "response" => "No Starch Press, 2008"},
    {"question" => "ISBN:"},
    {"question" => "Genre Category:", "response" => "Programming Languages: Ruby"},
  ]
  table.data.replace data
  table.render_on(pdf) 
end

#Demo of output text to the pdf document
pdf.text("\n\n1.  Did this book teach you anything about scripting in Ruby (circle one)?" , :font_size => 14)
pdf.text("\n    Yes   No     Why or why not?____________________________")
pdf.text("\n2.  Are the example scripts appropriate and are they explained well?")
pdf.text("\n    Yes   No     Why or why not?____________________________")
pdf.text("\n3.  Would you recommend this book to another person?  Why or why not?")
pdf.text("    ________________________________________________________________")
pdf.text("    ________________________________________________________________")
pdf.text("\n4.  List three adjectives that describe this book:")
pdf.text("    a._______________  b._______________ c._______________")
pdf.text("\n5.  Write any additional information you would like to share here:")
pdf.text("    ________________________________________________________________")
pdf.text("    ________________________________________________________________")
pdf.text("    ________________________________________________________________")
pdf.text("    ________________________________________________________________")
pdf.text("    ________________________________________________________________")
pdf.text("\n6.  Overall rating: Check one (0=Horrible, 5=Wicked Cool):")
pdf.text("           0             1            2            3            4            5")
#This shows how 
pdf.circle_at(66, pdf.y+5, 5).stroke
pdf.circle_at(121, pdf.y+5, 5).stroke
pdf.circle_at(170, pdf.y+5, 5).stroke
pdf.circle_at(219, pdf.y+5, 5).stroke
pdf.circle_at(268, pdf.y+5, 5).stroke
pdf.circle_at(316, pdf.y+5, 5).stroke

pdf.save_as('book_review.pdf')