# encoding: utf-8
#
require 'rubygems'
require 'prawn'
require 'csv'
 
Prawn.debug = true
show_layout = false


rows = CSV.open(ARGV[0], 'r', ',').to_a 

Prawn::Document.generate("#{ARGV[0]}.pdf", :page_layout => :landscape, :page_size=>'A4') do
  
  BOX_W = bounds.width * 0.45
  BOX_H = bounds.height * 0.45
    
  BOX_X = (bounds.width  - BOX_W) * 0.85
  BOX_Y = (bounds.height  - BOX_H) * 0.85

  stroke_color("000000")
  #todo generate automatically from first row.
  fieldmap = { :id=>0, :text=>1, :priority=>2, :effort=>3 , :meta=>4}
  index = 1
  
  pages = rows.size / 4
  pages = pages.succ if(rows.size % 4) 
    
  puts "Generating #{pages} pages for #{rows.size-1} issues."
  
  pages.times do |page|
    start_new_page unless page==0
      2.times do |y|
        2.times do |x|
         next if index >= rows.size
         
         
         puts "Page: #{page} Card: #{index}\t(#{x},#{y})"
         ycr = 0
         xcr = 0
         margin = 20
         bounding_box [BOX_X*x, bounds.height - BOX_Y*y], :width => BOX_W, :height => BOX_H do
            line_width(2)
            stroke_bounds
            
            bounding_box([margin,bounds.height - margin], :width=>bounds.width-margin*2, :height=>bounds.height-margin*2) do
                stroke_bounds if show_layout
                ycr = 30
                
                # #123        NETA
                font "Helvetica", :style => :bold, :size => 30
                bounding_box([0,bounds.height], :width=> 120, :height => ycr) do
                    text '#'+   rows[index][fieldmap[:id]].to_s
                    stroke_bounds if show_layout
                end
                
                bounding_box([120,bounds.height], :width=> bounds.width - 120, :height => ycr) do
                    text rows[index][fieldmap[:meta]].upcase, :align => :right 
                    stroke_bounds if show_layout
                end
                
                
                # main text
                font "Helvetica", :style => :bold, :size =>20
                ycr = bounds.height - ycr - (margin)
                bounding_box([0,ycr], :width=> bounds.width, :height => 90) do
                    text rows[index][fieldmap[:text]]
                    stroke_bounds if  show_layout
                end
                
                # Pr 3        Ef 3
                font "Helvetica", :style => :bold, :size => 30
                ycr = bounds.height - ycr - margin
                bounding_box([0,ycr], :width=> bounds.width/2, :height => 30) do
                    text 'Pr '+   rows[index][fieldmap[:priority]].to_s
                    stroke_bounds if show_layout
                end
                
                bounding_box([bounds.width/2,ycr], :width=> bounds.width/2, :height => 30) do
                    text 'Ef ' + rows[index][fieldmap[:effort]].to_s
                    stroke_bounds if show_layout
                end
                
               index = index.succ  

            end
         end

        end
      end

  end
end
